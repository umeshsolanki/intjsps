<%-- 
    Document   : exedock
    Created on : 29 Mar, 2018, 10:22:27 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="entities.DistSaleManager"%>
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
        String oId=request.getParameter("i");
        String r=request.getParameter("r");
        DistSaleManager o=(DistSaleManager)sess.get(DistSaleManager.class, new Long(oId));
%>
<div class="loginForm" style="background-color: #ababbc;max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="clrRSP();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <h2 class="nomargin nopadding bgcolt8 centAlText">Execute Docket <%=o.getDocketNo()%></h2><hr>
        <br>
    <center>
        <form action="FormManager " method="post" name="ef" id='ef' >
            <input type="hidden" name="action" id="action" value="executed"/>
            <input type="hidden" name="r" id="r" value="<%=r%><%=oId%>"/>
            <input type="hidden" name="i" id="i" value="<%=oId%>"/>
            <input class="textField" value="<%=Utils.DbFmt.format(new Date())%>" type="text" id="dt" name="dt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Execution Date"/><br>
            <input class="textField" type="text" id="iboy" name="iboy" value="" placeholder="Executed by"/><br>
                <%
                    if(o.getDist().getType().matches(".*nline.*")){
                %>
                <p class="greenFont nomargin spdn">Courier Details</p>
                    <input class="textField" type="text"  id="logName" name="log" placeholder="Logistic Name" list="courierList"/>
                    <datalist id="courierList" class="hidden">
                        <%
                        List<String> cr=sess.createQuery("select distinct logName from CourierRecord ").list();
                        for(String s:cr){%>
                        <option value="<%=s%>"><%=s%></option>
                        <%}%>    
                    </datalist>
                        <input class="textField" type="text"  id="awb" name="awb" placeholder="AWB Number"/><br>
                    <input class="textField" value="" type="text" id="ddt" name="ddt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Dispatch  Date"/>
                    <input class="textField" value="" type="text" id="delDtt" name="deldt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Delivery Date"/>
                    <%}%>
                    <br><br>
            <button onclick='return subForm("ef","FormManager");' id="editBtn" class="button">Save</button><br>
            <br><br>
        </form>
    </center>
</div>
    <style>
        .popSMRt{
                                box-shadow: 4px 4px 25px black;
                            }
    </style>
<%
sess.close();
%>
