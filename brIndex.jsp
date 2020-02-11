<%-- 
    Document   : brIndex
    Created on : 21 Nov, 2017, 10:17:13 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="entities.StockManager"%>
<%@page import="java.util.List"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="entities.Admins"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <%
            
    Admins role=(Admins)session.getAttribute("role");
    Session sess=null;
    try{

    sess=sessionMan.SessionFact.getSessionFact().openSession();
    }catch(Exception e){
        e.printStackTrace();
        out.print("<script>showMes('App Initialization Error was Detected at server',true);</script>");
        return;
    }
        %>
    <!--<center>-->
            <%
            if(sess!=null){
//                List<StockManager> stockWarning=sess.createQuery("from StockManager s where s.Qty<s.mat.minQnt order by mat.matName").list();
            %>            

<!--<div style="min-width: 100%;"  class="fullWidWithBGContainer cardContainer">-->
<%
    if(role.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_BR_FPSTOCKV+".*)|(.*"+ROLE.ADM_BR_ALLSTOCKV+".*)|(.*"+ROLE.ADM_BR_ALLStockM+".*)")){
    %>
    <div class="tile" style="background-color: #ffffff;" onclick='loadPage("af/BRConsumption.jsp");'>
        <img src="images/meter.svg" class="horTileIcon"/>
        <p class="tiletitle" align='left'><b>RM Purchases</b></p>
    </div>    
<%}
    if(role.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_BR_FPSTOCKV+".*)|(.*"+ROLE.ADM_BR_ALLSTOCKV+".*)|(.*"+ROLE.ADM_BR_ALLStockM+".*)")){
    %>
    <div class="tile" style="background-color: #ffffff;" onclick='loadPage("af/BRProduction.jsp");'>
        <img src="images/production_JCB.png" class="tileIcon"/> 
        <p class="tiletitle" align='left'><b>Stock</b></p>
    </div>    
<%}    if(role.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_BR_FPSTOCKV+".*)|(.*"+ROLE.ADM_BR_ALLSTOCKV+".*)|(.*"+ROLE.ADM_BR_ALLStockM+".*)")){
    %>
    <div class="tile" style="background-color: #ffffff;" onclick='loadPage("af/BRPurchases.jsp");'>
        <img src="images/import.png" class="tileIcon"/> 
        <p class="tiletitle" align='left'><b>Production</b></p>
    </div>    
<%}
sess.close();}%>