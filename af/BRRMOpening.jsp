<%-- 
    Document   : BranchManagement
    Created on : 30 Jul, 2017, 12:32:45 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.InwardManager"%>
<%@page import="entities.Material"%>
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
List<Material> prods=sess.createCriteria(Material.class).list();
%>
<div class="loginForm">
    <span class="close" id="close" onclick="closeMe();">x</span>
    <div class="fullWidWithBGContainer">
        <div class="half left" >
            <span class="white"><h2 class="nopadding nomargin">Material Opening Manager</h2></span><hr>
        <br>
    <center>
        <form action="FormManager " method="post" name="loginForm" id='loginForm' >
            <input type="hidden" name="action" id="action" value="Mopening"/>
            <select class="textField" name="mId" id="pId">
            <option>Select Material</option>
                <%
                for(Material fp:prods){
                    %><option value="<%=fp.getMatId()%>"><%=fp.getMatName()%></option><%
                }
                %>
            </select><br><br>
            <input class="textField" type="text"  id="amt" name="amt" placeholder="Opening Amount"/><br><br>
            <button onclick='return subForm("loginForm","FormManager")' id="editBtn" class="button">Save</button>
            <br><br>
        </form>
       </center>
    </div>
    <div class="half right" >
        <span class="white"><h2 class="nopadding nomargin">Material opening</h2></span><hr>
        <div class="scrollable">
          <table style="margin:0px" width="100%" border='1' cellpadding="5px" >
        <thead>
            <tr align="left">
                <th>Material</th>
                <th>Quantity</th>
            </tr>
        </thead>
        <tbody id="MoreCont" style="max-height: 500px;overflow: auto">
            <%
            List<InwardManager> finProds=sess.createCriteria(InwardManager.class).add(Restrictions.eq("inBr", role.getBranch())).add(Restrictions.eq("opening", true)).list();
            for(InwardManager fp:finProds){
            %>
            <tr>
                <td><span><%=fp.getMatId().getMatName()%></span></td>
                <td><%=fp.getQtyInPPC()%></td>
            </tr>
            <%}%>
        </tbody>
    </table>
    </div>
    </div>
    </div>      
</div>
    <center>
                    <div style="padding: 1px;" class="fullWidWithBGContainer" id="subPageContainer">
                    </div>
    </center>