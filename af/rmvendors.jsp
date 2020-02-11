<%-- 
    Document   : vendors
    Created on : 21 Jun, 2018, 10:41:24 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="org.hibernate.criterion.Order"%>
<%@page import="entities.Vendor"%>
<%@page import="java.util.List"%>
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

    if(!UT.ia(role, "20")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
        return;
        }
    List<Vendor> pendings = sess.createCriteria(Vendor.class).addOrder(Order.desc("name")).list();
%><hr>
<h3 class="nmgn spdn bgcolef">Vendors</h3>    
    <div class="scrollable">
    <table width="100%" cellpadding="5" border="1px">
    <thead>
        <tr rowspan="2" align="left" >
            <th>Name</th><th>Mobile</th>
            <th>GSTNo</th>
            <th>Address</th><th>Action</th>
        </tr>
    </thead>
    <%
    for(Vendor df:pendings){
    %>
    <tr id="row<%=df.getId()%>">
        <td><%=df.getName()%></td>
        <td><%=df.getMob()%></td>
        <td><%=df.getGstNo()%></td>    
        <td><%=df.getAddress()%></td>    
        <td>
            <%if(role.getRole().matches(".*Global.*")){%>
            <span onclick="editUI('Update Vendor Info','editUI?res=vendor&i=<%=df.getId()%>','vendor')" class="button fa fa-edit" title="Update Vendor Info"></span>
            <span onclick="sendDataForResp('del','action=remVendor&i=<%=df.getId()%>')" class="popDel button fa fa-trash" title="Delete"></span>
            <%}%>
        </td>    
    </tr>
    <%}%>
    </table>
</div>
    