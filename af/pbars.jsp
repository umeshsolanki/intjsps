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
<div class="">
    <span class="close fa fa-close blkFnt" onclick="clrLSP()"></span>
    <div >
        <h2 class="nomargin nopadding white centAlText">Barcodes </h2><hr>
        <div class="scrollable" id="barCont">
    <%
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    Admins role=(Admins)session.getAttribute("role");
    String p=request.getParameter("p"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),br=request.getParameter("br");
    List<Manufactured> mans =sess.createQuery("from Manufactured where pr.reqId=:pr").setParameter("pr", new Long(p)).list();
    for(Manufactured m:mans){
    %>
    <img src="<%=m.getBar()%>.jpg"   />
    <!--<span>&#8377;<%=m.getpCat().getMRP()%></span>-->
    <%}%>
    </div>
        </div>
    <br>
    <button onclick="pCnt('barCont',true,true)">Print</button>
</div>