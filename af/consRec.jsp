<%-- 
    Document   : MaterialConsumption
    Created on : 28 Jul, 2017, 10:36:18 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="utils.UT"%>
<%@page import="entities.Admins"%>
<%@page import="entities.MaterialConsumed"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.StockManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div  class="loginForm">
    <span class="close" id="close" onclick="closeMe()">&Cross;</span>
    <!--<span></span>-->
    
    
    <style>
        table tr th{
            border-bottom: 1px solid #000;
        }
    </style>
<%
Admins role=(Admins)session.getAttribute("role");
    if(role==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
        <%
    return ;
}
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    String iLim=request.getParameter("ini");
    int ini=0;
    if(iLim!=null&&iLim.matches("\\d+")){
        ini=Integer.parseInt(iLim);
    }
    
    List<MaterialConsumed> prods=sess.createQuery("from MaterialConsumed mc order by mc.consumeId desc").list();
    
  
    %>

    <div>
        <span class="white"><h2 class="nomargin nopadding">Material Consumption </h2></span>
    <hr>
      <table width="100%" border="1px" cellpadding="5" >
        <thead>
            <tr align="center">
                <th>Date</th>
                <th>Branch</th>
                <th>Product</th>
                <th>Qty</th>
                <th>Material</th>
                <th>Consumed</th>
            </tr>
        </thead>
        <tbody style="max-height: 500px;overflow: auto">

      
<%for(MaterialConsumed in:prods){%>

            <tr align="center">
                <td><%=in.getStoreId().getProducedOn()%></td>
                <td><%=in.getStoreId().getProducedBy().getBrName()%></td>
                <td><%=in.getStoreId().getProduct().getFPName()%></td>
                <td><%=UT.df.format(in.getStoreId().getQnt())%></td>
                <td><%=in.getMat().getMatName()%></td>
                <td><%=UT.df.format(in.getQnt())+" "+in.getMat().getPpcUnit()%></td>
                <%}%>
        </tbody>
        </table>
         <br><span class="button">View More...</span><br><br>
    </div>
</div>