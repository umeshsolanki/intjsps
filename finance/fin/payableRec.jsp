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
            .add(Restrictions.eq("pending", true)).add(Restrictions.gt("debit", 0.0)).list();
    
    List<Object[]> os=sess.createQuery("select sum(price-paid) as ttlPayable,billNo from InwardManager dom where dom.approved=true"
                + " group by billNo order by ttlPayable desc").list();
        String[] rchart=UT.chartize(os, 1, 0);
    List<Object[]> vendWise = sess.createQuery("select sum(price-paid) as ttlPayble,purFrom from InwardManager where price-paid>0 group by purFrom order by ttlPayble desc").list();

//    for(Object[] df:pendings){
        String[] billInfo=UT.chartize(vendWise, 1, 0);
%>
    <hr>
    <div class="fullWidWithBGContainer bgcolef">
        <!--<div class="halfnc left">-->
            Purchase Pending Bills
            <canvas id="purPend" height="70em"></canvas>
            <script>
                new Chart($("#purPend"),{
        type: 'bar',
        data: {
                labels: <%=rchart[0]%>,
                datasets: [{
                    label: 'Bill Pending',
                    data: <%=rchart[1]%>,
                    fill: false,
                    backgroundColor:'green',
                    borderColor:  'red',
                    borderWidth: 1
                }]
            }});
            </script>
<!--        </div>
        <div class="halfnc right">-->
        <canvas id="purInfo" width="700px" height="200px"></canvas>
        <canvas id="purTaxInfo" width="500px" height="100px"></canvas>
        <canvas id="pendInfo" width="500px" height="100px"></canvas>
    </div>
    <script>
        var rwChart=new Chart($("#purInfo"),{
        type: 'bar',
        data: {
            label: ['Item Wise Requisition Chart'],
                labels: <%=billInfo[0]%>,
                datasets: [{
                    data: <%=billInfo[1]%>,
                    backgroundColor:getBGColrsArr(<%=billInfo[2]%>),
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
    <%--
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
</div>--%>