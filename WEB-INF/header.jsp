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
        <title>${title}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="${ctx}/materialize/css/materialize.min.css" />
        <link rel="stylesheet" href="${ctx}/css/via.css" />
        <script type="text/javascript" src="${ctx}/js/jquery-3.1.0.min.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="${ctx}/materialize/js/materialize.min.js" ></script>
    </head>
    <body class="">
        <div>
            <style>
/*                .input-field input{
                    color: white !important;
                }*/
            </style>
        <div class="navbar-fixed">
        <nav>
            <div class="nav-wrapper blue">
                <span class="brand-logo truncate">&nbsp;<a href="#" class="via-nav-trigger"><i class="material-icons">menu</i></a>Viatusk Solutions</span>
              <ul class="right hide-on-med-and-down">
                  <li><a href="${ctx}/api/admin/home">Home</a></li>
                <li><a class="modal-trigger" href="/api/logout" >Logout</a></li>
                <li><a href="${ctx}/contact.jsp">Contact Us</a></li>
              </ul>
            </div>
        </nav>
        <ul class="sidenav" id="mobile-demo">
            <li><a href="/api/admin/home">Home</a></li>
          <li><a class="modal-trigger" href="/api/logout" >Logout</a></li>
          <li><a href="${ctx}/contact.jsp">Contact US</a></li>
        </ul>
        </div>
        <script>
             document.addEventListener('DOMContentLoaded', function() {
                var elems = document.querySelectorAll('.sidenav');
                var instances = M.Sidenav.init(elems, {});
                  var col = document.querySelectorAll('.collapsible');  
                      var instances = M.Collapsible.init(col, {});
              });
              $(".via-nav-trigger").on("click",function(){
                  $("#nav-container").toggleClass("hiddendiv");
              })
        </script>
    </div>