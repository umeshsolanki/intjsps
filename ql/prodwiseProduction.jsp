<%-- 
    Document   : receivable
    Created on : 28 Feb, 2018, 11:36:03 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="utils.Utils"%>
<%@page import="entities.SaleInfo"%>
<%@page import="entities.DistSaleManager"%>
<%@page import="org.hibernate.Transaction"%>
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
    Admins role=(Admins)request.getSession().getAttribute("role");
//    Date[] dtFilt=new Date[];
    if(role==null){
        response.sendRedirect("?msg=Login Please");
        return;
    }
    if(!UT.ia(role, "3")){
        out.print("<script>showMes('Requested resource denied to respond because of limited access rights');");
//        out.print("permission available");
        return;
        }
    String id=request.getParameter("iD"),fd=request.getParameter("fD");
    Date[] dt=Utils.gCMon(new Date());
    if(!UT.ie(id,fd)){
        dt[0]=Utils.DbFmt.parse(id);
        dt[1]=Utils.DbFmt.parse(fd);
    }
    

//    ProductionRequest
//    Transaction tr=sess.beginTransaction();
//    List<DistSaleManager> dsm=sess.createCriteria(DistSaleManager.class).list();
//    for(DistSaleManager d:dsm){    
//        for(SaleInfo s:d.getSaleRecord()){
//            s.setSaleMan(d);
//        }
//    }
//    tr.commit();

    List<Object[]> pen = sess.createQuery("select sum(developed),pr.product.FPName,"
            + "sum(toSKU),sum(toStock) from ProductionRequest pr where pr.product.semiFinished=false and (pr.producedOn between :id and :fd)  group by pr.product.FPId")
            .setParameter("id", dt[0]).setParameter("fd", dt[1])
    .list();
    
    List<Object[]> pendings = sess.createQuery("select sum(developed),pr.product.FPName,"
            + "sum(toSKU),sum(toStock) from ProductionRequest pr where pr.product.semiFinished=false "
            + "and (pr.producedOn between :id and :fd) group by pr.product.FPId")
            .setParameter("id", dt[0]).setParameter("fd", dt[1])
    .list();
    
    List<Object[]> semi = sess.createQuery("select sum(developed),pr.product.FPName"
            + " from ProductionRequest pr where pr.product.semiFinished=true and (pr.producedOn between :id and :fd) group by pr.product.FPId")
            .setParameter("id", dt[0]).setParameter("fd", dt[1])
    .list();
    
%>
    <hr>
    <%
//    for(Object[] df:pendings){
        String[] dev=UT.chartize(pendings, 1, 0);
        String[] semidev=UT.chartize(semi, 1, 0);
        
        String[] csku=UT.chartize(pendings, 1, 2);
        String[] lsku=UT.chartize(pendings, 1, 3);
//    }
    %>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="scrollable">
<!--    <table border="1px solid" cellpadding="2px">
        <thead>
            <tr><th>Bill No</th><th>Material</th><th>Qnt</th><th>Amount</th><th>Balance</th></tr>
        </thead>
            <%
//            List<ProductionRequest> im=sess.createQuery("from ProductionRequest order by producedOn desc").list();
//            for(ProductionRequest in:im){%>
            <% 
            //}
            %>
        
    </table>-->
    </div>
        <p>Finished Products production Report</p>
        <canvas id="purInfo" width="600px" height="200px"></canvas>
        <p>Semi Finished Products production Report</p>
        <canvas id="semiInfo" width="600px" height="200px"></canvas>
        <p>Transferred to CSKU</p>
        <canvas id="toCSKU" width="500px" height="100px"></canvas>
        <p>Used or stored in Local SKU</p>
        <canvas id="lsku" width="500px" height="100px"></canvas>
    </div>
    <script>
        var rwChart=new Chart($("#purInfo"),{
        type: 'bar',
        data: {
            label: ['Item Wise Requisition Chart'],
                labels: <%=dev[0]%>,
                datasets: [{
                    data: <%=dev[1]%>,
                    backgroundColor:getBGColrsArr(<%=dev[2]%>),
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
        var semiChart=new Chart($("#semiInfo"),{
        type: 'bar',
        data: {
            label: ['Item Wise Requisition Chart'],
                labels: <%=semidev[0]%>,
                datasets: [{
                    data: <%=semidev[1]%>,
                    backgroundColor:getBGColrsArr(<%=semidev[2]%>),
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
        var toCSKU=new Chart($("#toCSKU"),{
        type: 'bar',
        data: {
            label: ['Item Wise Requisition Chart'],
                labels: <%=csku[0]%>,
                datasets: [{
                    data: <%=csku[1]%>,
                    backgroundColor:getBGColrsArr(<%=csku[2]%>),
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
        var lsku=new Chart($("#lsku"),{
        type: 'bar',
        data: {
            label: ['Item Wise Requisition Chart'],
                labels: <%=lsku[0]%>,
                datasets: [{
                    data: <%=lsku[1]%>,
                    backgroundColor:getBGColrsArr(<%=lsku[2]%>),
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
//                alert(JSON.stringify(lsku));
    </script>
    
