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
   
List<Object[]> prodsSaleRec=sess.createQuery("select sum(qnt),sum(qnt*soldAt),prod.FPName from SaleInfo si where ( si.saleMan.dt between :id and :fd ) group by prod.FPId order by sum(qnt) desc")
            .setParameter("id", curr[0]).setParameter("fd", curr[1]).list();    
    String[] prodWiseChart=UT.chartize(prodsSaleRec, 2,0);
        
    
%>
<canvas id="prodWiseChart" width="800px" height="300px"></canvas>
<script>
    
    var rwChart=new Chart($("#prodWiseChart"),{
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
    });
</script>