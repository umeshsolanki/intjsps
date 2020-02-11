<%-- 
    Document   : purTrend
    Created on : 9 Apr, 2018, 10:40:59 AM
    Author     : UMESH-ADMIN
--%>
<%@page import="utils.Utils"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="java.util.Collection"%>
<%@page import="entities.OrderInfo"%>
<%@page import="entities.DistributorInfo"%>

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
//    Transaction tr=sess.beginTransaction();
//    List<DistOrderManager> dsm=sess.createCriteria(DistOrderManager.class).list();
//    for(DistOrderManager d:dsm){    
//        for(OrderInfo s:d.getProds()){
//            s.setDom(d);
//        }
//    }
//    tr.commit();
//    
//  
    String lbls="";
    String sold="",pur="";
//    for(FinishedProduct p:dist.getMyProds()){
//        if(!p.isDeleted()&&p.isSemiFinished()){
//        lbls+=p.getFPName()+",";
////        List<Object[]> actRec = sess.createQuery("select sum(oi.qnt)from OrderInfo oi where oi.dom.distributor=:d "
////                + " and (oi.prod=:p prod=:p) ")
//        List<Object[]> actRec = sess.createQuery("select sum(oi.qnt),sum(si.qnt) from OrderInfo oi, SaleInfo si where (oi.dom.distributor=:d or si.saleMan.dist=:d ) "
//                + " and (oi.prod=:p or si.prod=:p) ")
//                .setParameter("d", dist).setParameter("p", p)
//                .list();
//        for(Object[] o:actRec){
//            System.out.println(p.getFPName()+"-"+o[0]+","+o[1]);
//        }
//      }
//    }

    String id=request.getParameter("id"),fd=request.getParameter("fd");
    Date[] dt=Utils.gCMon(new Date());
    if(!UT.ie(id,fd)){
        dt[0]=Utils.DbFmt.parse(id);
        dt[1]=Utils.DbFmt.parse(fd);
    }
    
    List<Object[]> purRec = sess.createQuery("select sum(oi.qnt),oi.prod.FPName from OrderInfo oi where oi.dom.distributor=:d "
            + "and oi.prod.deleted=false and oi.dom.orderDate between :id and :fd group by oi.prod.FPId order by oi.prod.FPName").setParameter("d", dist)
            .setParameter("id",dt[0]).setParameter("fd",dt[1])
            .list();
    
    List<Object[]> SALEPI = sess.createQuery("select sum(oi.qnt),oi.prod.FPName from SaleInfo oi where oi.saleMan.dist=:d "
            + "and oi.prod.deleted=false and oi.saleMan.dt between :id and :fd group by oi.prod.FPId order by oi.prod.FPName")
            .setParameter("d", dist)
            .setParameter("id",dt[0]).setParameter("fd",dt[1])
            .list();
    
    List<Object[]> stock = sess.createQuery("select oi.stock,oi.prod.FPName from DistStock oi where oi.dist=:d "
            + "and oi.prod.deleted=false order by oi.prod.FPName").setParameter("d", dist).list();
  
%>
    <hr>
    <%
        String[] purc=UT.chartize(purRec, 1, 0);
        String[] SALE=UT.chartize(SALEPI, 1, 0);
        String[] stk=UT.chartize(stock, 1, 0);
    %>
    <div class="fullWidWithBGContainer">
            <p>Product Stock</p>
            <canvas id="pstk" width="auto" height="60em"></canvas>
            <p>Product Purchase </p>
            <canvas id="orderpi" width="auto" height="60em"></canvas>
            <p>Product Sale</p>
            <canvas id="sfpi" width="auto" height="60em"></canvas>
        <script>
            var rwChart=new Chart($("#orderpi"),{
            type: 'line',
            data: {
                    labels: <%=purc[0]%>,
                    datasets: [{
                        label: 'Purchased',
                        data: <%=purc[1]%>,
                        fill: false,
                        backgroundColor:'green',
                        borderColor:  'green',
                        borderWidth: 1
                    }]
                }
            });
            var sfpi=new Chart($("#sfpi"),{
            type: 'line',
            data: {
                    labels: <%=SALE[0]%>,
                    datasets: [{
                        label: 'Sale',
                        data: <%=SALE[1]%>,
                        fill: false,
                        backgroundColor:'red',
                        borderColor:  'red',
                        borderWidth: 1
                    }]
                }
            });
            
            var sfpi=new Chart($("#pstk"),{
            type: 'line',
            data: {
                    labels: <%=stk[0]%>,
                    datasets: [{
                        label: 'Current Stock',
                        data: <%=stk[1]%>,
                        fill: false,
                        backgroundColor:'gren',
                        borderColor:  'green',
                        borderWidth: 1
                    }]
                }
            });
        </script>
    </div>        