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
    List<Object[]> odrPI = sess.createQuery("select sum(credit),sum(debit),MONTHNAME(txnDate)||'-'||YEAR(txnDate) from DistFinance df where "
            + "dist=:d and pending=false group by (MONTH(txnDate)||'-'||YEAR(txnDate)) order by YEAR(txnDate)||MONTH(txnDate) ")
            .setParameter("d", dist)
            .list();
    
    
//    System.out.println(odrPI.size());
    
//[select sum(credit),sum(debit),MONTHNAME(txnDate) from entities.DistFinance df where dist=:d where pending=true group by MONTH(txnDate)    
    List<Object[]> pending = sess.createQuery("select sum(credit),sum(debit),MONTHNAME(txnDate)||'-'||YEAR(txnDate) from DistFinance df where "
            + "dist=:d and pending=true group by MONTH(txnDate)||'-'||YEAR(txnDate) order by YEAR(txnDate)||MONTH(txnDate) ")
            .setParameter("d", dist)
            .list();
    
    
//    List<Object[]> semi = sess.createQuery("select sum(developed),pr.product.FPName"
//            + " from ProductionRequest pr where pr.product.semiFinished=true group by pr.product.FPId")
//    .list();    
%>
    <hr>
    <%
        String[] dev=UT.chartize(odrPI, 2, 0);
        String[] cpi=UT.chartize(odrPI, 2, 1);
        String[] pendC=UT.chartize(pending, 2, 0);
        String[] pendD=UT.chartize(pending, 2, 1);
    %>
    <div class="fullWidWithBGContainer bgcolef">
    <div class="scrollable">
    </div>
        <p>Monthly Economy Indicator</p>
        <canvas id="orderpi" width="auto" height="50em"></canvas>
        <p>Pending Payment Indicator</p>
        <canvas id="pend" width="auto" height="50em"></canvas>
    </div>
    <script>
        var rwChart=new Chart($("#orderpi"),{
        type: 'line',
        data: {
                labels: <%=dev[0]%>,
                datasets: [{
                    label: 'Credits/Received',
                    data: <%=dev[1]%>,
                    fill: false,
                    backgroundColor:'green',
                    borderColor:  'green',
                    borderWidth: 1
                },{
                    label: 'Debits/Paid',
                    data: <%=cpi[1]%>,
                    fill: false,
                    backgroundColor:'red',
                    borderColor:  'red',
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
        var rwChart=new Chart($("#pend"),{
        type: 'line',
        data: {
                labels: <%=pendC[0]%>,
                datasets: [{
                    label: 'Pending Debits/Payable',
                    data: <%=pendD[1]%>,
                    fill: false,
                    backgroundColor:'red',
                    borderColor:  'red',
                    borderWidth: 1
                },{
                    label: 'Pending Credits/Receivable',
                    data: <%=pendC[1]%>,
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
    </script>