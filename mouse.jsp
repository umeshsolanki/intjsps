<%-- 
    Document   : mouse
    Created on : 20 Feb, 2018, 12:00:29 PM
    Author     : UMESH-ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mouse</title>
    </head>
    <body>
        <script>
            (function(){
             window.onload=function(event){
                 document.addEventListener("onmousemove",function(event){
                     alert(event.clientX);
                 })
             }   
            })();
        </script>
        <h1>Hello World!</h1>
    </body>
</html>
