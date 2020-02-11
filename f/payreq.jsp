<%-- 
    Document   : AjaxMan
    Created on : 9 Oct, 2017, 4:05:14 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.Admins.ROLE"%>
<%@page import="utils.Utils"%>
<%@page import="entities.Ticket"%>
<%@page import="entities.OrderInfo"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="java.util.List"%>
<%@page import="entities.Admins"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    String action = request.getParameter("action");
    Admins role=(Admins)session.getAttribute("role");
    if(role==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
        <%
        return ;
        }
            String iod=request.getParameter("oId");
            DistOrderManager orders=(DistOrderManager)sess.get(DistOrderManager.class,new Long(iod));    
        %>
        <h2 class=" centAlText nmgn mpdn white">Docket No: <%=orders.getDocketNo()%></h2><hr>
        <span class="close fa fa-close" onclick="clrRSP()"></span>
            <div class="centAlText">
                <div class="centAlText" style="max-height: 300px;color:black;">
                <table width="100%" cellpadding="2" border='1px #000'>
            <tr align="center"><th>Product</th><th>Qty</th><th>MRP Price</th></tr>
                <%
                    for(OrderInfo o:orders.getProds()){
                       %>
             <tr align="center"><td><%=o.getProd().getFPName()%></td><td><%=o.getQnt()%></td><td><%=o.getQnt()+" x "+o.getProd().getMRP()+" = "+o.getProd().getMRP()*o.getQnt()%></td></tr>    
            <%}%>
        </table>    
        <br>
        </div>
        <div class="scrollable">
            <script>
                var payMethod="";
function setPayMethod(val){
    payMethod=val;
    if(val==="Select Payment Method"){
        $("#payId").attr("disabled","disabled");
        $("#payId").val("");
        $("#bkNm").attr("disabled","disabled");
        $("#bkNm").val("");
        $("#paid").attr("disabled","disabled");
        $("#paid").val("");
    }else if(val==="Cash"){
        $("#paid").removeAttr("disabled");
        $("#paid").attr("placeholder","Amount*");
        $("#payId").attr("disabled","disabled");
        $("#payId").val("");
        $("#bkNm").attr("disabled","disabled");
        $("#bkNm").val("");
    }
    else if(val==="DD"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","DD No.*");
        $("#paid").removeAttr("Disabled");
        $("#paid").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");   
    }
    else if(val==="NEFT"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Transaction-Id*");
        $("#paid").removeAttr("Disabled");
        $("#paid").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    else if(val==="RTGS"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Transaction-Id*");
        $("#paid").removeAttr("Disabled");
        $("#paid").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    else if(val==="Cheque"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Cheque No.*");
        $("#paid").removeAttr("Disabled");
        $("#paid").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    else if(val==="Online"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Transaction-Id*");
        $("#paid").removeAttr("Disabled");
        $("#paid").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    }
            </script>
            <form onsubmit="return false;" id="oUpdate">
                <input name="action" value="upOrder" hidden/>
                <input value="<%=orders.getOrderId()%>" hidden name="oId"/>
                <%if(role.getRole().matches("(.*Global.*)|(.*(U3).*)")){%>
                <select name="pSts" class="textField">
                        <option value="">Select Finance Status</option>
                        <option value="Processing">Processing</option>
                        <!--<option value="PaymentPending">Full Payment Pending</option>-->
                        <option value="Partially_Paid">Partially Paid</option>
                        <option value="Payment_Done">Payment Done</option>
                        <option value="Closed">Close</option>
                </select>
                <select onchange="setPayMethod(this.value)" class="textField" type="text"  id="payMethod" name="payMethod">
                    <option>Select Payment Method</option>
                    <option>Cash</option>
                    <option>DD</option>
                    <option>NEFT</option>
                    <option>RTGS</option>
                    <option>Cheque</option>
                    <option>Online</option>
                </select>
            <input class="textField" name="paid" id="paid" placeholder="paying amount"/>
            <input class="textField" type="text" id="payId" disabled="true" name="payId" placeholder="Txn-Id/DD/Cheque No.*"/>
            <input class="textField" type="text" id="bkNm" name="bkNm" disabled="true" placeholder="Bank Name*"/>
            <%}%>
            <input class="textField" name="disc" placeholder="Discount In INR"/>
            <center>
                <textarea class="txtArea" name='finMes' placeholder="Message for Admin" title=" Message From Finance Dept to Admin"><%=(orders.getFinMes())%></textarea>
            <textarea disabled="" class="txtArea" name='disMes' title="Dist Dept Message" placeholder=" Message from Distribution Dept for Admin and Finance"><%=(orders.getDisMes())%></textarea>
            
            <textarea class="txtArea" disabled="" title="Sellers Remark"><%=orders.getOrderNotice()%></textarea>
            </center>
                <button class="button" onclick="return subForm('oUpdate','FormManager')">Update</button>
                <br>
            </form>
            </p>
            </div>
        </div>