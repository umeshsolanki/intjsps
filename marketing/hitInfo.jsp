<%-- 
    Document   : hitInfo
    Created on : 16 Mar, 2018, 11:44:24 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.List"%>
<%@page import="entities.Tracker"%>
<%@page import="org.hibernate.Session"%>
<%@page import="sessionMan.SessionFact"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<table>
        <thead>
            <tr>
                <th>Time</th><th>Source</th><th>URL</th>
            </tr>
        </thead>

<%
    Session sess=SessionFact.getSessionFact().openSession();
    Date[] dts=Utils.gCMon(new Date());
    List<Tracker> tkr=sess.createQuery("from Tracker order by hitTime desc").list();
    for(Tracker t:tkr){%>
    <tr>
        <td><%=t.getHitTime()%></td>
        <td><%=t.getSource()%></td>
    </tr>  
    <%}
%>
</table>