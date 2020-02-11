<%-- 
    Document   : DisFinance
    Created on : Oct 12, 2017, 10:20:53 PM
    Author     : sunil
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
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
        String param=request.getParameter("m");
        String[] m=request.getParameter("m").split("-");
        Calendar c=Calendar.getInstance();
        c.set(Calendar.YEAR, new Integer(m[0]));
        c.set(Calendar.MONTH, new Integer(m[1]));
//    Date[] curr=;
    double mCr=0,mDr=0;
//        System.out.println(curr[0]+"  "+ curr[1]);
        List<Object[]> todays = sess.createQuery("select sum(credit),sum(debit),txnDate from FinanceRequest where  pending=false and (txnDate between :iDt and :fDt )group by txnDate ")
        .setParameter("iDt", Utils.DbFmt.parse(param+"-01"))
        .setParameter("fDt", Utils.DbFmt.parse(param+"-"+c.getActualMaximum(Calendar.DATE)))
        .list();
        double credSum=0,debitSum=0;
            
%>
    <div class="scrollable">
    <table id="mainTable" width="100%" border='1px' cellpadding='5'>        
        <thead>
            <tr align='left'><th>Date</th><th>Credit</th><th>Debit</th><th>Outcome</th></tr>
        </thead>
        <%
            for(Object[] req:todays){
            debitSum+=(Double)req[0];
            credSum+=(Double)req[1];
        %>
        <tr onclick="$('.finDailyRecord').load('finance/vouchers.jsp?iD=<%=req[2]%>&v=1');">
        <td><%=req[2]%></td>
        <td title="click to view all credits of the day" style='cursor: default;color:green'>&#8377; <%=req[0]%></td>
        <td style='cursor: default;color:red' title="click to view all debits of the day">&#8377; <%=req[1]%></td>
        <td>&#8377; <%=((Double)req[0]-(Double)req[1])%></td>
         </tr>
            <%}%>
    </table>      
    <script>
        copyHdr("mainTable","header-fixed");
            $("#credSum").html("&#8377;<%=credSum%> ");              
            $("#debitSum").html("&#8377;<%=debitSum%> ");
    </script>      
    </div>
<%
sess.close();
%>
