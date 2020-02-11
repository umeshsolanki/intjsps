<%-- 
    Document   : quickLinkTemplate
    Created on : 7 Aug, 2018, 11:44:20 AM
    Author     : UMESH-ADMIN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../header.jsp" %>
<link rel="stylesheet" href="/lib/codemirror.css">
<script src="/lib/codemirror.js"></script>
<div class="row">
    <%@include file="../adminMenu.jsp" %>
    <div class="col s10 right-loader">
        <div class="col s12">
            <pre>
                ${logs}
            </pre>
        </div>
    </div>
</div>