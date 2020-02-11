<%-- 
    Document   : index
    Created on : 17 Jul, 2017, 12:51:28 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.Customer"%>
<%@page import="utils.UT"%>
<%@page import="utils.Utils"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="utils.MainModifier"%>
<%@page import="entities.Admins"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"/>
<%
    Session sess=null;
    try{
        sess=sessionMan.SessionFact.getSessionFact().openSession();
    }catch(Exception e){
        e.printStackTrace();
        out.print("<script>showMes('App Initialization Error was Detected at server',true);</script>");
        return;
    }
    Long cId=(Long)session.getAttribute("cust");
        if(cId==null){
            return ;    
        }
    Customer cust=(Customer)sess.get(Customer.class, cId);
%>
<div class="nav">
            <%if(cust.isuAdmin()){%>
                <span class="spdn ho-green-font module" src="../user/index">Users</span>
            <%}%>
            <span class="spdn ho-green-font bold module" src="../account/index">My Account</span>
            <span class="spdn ho-green-font module" src="../domain/index">Domains</span>
            <span class="spdn ho-green-font module" src="../hosting/index">Hosting</span>
            <span class="spdn ho-green-font module" src="../offer/index">Offers</span>
            <span class="spdn ho-green-font module" src="../file/index">File Manager</span>
            <%if(cust.isuAdmin()){%>
            <span class="spdn ho-green-font module" src="../shell/index">Shell</span>
            <span class="spdn ho-green-font module" src="../apache/index">Apache</span>
            <span class="spdn ho-green-font module" src="../tomcat/index">Tomcat</span>
            <%}%>
            <span class="spdn ho-green-font module" src="../mail/index">Email</span>
            <span class="spdn ho-green-font module" src="../dns/index">DNS</span>
            <span class="spdn ho-green-font module" src="../support/index">Tickets</span>
            <span class="spdn ho-green-font module" src="../billing/index">Invoices</span>
            <span class="spdn ho-green-font module" src="../orders/index">Orders</span>
            <span class="spdn ho-green-font module" src="../chat/index">Chat Box</span>
</div>
<br>
<div id="linkLoader">

</div>
<a onclick="refresh();" placeholder="Reload"><span class="rightDownButton"  id="reloadBtn"><center><span class="fa fa-repeat "></span></center></span></a>
<script>
    dragElement(document.getElementById('reloadBtn'));
    $(".module").on("click",function(){
        var module=this;
        $(".module").removeClass("bold");
        $(this).addClass("bold");
        loadPageIn('linkLoader',module.getAttribute("src")+".jsp");
        clearAllIntervals();
    });
        loadPageIn('linkLoader',"../account/index.jsp");
        
    
</script>
<%if(sess!=null) sess.close();%>
<div class="hidden invisible" id="noticeSync" style="width:0px;height: 0px;position: absolute;right:0;top:50%;"></div>
</body>
</html>