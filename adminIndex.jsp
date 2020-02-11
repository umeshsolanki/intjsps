<%-- 
    Document   : adminIndex
    Created on : 21 Nov, 2017, 10:16:58 AM
    Author     : UMESH-ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
    <c:forEach var="c" items="${modules}">
        <div ng-click="loadPage('${m.getReqUrl()}')" class="tile moduleIndex" style="background-color: #ffffff;" ${m.getModId()==4?"title=''":""} src="${m.getReqUrl()}">
            <img src="images/${m.getTileImage()}" class="tileIcon" style="height:${m.getIh()};width:${m.getIw()};"/>
            <p class="tiletitle" align='left'  style="font-size:${m.getFntSize()};"><b>${m.getTileName()}</b></p>
        </div>
    </c:forEach>
    <!--    <div class="tile" style="background-color: #ffffff;" onclick='loadPage("marketing/marketing.jsp");$(".moduleTitleInNav").text("Websites Hit");'>
            <img src="images/outward.svg" class="tileIcon" /> 
        <p class="tiletitle" align='left'><b>Marketing</b></p>
    </div>
    <div class="tile" style="background-color: #ffffff;" onclick='loadPage("module/index.jsp");$(".moduleTitleInNav").text("Modules");'>
        <img src="images/setting.png" class="tileIcon" /> 
        <p class="tiletitle" align='left'><b>Settings</b></p>
    </div>
    <div class="tile" style="background-color: #ffffff;" onclick='loadPage("tax/index.jsp");$(".moduleTitleInNav").text("Tax");'>
        <img src="images/setting.png" class="tileIcon" /> 
        <p class="tiletitle" align='left'><b>Tax Manager</b></p>
    </div>
    <div class="tile" style="background-color: #ffffff;" onclick='loadPage("howToStart.jsp");'>
        <img src="images/outward.svg" class="tileIcon" /> 
        <p class="tiletitle" align='left'><b>Help</b></p>
        </div>-->
</div>

