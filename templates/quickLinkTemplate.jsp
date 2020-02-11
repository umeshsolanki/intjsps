<%-- 
    Document   : quickLinkTemplate
    Created on : 7 Aug, 2018, 11:44:20 AM
    Author     : UMESH-ADMIN
--%>
<%@page import="utils.UT"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="entities.InwardManager"%>
<%@page import="entities.Material"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.DistFinance"%>
<%@page import="entities.Admins"%>
<%@page import="entities.FinanceRequest"%>
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
        if(!UT.ia(role, "20")){
            out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
            return;
        }
        sess.refresh(role);
        Date nw=new Date();
        Date[] curr=Utils.gCMon(nw);
        String m=request.getParameter("m"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),br=request.getParameter("br"),
                apv=request.getParameter("approved");
        
%>    
<div class="loginForm" style="max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left"></div><div class="d3 left leftAlText "></div><div class="d3 left leftAlText"><p></p></div>
    </div>
<div class="fullWidWithBGContainer bgcolt8">
<div class="subNav left" id="subNav" style=""><i class="fa btn fa-toggle-left fa-1pt25x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<div style="margin: 1px;padding: 1px;border: 1px white solid;">
    <h4 class="nomargin spdn white">Filters</h4><hr>
    <ul>
        <li title="Filters" class="bgcolef">
            <br>
            <form id="purFil" name="purFil">
            <input title="Start date" value="<%=UT.ie(iD)?Utils.DbFmt.format(curr[0]):iD%>" class="textField" type="date" name="iD"/><br>
            <input class="textField" value="<%=UT.ie(fD)?Utils.DbFmt.format(curr[1]):fD%>" title="End Date" type="date" name="fD"/><br><br>
            <span class="right" onclick="loadPg('af/.jsp?'+gfd('purFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
    </ul>
</div>
<%
if(role.isA()){
%>
<div style="margin-top: 10px;padding: 1px;border: 1px white solid;">
    <h4 class="nomargin spdn white">Quick Links</h4><hr>
    <ul class="bgcolef">
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','af/rmvendors.jsp')">Vendors<span class="right fa fa-angle-double-right"></span></li><hr>
    </ul>
</div>
<%}%>
    <br>
    </div>
    <div class="right sbnvLdr" id="linkLoader"><hr>
        <center>
        <table id="header-fixed" border="1px" cellpadding="2px" width="100%">
        </table>
        <div class="scrollable" >
            <table border="1" width="100" cellpadding="4">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Docket</th>
                        <th>Bal</th>
                        <th>Ser Charge</th>
                        <th>Customer</th>
                        <th>Mob</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    for(DistSaleManager dsm:pendings){
                    %>
                    <tr>
                        <td><%=%></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>

        </div>
        </center>
    </div>
    </div>
    <script>
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
    </script>
</div>
<%
sess.close();
%>