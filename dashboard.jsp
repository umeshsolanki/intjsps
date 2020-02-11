<%-- 
    Document   : dashboard
    Created on : 7 Jun, 2018, 11:34:59 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="java.util.regex.Pattern"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URL"%>
<%@page import="entities.Tracker"%>
<%@page import="entities.Material"%>
<%@page import="utils.UT"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="entities.Admins"%>
<%@page import="entities.MaterialConsumed"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.StockManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="css/PullNDry.css" rel="stylesheet" type="text/css"/>
        <link href="font-awesome-4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet" />
        <script src="js/jquery-3.1.0.min.js" type="text/javascript"></script>
        <script src="js/pullNdry.js" type="text/javascript"></script>
        <script src="js/Chart.js" ></script>
    </head>
<div class="fullWidWithBGContainer bg">        
    <div style="height: 100vh;background: black;max-width: 20%" class="leftNav centAlText" >
        <div class="fullWidWithBGContainer">
            <span class="fa-1pt5x right bluFnt  spdn fa fa-arrow-circle-o-right"></span>
            <br>
            <p class="white lpdn">Click To View Report</p>
        </div>
    </div>
    <div style="overflow: auto">
        <div class="fullWidWithBGContainer">
            
            <div class="d3 left bgcolt8">
                OM
            </div><div class="d3 left"></div><div class="d3 left"></div>
        </div>
    </div>
</div>
</html>