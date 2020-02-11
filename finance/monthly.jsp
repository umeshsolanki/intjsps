<%-- 
    Document   : DisFinance
    Created on : Oct 12, 2017, 10:20:53 PM
    Author     : sunil
--%>

<%@page import="org.hibernate.Query"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="entities.BankAccount"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="utils.UT"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.FinanceRequest"%>
<%@page import="entities.Admins"%>
<%@page import="entities.FinanceRequest"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="java.util.List"%>
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
        return;
    }
    
    
    List<Object[]> odrPI = sess.createQuery("select sum(credit),sum(debit),(MONTHNAME(txnDate)||'-'||YEAR(txnDate)),concat(YEAR(txnDate),'-',LPAD(MONTH(txnDate),2,'0')) from FinanceRequest df where "
            + " pending=false group by (MONTHNAME(txnDate)||'-'||YEAR(txnDate)) order by concat(YEAR(txnDate),'-',LPAD(MONTH(txnDate), 2, '0')) desc").list();
    
//    List<Object[]> pending = sess.createQuery("select sum(credit),sum(debit),MONTHNAME(txnDate)||'-'||YEAR(txnDate) as month from FinanceRequest df where"
//            + " pending=true group by month order by YEAR(txnDate)||MONTH(txnDate) ").list();
%>
<style>
    table.mat-table thead{
        border: 1px solid #000;
        
    }
    table.mat-table thead th{
        border: 1px solid #000;
        
    }
    table.mat-table tbody td{
        padding: 2px;
        text-align: left;
        border: 1px solid #000;
    }
</style>
<div class="fullWidWithBGContainer ">
    <table class="mat-table">
        <thead>
            <tr><th>Month</th><th>Credit</th><th>Debit</th></tr>
        </thead>
        <%for(Object[] r:odrPI){%>
        <tr class="finMonthLink" src='finance/daywise.jsp?m=<%=r[3]%>'>
            <td><%=r[2]%></td><td class="greenFont">&#8377;<%=r[0]%></td><td class="redFont">&#8377;<%=r[1]%></td>
        </tr>
        <%}%>
        </table>
        <%--                <div class="tile bgwhite m-5">
                    <p class="nmgn lpdn"><%=r[2]%></p>
                    <p class="bold nmgn p-15">&#8377; <%="<span class='greenFont'>"+r[0]+"</span> / <span class='redFont'>"+r[1]+"</span>"%></p>
                </div>--%>
</div>
<div class="finDailyRecord">
    
</div>
        <script>
            $(".finMonthLink").on("click",function(){
                $(".finDailyRecord").load(this.getAttribute("src"));
//                alert(this.getAttribute("src"));
            });
        </script>
<%
sess.close();
%>
