<%-- 
    Document   : header
    Created on : 21 July, 2017, 9:57:09 PM
    Author     : UMESH-ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="theme-color" content="#448833"/>
        <!--<meta name="google-site-verification" content="8PKYU8B96CVPnZRPSo3k_-3vs1JUYBL1b5EjXYewLVw" />-->
        <!--        <meta name="description" content="We are Web and Android developers Team">
        <meta name="robot" content='index,follow'>
            <meta name="keyword" content="Software development, Android App Developers, Website Developers">-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/PullNDry.css"/>
        <script src="js/jquery-3.1.0.min.js" ></script>
        <script src="js/pullNdry.js" ></script>
        <script src="js/Chart.js" ></script>
        <!--<script src="js/angular-1.7.5.js"></script>-->
        <!--<script src="js/angular.min.js" ></script>-->
        <!--<script src="js/angular.anim.min.js" ></script>-->
        <link href="font-awesome-4.7.0/css/font-awesome.css" rel="stylesheet">
        <!--<script src="font-awesome/js/angular.anim.min.js" ></script>-->
        <script src="js/angular-1.7.5.js"></script>
        <script src="js/erp.js" ></script>
        
        <style>
            table{
                border-spacing: 0px;
                border-collapse: collapse;
               padding: 2px;
            }
        </style>
        <link href="https://fonts.googleapis.com/css?family=Bree+Serif|Lato|Roboto|Roboto+Slab" rel="stylesheet">
        <!--            <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
            <script>
              (adsbygoogle = window.adsbygoogle || []).push({
                google_ad_client: "ca-pub-3740325070540173",
                enable_page_level_ads: true
              });
            </script>-->
    </head>
    <body ng-app="erp" ng-controller="erpCtrl as ec">
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
                          ${compName}
                    </span>
                </div>
                <div class="d3 left centAlText">
                    <span class="moduleTitleInNav">Home</span>
                </div>
                <div class="d3 left">
                    <div class="searchCont rightAlText">
                        <c:if test="${isSeller&&ad==null&&dis==null}">
                            <span title="login" onclick="loadPage('df/LoginForm.jsp')"><img class="btn" width="35px" height="35px" src="images/loginnn.svg"/></span>
                        </c:if>
                    <span title="logout"><a href='logout.jsp'><img class="btn" width="35px" height="35px" src="images/logout.svg"/></a></span>
                    <span title="Toggle Notification Bar" onclick="$('#impNotCont').toggleClass('nopen nclose');"><i class="fa fa-arrows-h fa-2x btn"></i></span>
                    <div id="searchRes" style="font-size: 14px;z-index: 9999;overflow: auto;margin: 0px;background-color: #efefef;max-height: 250px;;display: none;" ></div>
                    </div>
                </div>
            <!--<span class="right" style='right:150px;width: 50px;height: 50px;color:black;'>Logout</span>-->
            <!--<span class="right" style='right:0px;color:black;'>Reload</span>-->
            
        </div>
        </div>
    <script>
        
        var mats = jar.toString();
        var prods = jar.toString();
        
        var SearchQuery={query:"","in":"","what":"",target:""};
        function getKeys(filter) {
            if(window.event.keyCode==13){
                SearchQuery.what=$("#SCHBOX").val();
                loadByJson("SearchManager",JSON.stringify(SearchQuery),true);
            }
            if(filter.toString().length>1){
                $("#searchRes").html("");
                $("#searchRes").css("display","block");
                var patt=new RegExp(".*"+filter+".*","i");
        for(var i=0;i<mats.length;i++){
                var mat=mats[i];
                if(patt.test(mat.name)){
                $("#searchRes").append("<div onclick='buildQuery(\"mat\",\""+
                        mat.name.replaceAll("\"","&quot;")+"\",\""+mat.id+"\");' \n\
                    style='padding:5px;'>"+mat.name+", RM <span style='padding:0px;margin:0px;\n\
                    float:right;right:0px;'>&nwarr;</span></div>");
                }
            }
        //            patt=new RegExp(".*"+filter+".*","i");
        for(var i=0;i<prods.length;i++){
            var mat=prods[i];
//                    alert(mat.name);
//                    var patt=new RegExp(".*"+filter+".*","i");
//                    alert(mat.name);
                if(patt.test(mat.name)){
                    $("#searchRes").append("<div style='padding:5px;'>"+mat.name+", FP \n\
                        <span style='padding:0px;margin:0px;float:right;right:0px;'>&nwarr;</span></div>");
                }
            }

        }else{
                    $("#searchRes").html("");
                        $("#searchRes").css("display","none");
                }
                }
                function buildQuery(what,IN,target,query) {
                    SearchQuery.in=IN;
                    SearchQuery.what=what;
                    SearchQuery.target=target;
                    SearchQuery.query=query;
                    $("#searchRes").html("");
        //                        alert(JSON.stringify(SearchQuery));
                }
    </script>
    <div class="header">
        <div class="navContainer" id="navCont">
          <ul>
            <a  href="index.jsp" ><li class="navLink">Home Page</li></a>
          </ul>
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
        <div class="fullWidWithBGContainer tileCont">
            <div class="tile bgwhite">
                <a href="admin" class="tileIcon" >Go to Admin Panel</a>
            </div>
            <div class="tile bgwhite">
                <a href="sellers" class="tileIcon" >Go to Sellers Panel</a>
            </div>
        </div>
        </div>
        <div  class="pageContainer" id="contentLoader"></div>
    </center> 
        <script>
            dragElement(document.getElementById(("confirmBox")));
           dragElement(document.getElementById(("editBox")));
           
//
//        var curNot=1;    
//            setInterval(function(head,mes){
//            curNot++;
//            notify('Hey'+curNot,'OM Long text will not look awkward so let me checkit extra lonh tetdfm dk dk dk dd  almaol olw o oieiowno eowe wo  oolj  '+curNot);
//            },2000);
//        </script>