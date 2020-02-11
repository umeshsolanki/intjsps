<%-- 
    Document   : addtax
    Created on : 2 Jan, 2018, 1:24:50 PM
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
//        DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
//        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
//        sess.refresh(dist);
              
//        Transaction tr = sess.beginTransaction();
%>
<div class="loginForm bgcolef">
    <span class="close fa fa-close" id="close" onclick="clrLSP();"></span>
    <div class="fullWidWithBGContainer">
    <h2 class="nomargin nopadding centAlText">Create Tax System</h2><hr><br>
    <center>
        <form action="FormManager " method="post" name="loginForm" id='newTaxForm' >
            <input type="hidden" name="act" value="newTax"/>
            <input class="textField" type="text" id="name" name="name" placeholder="Tax Code or Name"/><br><br>
            <input class="textField" type="number" id="perc" name="perc" placeholder="Tax Percentage"/><br><br>
            <button onclick='return subForm("newTaxForm","tax")' id="editBtn" class="button">Save</button>
            <br><br>
        </form>
       </center>           
</div>
    <style>
                            .popSMLE{
                                box-shadow: 4px 4px 25px black;
                            }
                        </style>
<%
sess.close();
%>
