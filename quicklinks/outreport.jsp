<%-- 
    Document   : receivable
    Created on : 28 Feb, 2018, 11:36:03 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.MaterialStockListener"%>
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
    List<MaterialStockListener> pendings = sess.createCriteria(MaterialStockListener.class)
        .add(Restrictions.isNotNull("semi"))
        .add(Restrictions.gtProperty("closingStock", "openingStock"))
        .list();
    List<Object[]> matStk=sess.createQuery("select sum(closingStock-openingStock),mat "
            + "from MaterialStockListener where openingStock>closingStock and mat is not null group by mat").list();
    List<Object[]> fpStk=sess.createQuery("select sum(closingStock-openingStock),semi "
            + "from MaterialStockListener where openingStock>closingStock and semi is not null group by semi").list();
    out.print(matStk.size()+"-"+fpStk.size());
%>
    <hr>
        <canvas id="reqChart" width="400px" height="100px"></canvas>
        <canvas id="reqIChart" width="400px" height="100px"></canvas>
        <script>
            
        </script>
        