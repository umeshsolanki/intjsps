<%-- 
    Document   : receivable
    Created on : 28 Feb, 2018, 11:36:03 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.InwardManager"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="entities.MaterialStockListener"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.FinanceRequest"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="utils.UT"%>
<%@page import="entities.Admins"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    Admins role=(Admins)request.getSession().getAttribute("role");
    if(role==null){
        response.sendRedirect("?msg=Login Please");
        return;
    }
    
//    MaterialStockListener opn=new MaterialStockListener();
    List<MaterialStockListener> pr=sess.createCriteria(MaterialStockListener.class)
            .add(Restrictions.isNotNull("mat"))
            .add(Restrictions.eq("type", MaterialStockListener.Type.Opening)).list();
//    List<InwardManager> matO=sess.createCriteria(InwardManager.class).add(Restrictions.eq("opening", true)).list();
//    out.print(pr.size());
%>
    <hr>
    <div class="fullWidWithBGContainer">
        <div class="half left">
            <h3 class="nomargin nopadding centAlText">Material Opening</h3>
            <div class="scrollable">
    <table width="100%" cellpadding="5" border="1px">
    <thead>
        <tr rowspan="2" align="left" >
            <th>Date</th><th>Material</th><th>Branch</th><th>Qnt</th>
        </tr>
    </thead>
    <%
    for(MaterialStockListener df:pr){
    %>
    <tr>
        <td><%=df.getD()%></td>
        <td><%=df.getMat().getMatName()%></td>
        <td><%=df.getBr().getBrName()%></td>
        <td><%=df.getClosingStock()-df.getOpeningStock()+" "+df.getMat().getPpcUnit()%></td>
    </tr>
    <%}%>
    </table>
</div>
        </div>
    <div class="half right">
        <h3 class="nomargin nopadding centAlText">Product opening</h3>
        <div class="scrollable">
    <table width="100%" cellpadding="5" border="1px">
    <thead>
        <tr rowspan="2" align="left" >
            <th>Date</th><th>Product</th><th>Branch</th><th>Qnt</th>
        </tr>
    </thead>
    <%
    pr=sess.createCriteria(MaterialStockListener.class)
        .add(Restrictions.isNotNull("semi"))
        .add(Restrictions.eq("type", MaterialStockListener.Type.Opening)).list();
    for(MaterialStockListener df:pr){
    %>
    <tr>
        <td><%=df.getD()%></td>
        <td><%=df.getSemi().getFPName()%></td>
        <td><%=df.getBr().getBrName()%></td>
        <td><%=df.getClosingStock()-df.getOpeningStock()%></td>
    </tr>
    <%}%>
    </table>
</div>
    </div>
    </div>
    