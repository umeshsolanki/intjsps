<%-- 
    Document   : warranty
    Created on : 11 Sep, 2018, 1:34:19 PM
    Author     : UMESH-ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="loginForm">
    <p class="matlred">Press Escape(Esc) to close</p>
    <p class="matlgreen">Enter Docket No/Mobile No/Service No</p>
    <input class="textField" id="warNo" placeholder="Enter here" /><span class="button matBlu" onclick="loadPageIn('status','warranty?no='+$('#warNo').val())">Check/get status</span>
    <div class="fullWidWithBGContainer p-15" id="status">
        
    </div>
</div>