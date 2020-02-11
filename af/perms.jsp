<%-- 
    Document   : BranchManagement
    Created on : 30 Jul, 2017, 12:32:45 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.Permissions"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="entities.Admins"%>
<%@page import="java.util.List"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Admins role=(Admins)session.getAttribute("role");
    if(role==null||!role.getRole().matches(".*Global.*")){
        %>
        <script>
            window.location.replace("?msg=Sorry You don't have permission to access this page");
        </script>
<%
    return ;
}
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
List<ProductionBranch> branches=sess.createCriteria(ProductionBranch.class).list();
%>      
<div class="loginForm">
    <style>
/*        .cell_4{
            width: 12%;
            max-width: 12%;
            display: inline-block;
            overflow: auto;
        }*/
        
/*        .block{
            display: block;
            max-width: 100%;
            width: 100%;
        }*/
    </style>
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer">
        <div class="tFivePer left">
            <span class="white"><h2 class="nomargin nopadding">Create New Permission</h2></span><hr>
    <form id="prodForm" name='prodForm' onsubmit="return false;">
        <input type="text"  name="action" id="action" value="nPerm" hidden/><br>
                    <input class="textField" type="text" id="pId" name="pId" placeholder="Permission Name"/><br>
                <input class="textField" type="text" id="pHint" name="pHint" placeholder="Hint text/Short Name"/><br><br>
                <button onclick='return subForm("prodForm","FormManager")' id="editBtn" class="button">Add</button> 
                <br><br>
            <script>
                    function updateUser(userId,act){
                        user = unescape(userId);
                        $("#brId").val(user);
                        $("#action").val("UU");
                        $("#editBtn").html("Update");
                        $("#brId").on("keydown",function(){return false;});
                    }
            </script>
    </form>
        </div>
                    <div class="sixtyFivePer right">
                        <span class="white"><h2 class="nomargin nopadding">Existing Permissions</h2></span><hr>
                        <div class="scrollable">
                            <table class="block" border="1px #000;" width="100%" cellpadding="5">
                            <thead class="block" align='left'>
                                <tr class="block">
                                    <th class="cell_4">Perm Id</th>
                                    <th class="cell_4">Perm Hint</th>
                                    <th class="cell_4">Action</th>
                                </tr>
                            </thead>        
                        <tbody class="block">    
        <%
            List<Permissions> admins=sess.createCriteria(Permissions.class).list();
            for(Permissions pb:admins){
        %>           <tr class="block">
                        <td class="cell_4"><%=pb.getVisName()%></td>
                        <td class="cell_4"><%=pb.getHintName()%></td>
                        <td class="cell_4" style="overflow: auto;min-width: 150;max-width: 200;">
                            <button onclick='updateUser(escape("<%=pb.getPermId()%>"))' class="button  fa fa-edit" ></button>
                            <button class="button fa fa-trash-o" onclick="sendDataForResp('FormManager','action=dU&id=<%=pb.getPermId()%>',false)"></button>
                        </td>
                    </tr>
                    
            <%
            }
sess.close();
            %>
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