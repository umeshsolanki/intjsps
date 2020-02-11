<%-- 
    Document   : ereg
    Created on : 15 Feb, 2018, 7:04:39 PM
    Author     : UMESH-ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="loginForm" style="max-width: 50%;min-height: 50%;">
    <span class="close" id="close" onclick="closeMe();">x</span>
    <span class="white"><h2>License Activation Request</h2></span><hr>
        <br>
        <!--<center><h1>Student Login</h1></center>-->
    <center>
        <form method="post" name="licForm" id='licForm'>
            <input type="hidden"  name="action" value="licAct"/><br>
            <input class="textField " type="text"  name="admId" placeholder="Admin-Id"/><br><br>
            <input class="textField " type="password" minlength="4" maxlength="15"  name="pass" placeholder="password"/><br><br>
            <!--<input class="textField" type="text"  name="otp" placeholder="OTP"/><br><br>-->
            <button onclick='return subForm("licForm","S");' class="button ">Proceed</button>
        </form>
       </center>
        <br><br><br>
</div>