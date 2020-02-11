<%-- 
    Document   : MaterialConsumption
    Created on : 28 Jul, 2017, 10:36:18 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.Material"%>
<%@page import="utils.UT"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="entities.Admins"%>
<%@page import="entities.MaterialConsumed"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.StockManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div  class="loginForm">
    <!--<span></span>-->
    <style>
        table tr th{
            border-bottom: 1px solid #000;
        }
    </style>
<%
    String p=request.getParameter("p");
    Admins role=(Admins)session.getAttribute("role");
    if(role==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login");
        </script>
        <%
    return ;
}
    if(!UT.ia(role, "17")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
            return;
        }
    
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    String iLim=request.getParameter("ini");
    Date nw=new Date();
    Date[] curr=Utils.gCMon(nw);
    String pr=request.getParameter("p"),m=request.getParameter("m"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),br=request.getParameter("br");
    int ini=0;
    if(iLim!=null&&iLim.matches("\\d+")){
        ini=Integer.parseInt(iLim);
    }
    Criteria c=sess.createCriteria(MaterialConsumed.class);
    if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
            c.add(Restrictions.between("dt", Utils.DbFmt.parse(iD), Utils.DbFmt.parse(fD)));
    }else{
               c.add(Restrictions.between("dt", curr[0],curr[1]));
        }
        if(br!=null&&br.matches("\\d+")){
            c.add(Restrictions.eq("branch.brId",new Long(br)));
        }
        if(m!=null&&m.matches("\\d+")){
            c.add(Restrictions.eq("mat.matId",new Long(m)));
        }
        if(pr!=null&&pr.matches("\\d+")){
            c.add(Restrictions.eq("semiFinProd.FPId",new Long(pr)));
        }
    List<FinishedProduct> fpa= sess.createCriteria(FinishedProduct.class).add(Restrictions.eq("deleted", false)).addOrder(Order.asc("FPName")).list();
    List<MaterialConsumed> prods=c.list();
    %>
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer">
<!--        <div class="d3 left">
            <p class="white pointer" onclick="popsl('af/newprodrec.jsp')">
                <span class="button white"><i class="fa fa-plus-circle"></i> Add Production Request</span></p>
        </div>-->
        <div class="d3 left leftAlText">
            <!--<p class="greenFont"><%=p!=null?"from "+p:"from : "+Utils.HRFmt.format(curr[0])%></p>-->
        </div>
        <div class="d3 left leftAlText">
            <!--<p class="redFont"><%=p!=null?"to "+p:"to : "+Utils.HRFmt.format(curr[1])%></p>-->
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left rShadow" style="">
            <i class="fa btn fa-arrow-circle-left fa-2x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<!--            <span class="white"><h2 class="nomargin nopadding">Finance Record</h2></span><hr>-->
<div style="">
    <p class="nomargin p-15 white bgcolt8  bold">Month: <%=Utils.getWMon.format(new Date())%> </p><hr>
    <ul class="bgcolef">
        <li title="Filters" class="bgcolef">
            <br>
            <form id="prodFil" name="prodFil">
                <select title="For branch" class="textField" name="br">
                    <option>Select Production Branch</option>
                <%
                    List<ProductionBranch> b=sess.createCriteria(ProductionBranch.class).list();
                    for(ProductionBranch brr:b){
                %>
                <option value="<%=brr.getBrId()%>"><%=brr.getBrName()%></option>
                <%}%>
            </select><br>
            <select class="textField" name="m" >
                    <option>Select Material</option>
                    <%
                        List<Material> mt=sess.createCriteria(Material.class).list();
                    List<FinishedProduct> pds=sess.createCriteria(FinishedProduct.class).add(Restrictions.eq("semiFinished", true)).list();
                    
                    for(Material mc:mt){
                    %>
                    <option value="<%=mc.getMatId()%>"><%=mc.getMatName()%></option>
                    <%
                    }
                    %>
                    </select><br>
            <select class="textField" name="p" >
                    <option>Select Product</option>
                    <%
                    for(FinishedProduct pd:pds){
                    %>
                    <option value="<%=pd.getFPId()%>"><%=pd.getFPName()%></option>
                    <%
                    }
                    %>
                    </select><br>
            
                    <input title="Start date" class="textField" value="<%=Utils.DbFmt.format(curr[0])%>" type="date" name="iD"/><br>
                    <input class="textField" title="End Date" value="<%=Utils.DbFmt.format(curr[1])%>" type="date" name="fD"/><br><br>
                    <span class="right" onclick="loadPg('af/BRConsumption.jsp?'+gfd('prodFil'))">
                <span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
    </ul>
</div>
<div style="">
    <p class="nomargin p-15 white bgcolt8  bold">Report</p><hr>
    <ul class="bgcolef">
        <li class="navLink leftAlText"  onclick="loadPageIn('linkLoader','report/matWiseConsumption.jsp?'+gfd('prodFil'))">Raw Material Wise<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">SemiProduct Wise<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">-<span class="right fa fa-angle-double-right"></span></li>
    </ul>
</div>
        <br>
        </div>
        <div class="right sbnvLdr lShadow" id="linkLoader" >
        <!--<center>-->
            <table id="header-fixed" border="1px" cellpadding="2" style="margin:0px;" width="100%">
            </table>
            <div class="scrollable" >
                <form id="initProduction" onsubmit="return false;">

    <!--<span class="close fa fa-close" id="close" onclick="<%=p!=null?"clrLSP()":"closeMe()"%>"></span>-->
    <!--<div>-->
        <!--<span class="white"><h2 class="nomargin nopadding centAlText">Material Consumed </h2></span>-->
    <hr>
    
    <table id="mainTable" width="100%" border="1px" cellpadding="5" >
        <thead>
            <tr align="center">
                <th>Date</th>
                <th>Branch</th>
                <th>Product</th>
                <th>Qty</th>
                <th>Material</th>
                <th>Consumed</th>
            </tr>
        </thead>
        <tbody style="max-height: 500px;overflow: auto">
        <%for(MaterialConsumed in:prods){
        if(in.getStoreId()==null){%>
        <%continue;}
        %>
            <tr align="center">
                <td><%=in.getStoreId().getProducedOn()%></td>
                <td><%=in.getStoreId().getProducedBy().getBrName()%></td>
                <td><%=in.getStoreId().getProduct().getFPName()%></td>
                <td><%=UT.df.format(in.getStoreId().getQnt())%></td>
                <td><%=in.getMat()!=null?"<span class='greenFont'  title='Green color for Raw Material'>"+in.getMat().getMatName()+"</span>":"<span class='ylFnt' title='Yellow color for Semi product'>"+in.getSemiFinProd().getFPName()+"</span>"%></td>
                <td><%=UT.df.format(in.getQnt())+" "+(in.getMat()!=null?in.getMat().getPpcUnit():"")%></td>
                <%}%>
        </tbody>
        </table>
        <script>
            copyHdr("mainTable","header-fixed");
        </script>
         <!--<br><span class="button">View More...</span><br><br>-->
    </div>
    <style>
        
    .popSMLE{
        box-shadow: 4px 4px 25px black;
    }
    
    </style>
</div>
    </div>
    </div>       