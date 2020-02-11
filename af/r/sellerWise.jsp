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
            .add(Restrictions.eq("pending", true)).add(Restrictions.gt("credit", 0.0)).list();
%>
    <hr>
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
            <span onclick="sendDataForResp('FormManager','action=TUP&mod=Fin&i=<%=df.getFinId()%>')" class="button <%=df.isApproved()?"greenFont":"redFont"%> fa fa-thumbs-up" title="Approve"></span>
            <%}if(role.getRole().matches("(.*Global.*)|(.*\\(D3\\).*)")){%>
            <span onclick="sendDataForResp('FormManager','action=del&mod=Fin&i=<%=df.getFinId()%>');" class="button fa fa-trash" title="Delete"></span>
          <%}%>
          </td>    
    </tr>
    <%}%>
    </table>
</div>