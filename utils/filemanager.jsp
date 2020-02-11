<%-- 
    Document   : filemanager
    Created on : 26 Apr, 2018, 11:00:02 AM
    Author     : UMESH-ADMIN
--%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.Date"%>
<%@page import="entities.Admins"%>
<%@page import="utils.UT"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        Admins role=(Admins)session.getAttribute("role");
        if(UT.ie(role)&&role.getRole().matches(".*Global.*")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
            return;
        }
        String path=request.getParameter("p");
        File[] f=null;
        if(!Utils.isEmpty(path)){
            f=new File(path).listFiles();
        }else{
            f=File.listRoots();
        }
    
//        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
        sess.refresh(role);
        Date nw=new Date();
        Date[] curr=Utils.gCMon(nw);
        %>    
<div class="loginForm" style="max-width: 100%;">
    <style>
        .yellow{
            background-color: yellow !important;
            transition: all 1s;
            color: #449955;
        }
        .normal{
                  background-color: transparent;
                  transition: all 1s;
              }
    </style>
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">   
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\((C|U)19\\).*)")?"":"invisible"%>" onclick="popsl('f/ustk.jsp')" >
                <span class="button white"><i class="fa fa-plus-circle"></i> Update Stock</span></p>
        </div>
        <div class="d3 left leftAlText ">
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\((C|U)19\\).*)")?"":"invisible"%>" onclick="popsl('f/pof.jsp')">
                <span class="button white"><i class="fa fa-plus-circle"></i> Stock Opening</span></p>
        </div>
        <div class="d3 left leftAlText">
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\(U19\\).*)")?"":"invisible"%>" onclick="popsl('af/cskutr.jsp')">
            <span class="button white"><i class="fa fa-plus-circle"></i> CSKU Transfer</span></p>
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left" style="">
            <i class="fa btn fa-toggle-left fa-1pt25x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<!--            <span class="white"><h2 class="nomargin nopadding">Finance Record</h2></span><hr>-->
<div style="margin: 1px;padding: 1px;border: 1px white solid;">
    <p class="nomargin nopadding white bgcolt8">Filters </p><hr>
    <ul>
        <li title="Filters" class="bgcolef">
            <br>
            <form id="purFil" name="purFil">
            <select title="For branch" class="textField" name="r">
                
            </select><br>
            <select class="textField" name="p" >
            
            </select>
            <br><br>
            <span class="right" onclick="loadPg('af/BRStock.jsp?'+gfd('purFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
    </ul>
</div>
    <div style="margin-top: 10px;padding: 1px;border: 1px white solid;" class="bgcolef">
    <p class="nomargin nopadding white bgcolt8">Quick Links </p><hr>
        <ul>
            <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','quicklinks/openingRec.jsp',false);">Show Opening Record <span class="right fa fa-angle-double-right"></span></li><hr><br>
            <li>
                <form id="dtFilt">
                
                </form>
            </li>
            <li class="navLink leftAlText" onclick="popLR('quicklinks/stockVouchers.jsp?'+gfd('dtFilt'),false);">View Stock Vouchers<span class="right fa fa-angle-double-right"></span></li><hr>
        </ul>
    </div><br>
    </div>
    <div class="right sbnvLdr" id="linkLoader">
    <hr>
    <div class="fullWidWithBGContainer">
    <div class="half left">
        <h3 class="nopadding nomargin">Directory</h3>
        <div class="scrollable" >
            <table>
                <tr><th>Select</th><th>Name</th><th>Size</th><th>LastModified</th></tr>
                <%
                for(File o:f){
                if(!o.isDirectory())continue;
                %>
                <tr>
                    <td><input class="" type="checkbox"/></td><td><%=o.getName()%></td><td><%=o.getTotalSpace()/1024%></td>Kb<td><%=o.lastModified()%></td>
                </tr>
                <%}
                %>
            </table>
        </div>
    </div>
    <div class="half right" style="">
        <h3 class="nomargin nopadding">Files</h3><hr>
        <div class="scrollable" >
            <table>
                <tr><th>Select</th><th>Name</th><th>Size</th><th>LastModified</th></tr>
                <%
                for(File o:f){
                if(!o.isFile())continue;
                %>
                <tr>
                    <td><input class="" type="checkbox"/></td><td><%=o.getName()%></td><td><%=o.getTotalSpace()/1024%>Kb</td><td><%=o.lastModified()%></td>
                </tr>
                <%}
                %>
            </table>
        </div>
      </div>
    </div>
    </div>
    </div>
</div>
<%
sess.close();
%>