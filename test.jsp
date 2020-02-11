<%-- 
    Document   : header
    Created on : 21 July, 2017, 9:57:09 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.ProductionBranch"%>
<%@page import="utils.HtmlUtils"%>
<%@page import="entities.CompanyDomain"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="entities.ActivityTracer"%>
<%@page import="entities.FinanceRequest"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.criterion.Criterion"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="utils.Utils"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="entities.Material"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.Admins"%>
<%@page import="utils.FetchContents"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%--<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="theme-color" content="#448833"/>
        <!--<meta name="google-site-verification" content="8PKYU8B96CVPnZRPSo3k_-3vs1JUYBL1b5EjXYewLVw" />-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/PullNDry.css"/>
        <script src="js/jquery-3.1.0.min.js" ></script>
        <script src="js/pullNdry.js" ></script>
        <script src="js/Chart.js" ></script>
        <script src="js/angular.min.js" ></script>
        <!--<script src="js/angular.anim.min.js" ></script>-->
        <link href="font-awesome-4.7.0/css/font-awesome.css" rel="stylesheet">
        <!--<script src="font-awesome/js/angular.anim.min.js" ></script>-->
        
        <style>
            table{
                border-spacing: 0px;
                border-collapse: collapse;
               padding: 2px;
            }
        </style>
        <link href="https://fonts.googleapis.com/css?family=Bree+Serif|Lato|Roboto|Roboto+Slab" rel="stylesheet">
    </head>
    <body>
        <div class="msg">
        </div>
        <a name='top'></a>
    <center>
        <div id="impNotCont" class="notifContRight nclose">
        </div>
    </center>
        <div class="webTitle">   
            <div class="">
                <div class="d3 left">
                    <span onclick="toggleSideBar()" class="navIconLeft">
                    <span class="bar"></span><span class="bar"></span><span class="bar"></span>
                    </span>
                    <span style="color:#3d8dda;">
                            VIA Software Solutions
                    </span>
                </div>
                <div class="d3 left centAlText">
                    <span class="moduleTitleInNav">Home</span>
                </div>
                <div class="d3 left">
                </div>
            <!--<span class="right" style='right:150px;width: 50px;height: 50px;color:black;'>Logout</span>-->
            <!--<span class="right" style='right:0px;color:black;'>Reload</span>-->
            
        </div>
        </div>
        <div class="header">
        <div class="navContainer" id="navCont">
            
        </div>
        </div>
    <div style="margin-top:55px;"></div>
    <div  class="popSMLE" id="leftPop"></div>
    <div  class="popSMRt" id="rigPop"></div>
    <div  class="popUp" id="LLPop"></div>
    <div  class="popUpRight" id="LRPop"></div>
    <script>
    dragElement(document.getElementById(("leftPop")));
    dragElement(document.getElementById(("rigPop")));
    dragElement(document.getElementById(("LLPop")));
    dragElement(document.getElementById(("LRPop")));
    
    
    
function dragElement(elmnt) {
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
  if (document.getElementById(elmnt.id + "")) {
    /* if present, the header is where you move the DIV from:*/
    document.getElementById(elmnt.id + "").ondblclick = dragMouseDown;
  } else {
    /* otherwise, move the DIV from anywhere inside the DIV:*/
    elmnt.onmousedown = dragMouseDown;
  }

  function dragMouseDown(e) {
    e = e || window.event;
    // get the mouse cursor position at startup:
    pos3 = e.clientX;
    pos4 = e.clientY;
    document.onmouseup = closeDragElement;
    // call a function whenever the cursor moves:
    document.onmousemove = elementDrag;
  }

  function elementDrag(e) {
    e = e || window.event;
    // calculate the new cursor position:
    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;
    // set the element's new position:
    elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
    elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
  }

  function closeDragElement() {
    /* stop moving when mouse button is released:*/
    document.onmouseup = null;
    document.onmousemove = null;
  }
}

</script>

    <div  class="conDial" id="confirmDialog">
        <center>
            <div class="fullWidWithBGContainer" id="confirmBox">
                <div class="bgcolef" style="border-radius:5px;max-width: 50%;min-height: 300px;margin-top: 70px;">
                    <div class="fullWidWithBGContainer">
                        <span class="fa fa-close close" onclick="hideMe('confirmDialog')"></span>
                        <h3 id="confDialHead" class="bgcolt8 leftAlText nomargin spdn movCurs">Dialog</h3>
                        <div id="confDialCont" class="leftAlText spdn">
                            <p class="greenFont" id="dialMes"></p>
                            <span class="right lpdn ">
                                <button class="button greenFont" id="confYesBtn">Yes</button>
                                <button  class="button redFont" id="confNoBtn">No</button>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </center>
    </div>    
<div  class="conDial" id="editDialog">
        <center>
            <div class="fullWidWithBGContainer"  id="editBox">
                <div class="bgcolef" style="border-radius:5px;max-width: 50%;min-height: 300px;margin-top: 70px;">
                    <div class="fullWidWithBGContainer">
                        <span class="fa fa-close close" onclick="hideMe('editDialog')"></span>
                        <h3 id="editDialHead" class="bgcolt8 leftAlText nomargin spdn movCurs">Dialog</h3>
                        <div id="editDialCont" class="leftAlText spdn">
                            <form action="#" onsubmit="return false;" id="globalEditForm" >
                                <input type="hidden" name="editAction" id="editAction" value=""/>
                            <p class="greenFont" id="editForm">
                                
                            </p>
                            <span class="right lpdn ">
                                <button class="button greenFont" id="editUpdateBtn">Update</button>
                                <button  class="button redFont" id="editCancBtn">Cancel</button>
                            </span>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </center>
</div>
<center>
    <br>
        <%
        out.print(HtmlUtils.genEntryForm(new ProductionBranch()));
        %>
</center> 
<script>
    dragElement(document.getElementById(("confirmBox")));
    dragElement(document.getElementById(("editBox")));
</script>