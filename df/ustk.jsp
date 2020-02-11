<%-- 
    Document   : ustk
    Created on : 6 Jan, 2018, 12:55:20 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="entities.DistributorInfo"%>
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
    DistributorInfo role=(DistributorInfo)session.getAttribute("dis");
    DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
    if(role==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
<%
        return ;
    }
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    sess.refresh(role);
    
    List<FinishedProduct> prods=new ArrayList(role.getMyProds());
//List<ProductionBranch> br=sess.createCriteria(ProductionBranch.class).list();
//    List<Material> mats=sess.createCriteria(Material.class).list();
%>
<div style="max-width: 100%;">
    <span class="fa fa-close close" id="close" onclick="clrLSP();"></span>
    <div class="fullWidWithBGContainer">
    <center>
        <%if(LU==null||(LU!=null&&LU.getRoles().matches(".*UStk.*"))){%>
        <div class="">
            <span class="white"><h2 class="nopadding nomargin">Update Stock</h2></span><hr>
        <br>
        <form action="U" class="borderRight" method="post" name="loginForm" id='psf' >
            <input type="hidden" name="action"  id="action" value="udstk"/><br>
            <input type="hidden" name="t"  id="action" value="u"/>
            <select class="textField" name="p" id="pId">
            <option value="">Select Product</option>
                <%
                for(FinishedProduct fp:prods){
                    %><option value="<%=fp.getFPId()%>"><%=fp.getFPName()%></option><%
                }
                %>
            </select><br>
            <input type="date" name="d" id="dt" class="textField" value="<%=Utils.DbFmt.format(new Date())%>"/><br>
            <textarea name="r" class="txtArea" placeholder="Reason"></textarea><br>
            <input class="textField" type="text"  id="amt" name="q" placeholder="New Stock Value"/><br><br>
            <button onclick='return subForm("psf","U")' id="editBtn" class="button">Save</button>
        </form>
        <br><br>
    </div>
            <%}%>
    </center>
    </div>
</div>
    <center>
        <div style="padding: 0px;" class="fullWidWithBGContainer" id="subPageContainer">

        </div>
    </center>