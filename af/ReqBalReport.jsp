<%-- 
    Document   : RMBelowDL
    Created on : 6 Nov, 2017, 3:56:07 PM
    Author     : UMESH-ADMIN
--%>
<%@page import="entities.DistributorInfo"%>
<%@page import="entities.DistOrderManager"%>
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
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
%>


<div class=" boxPcMinHeight loginForm" style="max-width: 100%;">
    <span class="close" id="close" onclick="closeMe();">&Cross;</span>
    <div>
        <center><h2 class="nomargin nopadding white">Sellers Pending Balance</h2></center><hr>
            <div class=" popUpRight">
                <!--<span class="close" onclick='$("#pendBalCont").html("");'>&Cross;</span>-->
            </div>
            <div class="scrollable tFivePer left" >
                  <table width="100%" cellpadding='5' border="1px">        
      <thead>
            <tr align='left'><th>Seller</th><th>Bal</th></tr>
      </thead>
        <%
            List<Object[]> fin=sess.createQuery("select sum(totalPayment-paid-discount),dom.distributor from DistOrderManager dom where dom.deleted=false and seen=true group by dom.distributor").list();
                for(Object[] req:fin){
        %>
                 <tr>
                     <td><%=((DistributorInfo)req[1]).getDisId()%></td>
                     <td onclick="loadPageIn('pendBalCont','adminForms/sellerDetails.jsp?i=<%=((DistributorInfo)req[1]).getDisId()%>&fil=bal',false);" title="click to view detail" style='cursor: default;color:green'>
                        &#8377; <%=req[0]%>
                    </td>
                    <%--td style='cursor: default;color:red' title="click to view all debits of the day" onclick="loadPage('adminForms/LoadFinance.jsp?i=1&d=<%=req[2]%>')">
                        <%=req[1]%>
                    </td>
                    <td><%=((Double)req[0]-(Double)req[1])%></td--%>
                 </tr>
    <%}%>
          </table>
      </div>
            <div class="scrollable sixtyFivePer right" id="pendBalCont">
                
            </div>
    </div>
</div>      
   