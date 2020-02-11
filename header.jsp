<%-- 
    Document   : header
    Created on : 21 July, 2017, 9:57:09 PM
    Author     : UMESH-ADMIN
--%>

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
        <%
            Session sess=null;
            try{
                sess=sessionMan.SessionFact.getSessionFact().openSession();
            }catch(Exception e){
                e.printStackTrace();
                out.print("<script>showMes('ERP Initialization Error was Detected at server',true);</script>");
            return;
            }
            
            Admins ad=(Admins)session.getAttribute("role");
            DistributorInfo dis=(DistributorInfo)session.getAttribute("dis");
            DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
            String url=request.getRequestURL().toString();
//            out.print(url);
        if(url.contains("index.jsp")){
            out.print("<title>VIA ERP</title>");
        }else{
            out.print("<title>Via ERP</title>");
        }
        %>
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
            <%
        //        boolean isHttps=false;    
                String msg=request.getParameter("msg");
                boolean isErp=request.getRequestURL().toString().toLowerCase().matches("(.*int\\..*)|(.*admin.*)");
                boolean isSeller=request.getRequestURL().toString().toLowerCase().matches(".*seller.*");
                if(isErp){
                    session.setAttribute("Target","ERP");
                }

            if(msg!=null){
            %>
                <script>showMes('<%=msg.replaceAll("'", "&apos;")%>',true,true);</script>    
            <%}%>
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
                        <%
                            List<CompanyDomain> cd=sess.createCriteria(CompanyDomain.class).list();
                            if(cd.isEmpty()){%>
                            VIA Software Solutions
                            <%}else{%>
                            <%=cd.get(0).getCompName()%>
                            <%}
        //                    out.print("IP: "+request.getHeader("X-Real-IP"));
                        %>
                    </span>
                </div>
                <div class="d3 left centAlText">
                    <span class="moduleTitleInNav">Home</span>
                </div>
                <div class="d3 left">
                <div class="searchCont rightAlText" style="//z-index: 9999;//position: absolute;//top:0px;//right:10px;//padding: 5px;">
                <%if(isSeller&&ad==null&&dis==null){%>
                <span title="login" onclick="loadPage('df/LoginForm.jsp')"><img class="btn" width="35px" height="35px" src="images/loginnn.svg"/></span>
                <%}%>
                <%if(isErp&&ad==null&&dis==null){%>
                <span title="login" onclick="loadPage('forms/LoginForm.jsp')"><img class="btn" width="35px" height="35px" src="images/loginnn.svg"/></span>
                <%}if(ad!=null||dis!=null){%>
                <%=(ad==null)?"<span>"+(LU==null?dis.getDisId():LU.getDisId())+"</span>":"<span class='txtCenter' style='height:35px;'>"+ad.getAdminId()+"</span>"%>
                <span title="logout"><a href='logout.jsp'><img class="btn" width="35px" height="35px" src="images/logout.svg"/></a></span>
                <%}else{
                }%>
                <!--<span title="search"><img class="btn" width="35px" height="35px" src="images/search.svg"/></span>-->
                <span title="Toggle Notification Bar" onclick="$('#impNotCont').toggleClass('nopen nclose');"><i class="fa fa-arrows-h fa-2x btn"></i></span>
                <!--<span title="reload" style="padding: 5px;cursor: default;font-size: 35px;width: 35px;height: 35px;">&circlearrowright;</span>-->
                <!--&nbsp;<input type="search" id="SCHBOX" style="background: #efefef;" placeholder="Search" name="search" class="textField" onkeyup="getKeys(this.value)"/>-->
                <div id="searchRes" style="font-size: 14px;z-index: 9999;overflow: auto;margin: 0px;background-color: #efefef;max-height: 250px;;display: none;" ></div>
                </div>
                    </div>
            <!--<span class="right" style='right:150px;width: 50px;height: 50px;color:black;'>Logout</span>-->
            <!--<span class="right" style='right:0px;color:black;'>Reload</span>-->
            
        </div>
        </div>
    <script>
        <%
        List<Material> mats=sess.createCriteria(Material.class).list();
        JSONArray jar=new JSONArray();
        for(Material m:mats){
            jar.put(new JSONObject(m.toName()));
        }
        out.print("var mats="+jar.toString()+";");
        List<FinishedProduct> fp= sess.createCriteria(FinishedProduct.class).list();
        jar=new JSONArray();
        for(FinishedProduct m:fp){
            jar.put(new JSONObject(m.toName()));
        }
        out.print("\n\nvar prods="+jar.toString()+";");
        %>

        var SearchQuery={query:"","in":"","what":"",target:""};
        function getKeys(filter) {
//                        alert(JSON.stringify(window.event.keyCode));
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
//                var patt=new RegExp(".*"+filter+".*","i");
//                alert(mat.name);
    if(patt.test(mat.name)){
        $("#searchRes").append("<div onclick='buildQuery(\"mat\",\""+mat.name.replaceAll("\"","&quot;")+"\",\""+mat.id+"\");' \n\
            style='padding:5px;'>"+mat.name+", RM <span style='padding:0px;margin:0px;float:right;right:0px;'>&nwarr;</span></div>");

    }
    }
//            patt=new RegExp(".*"+filter+".*","i");
for(var i=0;i<prods.length;i++){

                var mat=prods[i];
//                            alert(mat.name);
//                            var patt=new RegExp(".*"+filter+".*","i");
//                            alert(mat.name);
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
                <%
                    if(!isErp&&Utils.isEmpty(session.getAttribute("dis"))){
                    if(isSeller){%>
                    <li onclick="loadPg('df/LoginForm.jsp');" class="navLink" ><a href="#login" >User Login</a></li>
                <%}%>
                <a  href="#contactUs" style="color: #fff"><li class="navLink" >contact us</li></a>
                <a  href="#aboutUs" style="color: #fff"><li class="navLink" >about us</li></a>
            <%
            }
            if(!Utils.isEmpty(session.getAttribute("dis"))){
            %>
            <%if(LU==null){%>
                <li onclick="loadPg('df/distUsers.jsp');" class="navLink" ><a href="#login" >Create User</a></li>
            <%}
            if(LU==null||(LU.getRoles().matches(".*DM-REQE.*"))){
            %>
                <li onclick="loadPg('df/MakeOrder.jsp');" class="navLink" ><a href="#login" >Requisition</a></li>
            <%}
            if(LU==null||(LU.getRoles().matches(".*DM-VStock.*"))){
            %>
                <li onclick="loadPg('df/myStock.jsp');" class="navLink" ><a href="#login" >Stock</a></li>
            <%}
                if(LU==null||(LU.getRoles().matches(".*DM-OrderE.*"))){
            %>
                <li onclick="loadPg('df/recentOrders.jsp');" class="navLink" ><a href="#login" >Order</a></li>
            <%}
            if(LU==null||(LU.getRoles().matches(".*DM-FinanceE.*"))){
            %>
                <li onclick="loadPg('df/PendingBills.jsp');" class="navLink" ><a href="#login" >Pending Payment</a></li>
            <%}
            if(LU==null||(LU.getRoles().matches(".*DM-ComplaintE.*"))){
            %>
                <li onclick="loadPg('df/complain.jsp');" class="navLink" ><a href="#login" >Complaint</a></li>
            <%}
            if(LU==null||(LU.getRoles().matches(".*DM-DSR.*"))){
            %>
                <li onclick="loadPg('df/DSR.jsp');" class="navLink" ><a href="#login" >DSR</a></li>
            <%}
            if(LU==null||(LU.getRoles().matches(".*DM-FinanceE.*"))){
            %>
                <li onclick="loadPg('df/myFinance.jsp');" class="navLink" ><a href="#login" >Finance</a></li>
            <%}%>
                <li><a href="logout.jsp" class="navLink">Logout</a></li>    
                <a  href="#contactUs" style="color: #fff"><li class="navLink" >contact us</li></a>
                <a  href="#aboutUs" style="color: #fff"><li class="navLink" >about us</li></a>
            <%
            }
            if(isErp&&ad==null&&Utils.isEmpty(session.getAttribute("dis"))){
            %>
                <li onclick="loadPg('forms/LoginForm.jsp');" class="navLink" ><a href="#login" >User Login</a></li>
                <a  href="#contactUs" style="color: #fff"><li class="navLink" >contact us</li></a>
                <a  href="#aboutUs" style="color: #fff"><li class="navLink" >about us</li></a>
            <%}if(isErp&&ad!=null&&ad.getRole().contains(Admins.ROLE.Global.name())){%>
            <li onclick="loadPg('af/AccessManagement.jsp');" class="navLink" ><a href="#login" >Access Management</a></li>    
            <li onclick="loadPg('dev/devops.jsp');" class="navLink" ><a href="#login" >Developer Options</a></li>
            <li onclick="loadPg('af/UserActivities.jsp');" class="navLink" ><a href="#login" >Users Activities
                    <%
                List<ActivityTracer> reqs= sess.createCriteria(ActivityTracer.class).add(Restrictions.eq("seen",false)).list();
                if(reqs.size()>0){
                out.print("<span class='right' style='color:#fff;background:#ff0000;padding:5px;border-radius:50px;' >&nbsp;"+reqs.size()+"&nbsp;</span>");
                }
            %></a>
            </li>    
            <%}
            if(ad!=null&&(ad.getRole().matches("(.*"+ROLE.Global+".*)|(.*"+ROLE.Fin_V+".*)|(.*"+ROLE.ADM_Fin_E+".*)|(.*"+ROLE.Fin_D+".*)"))){
            %>
            <li onclick="loadPg('af/FinanceReq.jsp');" class="navLink" ><a href="#login" >Finance Management
            <%List<FinanceRequest> reqs= sess.createCriteria(FinanceRequest.class).add(Restrictions.eq("approved",false)).list();
                if(reqs.size()>0){
                out.print("<span class='right' style='color:#fff;background:#ff0000;padding:5px;border-radius:50px;' >&nbsp;"+reqs.size()+"&nbsp;</span>");
                }%>
            </a></li>    
            <%}if(ad!=null&&ad.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_SelPendV+".*)")){
        %>
            <li onclick="loadPg('af/ReqBalReport.jsp');" class="navLink" ><a href="#login" >Sellers Balance</a></li>    
            <%}if(ad!=null&&ad.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_ReqA+".*)|(.*"+ROLE.ADM_ReqFinStM+".*)|(.*"+ROLE.ADM_ReqStkStM+".*)")){
            %>
            <li onclick="loadPg('af/requisition.jsp');" class="navLink" ><a href="#login" >Pending Requisition
                <%
                List<DistOrderManager> orders= sess.createCriteria(DistOrderManager.class).add(Restrictions.eq("deleted", false)).add(Restrictions.ne("fstatus", DistOrderManager.FinStatus.Closed)).list();
                if(orders.size()>0){
                out.print("<span class='right' style='color:#fff;background:#ff0000;padding:5px;border-radius:50px;' >&nbsp;"+orders.size()+"&nbsp;</span>");
                }
                %>
                </a>
            </li>    
            <!--<li onclick="loadPg('af/SoldReport.jsp');" class="navLink" ><a href="#login" >Requisition Executed</a></li>-->    
                <%}if(ad!=null&&ad.getRole().matches("(.*Global.*)|(.*"+ROLE.HOO_V+".*)")){
            %>
            <li onclick="loadPg('af/hoOrders.jsp');" class="navLink" ><a href="#login" >H/O Dist Orders</a></li>    
                <%}if(ad!=null&&ad.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_ReqA+".*)")){
            %>
            <li onclick="loadPg('af/Distribution.jsp');" class="navLink" ><a href="#login" >New Invoice</a></li>    
            <!--<li onclick="loadPg('af/Returns.jsp');" class="navLink" ><a href="#login" >Warranty</a></li>-->    
                <%}if(ad!=null&&ad.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_SC_Cr+".*)|(.*"+ROLE.ADM_SC_M+".*)")){
            %>
            <li onclick="loadPg('af/DistributionForm.jsp');" class="navLink" ><a href="#login" >Sale Centers</a></li>    
                <%}if(ad!=null&&ad.getRole().matches("(.*Global.*)|(.*"+ROLE.Cr_Mat+".*)")){%>
            <li onclick="loadPg('af/AddMaterial.jsp');" class="navLink"><a href="#" >Material Management</a></li>        
                <%}if(ad!=null&&ad.getRole().matches("(.*Global.*)|(.*"+ROLE.Cr_Prod+".*)")){%>
            <li onclick="loadPg('af/AddFinishedProduct.jsp');" class="navLink"><a href="#" >Product Management</a></li>        
            <li onclick="loadPg('af/ImageMan.jsp');" class="navLink"><a href="#" >Product Images</a></li>        
                <%}if(ad!=null&&ad.getRole().matches("(.*Global.*)|(.*"+ROLE.SKUStock_V+".*)")){%>
            <li onclick="loadPg('af/SKUStock.jsp');" class="navLink" ><a href="#login" >SKU Stock</a></li>    
                <%}if(ad!=null&&ad.getRole().matches("(.*Global.*)|(.*"+ROLE.SKUStock_M+".*)|(.*"+ROLE.SKU_O+".*)")){%>
            <li onclick="loadPg('af/OpeningStock.jsp');" class="navLink" ><a href="#login" >SKU Opening</a></li>    
                <%}if(ad!=null&&ad.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_BR_RMTE+".*)")){%>
            <li onclick="loadPg('af/BrTransfer.jsp');" class="navLink"><a href="#" >Material Transfer</a></li>
                <%}if(ad!=null&&ad.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_BR_ALLSTOCKV+".*)")){%>
            <li onclick="loadPg('af/RMBelowDL.jsp');" class="navLink"><a href="#" >Mat Below Deadline</a></li>
                <%}if(ad!=null&&ad.getRole().matches("(.*Global.*)|(.*"+ROLE.Br_Cr+".*)")){%>
            <li onclick="loadPg('af/BranchManagement.jsp');" class="navLink"><a href="#" >Branch Management</a></li>
                <%}if(ad!=null&&ad.getRole().matches("(.*Global.*)?(.*SalesPoint.*)?")){%>
                <!--                <li onclick="loadPg('NewWizard/newDistributor');" class="navLink" ><a href="#login" >Distributor Registration</a></li>    
                <li onclick="loadPg('NewWizard/newMat.jsp');" class="navLink"><a href="#" >Material Management</a></li>        
                <li onclick="loadPg('af/FinanceReq.jsp');" class="navLink"><a href="#" >New Finance Record</a></li>        
                <li onclick="loadPg('FinReport/');" class="navLink"><a href="#" >Finance Report</a></li>        
                <li onclick="loadPg('NewWizard/brMGMT');" class="navLink" ><a href="#login" >Branch Management</a></li>    
                <li onclick="loadPg('NewWizard/distProds');" class="navLink" ><a href="#login" >Invoice\Bills</a></li>    
                <li onclick="loadPg('NewWizard/pendBill');" class="navLink" ><a href="#login" >Pending Bills</a></li>    
                <li onclick="loadPg('NewWizard/recentBill');" class="navLink" ><a href="#login" >All Bills</a></li>    
                <li onclick="loadPg('NewWizard/newProd');" class="navLink"><a href="#" >Add Product</a></li>        
                <li onclick="loadPg('NewWizard/updProd');" class="navLink"><a href="#" >Update Product</a></li>        -->
                <%
                }if(isErp&&ad!=null&&ad.isBranchModule()){
                    if(ad.getRole().matches("(.*"+ROLE.BRM_RME+".*)|(.*"+ROLE.BRM_RMEA+".*)")){
                    %>
            <li onclick="loadPg('brf/ImportHistory.jsp');" class="navLink" ><a href="#login" >Purchase</a></li>    
                    <%}if(ad.getRole().matches("(.*"+ROLE.Cons_V+".*)")){%>
            <li onclick="loadPg('brf/MaterialConsumption.jsp');" class="navLink" ><a href="#login" >Mat Consumption</a></li>    
                    <%}if(ad.getRole().matches("(.*"+ROLE.BRM_PRODE+".*)|(.*"+ROLE.BRM_PRODEA+".*)")){%>
            <li onclick="loadPg('brf/FinishedProduct.jsp');" class="navLink" ><a href="#login" >Production </a></li>    
                    <%}if(ad.getRole().matches("(.*"+ROLE.BRM_FPOE+".*)|(.*"+ROLE.BRM_FPOEA+".*)")){%>
            <li onclick="loadPg('brf/stk.jsp');" class="navLink" ><a href="#login" >Stock</a></li>    
                    <%}if(ad.getRole().matches("(.*"+ROLE.BRM_RMOEA+".*)|(.*"+ROLE.BRM_RMOE+".*)")){%>
            <!--<li onclick="loadPg('brf/MaterialOpening.jsp');" class="navLink" ><a href="#login" >Material Opening</a></li>-->    
                <%}if(ad.getRole().matches(".*ProdRepairBr.*")){%>
            <!--<li onclick="loadPg('brf/Returns.jsp');" class="navLink" ><a href="#login" >Returns</a></li>-->    
                <%}if(ad.getRole().matches(".*ProductionEntry.*")){%>
            <!--<li onclick="loadPg('brf/FinishedProduct.jsp');" class="navLink" ><a href="#login" >Production Entry</a></li>-->
                <%}if(ad.getRole().matches(".*InwardEntry.*")){%>
            <!--<li onclick="loadPg('brf/ImportHistory.jsp');" class="navLink" ><a href="#login" >Purchase Entry</a></li>-->    
               <!--                    <li onclick="loadPg('BrManRes/consumedHist');" class="navLink" ><a href="#login" >Material Consumption</a></li>    
                        <li onclick="loadPg('BrManRes/stock');" class="navLink" ><a href="#login" >Material Stock</a></li>    
                        <li onclick="loadPg('BrManRes/importMan');" class="navLink" ><a href="#login" >Import Manager</a></li>    -->
                <%}}
                if(ad!=null){
                out.print("<li><a href=\"logout.jsp\" class=\"navLink\">Logout</a></li>");    
                }
                %>  
            <li class="navLink" onclick="loadPg('forms/Feedback.jsp');">Feedback</li>
            <a  href="index.jsp" ><li class="navLink">Home Page</li></a>
                <!--            <li><a href="#screenshot" class="navLink">Screenshots</a></li>
            <li><a href="#testimonial-s" class="navLink">Testimonials</a></li>
            <li><a href="#contact" class="navLink" id="contacts"><i class="fa fa-send"></i></a></li>-->
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
        <%if(!isErp&&!isSeller){%>
        <div class="fullWidWithBGContainer tileCont">
            <div class="tile bgwhite">
                <a href="admin" class="tileIcon" >Go to Admin Panel</a>
            </div>
            <div class="tile bgwhite">
                <a href="sellers" class="tileIcon" >Go to Sellers Panel</a>
            </div>
        </div>
        </div>
        
        <%}%>
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