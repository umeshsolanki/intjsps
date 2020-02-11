<%-- 
    Document   : BranchManagement
    Created on : 30 Jul, 2017, 12:32:45 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.DistributorInfo"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
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
    if(role==null||role.getAttachedSaleCenter()!=null){
%>
        <script>
            window.location.replace("?msg=Sorry You don't have permission to access this page");
        </script>
<%
    return ;
}
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
//List<DistributorInfo> branches=sess.createCriteria(DistributorInfo.class).list();
%>      
<div class="loginForm">
    <style>
        .cell_4{
            width: 12%;
            max-width: 12%;
            display: inline-block;
            overflow: auto;
        }
        
        .block{
            display: block;
            max-width: 100%;
            /*width: 100%;*/
        }
    </style>
    <span class="close" id="close" onclick="closeMe();">&Cross;</span>
    <div class="fullWidWithBGContainer">
        <div class="half left">
            <span class="white"><h2 class="nomargin nopadding">Create New User</h2></span><hr>
    <form id="prodForm" name='prodForm' onsubmit="return false;"><br>
                    <input type="text"  name="action" id="action" value="nDUser" hidden/>
                    <input class="textField" type="text" id="brId" name="uId" placeholder="User Id"/>
                <input class="textField" type="text" id="pass" name="pass" placeholder="Password"/>
                <input class="textField" type="text" id="mob" name="mob" placeholder="Mobile"/>
                <input class="textField" type="text" id="mail" name="mail" placeholder="Mail"/>
                <script>
//                    function selModule(mod) {
//                        if(mod=="branch"){
//                            $("#adminModule").css("display","none");
//                            $("#linkedBr").prop("disabled",false);
//                            $("#branchModule").css("display","block");
//                        }else{
//                            $("#linkedBr").prop("disabled",true);
//                            $("#branchModule").css("display","none");
//                            $("#adminModule").css("display","block");
//                        }
//                    }
                </script>
                <!--<input class="textField" type="text" id="brLoc" name="brLoc"  onsubmit="return false;"placeholder="Location"/><br><br>-->
                <div >
                <!--<div>-->
<!--                        <div  id='branchModule' class='hidden'>
                        <p style="padding-left: 5em" align='left'>Mark Permissions<br><br>
                        <input type="checkbox" name="perm" value='InwardEntry'/>Inward Entry <br>
                        <input type="checkbox" name="perm" value="InwardModify" />Update Inward Entry<br>
                        <input type="checkbox" name="perm" value='ProductionEntry'/>Production Entry <br>
                        <input type="checkbox" name="perm" value='ProductionModify'/>Update Production Entry<br>
                        <input type="checkbox" name="perm" value='MatOpening'/>Material Opening<br>
                        <input type="checkbox" name="perm" value='ProdOpening'/>Product Opening<br>
                        <input type="checkbox" name="perm" value='ProdRepairBr'/>Products Repair<br>
                        </p>
                    </div>--><br>
                    <div id='adminModule'>
                        <p class="nomargin nopadding white" align='left'>&nbsp; Assign Permissions</p>
                            <div class="fullWidWithBGContainer border">
                            <div class="tFivePer left  leftAlText"><p style="margin:0px;padding: 5px" >Requisition</p></div>
                            <div class="sixtyFivePer right  leftAlText">
                                <p style="margin:0px;padding: 4px" >
                                    <input type="checkbox" name="perm" value="(VReq)" />View
                                    <input type="checkbox" name="perm" value="(CReq)" />Create
                                    <input type="checkbox" name="perm" value="(UReq)" />Update
                                    <input type="checkbox" name="perm" value="(AReq)" />Approve
                                    <input type="checkbox" name="perm" value="(DReq)" />Delete
                                </p>
                            </div>
                            <div class="tFivePer left  leftAlText"><p style="margin:0px;padding: 5px" >Finance</p></div>
                            <div class="sixtyFivePer right  leftAlText">
                                <p style="margin:0px;padding: 4px" >
                                    <input type="checkbox" name="perm" value="(VFin)" />View
                                    <input type="checkbox" name="perm" value="(CFin)" />Create
                                    <input type="checkbox" name="perm" value="(UFin)" />Update
                                    <input type="checkbox" name="perm" value="(AFin)" />Approve
                                    <input type="checkbox" name="perm" value="(DFin)" />Delete
                                </p>
                            </div>
                            <div class="tFivePer left  leftAlText"><p style="margin:0px;padding: 5px" >Stock</p></div>
                            <div class="sixtyFivePer right  leftAlText">
                                <p style="margin:0px;padding: 4px" >
                                    <input type="checkbox" name="perm" value="(VStk)" />View
                                    <input type="checkbox" name="perm" value="(CStk)" />Create
                                    <input type="checkbox" name="perm" value="(UStk)" />Update
                                    <input type="checkbox" name="perm" value="(AStk)" />Approve
                                    <input type="checkbox" name="perm" value="(DStk)" />Delete
                                </p>
                            </div>
                            <div class="tFivePer left  leftAlText"><p style="margin:0px;padding: 5px" >Orders</p><br></div>
                            <div class="sixtyFivePer right  leftAlText">
                                <p style="margin:0px;padding: 4px" >
                                    <input type="checkbox" name="perm" value="(VOdr)" />View
                                    <input type="checkbox" name="perm" value="(COdr)" />Create
                                    <input type="checkbox" name="perm" value="(UOdr)" />Update
                                    <input type="checkbox" name="perm" value="(EOdr)" />Execute
                                    <input type="checkbox" name="perm" value="(TOdr)" />Transfer
                                    <input type="checkbox" name="perm" value="(AOdr)" />Approve
                                    <input type="checkbox" name="perm" value="(DOdr)" />Delete
                                </p>
                            </div>
                            <div class="tFivePer left  leftAlText"><p style="margin:0px;padding: 5px" >Complaints</p><br></div>
                            <div class="sixtyFivePer right  leftAlText">
                                <p style="margin:0px;padding: 4px" >
                                    <input type="checkbox" name="perm" value="(VComp)" />View
                                    <input type="checkbox" name="perm" value="(CComp)" />Create
                                    <input type="checkbox" name="perm" value="(UComp)" />Update
                                    <input type="checkbox" name="perm" value="(EComp)" />Execute
                                    <input type="checkbox" name="perm" value="(TComp)" />Transfer
                                    <input type="checkbox" name="perm" value="(AComp)" />Approve
                                    <input type="checkbox" name="perm" value="(DComp)" />Delete
                                </p>
                            </div>
                            <div class="tFivePer left  leftAlText"><p style="margin:0px;padding: 5px" >DSR</p></div>
                            <div class="sixtyFivePer right  leftAlText">
                                <p style="margin:0px;padding: 4px" >
                                    <input type="checkbox" name="perm" value="(VDSR)" />View
                                    <!--<input type="checkbox" name="perm" value="(CReq)" />Create-->
                                    <!--<input type="checkbox" name="perm" value="(UReq)" />Update-->
                                    <!--<input type="checkbox" name="perm" value="(AReq)" />Approve-->
                                    <!--<input type="checkbox" name="perm" value="(DReq)" />Delete-->
                                </p>
                            </div>
                            <div class="tFivePer left  leftAlText"><p style="margin:0px;padding: 5px" >Return</p></div>
                            <div class="sixtyFivePer right  leftAlText">
                                <p style="margin:0px;padding: 4px" >
                                    <input type="checkbox" name="perm" value="(VRet)" />View
                                    <input type="checkbox" name="perm" value="(CRet)" />Create
                                    <!--<input type="checkbox" name="perm" value="(URet)" />Update-->
                                    <!--<input type="checkbox" name="perm" value="(ARet)" />Approve-->
                                    <!--<input type="checkbox" name="perm" value="(DRet)" />Delete-->
                                </p>
                            </div>
                            </div>
                        <div class="leftAlText">
<!--                            <input value="DM-REQE" type="checkbox" name="perm" />Requisition<br>
                            <input type="checkbox" name="perm" value='DM-FinanceE'/> Finance<br>
                            <input type="checkbox" name="perm" value='DM-FinanceUpdate'/> Finance Update<br>
                            <input type="checkbox" name="perm" value='DM-VStock'/>Stock<br>
                            <input type="checkbox" name="perm" value='DM-SKUOpening'/>SKU Stock Opening<br>
                            <input type="checkbox" name="perm" value='DM-OrderE' />Orders<br>
                            <input type="checkbox" name="perm" value='DM-ComplaintE'/> Complain<br>
                            <input type="checkbox" name="perm" value='DM-DSR'/>DSR <br>
                            <input type="checkbox" name="perm" value='DM-TROrders'/>Transfer Orders<br>
                            <input type="checkbox" name="perm" value='DM-TRComps'/>Transfer Complaints<br>
                            <input type="checkbox" name="perm" value='DM-OAPR'/>Approve Orders<br>
                            <input type="checkbox" name="perm" value='DM-OExe'/>Execute Orders<br>
                            <input type="checkbox" name="perm" value='DM-CAPR'/>Approve Complain<br>
                            <input type="checkbox" name="perm" value='DM-CExe'/>Execute Complain<br>-->
                            </div>
                            <!--<input type="checkbox" name="perm" value='ProdMatManagement'/> Material & Product Management<br>-->
                    </div>
                </div>
                <br><button onclick='return subForm("prodForm","FormManager")' id="editBtn" class="button">Add</button> <br><br>
            <script>
                    function updateUser(userId,add,mob){
                        user = unescape(userId);
                        $("#brId").val(user);
                        $("#mob").val(mob);
//                        $("#address").val(add);
                        $("#action").val("UDU");
                        $("#editBtn").html("Update");
                        $("#brId").on("keydown",function(){return false;});
                    }
            </script>
    </form>
        </div>
                    <div class="half right">
                        <span class="white"><h2 class="nomargin nopadding">Existing Users</h2></span><hr>
                        <div style=" margin: 0px;padding: 0px;height: 500px;max-height: 500px;overflow: auto">
                            <table class="" border="1px" width="100%" style='margin: 0px;padding: 0px;' cellpadding="5">
                            <thead class="" align='left'>
                                <tr class="">
                                    <th >User Id</th>
                                    <th >Password</th>
                                    <th >Mobile</th>
                                    <!--<th >Email</th>-->
                                    <th  style="overflow: auto;min-width: 45%;max-width: 50%;">Permissions</th>
                                    <!--<th ></th>-->
                                    <th  style="overflow: auto;min-width: 15%;max-width: 15%;">Action</th>
                                </tr>
                            </thead>        
                        <tbody class="">    
        <%
            List<DistributorInfo> admins=sess.createCriteria(DistributorInfo.class).add(Restrictions.eq("attachedSaleCenter", role)).add(Restrictions.eq("deleted", false)).list();
            for(DistributorInfo pb:admins){  
        %>           
                    <tr class="">
                        <td ><%=pb.getDisId()%></td>
                        <td ><%=pb.getPass()%></td>
                        <td ><%=pb.getMob()%></td>
                        
                        <td  style="overflow: auto;min-width: 45%;max-width: 50%;"><%=pb.getRoles()%></td>
                        <%--<td ><%if(pb.getAttachedSaleCenter()!=null)out.print(pb.getAttachedSaleCenter().getDisId());%></td>--%>
                        <td  style="overflow: auto;min-width: 15%;max-width: 15%;">
                            <%--<button onclick='updateUser(escape("<%=LU.getDisId()%>","","<%=LU.getMob()%>"))' class="button" >Edit</button>--%>
                            <button class="button fa fa-trash-o" onclick="sendDataForResp('del','action=dD&id=<%=pb.getDisId()%>',false)" title="Click to Delete User"></button>
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