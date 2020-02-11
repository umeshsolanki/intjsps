<%-- 
    Document   : requisitnVisibility
    Created on : 24 Apr, 2018, 11:55:57 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.OrderInfo"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String i=request.getParameter("i");
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    DistOrderManager orders=(DistOrderManager)sess.get(DistOrderManager.class,new Long(i));    
%>
<div class="loginForm" style="background-color: #efefef" class="draggable" id="matDrag">
    <span class="close fa fa-close" id="close" onclick="clrRSP()"></span>
        <div class="fullWidWithBGContainer">
                <span class=""><h2 class="nomargin nopadding centAlText">Update Requisition Visibility </h2></span><hr>
                <center><br>
                    Requisition Date :<%=Utils.HRFmt.format(orders.getOrderDate())%>
                    <table width="100%" cellpadding="2" border='1px #000' class="bgcolt8">
                    <tr align="center"><th>Product</th><th>Qty</th>
                        <th>Unit Price</th><th>value</th>
                    </tr>
                <%
                    double total=0;
                    for(OrderInfo o:orders.getProds()){
                        total+=o.getQnt()*o.getSoldAt();
                %>
                    <tr align="center"><td><%=o.getProd().getFPName()%></td><td><%=o.getQnt()%></td>
                       <td><%=o.getSoldAt()%></td><td><i class="fa fa-rupee"> </i> <%=o.getQnt()*o.getSoldAt()%></td>
                    </tr>    
            <%}%>
            <tr align="center" class="bold"><td>Total</td><td></td>
                       <td></td><td><i class="fa fa-rupee"> </i> <%=total%></td>
            </tr>    
        </table>    
                <form method="post" name="reqvisForm" id='reqvisForm' >
                    <input type="hidden" id='action' name="action" value="upOrder" /><br>
                    <input type="hidden" id='oId' name="oId" value="<%=i%>" /><br>
                    <select name="wcs" class="textField">
                        <option value="Fin">Finance Manager</option>
                        <option value="SKU">Stock Manager</option>
                        <option value="Both">Both</option>
                        <option value="SA">Only Admin</option>
                        <option value="">Select Who Can See</option>
                    </select><br>
                    <select name="dSts" class="textField">
                        <option value="Delivered">Delivered</option>
                        <option value="Processing">Processing</option>
                        <option value="">Select Distribution Status</option>
                        <!--<option value="Dispatched">Dispatched</option>-->
                        
                    </select><br><br>
                    <div class="inputWrapper">
                        <input class="textField" type="date" required="" name="ddt" value="<%=Utils.DbFmt.format(orders.getOrderDate())%>"/>
                        <span class="movLabel">Delivered Date</span>
                    </div>
                    <br><br>
                    <button onclick='return subForm("reqvisForm","FormManager");' id='adButton' class="button">Update</button><br><br>
                </form>
                </center>
        </div>
</div>
<%
    sess.close();
%>