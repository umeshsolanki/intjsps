<%-- 
    Document   : logout
    Created on : 25 Aug, 2016, 12:49:39 PM
    Author     : UMESH-ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>logout</title>
    </head>
    <body>
        <%
            session.invalidate();
            try{
            for(Cookie ck:request.getCookies()){
                ck.setMaxAge(0);
                response.addCookie(ck);
            }
            }catch (Exception ex) {
                    
            }
            response.sendRedirect("index.jsp");  
        %>
    </body>
</html>
