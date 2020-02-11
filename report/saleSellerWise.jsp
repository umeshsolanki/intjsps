<%-- 
    Document   : salesVendorWise
    Created on : 17 Aug, 2018, 4:51:07 PM
    Author     : UMESH-ADMIN
--%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="entities.DistSaleManager"%>
<%@page import="org.hibernate.Query"%>
<%@page import="java.util.List"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.Date"%>
<%@page import="utils.UT"%>
<%@page import="entities.Admins"%>
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
    Query qr=sess.createQuery("select count(*),dist.disId from DistSaleManager dsm where dsm.dt between :id and :fd group by dsm.dist order by count(*) desc")
    .setParameter("id", curr[0]).setParameter("fd", curr[1]);
    List<DistSaleManager> list=null;
    List<Object[]> dw=null;
//    Criteria c = sess.createCriteria(DistSaleManager.class).addOrder(Order.desc("dt"));
//    list=c.list();
    dw=qr.list();
    String[] czd=UT.chartize(dw, 1, 0);
        
    
%>
<canvas id="salesChart" width="500px" height="150px"></canvas>
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
    });
</script>