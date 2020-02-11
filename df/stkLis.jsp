<%-- 
    Document   : MaterialConsumption
    Created on : 28 Jul, 2017, 10:36:18 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.DistributorInfo"%>
<%@page import="entities.DistStockListener"%>
<%@page import="entities.Material"%>
<%@page import="utils.UT"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
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
    <!--<span></span>-->
    <style>
        table tr th{
            border-bottom: 1px solid #000;
        }
    </style>
<%
    String p=request.getParameter("p");
    DistributorInfo role=(DistributorInfo)session.getAttribute("dis");
    if(role==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login");
        </script>
        <%
    return ;
}
    
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    sess.refresh(role);
    String pr=request.getParameter("p"),m=request.getParameter("m"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),br=request.getParameter("br");
    Criteria c=sess.createCriteria(DistStockListener.class).add(Restrictions.eq("dist",role)).add(Restrictions.eq("prod.FPId",new Long(pr)))
    .addOrder(Order.asc("dt"));
    List<DistStockListener> prods=c.list();
    %>
    <span class="close fa fa-close" id="close" onclick="clrLSP()"></span>
    <span class="white"><h2 class="nomargin nopadding centAlText">Stock logger</h2></span>
    <div class="fullWidWithBGContainer">
      <table width="100%" border="1px" cellpadding="5" >
        <thead>
            <tr align="center">
                <th>Date</th>
                <th>Product</th>
                <th>Opening</th>
                <th>In</th>
                <th>Closing</th>
                <th>Remark</th>
            </tr>
        </thead>
        <tbody style="max-height: 500px;overflow: auto">
        <%
            double op=0,cl=0;
            for(DistStockListener in:prods){
                double qnt=in.getClosing()-in.getOpening();
                op=cl;
                cl=cl+qnt;
        %>
            <tr align="center">
                <td><%=in.getDt()%></td>
                <td><%=in.getProd().getFPName()%></td>
                <td><%=op%></td>
                <td class="<%=qnt>=0?"greenFont":"redFont"%>"><%=qnt<0?-qnt:qnt%></td>
                <td><%=cl%></td>
                <td><%=in.getRemark()%></td>
            </tr>
                <%}%>
        </tbody>
        </table>
         <!--<br><span class="button">View More...</span><br><br>-->
    </div>
        <style>
        .popSMLE{
            box-shadow: 4px 4px 25px black;
        }
        </style>
</div>
    </div>
    </div>       