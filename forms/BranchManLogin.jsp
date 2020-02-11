<%-- 
    Document   : LoginForm
    Created on : 21 Sep, 2016, 3:41:33 PM
    Author     : UMESH-ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="loginForm" style="max-width: 50%">
    <span class="close" id="close" onclick="closeMe();">x</span>
    <span class="white"><h2>Branch Manager Login</h2></span><hr>
        <br>
        <!--<center><h1>Student Login</h1></center>-->
    <center>
        <form action="ChkLogin" method="post" name="loginForm" id='loginForm' >
            <input type="hidden" name="who" value="brManLogin"/> 
            <input class="textField" type="text"  name="brId" placeholder="Branch Id"/><br><br>
            <input class="textField" type="password" name="pass" placeholder="password"/><br><br>
            <!--<input class="textField" type="text"  name="otp" placeholder="OTP"/><br><br>-->
            <button onclick='return subLog();' class="button">Login</button>
            
        </form>
       </center>
        <br><br>
</div>
