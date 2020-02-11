<%-- 
    Document   : cskutr
    Created on : 8 Jan, 2018, 7:26:52 AM
    Author     : UMESH-ADMIN
--%>
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
        <div class="">
        <span class="white"><h2 class="nopadding nomargin">Outward Entry</h2></span><hr>
        <br>
        <form action="U" class="borderRight" method="post" name="loginForm" id='psf' >
            <input type="hidden" name="action"  id="action" value="trcs"/>
            <input type="date" name="d" id="dt" class="textField" value="<%=Utils.DbFmt.format(new Date())%>"/><br>
            <select class="textField" name="p" id="pId">
            <option value="">Select Product</option>
                <%
                for(FinishedProduct fp:prods){
                    %><option value="<%=fp.getFPId()%>"><%=fp.getFPName()%></option><%
                }
                %>
            </select><br>
            <%if(role.getBranch()==null){%>
            <select title="For branch" class="textField" name="b"><option>Select Production Branch</option>
            <%
                        List<ProductionBranch> b=sess.createCriteria(ProductionBranch.class).list();
                    for(ProductionBranch brr:b){
                    %>
            <option value="<%=brr.getBrId()%>"><%=brr.getBrName()%></option>
            <%}%>
            </select><br>
            <%}else{%>
            <input type="hidden" value="<%=role.getBranch().getBrId()%>" name="b"/>
            <%}%>
            
            <input class="textField" type="number"  id="amt" name="q" placeholder="Quantity"/><br><br>
            <button onclick='return subForm("psf","S")' id="editBtn" class="button">Proceed</button>
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