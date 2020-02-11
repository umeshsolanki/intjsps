<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.Locale"%>
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
<!DOCTYPE html>
<%
Admins role=(Admins)session.getAttribute("role");
Session sess=null;
    try{

    sess=sessionMan.SessionFact.getSessionFact().openSession();
    }catch(Exception e){
        e.printStackTrace();
    out.print("<script>showMes('App Initialization Error was Detected at server',true);</script>");
    return;
    }


if(role==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
        <%
    return ;
    
}%>
<%
    Date dt=new Date();
    List<Object[]> saleGrpByRef=sess.createQuery("select count(*),sum(toPay) as NW,sum(paid),"
            + "sum(disc),sum(bal),refBy from DistSaleManager dsm where dsm.dist.ownedByGA=true group by refBy order by NW desc)").list();
//    List<DistSaleManager> groupedByRef=sess.createCriteria("select  from DistSaleManager where deleted=false group by refBy").list();
%>
<div class="loginForm">
    <span class="close" id="close" onclick="closeMe();">X</span>
    <h2 class="white nopadding nomargin"><%=new SimpleDateFormat("MMM-YYYY").format(new Date())%> Performance</h2><hr>
    <div class="tileCont">
    <div class="tile" style="background-color: #ffffff;" onclick='loadPage("adminForms/BRConsumption.jsp");'>
        <img src="images/multy-user.svg" width="200px" height="100px"/> 
        <p style='background: #efefef;margin: 0;padding: 5px;color:black' align='left'><b>Finance Report</b></p>
    </div>    
    <div class="tile" style="background-color: #ffffff;" onclick='loadPage("adminForms/BRConsumption.jsp");'>
        <img src="images/multy-user.svg" width="200px" height="100px"/> 
        <p style='background: #efefef;margin: 0;padding: 5px;color:black' align='left'><b>Sale Centers Report</b></p>
    </div>    
    <div class="tile" style="background-color: #ffffff;" onclick='loadPage("adminForms/BRConsumption.jsp");'>
        <img src="images/multy-user.svg" width="200px" height="100px"/> 
        <p style='background: #efefef;margin: 0;padding: 5px;color:black' align='left'><b>Consumption</b></p>
    </div>    
    <div class="tile" style="background-color: #ffffff;" onclick='loadPage("adminForms/BRConsumption.jsp");'>
        <img src="images/multy-user.svg" width="200px" height="100px"/> 
        <p style='background: #efefef;margin: 0;padding: 5px;color:black' align='left'><b>Production</b></p>
    </div>    
    <div class="tile" style="background-color: #ffffff;" onclick='loadPage("adminForms/BRConsumption.jsp");'>
        <img src="images/multy-user.svg" width="200px" height="100px"/> 
        <p style='background: #efefef;margin: 0;padding: 5px;color:black' align='left'><b>RM Purchase</b></p>
    </div>    
    </div>
    <div class="fullWidWithBGContainer ">
        <div class="tFivePer left">
            <h3 class="white nopadding nomargin" id="finRes" >Income</h3>
            <div class="tinyScroll">
                <table border="1px">
                    <tr><th>Date</th><th>Total Collection</th><th>Total Expenses</th></tr>
    <%
        double tCr=0,tDr=0;
        List<Object[]> fins=sess.createQuery("select txnDate,sum(credit),sum(debit) from FinanceRequest req group by txnDate").list();
                for(Object[] s:fins){
                    tCr+=new Double(""+s[1]);
                    tDr+=new Double(""+s[2]);  
                %>
                <%="<tr align='left'><td align='left'>"+s[0]+"</td><td>"+s[1]+"</td><td>"+s[2]+"</td></tr>"%>
                <%}%>
                </table>
                <script>$('#finRes').html("Total Credit: <%=tCr%>, Total Debit: <%=tDr%>");</script>
            </div>
        </div>
        <div class="sixtyFivePer right">
            <h3 class="white nopadding nomargin" >Expenses</h3>
            <div class="tinyScroll">
                
            </div>
        </div>
    </div>
    <div class="fullWidWithBGContainer ">
        <div class="tFivePer left">
            <h3 align='left' class="white nopadding nomargin" id="ttlO"></h3>
            <div class="tinyScroll">
                <table border="1px">
                    <tr><th>Referrer</th><th>Total Orders</th></tr>
                <%
                double ttlO=0,NW=0,tDis=0,tB=0,tP=0;
                for(Object[] s:saleGrpByRef){
                    NW+=new Double(""+s[1]);
                    ttlO+=new Double(""+s[0]);
                    tB+=new Double(""+s[4]);
                    tP+=new Double(""+s[2]);
                    tDis+=new Double(""+s[3]);
                %>
                <%="<tr align='left'><td align='left'>"+s[5]+"</td><td>"+s[0]+"</td></tr>"%>
                <%}%>
                </table>
                <script>$('#ttlO').html("Orders this month: "+<%=ttlO%>+"");</script>
            </div>
        </div>
        <div class="sixtyFivePer right">
            <h3 align='left' class="white nopadding nomargin" id="NW"></h3>
            <div class="tinyScroll">
                <table border="1px">
                    <tr><th>Referrer</th><th>Total</th><th>Paid</th><th>Disc</th><th>Bal</th></tr>
                <%
//                long NW=0;
                for(Object[] s:saleGrpByRef){
//                    NW+=new Double(""+s[1]);
                %>
                <%="<tr><td>"+s[5]+"</td><td>"+s[1]+"</td><td>"+s[2]+"</td><td>"+s[3]+"</td><td>"+s[4]+"</td></tr>"%>
                <%}%>
                </table>
                <script>$('#NW').html("Total Value &#8377;"+<%=NW%>+", T.Collection &#8377;"+<%=tP%>+"\n\
                , T.Bal &#8377;"+<%=tB%>+"");</script>
            </div>
        </div>
    </div>
    <div class="fullWidWithBGContainer">
        <%
//            List<Object[]> saleGrpByProd=sess.createQuery("select saleRecord as sr from DistSaleManager dsm where dsm.dist.ownedByGA=true").list();
        %>
        
        <div class="tFivePer left">
            <h3 class="white nopadding nomargin" >Products Sold</h3>
            <div class="tinyScroll">
                
            </div>
        </div>
        <div class="sixtyFivePer right">
            <h3 class="white nopadding nomargin" >Production </h3>
            <div class="tinyScroll">
            <%
                List<Object[]> production=sess.createQuery("select product.FPName,sum(developed),sum(Qnt)-sum(developed) from ProductionRequest group by product").list();
            %>
            <table border="1px">
                    <tr><th>Product</th><th>Developed</th><th>Semifinished</th></tr>
                <%
                    double tQnt,tdev;
                for(Object[] s:production){
//                    FinishedProduct p=(FinishedProduct)s[0];
                %>
                <%="<tr align='left'><td align='left'>"+s[0]+"</td><td>"+s[1]+"</td><td>"+s[2]+"</td></tr>"%>
                <%}%>
                </table>
                <!--<script>$("#ttlO").html("Orders this month");</script>-->
            </div>
        </div>
    </div>
    <div class="fullWidWithBGContainer">
        <%
//            List<Object[]> matCons=sess.createQuery("select saleRecord as sr from DistSaleManager dsm where dsm.dist.ownedByGA=true").list();
        %>
        <div class="tFivePer left">
            <h3 class="white nopadding nomargin" >Material Consumed</h3>
            <div class="tinyScroll">
    <%
        List<Object[]> mCons=sess.createQuery("select mat.matName,sum(qnt),"
//                + "branch.brName,"
                + "mat.ppcUnit from MaterialConsumed where mat!=null group by mat"
//                + ", branch"
                + "").list();
        List<Object[]> pCons=sess.createQuery("select semiFinProd.FPName,sum(qnt)"
//                + ",branch.brName"
                + " from MaterialConsumed where semiFinProd!=null group by semiFinProd"
//                + ",branch"
                + "").list();
    %>
            <table border="1px">
                    <tr><th>Material</th><th>Consumed</th>
                        <!--<th>Branch</th>-->
                    </tr>
                <%
                for(Object[] s:mCons){
                %>
                <%="<tr align='left'><td align='left'>"+s[0]+"</td><td>"+s[1]+" "+s[2]+"</td>"
//                        + "<td>"+s[2]+"</td>"
                        + "</tr>"%>
                <%}%>
                    <tr><th>Semi Finished Product</th><th>Quantity</th>
                        <!--<th>Branch</th>-->
                    </tr>
            <%
                for(Object[] s:pCons){
                %>
                <%="<tr align='left'><td align='left'>"+s[0]+"</td><td>"+s[1]+"</td>"
//                        + "<td>"+s[2]+"</td>"
                        + "</tr>"%>
                <%}%>
                    
            </table>
            </div>
        </div>
        <div class="sixtyFivePer right">
            <h3 class="white nopadding nomargin" >Total Purchases</h3>
            <div class="tinyScroll">
                <table border="1px">
                    <tr><th>Material</th><th>Qty</th>
                        <!--<th>Branch</th>-->
                    </tr>
                <%
                List<Object[]> mP=sess.createQuery("select matId.matName,matId.ppcUnit,sum(Qty)"
//                        + ",inBr.brName"
                        + " from InwardManager group by matId"
//                        + ",inBr"
                        + "").list();
                for(Object[] s:mP){
                %>
                <%="<tr align='left'><td align='left'>"+s[0]+"</td><td>"+s[2]+" "+s[1]+"</td>"
//                        + "<td>"+s[3]+"</td>"
                        + "</tr>"%>
                <%}%>
            </table>
            
            </div>
        </div>
    </div>
</div>    