<%-- 
    Document   : AjaxMan
    Created on : 9 Oct, 2017, 4:05:14 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="java.util.Date"%>
<%@page import="org.hibernate.Query"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="utils.Utils"%>
<%@page import="entities.Ticket"%>
<%@page import="entities.OrderInfo"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="java.util.List"%>
<%@page import="entities.Admins"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div>
<%
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
     String action = request.getParameter("action");
       
               if(action.equals("viewDetails")){
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
            boolean fin=role.getRole().matches("(.*Global.*)|(.*\\(C3\\).*)"),stores=role.getRole().matches("(Global)|(.*\\(A10\\).*)");
            Object os=sess.createQuery("select sum(totalPayment-paid-discount) from DistOrderManager where seen=true and distributor=:dis").setParameter("dis", orders.getDistributor()).uniqueResult();
        %>
        <h2 class=" centAlText nomargin nopadding blkFnt bgcolt8">Docket No: <%=orders.getDocketNo()%></h2><hr>
        <span class="close fa fa-close" onclick="clrRSP()"></span>
            <div class="centAlText">
                <div class="centAlText" style="max-height: 300px;color:black;">
                <table width="100%" cellpadding="2" border='1px #000'>
                    <tr align="center"><th>Product</th><th>Qty</th>
                        <%
                        if(fin){
                        %>
                        <th>Unit Price</th><th>value</th>
                    <%}%>
                    </tr>
                <%
                    for(OrderInfo o:orders.getProds()){
                       %>
                    <tr align="center"><td><%=o.getProd().getFPName()%></td><td><%=o.getQnt()%></td>
                         <%
                        if(fin){
                        %>
                       <td><%=o.getSoldAt()%></td><td><i class="fa fa-rupee"> </i> <%=o.getQnt()*o.getSoldAt()%></td>
                       <%}%>
                    </tr>    
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
                <%
                    if(orders.isSeen()&&!orders.isDeleted()&&fin){
                %>
                <input class="textField" type="text" id="dt" name="dt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Payment Date"/>
                <select name="pSts" class="textField">
                        <option value="">Select Finance Status</option>
                        <option value="Processing">Processing</option>
                        <!--<option value="PaymentPending">Full Payment Pending</option>-->
                        <option value="Partially_Paid">Partially Paid</option>
                        <option value="Payment_Done">Payment Done</option>
                        <option value="Closed">Close</option>
                    </select>
                <input class="textField" name="disc" placeholder="Discount In INR" title="Discount" value="<%=orders.getDiscount()%>"/>
                <input class="textField" name="com" placeholder="Commission" title="Commission" value="<%=orders.getComm()%>"/><br>
                <input class="textField" name="pd" id="pd" placeholder="Paid" disabled="" value="<%=orders.getPaid()%>" title="Paid"/>
                <input title="Balance" class="textField" name="paid" id="paid"   placeholder="To Collect <%=orders.getTotalPayment()-orders.getDiscount()-orders.getPaid()%>"/>
                <input class="textField" type="text" id="invoice" name="invoice" placeholder="Invoice No.*"/>
                <input class="textField" name="tbp" disabled="" title="Seller's outstanding including current order" id="tbp" placeholder="Total Outstanding" value="<%=os%>"/><br>
            <select onchange="setPayMethod(this.value)" class="textField" type="text"  id="payMethod" name="payMethod">
                <option>Select Payment Method</option>
                <option>Cash</option>
                <option>DD</option>
                <option>NEFT</option>
                <option>RTGS</option>
                <option>Cheque</option>
                <option>Online</option>
            </select>
            <input class="textField" type="text" id="payId" disabled="true" name="payId" placeholder="Txn-Id/DD/Cheque No.*"/>
            <input class="textField" type="text" id="bkNm" name="bkNm" disabled="true" placeholder="Bank Name*"/><br>
            <textarea class="txtArea" name='finMes' title='Finance comment'placeholder="Finance Dept Message"><%=(orders.getFinMes())%></textarea>
            <%}%>
            <textarea class="txtArea" disabled="" title="Seller comment" ><%=orders.getOrderNotice()%></textarea>
            <% if(orders.isSeen()&&!orders.isDeleted()&&!orders.isStockUpdated()&&stores){%>
            <textarea class="txtArea" name='disMes' title="Distributor " placeholder="Dist Dept comment"><%=(orders.getDisMes())%></textarea><br>
            <input class="textField date" type="text" id="ddt" name="ddt" title="Delivered Date" placeholder="Delivered Date" value="<%=Utils.DbFmt.format(new Date())%>"/>
            <select name="dSts" class="textField">
                <option value="">Select Distribution Status</option>
                <option value="Processing">Processing</option>
                <!--<option value="Dispatched">Dispatched</option>-->
                <option value="Delivered">Delivered</option>
            </select>
            <br>
            <%}
            if(orders.isStockUpdated()){%>
            <textarea class="txtArea" disabled="" name='disMes' title="Store manager note" placeholder="Store Manager comment"><%=(orders.getDisMes())%></textarea><br>
            <%}%>
            
            <%if(orders.isSeen()&&!orders.isDeleted()){%>
            <br><button class="button" onclick="return subForm('oUpdate','FormManager')">Update</button>
            <%}%>
            </form>
            </p>
            </div>
        </div>
            
            <%  }
           if(action.equals("vTkt")){
Admins role=(Admins)session.getAttribute("role");
    if(role==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
        <%
        return ;
        }
            String tId=request.getParameter("tId");
            Ticket ti=(Ticket)sess.get(Ticket.class,new Long(tId));    
        %>
        <h2 class="nomargin nopadding white">Details for Ticket No: <%=ti.getTickId()%></h2><hr>
        <div>
            <form onsubmit="return false;">
                
            </form>
        </div>
        
        <table width="100%" cellpadding="2">
            <tr align="left"><th>Product</th><th>Qty</th><th>Sale Price</th></tr>
        </table>    
                   
<%
}
%>
</div>
<script>
    $(".date").on("focus",function(){
                    this.type='date';
                });
    $(".date").on("blur",function(){
                    this.type='text';
                });
                
</script>