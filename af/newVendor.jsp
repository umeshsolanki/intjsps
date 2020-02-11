<%-- 
    Document   : newVendor
    Created on : 6 May, 2018, 11:22:41 AM
    Author     : UMESH-ADMIN
--%>

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
        Admins role=(Admins)request.getSession().getAttribute("role");
        if(role==null){
            response.sendRedirect("?msg=Unauthorized access");
            return;
        }
%>
<div class="loginForm" style="background-color: #ababbc;max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="clrRSP();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <span class="white"><h2 class="nomargin nopadding bgcolt8 centAlText">New Vendor</h2></span><hr>
        <br>
    <center>
        <form action="FormManager " method="post" name="loginForm" id='vendFm' >
            <input type="hidden" name="action" id="action" value="newVendor"/>
            <input class="textField" type="text" id="acc"  name="name" placeholder="Vendor Name"/>
            <input class="textField" type="text" id="bknm" name="mob" placeholder="Mobile"/><br>
            <input class="textField" type="text" id="bkNm" name="add" placeholder="Address"/>
            <input class="textField" type="text" id="ifsc" name="gst" placeholder="GST NO"/><br><br>
            <button onclick='return subForm("vendFm","FormManager")' id="editBtn" class="button">Save</button>
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
