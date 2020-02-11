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
    <div class="col s12">
        <form>
            <div class="input-field col s12  m6 fixed">
                <input id="pageTitle" name="pageTitle"  type="text" class="validate">
                <label for="pageTitle">Page Title</label>
            </div>
            <div class="input-field col s12 m6">
                <input id="url" name="url"  type="text" class="validate">
                <label for="url">URL</label>
            </div>
            <div class="input-field col s12 m6">
                <input id="seo" name="seo"  type="text" class="validate">
                <label for="seo">SEO Title</label>
            </div>
            <div class="input-field col s12 m6">
                <input id="domain" name="domain"  type="text" class="validate">
                <label for="domain">Domain</label>
            </div>
            <div class="input-field col s12">
                <textarea id="pageTitle" class="materialize-textarea"></textarea>
                <label for="pageTitle">Page Content</label>
            </div>
        </form>
    </div>
    <script>
    
</script>
</div>