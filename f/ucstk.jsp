<%-- 
    Document   : ustk
    Created on : 6 Jan, 2018, 12:55:20 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.Material"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.Date"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.FinishedProductStock"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="entities.Admins"%>
<%@page import="java.util.List"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Admins role=(Admins)session.getAttribute("role");
    if(role==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
<%
    return ;
}
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    List<FinishedProduct> prods=sess.createCriteria(FinishedProduct.class).list();
List<ProductionBranch> br=sess.createCriteria(ProductionBranch.class).list();
    List<Material> mats=sess.createCriteria(Material.class).list();
%>
<div class="">
    <span class="fa fa-close close" id="close" onclick="clrLSP();"></span>
    <div class="fullWidWithBGContainer">
    <center>
        <div class="half left">
            <span class="white"><h2 class="nopadding nomargin">Update Stock</h2></span><hr>
        <br>
    
        <form action="U" class="borderRight" method="post" name="loginForm" id='psf' >
            <input type="hidden" name="action"  id="action" value="ucstk"/>
            <input type="hidden" name="t"  id="action" value="u"/>
            <input type="date" name="d" id="dt" class="textField" value="<%=Utils.DbFmt.format(new Date())%>"/>
            <select class="textField" name="p" id="pId">
            <option value="">Select Product</option>
                <%
                for(FinishedProduct fp:prods){
                    %><option value="<%=fp.getFPId()%>"><%=fp.getFPName()%></option><%
                }
                %>
            </select><br>
            <textarea name="r" class="txtArea" placeholder="Reason"></textarea>
            <input class="textField" type="text"  id="amt" name="q" placeholder="New Stock Value"/><br><br>
            <button onclick='return subForm("psf","U")' id="editBtn" class="button">Save</button>
        </form>
            <br><br>
    </div>
    <div class="half right">
        <span class="white"><h2 class="nomargin nopadding">Stock Opening</h2></span><hr><br>
        <form action="U " method="post" name="loginForm" id='msf' >
            <input type="hidden" name="action"  id="action" value="ucstk"/>
            <input type="hidden" name="t"  value="o"/>
            <input type="date" name="d" id="dt" class="textField" value="<%=Utils.DbFmt.format(new Date())%>"/>
            <select class="textField" name="p" id="pId">
                <option value="">Select Product</option>
                <%
                for(FinishedProduct fp:prods){
                    %>
                    <option value="<%=fp.getFPId()%>"><%=fp.getFPName()%></option>
                <%}%>
            </select><br>
            <textarea name="r" class="txtArea" placeholder="Reason"></textarea><br>
            <input class="textField" type="text"  id="amt" name="q" placeholder="Opening Quantity"/><br><br>
            <button onclick='return subForm("msf","U")' id="editBtn" class="button">Save</button>
        </form>
            <br><br>
    </div>
        </center>
    </div>
</div>
    <center>
        <div style="padding: 0px;" class="fullWidWithBGContainer" id="subPageContainer">

        </div>
    </center>