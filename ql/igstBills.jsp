<%-- 
    Document   : igstBills
    Created on : 5 May, 2018, 5:59:49 PM
    Author     : UMESH-ADMIN
--%>
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
    
%>
    <hr>
    <%
//    for(Object[] df:pendings){
//        String[] billInfo=UT.chartize(pendings, 1, 0);
//    }
    %>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="scrollable">
    <table border="1px solid" cellpadding="2px">
        <thead>
            <tr><th>Bill No</th><th>Material</th><th>Qnt</th><th>PurFrom</th><th>Amount</th><th>Tax</th><th>Balance</th><th>Action</th></tr>
        </thead>
            <%
                String i=request.getParameter("i");
                if(!i.matches(("i|c|s"))){
                    return ;
                }
            List<InwardManager> im = sess.createQuery("from InwardManager where "+i+"gst>0").list();
            for(InwardManager in:im){%>
            <tr><td><%=in.getBillNo()%></td><td><%=in.getMatId().getMatName()%></td><td><%=in.getQty()+in.getMatId().getImportUnit()%></td>
                <td><%=in.getPurFrom()%></td>
                <td>&#8377;<%=in.getPrice()%></td><td>&#8377;<%=in.getIgst()+in.getSgst()+in.getCgst()%></td>
                <td>&#8377;<%=in.getPrice()-in.getPaid()%></td>
                <td><%if(in.getPrice()-in.getPaid()>0&&role.getRole().matches("(.*Global.*)|((.*\\(V20\\).*)(.*\\(C3\\).*))")){%>
                    <button class="fa fa-credit-card" title="Click to pay" onclick='popsr("af/imp.jsp?i=<%=in.getImportId()%>")'>
                    </button>
                    <%}%></td></tr>
            <%}
            %>
        
    </table>
    </div>
    </div>
