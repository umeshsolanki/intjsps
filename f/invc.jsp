<%-- 
    Document   : invc
    Created on : 11 Jan, 2018, 1:59:36 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.CompanyDomain"%>
<%@page import="org.hibernate.Session"%>
<%@page import="sessionMan.SessionFact"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Session sess=SessionFact.getSessionFact().openSession();
    CompanyDomain cd=(CompanyDomain)sess.createCriteria(CompanyDomain.class).uniqueResult();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Invoice Manager</title>
    </head>
    
    <body>
        <%=cd.getCompName()%>
    </body>
</html>
