<%-- 
    Document   : Employees
    Created on : 9 Nov, 2017, 10:25:13 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="utils.Utils"%>
<%@page import="entities.Employee"%>
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
        }
        
        .block{*/
/*            display: block;
            max-width: 100%;*/
            /*width: 100%;*/
        /*}*/
    </style>
    <span class="close" id="close" onclick="closeMe();">&Cross;</span>
    <div class="fullWidWithBGContainer">
        <div class="tFivePer left">
            <span class="white"><h2 class="nomargin nopadding">New Employee </h2></span><hr>
    <form id="empFm" name='empFm' onsubmit="return false;">
                    <input type="text"  name="action" id="action" value="nEmp" hidden/>
                    <input class="textField" type="text" id="brId" name="eId" placeholder="Employee Id"/><br>
                    <!--<input class="textField" type="text" id="pass" name="pass" placeholder="Password"/><br><br>-->
                    <input class="textField" type="text" id="brId" name="des" placeholder="Designation/Branch"/><br>
                    <input class="textField" type="text" onblur="this.type='text'" onfocus="this.type='date' "id="brId" name="doj" placeholder="Date Of Joining"/><br>
                    <!--<input class="textField" type="text" id="brId" name="eId" placeholder="Date Of Leaving"/><br>-->
                    <input class="textField" type="text" id="brId" name="sal" placeholder="Salary"/><br>
                    <input class="textField" type="text" id="brId" name="mob" placeholder="Contact"/><br>
                    <input class="textField" type="text" id="brId" name="st" placeholder="State"/><br>
                    <input class="textField" type="text" id="brId" name="ct" placeholder="City"/><br>
                    <input class="textField" type="text" id="brId" name="vil" placeholder="Town/Village"/><br>
                    <input class="textField" type="text" id="brId" name="hno" placeholder="Street HNo."/><br>
                    <input class="textField" type="text" id="brId" name="pin" placeholder="PIN"/><br>
                    <input class="textField" type="text" id="brId" name="add" placeholder="Address"/><br>
<!--                <script>
                    function selModule(mod) {
                        if(mod=="branch"){
                            $("#adminModule").css("display","none");
                            $("#linkedBr").prop("disabled",false);
                            $("#branchModule").css("display","block");
                        }else{
                            $("#linkedBr").prop("disabled",true);
                            $("#branchModule").css("display","none");
                            $("#adminModule").css("display","block");
                        }
                    }
                </script>
                <input class="textField" type="text" id="brLoc" name="brLoc"  onsubmit="return false;"placeholder="Location"/><br><br>
                <div>Accessible Module<input type="radio" onchange="selModule('branch');" value="branch" name='role' />
                    Branch <input type="radio" value="admin" onchange="selModule('admin');" name='role'/> Admin </div><br>
                    <select disabled="true" id='linkedBr' class="textField" name="branch"><option>Select Branch</option>
                    <%for(ProductionBranch br:branches){
                    %>
                    <option value="<%=br.getBrId()%>"><%=br.getBrName()%></option>
                    <%}%>
                    </select>
                    <div><br>
                        <div  id='branchModule' class='hidden'>
                            <p style="padding-left: 5em" align='left'>Mark Permissions<br><br>
                                <input type="checkbox" name="perm" value='InwardEntry'/>Inward Entry <br>
                            <input type="checkbox" name="perm" value="InwardModify" />Update Inward Entry<br>
                            <input type="checkbox" name="perm" value='ProductionEntry'/>Production Entry <br>
                            <input type="checkbox" name="perm" value='ProductionModify'/>Update Production Entry<br>
                            <input type="checkbox" name="perm" value='MatOpening'/>Material Opening<br>
                            <input type="checkbox" name="perm" value='ProdOpening'/>Product Opening<br>
                            <input type="checkbox" name="perm" value='ProdRepairBr'/>Products Repair<br>
                            </p>
                        </div>
                        <div id='adminModule' class="hidden textField">
                            <p style="padding-left: 5em" align='left'>Mark Permissions<br><br>
                                <input value="StockEntry" type="checkbox" name="perm" />View Stock Entry<br>
                                <input type="checkbox" name="perm" value='StockAdmin'/>Modify Stock Entry<br>
                                <input type="checkbox" name="perm" value='MatTransfer'/>Material Transfer<br>
                                <input type="checkbox" name="perm" value='FinanceEntry'/> Finance Entry<br>
                                <input type="checkbox" name="perm" value='FinanceUpdate'/> Finance Update<br>
                                <input type="checkbox" name="perm" value='ViewBranchSum'/>All Branch Summary<br>
                                <input type="checkbox" name="perm" value='SKUOpening'/>SKU Stock Opening<br>
                                <input type="checkbox" name="perm" value='OrderApproval' />Order Approval<br>
                                <input type="checkbox" name="perm" value='Distribution'/> Distribution<br>
                                <input type="checkbox" name="perm" value='ProdMatManagement'/> Material & Product Management<br>
                            </p>
                        </div>
                    </div>-->
                <br><button onclick='return subForm("empFm","FormManager")' id="editBtn" class="button">Add</button> 
            <script>
//                    function updateUser(userId,act){
//                        user = unescape(userId);
//                        $("#brId").val(user);
//                        $("#action").val("UU");
//                        $("#editBtn").html("Update");
//                        $("#brId").on("keydown",function(){return false;});
//                    }
//            </script>
    </form>
        </div>
                    <div class="sixtyFivePer right">
                        <span class="white"><h2 class="nomargin nopadding">Employees</h2></span><hr>
                        <table id="header-fixed" border="1px" cellpadding="2" style="margin:0px;" width="100%">
                        </table>
                        <div style=" margin: 0px;padding: 0px;height: 500px;max-height: 500px;overflow: auto">
                            <table id="mainTable" class="block" border="1" width="100%"
                                   style='margin: 0px;padding: 0px;' cellpadding="2">
                            <thead class="block" align='left'>
                                <tr class="block">
                                    <th class="cell_4">Emp. Id</th>
                                    <th class="cell_4">Mob</th>
                                    <th class="cell_4">City</th>
                                    <th class="cell_4">State</th>
                                    <th class="cell_4">Joined On</th>
                                    <th class="cell_4">Left On</th>
                                    <th class="cell_4">Working</th>
                                    <th class="cell_4">Designation</th>
                                    <th class="cell_4">Address</th>
                                </tr>
                            </thead>        
                        <tbody>    
        <%
            List<Employee> admins=sess.createCriteria(Employee.class).add(Restrictions.eq("deleted", false)).list();
            for(Employee pb:admins){  
        %>           
        <tr class="block">
            <td class="cell_4"><%=pb.getEmpId()%></td>
            <td class="cell_4"><%=pb.getMob()%></td>
            <td class="cell_4"><%=pb.getCity()%></td>
            <td class="cell_4"><%=pb.getState()%></td>
            <td class="cell_4"><%=Utils.HRFmt.format(pb.getJoinedOn())%></td>
            <td class="cell_4"><%=pb.getLeftOn()==null?"---":Utils.HRFmt.format(pb.getLeftOn())%></td>
            <td class="cell_4"><%=(pb.isWorking()?"Yes":"No")%></td>
            <td class="cell_4"><%=(pb.getDesignation())%></td>
            <td class="cell_4"><%=pb.getStreet()+", "+pb.getAddr()%></td>
        </tr>
                    
            <%
            }
sess.close();
            %>
                </tbody>
            </table>
                    <script>
                        copyHdr("mainTable","header-fixed");    
                    </script>
                </div>
            </div>
    </div>      
</div>
    <center>
                    <div style="padding: 1px;" class="fullWidWithBGContainer" id="subPageContainer">  
                    </div>
    </center>