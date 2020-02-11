<%-- 
    Document   : cpadr
    Created on : 4 Sep, 2018, 10:57:08 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.Customer"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="entities.DistSaleManager"%>
<%@page import="entities.Address"%>
<%@page import="sessionMan.SessionFact"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        Session sess = SessionFact.getSessionFact().openSession();         
//        Address.class
        Transaction tr=sess.beginTransaction();
        List<DistSaleManager> odrs=sess.createCriteria(DistSaleManager.class).list();
        for(DistSaleManager o:odrs){
            Address a=o.getAddress();
            Customer c=o.getCust();
            if(a==null){
                a=new Address();
            }
            a.setAddr(c.getAddress());
            a.setApt(c.getAptName());
            a.setPin(c.getPIN());
            a.setFlat(c.getFlatno());
//            sess.save(a);
            o.setAddress(a);
        }
        tr.commit();
//        int modRes=sess.createQuery("update DistSaleManager as o  set o.address.flat=o.cust.flatno, o.address.apt=o.cust.aptName,"
//                + "o.address.addr=o.cust.address,o.address.pin=o.cust.PIN").executeUpdate();
        System.out.println(odrs.size());
        %>
    </body>
</html>
