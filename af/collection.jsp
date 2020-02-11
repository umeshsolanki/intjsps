<%-- 
    Document   : collection
    Created on : 29 Jul, 2018, 8:02:02 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.DistSaleManager"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="utils.UT"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="entities.Admins"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        Admins role=(Admins)session.getAttribute("role");
        double tBal=0,tServChg=0;
        if(!UT.ia(role, "24")){
            out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
            return;
        }
        sess.refresh(role);
        Date nw=new Date();
        Date[] curr=Utils.gCMon(nw);
        String s=request.getParameter("s"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),r=request.getParameter("r"),
                apv=request.getParameter("approved");
        if(!UT.ie(iD,fD)&&iD.matches(".{10}")&&fD.matches(".{10}")){
            curr[0]=Utils.DbFmt.parse(iD);
            curr[1]=Utils.DbFmt.parse(fD);
        }else if(!UT.ie(iD)){
            curr[0]=Utils.DbFmt.parse(iD);
        }else if(!UT.ie(fD)){
            curr[1]=Utils.DbFmt.parse(fD);
        }
//        DistSaleManager
        Query q=sess.createQuery("from DistSaleManager dsm where dsm.dt between :id and :fd and dsm.bal>0 "+(UT.ie(r)?"":" and dsm.refBy=:r ")+(UT.ie(s)?"":" and dsm.dist.disId=:s ")+" and dsm.executed=true and dsm.dist.ownedByGA=true").setParameter("fd", curr[1]).setParameter("id", curr[0]);
        if(!UT.ie(s)){
         q.setParameter("s", s);
        }
        if(!UT.ie(r)){
         q.setParameter("r", r);
        }
        List<DistSaleManager> pendings=q.list();
%>    
<div class="loginForm" style="max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left"></div><div class="d3 left leftAlText "></div><div class="d3 left leftAlText"><p>&nbsp;</p></div>
    </div>
<div class="fullWidWithBGContainer bgcolt8">
<div class="subNav left rShadow" id="subNav" style=""><i class="fa btn fa-arrow-circle-left fa-2x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<div style="">
    <h4 class="nomargin p-15 white bgcolt8">Filters</h4><hr>
    <ul>
        <li title="Filters" class="bgcolef">
            <br>
            <form id="purFil" name="purFil">
                <select  title="Show orders from selected Seller" class="textField" name="s">
                <option value="">Select Seller</option>
                <%
                List<DistributorInfo> b=sess.createCriteria(DistributorInfo.class).add(Restrictions.eq("deleted", false)).add(Restrictions.ne("type", "User")).add(Restrictions.ne("type", "Referer")).list();
                for(DistributorInfo brr:b){
                    
                
                %>
                <option value="<%=brr.getDisId()%>"><%=brr.getDisId()%></option>
                <%}%>
                </select><br>
                <select class="textField" name="r" >
                    <option value="">Select Referrer</option>
                    <%
                    b=sess.createCriteria(DistributorInfo.class).add(Restrictions.eq("deleted", false)).add(Restrictions.eq("type", "Referer")).list();
                    for(DistributorInfo mm:b){
                    %>
                    <option value="<%=mm.getDisId().split("00R-")[1]%>"><%=mm.getDisId().split("00R-")[1]%></option>
                    <%}%>
                </select><br>
                <input title="Start date" value="<%=UT.ie(iD)?Utils.DbFmt.format(curr[0]):iD%>" class="textField" type="date" name="iD"/><br>
                <input class="textField" value="<%=UT.ie(fD)?Utils.DbFmt.format(curr[1]):fD%>" title="End Date" type="date" name="fD"/><br><br>
                <span class="right" onclick="loadPg('af/collection.jsp?'+gfd('purFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
                
            <br><br>
        </li>
    </ul>
</div>
<%
if(role.isA()){
%>
<div style="">
    <h4 class="nomargin p-15 white bgcolt8">Quick Links</h4><hr>
    <ul class="bgcolef">
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','af/rmvendors.jsp')">Orders<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','af/rmvendors.jsp')">Complaints<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','af/rmvendors.jsp')">Requisitions<span class="right fa fa-angle-double-right"></span></li><hr>
    </ul>
</div>
<%}%>
    <br>
    </div>
    <div class="right sbnvLdr lShadow" id="linkLoader"><hr>
        <center>
        <table id="header-fixed" border="1px" cellpadding="2px" width="100%">
        </table>
        <div class="scrollable" >
            <table border="1" width="100" cellpadding="4" id="colTbl">
                <thead>
                    <tr>
                        <th> <i onclick="sortTable('colTbl',0)" class="fa fa-exchange fa-rotate-90"></i>Date</th>
                        <th><i onclick="sortTable('colTbl',1)" class="fa fa-exchange fa-rotate-90"></i>Seller</th>
                        <th> <i onclick="sortTable('colTbl',2)" class="fa fa-exchange fa-rotate-90"></i>Referrer</th>
                        <th> <i onclick="sortTable('colTbl',3)" class="fa fa-exchange fa-rotate-90"></i>Docket</th>
                        <th> <i onclick="sortTable('colTbl',4,true)" class="fa fa-exchange fa-rotate-90"></i>Bal</th>
                        <th class="leftAlText">SCharge(Exp-Paid)</th>
                        <th> <i onclick="sortTable('colTbl',6)" class="fa fa-exchange fa-rotate-90"></i>Customer</th>
                        <th>Mob</th>
                        <th>Address</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    double tExp=0,tCol=0;
                    for(DistSaleManager d:pendings){
                        
                    tBal+=d.getBal();
                    tExp+=d.getScExp();
                    tCol+=d.getInstCharge();
//                    tServChg+=d.getScExp()-d.getInstCharge();
                    %>
                    <tr>
                        <td><%=Utils.DbFmt.format(d.getDt())%></td>
                        <td><%=d.getDist().getDisId()%></td>
                        <td><%=d.getRefBy()%></td>
                        <td class="docketRef"><%=d.getDocketNo()%></td>
                        <td><%=d.getBal()%></td>
                        <td class="leftAlText">&#8377;<span class="leftAlText"><%=d.getScExp()+"-"+d.getInstCharge()+"=</span><b class='right'>"+(d.getScExp()-d.getInstCharge())+"</b>"%></td>
                        <td><%=d.getCust().getName()%></td>
                        <td><%=d.getCust().getMob()%></td>
                        <td><%=d.getCust().getAddress()%></td>
                    </tr>
                    <%}%>
                    <tr>
                        <td><b>Total</b></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td><b>&#8377;<%=UT.df.format(tBal)%></b></td>
                        <td class="leftAlText"><%=tExp+"-"+tCol+"= <b class='right'> &#8377;"+UT.df.format((tExp-tCol))+"</b>"%></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>

        </div>
        </center>
    </div>
    </div>
    <script>
        <%=UT.ie(r)?"":"purFil.r.value='"+r+"';"%>
        <%=UT.ie(s)?"":"purFil.s.value='"+s+"';"%>
        var $fixedHeader=$("#header-fixed").append($("#mainTable > thead").clone(false));
        $("#header-fixed th").each(function(index){
    var index2 = index;
    $(this).width(function(index2){
        var eee= $("#mainTable th").eq(index).width();
//        $("#mainTable th").eq(index).html("-");
//        alert(eee);
        return eee;
    });
});
    AIEL();
    </script>
</div>
<%
sess.close();
%>