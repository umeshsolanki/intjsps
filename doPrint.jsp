<%-- 
    Document   : pbars
    Created on : 4 Jan, 2018, 9:14:38 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="java.util.List"%>
<%@page import="entities.Admins"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.Manufactured"%>
<%@page import="entities.MaterialConsumed"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta name="theme-color" content="#448833"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--<link rel="stylesheet" type="text/css" href="css/PullNDry.css"/>-->
<!--        <script src="js/jquery-3.1.0.min.js" ></script>
        <script src="js/pullNdry.js" ></script>
        <script src="js/Chart.js" ></script>
        <script src="js/angular.min.js" ></script>
        <script src="js/angular.anim.min.js" ></script>-->
        <link href="font-awesome-4.7.0/css/font-awesome.css" rel="stylesheet">
    <div class="fullWidWithBGContainer">
    
    <!--<span class="close fa fa-close blkFnt" onclick="clrLSP()"></span>-->
    <div >
        <!--<h2 class="nomargin nopadding white centAlText">Barcodes </h2><hr>-->
        <div class="scrollable" id="barCont">
    <%
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    Admins role=(Admins)session.getAttribute("role");
    String p=request.getParameter("p"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),br=request.getParameter("br");
    List<Manufactured> mans =sess.createQuery("from Manufactured where pr.reqId=:pr").setParameter("pr", new Long(p)).list();
    for(Manufactured m:mans){
    %>
    <img src="<%=m.getBar()%>.jpg"   />
    <p>&#8377;<%=m.getpCat().getBarCode()%>(<%=m.getpCat().getFPName()%>)</p>
    <%}%>
    </div>
        </div>
    <br>
    <button onclick="window.print()">Print</button>
</div>