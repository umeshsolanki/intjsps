<%-- 
    Document   : BranchManagement
    Created on : 30 Jul, 2017, 12:32:45 PM
    Author     : UMESH-ADMIN
--%>

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
    <span class="close" id="close" onclick="closeMe();">&Cross;</span>
    <div class="fullWidWithBGContainer">
        <div class="tFivePer left">
            <span class="white"><h2 class="nomargin nopadding">Create New User</h2></span><hr>
    <form id="prodForm" name='prodForm' onsubmit="return false;">
                <input type="text"  name="action" id="action" value="nUser" hidden/><br>
                <input class="textField" type="text" id="brId" name="uId" placeholder="User Id"/><br>
                <input class="textField" type="text" id="pass" name="pass" placeholder="Password"/><br><br>
                <script>
                    function selModule(mod) {
//                        if(mod=="branch"){
//                            $("#adminModule").css("display","none");
//                            $("#linkedBr").prop("disabled",false);
//                            $("#branchModule").css("display","block");
//                        }else{
//                            $("#linkedBr").prop("disabled",true);
//                            $("#branchModule").css("display","none");
//                            $("#adminModule").css("display","block");
//                        }
                    }
                </script>
                <!--<input class="textField" type="text" id="brLoc" name="brLoc"  onsubmit="return false;"placeholder="Location"/><br><br>-->
<!--                <div>
                    Accessible Module<input type="radio" onchange="selModule('branch');" value="branch" name='role' />
                    Branch <input type="radio" value="admin" onchange="selModule('admin');" name='role'/> Admin </div><br>-->
                    
                    <select id='linkedBr' class="textField" name="branch">
                        <option value="">Select Branch</option>
                    <%for(ProductionBranch br:branches){
                    %>
                    <option value="<%=br.getBrId()%>"><%=br.getBrName()%></option>
                    <%}%>
                    </select>
                <div><br>
                    <div  id='branchModule' class="fullWidWithBGContainer">
                        <p style="padding-left: 10px;margin: 0;" align='left'>Select Branch To Apply These Permissions</p>
                        <div class="half left">
                        <p style="padding-left: 10px" align='left'>
                            <input type="checkbox" name="perm" value='<%=(ROLE.BRM_RMEA)%>'/>Inward Entry App<br>
                            <input type="checkbox" name="perm" value='<%=(ROLE.BRM_RME)%>'/>Inward Entry <br>
                            <input type="checkbox" name="perm" value='<%=(ROLE.BRM_PRODEA)%>'/>Production Entry App<br>
                            <input type="checkbox" name="perm" value='<%=(ROLE.BRM_PRODE)%>'/>Production Entry <br>
                        </p>
                        </div>
                        <div class="half right">
                        <p style="padding-left: 10px" align='left'>
                            <input type="checkbox" name="perm" value='<%=(ROLE.BRM_RMOEA)%>'/>Mat Op En App<br>
                            <input type="checkbox" name="perm" value='<%=(ROLE.BRM_RMOE)%>'/>Material Opening<br>
                            <input type="checkbox" name="perm" value='<%=(ROLE.BRM_FPOEA)%>'/>Product Op Entry App<br>
                            <input type="checkbox" name="perm" value='<%=(ROLE.BRM_FPOE)%>'/>Product Opening<br>
                        </p>    
                        </div>
                    </div>
    <div id='adminModule' class="fullWidWithBGContainer" >
        <p style="padding-left: 10px;margin: 0" align='left'>Mark Permissions</p><hr>
    <div class="half left">
        <p style="padding-left: 0px;margin: 0" align='left'>  
            <input value="<%=(ROLE.ADM_BR_ALLSTOCKV)%>" type="checkbox" name="perm" />View All Br Stock<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.ADM_BR_ALLStockM)%>'/>Modify All Br Stock<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.ADM_BR_RME)%>'/>All Br Purc Ent<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.ADM_BR_RMEA)%>'/>All Br Purc Ent Approval<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.ADM_BR_RMTE)%>'/>RM Transfer Ent<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.ADM_BR_RMTEA)%>'/>RM Transfer Ent App<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.ADM_SelPendV)%>'/> Seller's Pending Bal<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.ADM_Fin_E)%>'/> Finance Entry<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.ADM_Sal_E)%>'/> Salary Entry<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.ADM_SC_Cr)%>'/> Create Sale center<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.ADM_SC_M)%>'/> Edit Sale center<br>
        </p>
    </div>
    <div class="half right">
        <p style="padding-left: 0px;margin:0;" align='left'>
            <input type="checkbox" name="perm" value='<%=(ROLE.Cr_Ref)%>'/> New Referrer<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.Fin_D)%>'/> Modify Finance Entry<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.SKU_O)%>'/>SKU Stock Opening<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.ADM_ReqA)%>' />Requisition Approval<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.ADM_ReqStkStM)%>' />Requisition Stock Update<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.ADM_ReqFinStM)%>' />Requisition Finance Update<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.Cr_Mat)%>'/>Create Inward Material<br>
            <input type="checkbox" name="perm" value='<%=(ROLE.Cr_Prod)%>'/> Bill Of Matl<br>
        </p>
    </div>
                                
    </div>
    </div>
                <br><button onclick='return subForm("prodForm","FormManager")' id="editBtn" class="button">Add</button> 
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
                        <span class="white"><h2 class="nomargin nopadding">Existing Users</h2></span><hr>
                        <div class="scrollable">
                            <table class="block" border="1px #000;" width="100%" cellpadding="5">
                            <thead class="block" align='left'>
                                <tr class="block">
                                    <th class="cell_4">User Id</th>
                                    <th class="cell_4">Password</th>
                                    <th class="cell_4">Permissions</th>
                                    <th class="cell_4">Branch</th>
                                    <th class="cell_4">Action</th>
                                </tr>
                            </thead>        
                        <tbody class="block">    
        <%
            List<Admins> admins=sess.createCriteria(Admins.class).add(Restrictions.eq("deleted", false)).list();
            for(Admins pb:admins){  
        %>           <tr class="block">
                        <td class="cell_4"><%=pb.getAdminId()%></td>
                        <td class="cell_4"><%=pb.getAdminPass()%></td>
                        <td class="cell_4" style="overflow: auto;min-width: 200px;max-width:250px;"><%=pb.getRole()%></td>
                        <td class="cell_4"><%if(pb.getBranch()!=null)out.print(pb.getBranch().getBrName());%></td>
                        <td class="cell_4" style="overflow: auto;min-width: 150;max-width: 200;">
                            <button onclick='updateUser(escape("<%=pb.getAdminId()%>"))' class="button  fa fa-edit" title="Edit"></button>
                            <button class="button  fa fa-trash-o" onclick="sendDataForResp('FormManager','action=dU&id=<%=pb.getAdminId()%>',false)" title="Delete"></button>
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