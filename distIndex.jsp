<%-- 
    Document   : distIndex
    Created on : 21 Nov, 2017, 10:17:22 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="java.util.Random"%>
<%@page import="utils.Utils"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.DistSaleManager"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.DistributorInfo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DistributorInfo LU = null;
%>
<%if(LU==null||(LU.getRoles().matches("(.*\\(.Req\\).*)"))){%>
<div class="tile" onclick='loadPage("df/MakeOrder.jsp");' title="Pending For Approval"><img src="images/inward.png" width="100px" height="100px"/> <p style='background-color: #efefef;margin:0;padding: 5px;color:black' align='left'><b>${pp.size()} Requisition</b></p></div>
<%
        }if(LU==null||(LU.getRoles().matches("(.*\\(.Stk\\).*)"))){
    %>
    <div class="tile" style="background-color: #ffffff;" onclick='loadPage("df/lsku.jsp");'><img src="images/stock.png" width="100px" height="100px"/> <p style='background-color: #efefef;margin:0;padding: 5px;color:black' align='left'><b>Stock</b></p></div>
    <%
        }if(LU==null||(LU.getRoles().matches(".*\\(.Odr\\).*"))){
    %>
    <div class="tile" title="${po.size()} Orders Pending For Execution"
         onclick='loadPage("df/recentOrders.jsp");'><img src="images/order.png" width="100px" height="auto"/> <p style='background-color: #efefef;margin:0;padding: 5px;color:black' align='left'><b> Booked Orders</b></p></div>
    <%
        }if(LU==null||(LU.getRoles().matches(".*\\(.Ret\\).*"))){
    %>
    <div class="tile" 
         onclick='loadPage("df/return.jsp");'><img src="images/delivery.png" width="100px" height="auto"/> <p style='background-color: #efefef;margin:0;padding: 5px;color:black' align='left'><b> Return and Cancellation</b></p></div>
    <!--
    <div class="tile" 
         onclick='loadPage("df/TrOrders.jsp");'><img src="images/ho.png" width="100px" height="auto"/> <p style='background-color: #efefef;margin:0;padding: 5px;color:black' align='left'><b> Transfered Order(s)</b></p></div>-->
    <%
        }if(LU==null||(LU.getRoles().matches(".*\\(.Comp\\).*"))){
    %>
    <div class="tile" title="${com.size()} Complaints Pending For Execution" onclick='loadPage("df/complain.jsp");' style="background-color: #dd4141;"><img src="images/compl.jpg" width="100px" height="100px"/> <p style='background-color: #efefef;margin:0;padding: 5px;color:black' align='left'><b> Complaints</b></p></div>
    <%
//        com.size()
        }if(LU==null||(LU.getRoles().matches(".*\\(.DSR\\).*"))){
    %>
    <div class="tile" onclick='loadPage("df/DSR.jsp");'><img src="images/inr_icon.png" width="100px" height="auto"/> <p style='background-color: #efefef;margin:0;padding: 5px;color:black' align='left'><b>Daily Sales Report</b></p></div>
    <div class="tile" onclick='loadPage("df/DSR_1.jsp");'><img src="images/inr_icon.png" width="100px" height="auto"/> <p style='background-color: #efefef;margin:0;padding: 5px;color:black' align='left'><b>Manual DSR</b></p></div>
    <%
        }if(LU==null||(LU.getRoles().matches(".*\\(.Fin\\).*"))){
    %>
    <div class="tile" onclick='loadPage("df/fin.jsp");' style="background-color: #ffffff;"><img src="images/inr_icon.png" width="100px" height="100px"/> <p style='background-color: #efefef;margin:0;padding: 5px;color:black' align='left'><b>Finance</b></p></div>
    <div class="tile" onclick='loadPage("df/r/report.jsp");' style="background-color: #ffffff;"><img src="images/inr_icon.png" width="100px" height="100px"/> <p style='background-color: #efefef;margin:0;padding: 5px;color:black' align='left'><b>Report Manager</b></p></div>
    <%
        }if(LU==null||(LU.getRoles().matches(".*\\(.Fin\\).*"))){
    %>
<!--    <div class="tile" onclick='loadPage("df/PendingBills.jsp");' style="background-color: #ffffff;">
        <img src="images/pp.svg" width="100px" height="100px"/> 
        <p style='background-color: #efefef;margin:0px;padding: 5px;color:black' align='left'>
            <b>Pending Payment</b>
        </p>
    </div>-->
    <%
    }if(LU==null||(LU.getRoles().matches(".*\\(.Fin\\).*"))){
    %>
    <div class="tile" style="background-color: #ffffff;">
        <img src="images/taxationicon.svg" width="100px" height="100px"/> 
        <p style='background-color: #efefef;margin:0px;padding: 5px;color:black' align='left'>
            <b>Tax</b>
        </p>
    </div>
    <%
      }
    %>
<!--</div>-->
    <!--</center>-->
<!--</div>-->
    <%--<%
        Random ran=new Random();
        if(LU==null||(LU.getRoles().matches(".*DM-FinanceE.*"))){  
          StringBuilder lbl=new StringBuilder();
          StringBuilder creds=new StringBuilder();
          StringBuilder debs=new StringBuilder();
          String bgc="";
          
          List<Object[]> fin=sess.createQuery("select sum(credit),sum(debit),txnDate from DistFinance where dist=:dist and txnDate>=:dt group by txnDate order by txnDate asc").setParameter("dt", Utils.getPreFiteenthDay()).setParameter("dist", dis).list();
            for(Object[] req:fin){
                lbl.append("'"+req[2]+"',");
                creds.append(""+req[0]+",");
                debs.append(""+req[1]+",");
                bgc+="'rgb("+ran.nextInt(255)+", "+ran.nextInt(255)+", "+ran.nextInt(255)+")',";
            }
//        List<DistOrderManager> orders= sess.createCriteria(DistOrderManager.class).add(Restrictions.eq("distributor", dis)).add(Restrictions.eq("deleted", false)).add(Restrictions.eq("seen",false)).list();
        
        %>
        <hr>
        <h3 class="nomargin nopadding white">Finance Statement In Past 15 Days, after ${Utils.HRFmt.format(Utils.getPreFiteenthDay())}</h3><hr>
        <canvas id="finChart" width="400px" height="100px;">
             
        </canvas>
    <script>
        var ctx=$("#finChart");
        var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
//        labels: ['Red', "Blue", "Yellow", "Green", "Purple", "Orange","Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
        labels: [${lbl.toString()}],
        datasets: [{
            label: 'Income',
            data: [${creds.toString()}],
            backgroundColor:'rgba(55, 200, 64, 1)',
            borderColor: 'rgba(255, 159, 64, 1)',
            borderWidth: 1
        },{
            label: 'Expenditure',
            data: [${debs.toString()}],
            backgroundColor:'rgba(200, 50, 50, 1)',
            borderColor: 'rgba(255, 159, 64, 1)',
            borderWidth: 1
        }]
    },
    options: {
                    title:{
                        display:true,
                        text:"Finance Report"
                    },
                    tooltips: {
                        mode: 'index',
                        intersect: false
                    },
                    responsive: true,
                    scales: {
                        xAxes: [{
                            stacked: true,
                        }],
                        yAxes: [{
                            stacked: true
                        }]
                    }
                }
});
//$("#finChart").click(function(evt){
//            var activePoints = myChart.getElementsAtEvent(evt);
//            var firstPoint = activePoints[0];
//            var label = myChart.data.labels[firstPoint._index];
//            var value = myChart.data.datasets[firstPoint._datasetIndex].data[firstPoint._index];
//        if(label==="Stock"){
//            loadPage("df/myStock.jsp");
//        }else if(label==="DSR"){
//            loadPage("df/DSR.jsp");
//        }
//        else if(label==="Orders"){
//            loadPage("df/recentOrders.jsp");
//        }    
//        else if(label==="Complains"){
//            loadPage("df/complain.jsp");
//        }
//        else if(label==="Requisition"){
//            loadPage("forms/MakeOrder.jsp");
//        }
//        alert(label + ": " + value);
//        });

//$("#myChart").click(function(){alert('om');});
//myChart.data.datasets=[{label:'OM',data:[52,10,20],backgroundColor:['red','black','blue']}];
//myChart.update();

    
    </script>
    <%
        }if(LU==null||(LU.getRoles().matches(".*DM-VStock.*"))){
    %>
    
    <div class="fullWidWithBGContainer">
        <div class=""><h3 class="nomargin nopadding white">Booked Orders In Past 15 Days, after ${Utils.HRFmt.format(Utils.getPreFiteenthDay())}</h3><hr>
        <canvas id="saleChart" width="400px" height="100px;">
             
        </canvas>
        <%
        String labels="",data="",color="";
        List<Object[]> saleReport=sess.createQuery("select count(*),refBy from DistSaleManager where dist=:dist and dt>=:aftr group by refBy order by refBy asc").setParameter("aftr", Utils.getPreFiteenthDay()).setParameter("dist", dis).list();
        for(Object[] sr:saleReport){
            labels+="'"+sr[1]+"',";
            data+=""+sr[0]+",";
            color+="'rgb("+ran.nextInt(255)+", "+ran.nextInt(255)+", "+ran.nextInt(255)+")',";
        }
        
        %>
        <script>
            new Chart($('#saleChart'),{"type":"doughnut",
                    "data":{"labels":[${labels%>],
                "datasets":[{"label":"Orders",
                        "data":[${data%>],
                        "backgroundColor":[${color%>]}]
            }});
        </script>
        </div>
    </div>
    --%>
<%
//    }
}
%>