<%-- 
    Document   : receivable
    Created on : 28 Feb, 2018, 11:36:03 AM
    Author     : UMESH-ADMIN
--%>

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
    if(role==null){
        response.sendRedirect("?msg=Login Please");
        return;
    }
    if(!UT.ia(role, "3")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
        return;
    }
    List<FinanceRequest> pendings = sess.createCriteria(FinanceRequest.class)
            .add(Restrictions.eq("pending", true))
            .add(Restrictions.gt("credit", 0.0)).list();
%>
    <hr>
    <div class="fullWidWithBGContainer">
        <!--<div class="halfnc left">-->
            <canvas id="reqPend" height="70em"></canvas>
<!--        </div>
        <div class="halfnc right">-->
            <canvas id="odrPend"  height="70em"></canvas>
        <!--</div>-->
    </div>
    <script>
        <%
        List<Object[]> dockPend=sess.createQuery("select sum(bal+scExp-instCharge) as ttlPnd,dist.disId from DistSaleManager "
            + " where (bal>0 or scExp-instCharge>0) and dist.ownedByGA=true group by dist.disId order by ttlPnd desc").list();
        String[] dchart=UT.chartize(dockPend, 1, 0);
        
        List<Object[]> os=sess.createQuery("select sum(dom.totalPayment-dom.paid-dom.discount) as ttlPnd,dom.distributor.disId from DistOrderManager dom where dom.distributor.type is not 'Online Sale' and dom.seen=true"
                + " group by dom.distributor.disId order by ttlPnd desc").list();
        
        String[] rchart=UT.chartize(os, 1, 0);
        
        
        %> 
            new Chart($("#reqPend"),{
        type: 'bar',
        data: {
                labels: <%=dchart[0]%>,
                datasets: [{
                    label: 'Orders & Complaints Receivable',
                    data: <%=dchart[1]%>,
                    fill: false,
                    backgroundColor:'green',
                    borderColor:  'white',
                    borderWidth: 1
                }]
            }});
            new Chart($("#odrPend"),{
        type: 'bar',
        data: {
                labels: <%=rchart[0]%>,
                datasets: [{
                    label: 'Requisition Receivable ',
                    data: <%=rchart[1]%>,
                    fill: false,
                    backgroundColor:'green',
                    borderColor:  'white',
                    borderWidth: 1
                }]
            }});
    </script>
    
    <div class="scrollable">
    <table width="100%" cellpadding="5" border="1px">
    <thead>
        <tr rowspan="2" align="left" >
            <th>Date</th><th>Amount</th><th>Ref</th><th>Detail</th><th>Action</th>
        </tr>
    </thead>
    <%
    for(FinanceRequest df:pendings){
    %>
    <tr>
        <td><%=df.getTxnDate()%></td>
        <td><%=df.getCredit()%></td>
        <td class="pointer" onclick="popsl('af/dockRec.jsp?d=<%=df.getDocketNo()%>')"><%=df.getDocketNo()%></td>    
        <td><%=df.getSummary()%></td>    
        <td>
            <%if(role.getRole().matches("(.*Global.*)|(.*\\(A3\\).*)")){%>
            <span onclick="sendDataForResp('a','action=TUP&mod=Fin&i=<%=df.getFinId()%>')" class="button <%=df.isApproved()?"greenFont":"redFont"%> fa fa-thumbs-up" title="Approve"></span>
            <%}if(role.getRole().matches("(.*Global.*)|(.*\\(D3\\).*)")){%>
            <span onclick="sendDataForResp('del','action=del&mod=Fin&i=<%=df.getFinId()%>');" class="button fa fa-trash" title="Delete"></span>
          <%}%>
          </td>    
    </tr>
    <%}%>
    </table>
</div>