<%-- 
    Document   : BranchManagement
    Created on : 30 Jul, 2017, 12:32:45 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.FinishedProductStock"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="com.oracle.jrockit.jfr.Producer"%>
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
            window.location.replace("/PullNDry/index.jsp?msg=Unauthorized Access, Please Login First");
        </script>
<%
    return ;
}
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
List<FinishedProduct> prods=sess.createCriteria(FinishedProduct.class).list();
%>
<div class="loginForm">
    <span class="close" id="close" onclick="closeMe();">x</span>
    <div class="fullWidWithBGContainer">
        <div class="half left" style="background: #449955; margin: 0px;padding: 0px;height: 400px;max-height: 400px;overflow: auto">
        <span class="white"><h2>Waste Material</h2></span><hr>
        <br>
    <center>
        <form action="FormManager " method="post" name="loginForm" id='loginForm' >
            <input type="hidden" name="action" id="action" value="waste"/>
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
    <div class="half right" style="background: #99bb99; margin: 0px;padding: 0px;height: 400px;max-height: 400px;overflow: auto">
        <span class="white"><h2>Products Stock</h2></span><hr>
          <table style="margin:0px" width="100%" cellspacing="5" >
        <thead>
            <tr align="left">
                <th>Product</th>
                <th>Quantity</th>
            </tr>
        </thead>
        <tbody id="MoreCont" style="max-height: 500px;overflow: auto">
            <%
            List<FinishedProductStock> finProds=sess.createCriteria(FinishedProductStock.class).add(Restrictions.eq("producedBy", role.getBranch())).addOrder(Order.desc("updatedOn")).list();
            for(FinishedProductStock fp:finProds){
            %>
            <tr>
                <td><span><%=fp.getFPId().getFPName()%></span></td>
                <td><%=fp.getQnt()%></td>
            </tr>
            <%}%>
        </tbody>
    </table>
    
    </div>
    </div>      
</div>
    <center>
                    <div style="padding: 1px;" class="fullWidWithBGContainer" id="subPageContainer">
                        
                    </div>
    </center>