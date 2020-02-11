<%-- 
    Document   : PendingBills
    Created on : 10 Aug, 2017, 7:06:07 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.DistributorInfo"%>
<%@page import="entities.DistSaleManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.temporal.TemporalAccessor"%>
<%@page import="java.time.Duration"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Period"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Bill"%>
<%@page import="entities.DistributionRecord"%>
<%@page import="entities.Admins"%>
<%@page import="entities.Material"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.InwardManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Object dist=session.getAttribute("dis");
    if((dist==null)){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
<%
    return ;
}
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
%>    
<div class="loginForm boxPcMinHeight">
        <span class="white"><h2 class="nomargin nopadding">Pending Bills </h2></span>
        <span class="close" onclick="closeMe()"></span>
    <hr><br>
    <div id='billCont'>
      <table border="1px solid black" style="margin:0px" width="100%" cellpadding="5px" cellspacing="0" >
        <thead>
            <tr align="left">
                <th>Date</th>
                <th>Docket</th>
                <th>Referrer</th>
                <th>ExeDate</th>
                <th>Total</th>
                <!--<th>Paid</th>-->
                <th>Balance</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="dataCont">
   <%
       List<DistSaleManager> sales=sess.createQuery("from DistSaleManager where dist=:di order by refBy asc").setParameter("di", dist).list();
   for(DistSaleManager s:sales){
   %>
            <tr>
                <td><%=s.getDt()%></td>
                <td><%=s.getDocketNo()%></td>
                <td><%=s.getRefBy()%></td>
                <td><%=s.getExeDate()%></td>
                <td><%=s.getToPay()%></td>
                <!--<td><%=s.getPaid()%></td>-->
                <td><%=s.getBal()%></td>
                <td>
                    <%
                    
                    %>
                    <%if(s.getExeDate()!=null)out.print("<span class='button pointer' onclick='loadPage(\"distForms/DSR.jsp?a=today&dt="+s.getExeDate()+"\");'>"+new SimpleDateFormat("dd.MM.yy").format(s.getExeDate())+"</span>");%>
                    <%if(s.getExeDate()!=null)out.print("<span class='button pointer' onclick='loadPage(\"distForms/DSR.jsp?a=today&dkt="+s.getDocketNo()+"\");'>MV_TODAY</span>");%>
                </td>
                
                        
            </tr>
            <%}%>
        </tbody>
      </table>
    </div>
</div>