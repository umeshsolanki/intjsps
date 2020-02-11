<%-- 
    Document   : ImportHistory
    Created on : 2 Aug, 2017, 1:31:45 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.SKUChangeListener"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Bill"%>
<%@page import="entities.DistributionRecord"%>
<%@page import="entities.Admins"%>
<%@page import="entities.Material"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.InwardManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if(!(session.getAttribute("role") instanceof Admins)){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
<%
    return ;
}
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
%>
<div class="loginForm" style="margin: 0px;padding: 0px;">
    <span class="close" id="close" onclick="closeMe()">&Cross;</span>  
    <style>
        table tr th{
            border-bottom: 1px solid #000;
        }
    </style>
    
<%
    
    String iLim=request.getParameter("ini");
    int ini=0;
    if(iLim!=null&&iLim.matches("\\d+")){
        ini=Integer.parseInt(iLim);
    }%>
    <div id='billCont'></div>
    <div class="fullWidWithBGContainer boxPcMinHeight">
        <div class="left half">
            <span class="white"><h2>Requisition Executed</h2></span>
    <hr>
      <table style="margin:0px" width="100%" cellpadding="5px" border='#000 1px'>
        <thead>
            <tr align="left">
                <th>Date</th>
                <th>Docket No</th>
                <th>Distributor</th>
                <th>Paid</th>
                <th>Balance</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="dataCont">
    <%
                JSONArray jar=new JSONArray();
                List<DistOrderManager> odr=sess.createCriteria(DistOrderManager.class).addOrder(Order.desc("orderId")).add(Restrictions.eq("stockUpdated", true)).list();
                for(DistOrderManager man:odr){
                    List<SKUChangeListener> list=sess.createQuery("from SKUChangeListener where odrMan=:oman").setParameter("oman",man).list();
                    if(!list.isEmpty()){
                        jar.put(list);
                    }
    %>
<tr>
    <td><%=man.getOrderDate()%></td>
    <td><%=man.getDocketNo()%></td>
    <td><%=man.getDistributor().getDisId()%></td>
    <td><%=man.getPaid()%></td>
    <td><%=man.getTotalPayment()-man.getPaid()-man.getDiscount()%></td>
    <td><span class="button" onclick="showProdTrace(<%=man.getOrderId()%>,<%=man.getDocketNo()%>);">view</span></td>
</tr>
        
<%}%>        

        </tbody>
    </table>
</div>
<div class="half right">
    <script>
        var proStockList=<%=jar.toString()%>;
        function showProdTrace(oId,Dno) {
//            alert(oId);
        var sel="<h2>Stock affected by Docket No:"+Dno+" </h2><hr>\n\
        <table width='100%' border='#000 1px' cellpadding='5px'><thead>\n\
            <tr align='left'><th>Product</th><th>Opening</th><th>Closing</th></tr>";
            for(var disDtl in proStockList){
                var stkInfo=proStockList[disDtl];
                for(var info in stkInfo){
                    var dtl=JSON.parse(stkInfo[info]);
                    if(dtl.ordMan==oId){
                        var pro=JSON.parse(dtl.pro);
                   sel+="<tr><td>"+pro.fpName+"</td><td>"+dtl.o+"</td><td>"+dtl.c+"</td></tr>";     
                    }
                }
            }
            sel+="</tbody></table>";
            $("#orderCont").html(sel);
        }
        
    </script>
    <div id="orderCont">
        
    </div>
    
</div>
</div>
</div>