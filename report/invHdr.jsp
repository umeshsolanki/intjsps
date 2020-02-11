<%-- 
    Document   : invHdr
    Created on : 15 Jan, 2018, 12:32:26 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.CompanyDomain"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="../js/jquery-3.1.0.min.js" ></script>
        <script src="../js/pullNdry.js" ></script>
        <link type="text/css" href="../css/PullNDry.css" rel="stylesheet"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Invoice</title>
        <%
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        CompanyDomain cd=(CompanyDomain)sess.createCriteria(CompanyDomain.class).uniqueResult();
        
        %>
    </head>
    <body bgcolor="white !important">
        <div class="fullWidWithBGContainer" style="min-height: 100px;">
            <div class="d3 left"><h1 class="nmgn spdn">INVOICE</h1><p class="nmgn spdn">GST: <%=cd.getGstNo()%><br>TIN: <%=cd.getTinNo()%></p></div>
            <div class="d3 left"><p class="nmgn spdn"><%=cd.getToll()%></p><p class="nmgn spdn"><%=cd.getTel()%></p><p class="nmgn spdn"><%=cd.getWeb()%></p></div>
            <div class="d3 left"><p class="nmgn spdn"><%=cd.getAdr()%></p><p class="nmgn spdn"><%=cd.getCt()+","+cd.getStt()%></p>
                <p class="nmgn spdn">PIN <%=cd.getPin()%></p></div>
        </div>
        <div class="" style="min-height: 100px;">
            <div class="d3 left"><p class="nmgn spdn">Billed To</p><b><p class="nmgn spdn">UMESH SINGH SOLANKI</p><p class="nmgn spdn">#87-A, Kundanpuri, Raya (Mathura)</p></b></div>
            <div class="d3 left"><p class="nmgn spdn">Invoice No &amp; Date</p><b><p class="nmgn spdn">01234567</p><p class="nmgn spdn">27/07/2017</p></b></div>
            <div class="d3 left"><p class="nmgn spdn">Invoice Total</p><h1 class="nmgn spdn"><b>&#8377;45470</b></h1></div>
        </div>
        <hr><br>

