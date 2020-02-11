<%-- 
    Document   : ImportHistory
    Created on : 26 Jul, 2017, 1:31:45 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.Admins"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.StockManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="loginForm" style="margin: 0px;padding: 0px;">
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
            window.location.replace("/PullNDry/?msg=Unauthorized Access, Please Login First");
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
    List<StockManager> prods=sess.createCriteria(StockManager.class).addOrder(Order.desc("mat")).
    setFirstResult(ini).setMaxResults(20).add(Restrictions.eq("inBr", role.getBranch().getBrName())).list();
  
    %>

        <span class="white"><h2>Material Stock in <%=role.getBranch().getBrName()%></h2></span>
    <hr><br>
      <table style="margin:0px" width="100%" cellpadding="5" style="max-height: 500px;overflow: auto" >
        <thead>
            <tr align="left">
                <!--<th>Date</th>-->
                <th>Material</th>
                <th>In Stock(PPC Unit)</th>
            </tr>
        </thead>
        <tbody>
      
<%for(StockManager in:prods){%>

            <tr>
                <td><%=in.getMat().getMatId()%></td>
                <td><%=UT.df.format(in.getQty())+" "+in.getMat().getPpcUnit()%></td>
                <!--<td><in.getQtyInPPC()%></td>-->
<%}%>
        </tbody>
        </table>
         <br><span class="button">View More...</span><br><br>
    </div>