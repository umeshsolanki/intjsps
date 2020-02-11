<%-- 
    Document   : Feedback
    Created on : Sep 30, 2017, 10:48:40 AM
    Author     : sunil
--%>

<%@page import="utils.UT"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="entities.OrderInfo"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="java.util.List"%>
<%@page import="entities.UserFeedback"%>
<%@page import="entities.Admins"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="loginForm border" style="max-width: 100%;">
    <span class="close" id="close" onclick="closeMe();">X</span>
    <div class="fullWidWithBGContainer boxPcMinHeight">
        <script>
    <%
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        Admins role=(Admins)session.getAttribute("role");
        if(!UT.ia(role, "4")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
        return;
        }
        List<FinishedProduct> fp= sess.createCriteria(FinishedProduct.class).list();
        JSONArray jar=new JSONArray();
        for(FinishedProduct m:fp){
            if(m.isSemiFinished())
            jar.put(new JSONObject(m.toName()));
        }
        out.print("var prods="+jar.toString()+";");                    
            %>
        </script>
        
        <h2 class="nomargin nopadding white">Recent Requisition</h2><hr>
            <div class="scrollable">
            <table width="100%" border="1px" cellspacing='0' cellpadding='2'>
                <tr align="left"><th>Date</th><th>From</th><th>Docket</th><th>StockDeducted</th>
                    <!--<th>FinApproval</th>-->
                    <th>SKUApproval</th><th>SKUStatus</th><th>FinStatus</th><th>Amount</th><th>Discount</th><th>Paid</th><th>Bal</th><th style="min-width: 110px;">Action</th>
                </tr>
                <%
            List<DistOrderManager> orders=sess.createQuery("from DistOrderManager "
                    + "where deleted=false and fstatus is not :st order by orderId desc").setParameter("st", DistOrderManager.FinStatus.Closed).list();
//            out.print(orders.size());
            for(DistOrderManager odr:orders){
            %>
            <tr <% if((odr.getTotalPayment()-odr.getDiscount()-odr.getPaid())>0&&!odr.getFstatus().equals(DistOrderManager.FinStatus.Closed))out.print("style='color:red;'");else if((odr.getTotalPayment()-odr.getDiscount()-odr.getPaid())==0&&odr.getFstatus().equals(DistOrderManager.FinStatus.Closed))out.print("style='color:green;'");%>>
                    <td><%=odr.getOrderDate()%></td>
                    <td><%=odr.getDistributor().getDisId()+", "+odr.getDistributor().getType()%></td>
                    <td><%=odr.getDocketNo()%></td>
                    <td><span class='fa fa-check <%=odr.isStockUpdated()?"greenFont":"redFont"%>'/></td>
                    <!--<td><span class='fa fa-check <%=odr.isFinApp()?"greenFont":"redFont"%>'/></td>-->
                    <td><span class='fa fa-check <%=odr.isDisApp()?"greenFont":"redFont"%>'/></td>
                    <td><%=odr.getDstatus()%></td>
                    <td><%=odr.getFstatus()%></td>
                    <td>&#8377;<%=odr.getTotalPayment()%></td>
                    <td>&#8377;<%=odr.getDiscount()%></td>
                    <td>&#8377;<%=odr.getPaid()%></td>
                    <td>&#8377;<%=odr.getTotalPayment()-odr.getDiscount()-odr.getPaid()%></td>
                    <td >
                    <button onclick="loadPageIn('oProds','forms/AjaxMan.jsp?action=viewDetails&oId=<%=odr.getOrderId()%>',false)"class="button fa fa-eye" title="View"></button>
                    <%if(role.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_ReqA+".*)")){%>
                    <%if(!odr.isDeleted()&&!odr.isSeen()){%>
                        <button title="Approve" onclick="sendDataForResp('FormManager','action=TUP&mod=DReq&i=<%=odr.getOrderId()%>&who=PERM',false);" class="button fa fa-thumbs-up"></button>
                        <button title="Cancel" class="<%=odr.isDeleted()?"redFont":"greenFont"%> button fa fa-trash" id="deleteBtn" onclick="sendDataForResp('FormManager','action=dRO&dId=<%=odr.getOrderId()%>',false);"></button>
                    <%}if(odr.isSeen()){%>
                        <button title="Approved" class="button fa fa-check greenFont"></button>
                    <%}}%>
                    </td>
                </tr>
            <%
            }
            %>
            </table>
        </div>
            <div class="popUpRight" style="max-width: 500px;" id="oProds">
                
            </div>
    </div>
</div>
<%
sess.close();
%>
    