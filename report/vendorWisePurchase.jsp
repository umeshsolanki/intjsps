<%-- 
    Document   : receivable
    Created on : 28 Feb, 2018, 11:36:03 AM
    Author     : UMESH-ADMIN
--%>

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
    if(role==null){
        response.sendRedirect("?msg=Login Please");
        return;
    }
    if(!UT.ia(role, "3")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
        return;
        }
//    InwardManager
    List<Object[]> pendings = sess.createQuery("select sum(price-paid) as ttlPayble,purFrom from InwardManager where price-paid>0 group by purFrom order by ttlPayble").list();
%>
    <hr>
    <%
//    for(Object[] df:pendings){
        String[] billInfo=UT.chartize(pendings, 1, 0);
//    }
    %>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="scrollable">
    <table border="1px solid" cellpadding="2px">
        <thead>
            <tr><th>Vendor</th><th>PendingAmount</th><th>Action</th></tr>
        </thead>
            <%
            List<InwardManager> im=sess.createQuery("from InwardManager where (price-paid>0) order by billNo desc").list();
            for(InwardManager in:im){
            %>
            
            <%}%>
    </table>
    </div>
        <p>Bill wise Report</p>
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
            }});
    </script>
    
