<%-- 
    Document   : saleKPI
    Created on : 7 Apr, 2018, 3:57:40 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.DistributorInfo"%>
<%-- 
    Document   : receivable
    Created on : 28 Feb, 2018, 11:36:03 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.ProductionRequest"%>
<%@page import="entities.InwardManager"%>
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
    DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
    DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
    if(dist==null||LU!=null&&!LU.getRoles().matches(".*\\(.Fin\\).*")){
        out.print("<script>window.location.replace(\"?msg=You don't have permission to access this page\");</script>");
        return;
    }
    sess.refresh(dist);
    List<Object[]> odrPI = sess.createQuery("select count(docketNo),MONTHNAME(dt)||'-'||YEAR(dt) from DistSaleManager dsm where "
            + "dist=:d and docketNo like '2%' group by MONTH(dt)||YEAR(dt) order by YEAR(dt)||MONTH(dt)")
            .setParameter("d", dist)
            .list();
    
//    System.out.println(odrPI.size());
    
    
    List<Object[]> CPI = sess.createQuery("select count(*),MONTHNAME(dt)||'-'||YEAR(dt) from DistSaleManager dsm where "
            + "dist=:d and docketNo like '3%' group by MONTH(dt)||YEAR(dt) order by YEAR(dt)||MONTH(dt)")
            .setParameter("d", dist)
            .list();
    
    
//    List<Object[]> semi = sess.createQuery("select sum(developed),pr.product.FPName"
//            + " from ProductionRequest pr where pr.product.semiFinished=true group by pr.product.FPId")
//    .list();    
%>
    <hr>
    <%
        String[] dev=UT.chartize(odrPI, 1, 0);
//        String[] dev=UT.chartize(pendings, 1, 0);
        String[] cpi=UT.chartize(CPI, 1, 0);
    %>
    <div class="fullWidWithBGContainer bgcolef">
    <div class="scrollable">
    </div>
        <p>Orders</p>
        <canvas id="orderpi" width="700px" height="200px"></canvas>
        <p>Complaints</p>
        <canvas id="compi" width="700px" height="200px"></canvas>
    </div>
    <script>
        var rwChart=new Chart($("#orderpi"),{
        type: 'bar',
        data: {
                labels: <%=dev[0]%>,
                datasets: [{
                    label: 'Orders',
                    data: <%=dev[1]%>,
                    fill: false,
                    backgroundColor:'green',
                    borderColor:  'green',
                    borderWidth: 1
                }]
            }
//                    ,
//                    options: {
//                        scales: {
//                            yAxes: [{
//                                ticks: {
//                                    beginAtZero:true
//                                }
//                            }]
//                        }
//                    }
                });
        var semiChart=new Chart($("#compi"),{
        type: 'bar',
        data: {
                labels: <%=cpi[0]%>,
                datasets: [{
                    label: 'Complaints',
                    data: <%=cpi[1]%>,
                    backgroundColor:'green',
                    borderColor:  'rgba(255, 159, 64, 1)',
                    borderWidth: 1
                }]
            }
//                    ,
//                    options: {
//                        scales: {
//                            yAxes: [{
//                                ticks: {
//                                    beginAtZero:true
//                                }
//                            }]
//                        }
//                    }
                });
    </script>