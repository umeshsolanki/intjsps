<%-- 
    Document   : header
    Created on : May 5, 2019, 5:10:41 PM
    Author     : umesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
        String title="Viatusk Solutions";
        %>
        <title>${title}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="${ctx}/materialize/css/materialize.min.css" />
        <link rel="stylesheet" href="${ctx}/css/via.css" />
        <script type="text/javascript" src="${ctx}/js/jquery-3.1.0.min.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="${ctx}/materialize/js/materialize.min.js" ></script>
    </head>
    <body>
        <div>
        <nav>
            <div class="nav-wrapper blue">
              <a href="#!" class="brand-logo">&nbsp;&nbsp; Viatusk Solutions</a>
              <a href="#" data-target="mobile-demo" class="sidenav-trigger"><i class="material-icons">menu</i></a>
              <ul class="right hide-on-med-and-down">
                  <li><a href="${ctx}/api/admin/home">Home</a></li>
                  <li><a href="${ctx}/api/admin/file">File</a></li>
                <li><a class="modal-trigger" href="/api/logout" >Logout</a></li>
                <li><a href="${ctx}/contact.jsp">Contact Us</a></li>
              </ul>
            </div>
        </nav>
        <ul class="sidenav" id="mobile-demo">
            <li><a href="/api/admin/home">Home</a></li>
          <li><a href="${ctx}/api/admin/file">File</a></li>
          <li><a class="modal-trigger" href="/api/logout" >Logout</a></li>
          <li><a href="${ctx}/contact.jsp">Contact US</a></li>
        </ul>
        <script>
             document.addEventListener('DOMContentLoaded', function() {
                var elems = document.querySelectorAll('.sidenav');
                var instances = M.Sidenav.init(elems, {});
                  var col = document.querySelectorAll('.collapsible');  
                      var instances = M.Collapsible.init(col, {});
              });
              
        </script>
    </div>