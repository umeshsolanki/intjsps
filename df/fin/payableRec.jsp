<%-- 
    Document   : receivable
    Created on : 28 Feb, 2018, 11:36:03 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.DistributorInfo"%>
<%@page import="entities.DistFinance"%>
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
    DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
    DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
        if(dist==null||LU!=null&&!LU.getRoles().matches(".*\\(.Fin\\).*")){
            out.print("<script>window.location.replace(\"?msg=You don't have permission to access this page\");</script>");
            return;
        }

        sess.refresh(dist);
        

    
    List<DistFinance> pendings = sess.createCriteria(DistFinance.class)
            .add(Restrictions.eq("dist", dist))
            .add(Restrictions.eq("pending", true))
            .add(Restrictions.gt("debit", 0.0)).list();
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
    for(DistFinance df:pendings){
    %>
    <tr id="pend<%=df.getFinId()%>">
        <td><%=df.getTxnDate()%></td>
        <td><%=df.getDebit()%></td>
        <td class="pointer" onclick="popsl('df/dockRec.jsp?d=<%=df.getDocketNo()%>')"><%=df.getDocketNo()%></td>    
        <td><%=df.getSummary()%></td>    
        <td>
            <%if(LU==null){%>
                <%if(df.isPending()){%>
                    <span onclick="sendDataForResp('a','action=madone&mod=Fin&i=<%=df.getFinId()%>');" class="button  fa fa-check-square" title="Click to mark as done"></span> 
                <%}%> 
                    <span onclick="sendDataForResp('a','action=TUP&mod=Fin&i=<%=df.getFinId()%>')" class="button <%=df.isApproved()?"greenFont":"redFont"%> fa fa-thumbs-up" title="Approve"></span>
                    <span onclick="showDial('action=del&mod=Fin&i=<%=df.getFinId()%>&r=row<%=df.getFinId()%>','del','Confirm Delete','It\'ll update the docket bal ');" class="button fa fa-trash" title="Delete"></span>
            <%}%>
        </td>    
    </tr>
    <%}%>
    </table>
</div>