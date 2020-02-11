<%-- 
    Document   : login
    Created on : Jul 3, 2019, 9:03:51 PM
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
    <body>
        <div class="container">
            <div class="card-panel col s12 m6">
            <form class="col s12 loginForm" action="/api/login/admin" method="post">
                <div class="row via-bold">
                    Enter your credential to proceed
                </div>
                <p class="red-text">${message}</p>
                <div class="row">
                    <div class="input-field col s12 m6">
                        <input id="mobile_log" name="mob" type="text" class="validate">
                        <label for="mob">User Id</label>
                    </div>
                    <div class="input-field col s12 m6">
                        <input id="pass_log" type="password" name="pass" class="validate">
                        <label for="password">Password</label>
                    </div>
                    <div class="row" id="loginResponse">
    <!--                            <center>OM</center>-->
                    </div>
                </div>
                <div class="row">
                    <button class="btn waves-effect waves-green offset-m8 col m2 s12 loginAction">Login</button>  
                </div>
            </form>
        </div>
        </div>
    </body>
</html>
