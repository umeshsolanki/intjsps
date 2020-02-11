<%-- 
    Document   : RMBelowDL
    Created on : 6 Nov, 2017, 3:56:07 PM
    Author     : UMESH-ADMIN
--%>
<%@page import="utils.UT"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.Admins"%>
<%@page import="java.util.List"%>
<%
    Admins role=(Admins)session.getAttribute("role");
    if(role==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
        <%
    return ;
}
if(!UT.ia(role, "3")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
        return;
}
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
%>
<div class="loginForm" style="max-width: 100%;">
    <span class="close" id="close" onclick="closeMe();">X</span>
    <span class="close" id="close" style="right: " onclick="closeMe();">X</span>
    <div class="popUp" id="finExplorer"></div>
    <div class="fullWidWithBGContainer boxPcMinHeight">
<div>
    <center><h3 class="white nomargin nopadding">Finance</h3></center><hr>
    <table width="100%" border='1px' cellpadding='5'>        
      <thead>
          <tr align='left'><th>Date</th><th>Credit</th><th>Debit</th><th>Bank</th><th>Outcome</th></tr>
      </thead>
    <%
          List<Object[]> fin=sess.createQuery("select sum(credit),sum(debit),txnDate from FinanceRequest finId group by txnDate order by txnDate desc").list();
            for(Object[] req:fin){
    %>
                 <tr>
                     <td><%=req[2]%></td>
                     <td title="click to view all credits of the day" style='cursor: default;color:green' onclick="loadPageIn('finExplorer','adminForms/LoadFinance.jsp?i=0&d=<%=req[2]%>')">&#8377; <%=req[0]%></td>
                    <td style='cursor: default;color:red' title="click to view all debits of the day" onclick="loadPageIn('finExplorer','adminForms/LoadFinance.jsp?i=1&d=<%=req[2]%>')">&#8377; <%=req[1]%></td>
                <td>&#8377; <%=((Double)req[0]-(Double)req[1])%></td>
                 </tr>
    <%}%>
          </table>
      </div>
    </div>
</div>