<%-- 
    Document   : genbr
    Created on : 4 Jan, 2018, 2:14:43 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.Manufactured"%>
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
    List<Manufactured> prods=sess.createQuery("from Manufactured mc "+((p!=null&&p.matches("\\d+"))?"where pr.reqId="+new Long(p):"")+"").list();
    %>
    <span class="close fa fa-close" id="close" onclick="<%=p!=null?"clrLSP()":"closeMe()"%>"></span>
    <div>
        
        <span class="white"><h2 class="nomargin nopadding centAlText">Manufactured Products</h2></span>
    <hr>
      <table width="100%" border="1px" cellpadding="5" >
        <thead>
            <tr align="center">
                <th>ProducedOn</th>
                <th>Branch</th>
                <th>Product</th>
                <th>Barcode</th>
                <th>Trace</th>
            </tr>
        </thead>
        <tbody style="max-height: 500px;overflow: auto">
        <%for(Manufactured in:prods){%>
            <tr align="center">
                <td><%=in.getManOn()%></td>
                <td><%=in.getPr().getProducedBy().getBrName()%></td>
                <td><%=in.getpCat().getFPName()%></td>
                <td><%=in.getBar()%></td>
                <td><%=in.getTrace()%></td>
        <%}%>
        </tbody>
        </table>
    </div>
        <style>
        .popSMLE{
            box-shadow: 4px 4px 25px black;
        }
        </style>
</div>