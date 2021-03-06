<%-- 
    Document   : BranchManagement
    Created on : 30 Jul, 2017, 12:32:45 PM
    Author     : UMESH-ADMIN
--%>

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
%>
<div class="">
    <span class="fa fa-close close" id="close" onclick="clrLSP();"></span>
    <div class="fullWidWithBGContainer">
        <div class="half left">
            <span class="white"><h2 class="centAlText nopadding nomargin">Product Opening</h2></span><hr>
        <br>
    <center>
        <form action="FormManager " method="post" name="loginForm" id='loginForm' >
            <input type="hidden" name="action" id="action" value="opening"/>
            <select class="textField" name="pId" id="pId">
            <option>Select Product</option>
                <%
                for(FinishedProduct fp:prods){
                    %><option value="<%=fp.getFPId()%>"><%=fp.getFPName()%></option><%
                }
                %>
            </select><br><br>
            <input class="textField" type="text"  id="amt" name="amt" placeholder="Opening Amount"/><br><br>
            <button onclick='return subForm("loginForm","FormManager")' id="editBtn" class="button">Save</button>
            <br><br>
        </form>
       </center>
    </div>
    <div class="half right">
        <span class="white"><h2 class="nomargin nopadding">Products Stock</h2></span><hr>
        <div class="scrollable">
         <table style="margin:0px" width="100%" cellpadding="5px" border="1px" >
            <thead>
                <tr align="left">
                    <th>Product</th>
                    <th>Quantity</th>
                </tr>
            </thead>
            <tbody id="MoreCont">
                <%
                List<ProductionRequest> finProds=sess.createCriteria(ProductionRequest.class).
                        add(Restrictions.eq("producedBy", role.getBranch())).
                        add(Restrictions.eq("opening", true)).list();
                for(ProductionRequest fp:finProds){
                %>
                <tr>
                    <td><span><%=fp.getProduct().getFPName()%></span></td>
                    <td><%=fp.getQnt()%></td>
                </tr>
                <%}%>
            </tbody>
        </table>
        </div>
    </div>
    </div>      
</div>
    <center>
        <div style="padding: 0px;" class="fullWidWithBGContainer" id="subPageContainer">

        </div>
    </center>