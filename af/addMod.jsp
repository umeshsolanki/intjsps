<%-- 
    Document   : LoginForm
    Created on : 21 Sep, 2016, 3:41:33 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.Permissions"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.ConnectionString"%>
<%@page import="utils.Utils"%>
<%@page import="entities.Admins"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="entities.Material"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(!(session.getAttribute("role") instanceof Admins)){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
<%
    return ;
}
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
%>

<div class="" id="topScroll" >
    <span class="close fa fa-close" id="close" onclick="clrLSP()"></span>
        <!--<br>-->
        <!--<center><h1>Student Login</h1></center>-->
        
    <center>
        <div class="fullWidWithBGContainer">
            <span class="white"><h2 class="nomargin nopadding bgcolt8">Add Module</h2></span><hr>
        <form method="post" name="AddMaterial" id='addMod' >
            <input type="hidden" id='action' name="action" value="addMod" /><br>
            <input type="text" class="textField" id='i' name="i" placeholder="Module Id" />
            <input class="textField" type="text" id="name"  name="name" placeholder="*Module Name"/><br>
            <input class="textField" type="text" id="url"  name="url" placeholder="*Module URL/File Name"/>
            <input class="textField" type="text" id="img"  name="img" placeholder="*Icon Image (w/o directory)"/><br>
            <select class="textField" id="inUnit" name="inunit">
                <option value="">Select Group</option>
                <option>Finance</option>
                <option>Sale</option>
                <option>Inventory</option>
                <option>Manufacturing</option>
                <option>Human Resourse</option>
                <option>Report and Performance</option>
            </select><br>
            <textarea class="txtArea" placeholder="Customized Query"></textarea><br>
            <!--<p class="leftAlText">Permissions Needed to access this Module</p>-->
            <%--
            List<Permissions> admins=sess.createCriteria(Permissions.class).list();
            for(Permissions pb:admins){
            %>
            <p class="leftAlText"><input type="checkbox" name="perm" value='<%=pb.getPermId()%>'/><%=pb.getVisName()%></p>  
            <%}%>
<!--            <input class="textField" type="text" id="rate"  name="rate" placeholder="Rate per unit(only digits and decimal)"/>
            <br><br>--%>
            <button onclick='return subForm("addMod","FormManager");' id='adButton' class="button">Add</button><br><br>
        </form>
            </div>
</center>
</div>
<%
sess.close();
%>