<%-- 
    Document   : newEmp
    Created on : Jan 2, 2018, 2:58:35 PM
    Author     : sunil
--%>

<%@page import="entities.Admins.ROLE"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.Date"%>
<%@page import="entities.Admins"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if(!(session.getAttribute("role") instanceof Admins)){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
<%return; }
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
List<ProductionBranch> branches=sess.createCriteria(ProductionBranch.class).list();
%>
<div class="loginForm" style="background-color: #333">
    <span class="close fa fa-close" id="close" onclick="clrLSP()"></span>
        <div class="fullWidWithBGContainer">
                <span class="white"><h2 class="nomargin nopadding centAlText">Create Employee</h2></span><hr>
                <center>
                    <form id="empFm" name='empFm' onsubmit="return false;">
                    <input type="text"  name="action" id="action" value="nEmp" hidden/>
                    <input class="textField" type="text" id="brId" name="eId" placeholder="Employee Id"/>
                    <!--<input class="textField" type="text" id="pass" name="pass" placeholder="Password"/><br><br>-->
                    <input class="textField" type="text" id="brId" name="des" placeholder="Designation/Branch"/><br>
                    <input class="textField" type="text" onblur="this.type='text'" onfocus="this.type='date' "id="brId" name="doj" placeholder="Date Of Joining"/>
                    <!--<input class="textField" type="text" id="brId" name="eId" placeholder="Date Of Leaving"/><br>-->
                    <input class="textField" type="text" id="brId" name="sal" placeholder="Salary"/><br>
                    <input class="textField" type="text" id="brId" name="mob" placeholder="Contact"/>
                    <input class="textField" type="text" id="brId" name="st" placeholder="State"/><br>
                    <input class="textField" type="text" id="brId" name="ct" placeholder="City"/>
                    <input class="textField" type="text" id="brId" name="vil" placeholder="Town/Village"/><br>
                    <input class="textField" type="text" id="brId" name="hno" placeholder="Street HNo."/>
                    <input class="textField" type="text" id="brId" name="pin" placeholder="PIN"/><br>
                    <input class="textField" type="text" id="brId" name="add" placeholder="Address"/><br>
                    <div><br>
                        <div style="display: inline-block;">
                            <div  id='branchModule' class=" textField" style="float: left;" >
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
                        <div id='adminModule' class=" textField" style="float: right;">
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
                        </div>
                    </div>
                <br><button onclick='return subForm("empFm","FormManager")' id="editBtn" class="button">Add</button> <br><br>
    </form>
        </div>
    </div>
</div>
<%
    sess.close();
%>
