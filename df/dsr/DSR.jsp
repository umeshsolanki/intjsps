<%@page import="entities.DistFinance.PaymentMethod"%>
<%@page import="java.util.Calendar"%>
<%@page import="entities.COBF"%>
<%@page import="utils.UT"%>
<%@page import="org.hibernate.Query"%>
<%@page import="utils.Utils"%>
<%@page import="entities.HORecord"%>
<%@page import="entities.DSRBottom"%>
<%@page import="entities.DSRManager"%>
<%@page import="entities.DSRExcecutionRec"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.DistFinance"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="entities.SaleInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entities.DistSaleManager"%>
<%@page import="entities.DistStock"%>
<%@page import="entities.OrderInfo"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="java.util.List"%>
<%@page import="entities.UserFeedback"%>
<%@page import="entities.Admins"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DistributorInfo dis=(DistributorInfo)session.getAttribute("dis");
    DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
    if(dis==null||LU!=null&&!LU.getRoles().matches(".*\\(.DSR\\).*")){
        out.print("<script>window.location.replace(\"?msg=You don't have permission to access this page\");</script>");
        return;
    }
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
    sess.refresh(dist);
    String dat=request.getParameter("dt");
    String tgt=request.getParameter("tgt");
    
    Date dt=new Date();
    try{
        dt=Utils.DbFmt.parse(dat);
    }catch(Exception ex){}
%>
<div class="fullWidWithBGContainer " style="max-height: 225px;overflow: auto">
    <table border="1px" width="100%">
        
    <%if(tgt.equals("cash")){        
//        DistFinance.class
    double cash=0;    
    Query q=sess.createQuery("from DistFinance df where credit>0 and pending=false and dist=:di and txnDate=:dt and method=:m order by docketNo ")
        .setParameter("m", PaymentMethod.Cash).setParameter("di", dist).setParameter("dt", dt);
        List<DistFinance> fin=q.list();%>
        <thead><tr><th>Docket</th><th>Amt</th></tr></thead>
        <%for(DistFinance df:fin){cash+=df.getCredit();%>
        <tr>
            <td><%=df.getDocketNo()%></td>
            <td>&#8377;<%=df.getCredit()%></td>
        </tr>
        <script>$("#cashCol").html("&#8377; <%=cash%>");</script>  
        <%}}else if(tgt.equals("online")){        
//        DistFinance.class
    double cash=0;    
    Query q=sess.createQuery("from DistFinance df where credit>0 and pending=false and dist=:di and txnDate=:dt and method=:m order by docketNo ")
        .setParameter("m", PaymentMethod.Online).setParameter("di", dist).setParameter("dt", dt);
        List<DistFinance> fin=q.list();%>
        <thead><tr><th>Docket</th><th>Amt</th></tr></thead>
        <%for(DistFinance df:fin){cash+=df.getCredit();%>
        <tr>
            <td><%=df.getDocketNo()%></td>
            <td>&#8377;<%=df.getCredit()%></td>
        </tr>
        <%}%>  
      
    <%}else if(tgt.equals("docketwise")){        
//        DistFinance.class
    double cash=0;    
    Query q=sess.createQuery("select sum(credit),docketNo from DistFinance df where pending=false and dist=:di and txnDate=:dt group by docketNo")
        .setParameter("di", dist).setParameter("dt", dt);
        List<Object[]> fin=q.list();%>
        <thead><tr><th>Docket</th><th>Amt</th></tr></thead>
        <%for(Object[] df:fin){cash+=(Double)df[0];%>
        <tr>
            <td><%=df[1]%></td>
            <td>&#8377;<%=df[0]%></td>
        </tr>
        <%}%>  
      <script>$("#docketwise").html("&#8377; <%=cash%>");</script>  
    <%}else if(tgt.equals("executed")){
//        DistFinance.class
    double cash=0;    
    Query q=sess.createQuery("select sum(credit),docketNo from DistFinance df where pending=false and dist=:di and txnDate=:dt group by docketNo")
        .setParameter("di", dist).setParameter("dt", dt);
        List<Object[]> fin=q.list();%>
        <thead><tr><th>Docket</th><th>Amt</th></tr></thead>
        <%for(Object[] df:fin){cash+=(Double)df[0];%>
        <tr>
            <td><%=df[1]%></td>
            <td>&#8377;<%=df[0]%></td>
        </tr>
        <%}%>  
      <script>$("#docketwise").html("&#8377; <%=cash%>");</script>  
    <%}%>
    
    </table>
</div>
    
<%
sess.close();
%>
    