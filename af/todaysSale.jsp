<%-- 
    Document   : DisFinance
    Created on : Oct 12, 2017, 10:20:53 PM
    Author     : sunil
--%>

<%@page import="entities.SaleInfo"%>
<%@page import="entities.DistSaleManager"%>
<%@page import="org.hibernate.Query"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="entities.BankAccount"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="utils.UT"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.FinanceRequest"%>
<%@page import="entities.Admins"%>
<%@page import="entities.FinanceRequest"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    Admins role=(Admins)request.getSession().getAttribute("role");
    if(role==null){
        response.sendRedirect("?msg=Login Please");
        return;
    }
    boolean vc=false;
    if(!UT.ia(role, "3")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
        return;
    }
        
        Date nw=new Date();
        String m=request.getParameter("p"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),v=request.getParameter("v"),d=request.getParameter("d");
        vc=v!=null&&v.equals("1");
        
        Date[] curr=(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}"))?new Date[]{Utils.DbFmt.parse(iD),Utils.DbFmt.parse(fD)}:Utils.gCMon(new Date());
        double mCr=0,mDr=0;
        double credSum=0,debitSum=0;
        Criteria c = sess.createCriteria(DistSaleManager.class)
                .addOrder(Order.desc("dt"));
        if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
            c.add(Restrictions.between("dt", Utils.DbFmt.parse(iD), Utils.DbFmt.parse(fD)));
//            c.add(Restrictions.eq("dist.disId",d));
        }else if(iD!=null&&iD.matches(".{10}")){
            c.add(Restrictions.eq("dt", Utils.DbFmt.parse(iD)));       
        }else{
               c.add(Restrictions.between("dt", curr[0],curr[1]));
        }
        if(!Utils.isEmpty(d)){
            c.add(Restrictions.eq("dist.disId",d));
        }
    
//    List<Object[]> prodsRec=sess.createSQLQuery("select * from DistSaleManager_SaleInfo ").list();
//    Transaction tr=sess.beginTransaction();
//    for(Object dsm:sess.createCriteria(DistSaleManager.class).list()){
//        DistSaleManager sm=(DistSaleManager)dsm;
//        for(SaleInfo si:sm.getSaleRecord()){
//            si.setSaleMan(sm);
//        }
//    }
//    tr.commit();
     List<Object[]> prodsSaleRec=sess.createQuery("select sum(qnt) as ttlQnt,sum(qnt*soldAt),prod.FPName from SaleInfo si where ( si.saleMan.dt between :id and :fd ) group by prod.FPId order by ttlQnt desc")
            .setParameter("id", curr[0]).setParameter("fd", curr[1]).list();
    
    String[] prodWiseChart=UT.chartize(prodsSaleRec, 2,0);
    
//    List<Object[]> prodsManufRec=sess.createQuery("select sum(qnt),sum(qnt*soldAt),prod.FPName from SaleInfo si where ( si.saleMan.dt between :id and :fd ) group by prod.FPId")
//            .setParameter("id", curr[0]).setParameter("fd", curr[1]).list();
//    List<Object[]> RMPurchaseRec=sess.createQuery("select sum(qnt),sum(qnt*soldAt),prod.FPName from SaleInfo si where ( si.saleMan.dt between :id and :fd ) group by prod.FPId")
//            .setParameter("id", curr[0]).setParameter("fd", curr[1]).list();
//    List<Object[]> RMConsumed=sess.createQuery("select sum(qnt),sum(qnt*soldAt),prod.FPName from SaleInfo si where ( si.saleMan.dt between :id and :fd ) group by prod.FPId")
//            .setParameter("id", curr[0]).setParameter("fd", curr[1]).list();
    
    
    Query qr=sess.createQuery("select count(*) as ttl,dist.disId from DistSaleManager dsm where "
        +" dsm.dt between :id and :fd group by dsm.dist order by ttl desc")
        .setParameter("id", curr[0]).setParameter("fd", curr[1]);
        List<DistSaleManager> list=null;
        List<Object[]> dw=null;
//        if(vc){
            list=c.list();
//        }else{
            dw=qr.list();
//        }
//        System.out.println(list.size()+","+dw.size());
//    StringBuilder sellbl=new StringBuilder("[");
//    StringBuilder selData=new StringBuilder("[");
//    String[] reflbl=new String[10];
//    String[] refdata=new String[10];
//    String[] exelbl=new String[10];
//    String[] exedata=new String[10];
//    String[] bylbl=new String[10];
//    String[] bydata=new String[10];
//    String[] prodlbl=new String[10];
//    String[] proddata=new String[10];
    
    String[] czd=UT.chartize(dw, 1, 0);
    
//    for(Object[] o:dw){
//        sellbl.append("'"+o[1]+"',");
//        selData.append(""+o[0]+",");
//    }
%>
<div class="loginForm" style="max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">
            <p>&nbsp;</p>
        </div>
        <div class="d3 left leftAlText ">
            
        </div>
        <div class="d3 left leftAlText">
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left rShadow" style="">
            <i class="fa btn fa-arrow-circle-left fa-2x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<!--            <span class="white"><h2 class="nomargin nopadding">Finance Record</h2></span><hr>-->
<div style="">
    <p class="nomargin p-15 white bgcolt8  bold">Month: <%=Utils.getWMon.format(new Date())%> </p><hr>
    <ul>
        <li title="Filters" class="bgcolef">
            <br>
            <form id="prodFil" name="prodFil">
            <select title="For seller" class="textField" name="d"><option value="" hidden="">Select Seller</option>
                <%
                List<DistributorInfo> dd=sess.createQuery("from DistributorInfo where type is not 'referer' and deleted=false order by disId").list();
                for(DistributorInfo brr:dd){
                %>
                <option value="<%=brr.getDisId()%>"><%=brr.getDisId()%></option>
                <%}%>
            </select><br>
            <select title="Branch" class="textField" name="b"><option value="" hidden="">Select Branch</option>
                <%
                List<ProductionBranch> b=sess.createQuery("from ProductionBranch order by brName").list();
                for(ProductionBranch brr:b){
                %>
                <option value="<%=brr.getBrId()%>"><%=brr.getBrName()%></option>
                <%}%>
            </select><br>
            <input title="Start date" value="<%=UT.ie(iD)?Utils.DbFmt.format(curr[0]):iD%>" class="textField" type="date" name="iD"/><br>
            <input class="textField" value="<%=UT.ie(fD)?Utils.DbFmt.format(curr[1]):fD%>" title="End Date" type="date" name="fD"/><br><br>
            <span>
                <input type="radio" name="v" value="1" <%=!vc?"":"checked"%>/>Tabular View
                <input <%=!vc?"checked":""%> type="radio" name="v" value="0" />Graphical View<br>
            </span>
            <br><br>
            <span class="right" onclick="loadPg('af/todaysSale.jsp?'+gfd('prodFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
    </ul>
</div>
<div style="" class="bgcolef">
    <p class="nomargin p-15 white bgcolt8  bold">Quick Links</p><hr>
    <ul>
    </ul>
</div>
        <br>
        </div>
        <div class="right sbnvLdr lShadow bgcolef" id="linkLoader" >
              <hr>
                <canvas id="salesChart" width="500px" height="150px"></canvas>
                <!--<canvas id="byChart" width="500px" height="150px"></canvas>-->
                <canvas id="prodWiseChart" width="800px" height="300px"></canvas>
            <script>
                var rwChart=new Chart($("#salesChart"),{
        type: 'bar',
        data: {
            label: ['Item Wise Requisition Chart'],
                labels: <%=czd[0]%>,
                datasets: [{
                    data: <%=czd[1]%>,
                    backgroundColor:getBGColrsArr(<%=czd[2]%>),
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
                rwChart=new Chart($("#prodWiseChart"),{
        type: 'bar',
        data: {
            label: ['Item Wise Requisition Chart'],
                labels: <%=prodWiseChart[0]%>,
                datasets: [{
                    data: <%=prodWiseChart[1]%>,
                    backgroundColor:getBGColrsArr(<%=prodWiseChart[2]%>),
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
            </div>
          </div>
        </div>
</div>
<%
sess.close();
%>
