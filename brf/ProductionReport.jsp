<%-- 
    Document   : FinishedProduct
    Created on : 26 Jul, 2017, 3:22:39 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="utils.UT"%>
<%@page import="entities.Admins"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="entities.FinishedProductStock"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.List"%>
<%@page import="entities.FinishedProduct"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
%>
<div style="margin: 0px;padding: 0px;">
    <form id="initProduction">
        <table style="margin:0px" border='1px' width="100%" cellpadding="5" >
        <thead>
            <tr align="left">
                <th>Date</th>
                <th>Semi</th>
                <th>Developed</th>
                <th>Stock</th>
                <th>SKU</th>
                
            </tr>
        </thead>
        <tbody id="MoreCont" style="max-height: 500px;overflow: auto">
            <%
            String prodId=request.getParameter("prod");
            List<ProductionRequest> finProds=sess.createQuery("from ProductionRequest where producedBy=:pb and product.FPId=:prod order by reqId desc").setParameter("pb",role.getBranch()).setParameter("prod", Long.parseLong(prodId)).list();
            if(!finProds.isEmpty()){
                out.print("<h2><u>"+finProds.get(0).getProduct().getFPName()+"</u> Production<h2><hr>");
            }
            for(ProductionRequest fp:finProds){
            %>
            <tr>
                <td><%=fp.getProducedOn()%></td>
                <td><%=UT.df.format((fp.getQnt()-fp.getDeveloped()))%></td>
                <td><%=UT.df.format((fp.getDeveloped()))%></td>
                <td><%=fp.getToStock()%></td>
                <td><%=fp.getToSKU()%></td>
            </tr>
            <%}%>
        </tbody>
    </table>
    </form>
</div>