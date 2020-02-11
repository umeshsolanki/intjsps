<%-- 
    Document   : RMBelowDL
    Created on : 6 Nov, 2017, 3:56:07 PM
    Author     : UMESH-ADMIN
--%>
<%@page import="entities.Admins"%>
<%@page import="java.util.List"%>
<%@page import="entities.StockManager"%>
<%@page import="org.hibernate.Session"%>
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


<div class="loginForm" style="max-width: 100%;">
    <span class="close" id="close" onclick="closeMe();">&Cross;</span>
    <div class="fullWidWithBGContainer">


            <%
            if(role.getRole().matches("(.*Global.*)?(.*Stock.*)?")){
            if(sess!=null){
                List<StockManager> stockWarning=sess.createQuery("from StockManager s where s.Qty<s.mat.minQnt order by mat.matName").list();
            %>
            <div class="half left lightBlue border" style="min-height: 400px;">
                <marquee><b  style='padding: 5px;color:#882244;'>RM below deadline</b></marquee><hr>
                <div class="scrollable">
            <table  border="0" width="100%" style='margin: 0px;padding: 0px;' cellspacing="2" cellpadding="5">

<thead align='left'>
                <tr>
                    <th>Material</th>
                    <th>Quantity</th>
                    <th>Branch-Id</th>
                </tr>
</thead>
        <tbody>
        <%
            for(StockManager sm:stockWarning){
        %>
                    <tr>
                        <td><%=sm.getMat().getMatName()%></td>
                        <td style='color:red;'><%=sm.getQty()+" "+sm.getMat().getPpcUnit()%></td>
                        <td><%=sm.getInBr().getBrName()%></td>
                    </tr>
        <%
            }

        %>
                </tbody>
                </table>
                </div>
                </div>
<%sess.close();}}%>