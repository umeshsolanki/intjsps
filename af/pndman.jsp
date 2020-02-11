<%-- 
    Document   : PendingBills
    Created on : 10 Aug, 2017, 7:06:07 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.temporal.TemporalAccessor"%>
<%@page import="java.time.Duration"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Period"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Bill"%>
<%@page import="entities.DistributionRecord"%>
<%@page import="entities.Admins"%>
<%@page import="entities.Material"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.InwardManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if(!(session.getAttribute("role") instanceof Admins)){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
<%
    return ;
}
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
%>
<%
    
    String iLim=request.getParameter("ini");
    int ini=0;
    if(iLim!=null&&iLim.matches("\\d*")){
        ini=Integer.parseInt(iLim);
    }
//    List<DistributionRecord> prods=sess.createCriteria(DistributionRecord.class).addOrder(Order.desc("distId")).
//            setFirstResult(ini).setMaxResults(20).list();
List<Bill> prods=sess.createQuery("from Bill where (ToPay-paidAmount)>0 order by billId Asc").setFirstResult(ini).setMaxResults(20).list();
ArrayList<DistributionRecord> dists;
if(ini>0){

    for(Bill in:prods){
        double bal=in.getToPay()-in.getPaidAmount();
    dists=new ArrayList(in.getDist());
    Date sold=dists.get(0).getSoldOn();
    Date now=new Date();
    long dur=now.getTime()-sold.getTime();
    int days=(int)dur/(1000*3600*24);    
    String day="";
    int mon,yr;
    if(days>365){
        yr=days/365;
        days%=365;
        day+=yr+" Year(s)";
    }
    if(days>30){
        mon=days/30;
        days%=30;
        day+=","+mon+" Month(s)";
    }
    day+=" "+days+" day(s)";
%>
            <tr>
                <td><%=dists.get(0).getSoldOn()%></td>
                <td><%=dists.get(0).getToWhome().getDisId()+","+dists.get(0).getToWhome().getType()%></td>
                <td><%=day%></td>
                <td>
                    <select disabled="true" class="autoFitTextField" type="text"  id="payMethod<%=in.getBillId()%>" name="payMethod">
                <option>Payment Method</option>
                <option>Cash</option>
                <option>DD</option>
                <option>NEFT</option>
                <option>RTGS</option>
                <option>Cheque</option>
                <option>Online</option>
            </select></td>
            <td><input disabled="true" type="text" class="autoFitTextField" placeholder="Payment Id" id="payId<%=in.getBillId()%>" name="payId"/></td>
            <td><input disabled="true" type="text" class="autoFitTextField" placeholder="Bank Name" id="bkNm<%=in.getBillId()%>" name="bkNm"/></td>
            <td ondblclick="enableFields(<%=in.getBillId()%>)">
                <input type="number" disabled="disabled" onblur="updPaid(<%=in.getBillId()%>,<%=bal%>);" class="autoFitTextField" placeholder="Paying Amount" id="amt<%=in.getBillId()%>" name="amt"/></td>
                <%
                if(bal>0){
                out.print("<td style='padding-left:5px;background-color:red;'>"+bal+"</td>");
                }else{
                out.print("<td style='padding-left:5px;background-color:green;'>"+bal+"</td>");
                }
                %>
                <td><button class="button" onclick="loadPageIn('billCont','adminForms/PrintBill.jsp?bId=<%=in.getBillId()%>',false)">Details</button></td>
            </tr>
    <%
}
return ;
}
%>

<div class="loginForm" style="margin: 0px;padding: 0px;">
    <span class="close" id="close" onclick="closeMe()">&Cross;</span>
    <!--<span></span>-->
    
    <style>
        table tr th{
            border-bottom: 1px solid #000;
        }
    </style>
        <span class="white"><h2>Pending Bills</h2></span>
    <hr><br>
    <div id='billCont'></div>
      <table style="margin:0px" width="100%" cellspacing="5" >
        <thead>
            <tr align="left">
                <th>Date</th>
                <th>Distributor</th>
                <!--<th>Amount</th>-->
                <!--<th>Discount</th>-->
                <th>Due Date</th>
                <th>Payment method</th>
                <th>Payment Id</th>
                <th>Bank</th>
                <th>Paying Amount</th>
                <th>Balance</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="dataCont">
            <%
   
    for(Bill in:prods){
        double bal=in.getToPay()-in.getPaidAmount();
    dists=new ArrayList(in.getDist());
    Date sold=dists.get(0).getSoldOn();
    Date now=new Date();
    long dur=now.getTime()-sold.getTime();
    int days=(int)dur/(1000*3600*24);    
    String day="";
    int mon,yr;
    if(days>365){
        yr=days/365;
        days%=365;
        day+=yr+" Year(s)";
    }
    if(days>30){
        mon=days/30;
        days%=30;
        day+=","+mon+" Month(s)";
    }
    day+=" "+days+" day(s)";
        
        
//    Period.between(LocalDate.of(, month, dayOfMonth)ofsold, LocalDate.now());
//    String pendingTime=
%>

            <tr>
                <td><%=dists.get(0).getSoldOn()%></td>
                <td><%=dists.get(0).getToWhome().getDisId()+","+dists.get(0).getToWhome().getType()%></td>
                <td><%=day%></td>
                <td>
                    <select disabled="true" class="autoFitTextField" type="text"  id="payMethod<%=in.getBillId()%>" name="payMethod">
                <option>Payment Method</option>
                <option>Cash</option>
                <option>DD</option>
                <option>NEFT</option>
                <option>RTGS</option>
                <option>Cheque</option>
                <option>Online</option>
            </select></td>
            <td><input disabled="true" type="text" class="autoFitTextField" placeholder="Payment Id" id="payId<%=in.getBillId()%>" name="payId"/></td>
            <td><input disabled="true" type="text" class="autoFitTextField" placeholder="Bank Name" id="bkNm<%=in.getBillId()%>" name="bkNm"/></td>
            <td ondblclick="enableFields(<%=in.getBillId()%>)">
                <input type="number" disabled="disabled" onblur="updPaid(<%=in.getBillId()%>,<%=bal%>);" class="autoFitTextField" placeholder="Paying Amount" id="amt<%=in.getBillId()%>" name="amt"/></td>
                <%
                if(bal>0){
                out.print("<td style='padding-left:5px;background-color:red;'>"+bal+"</td>");
                }else{
                out.print("<td style='padding-left:5px;background-color:green;'>"+bal+"</td>");
                }
                %>
                <td><button class="button" onclick="loadPageIn('billCont','adminForms/PrintBill.jsp?bId=<%=in.getBillId()%>',false)">Details</button></td>
            </tr>
<%
    dists=null;}
sess.close();%>
<script>
    function enableFields(baseId) {
        $("#payMethod"+baseId).removeAttr("disabled");
        $("#bkNm"+baseId).removeAttr("disabled");
        $("#amt"+baseId).removeAttr("disabled");
        $("#payId"+baseId).removeAttr("disabled");
}
        function updPaid(baseId,bal) {
    var newVal=new Number($("#amt"+baseId).val());
    var method=$("#payMethod"+baseId).val();
    var payId=$("#payId"+baseId).val();
    var bkNm=$("#bkNm"+baseId).val();
    if(method=="Payment Method"){
        showMes("Please select payment method",true);
        return ;
    }else if(newVal==0){
                showMes("Amount must not be zero ",true);
    }else{
        $.post("FormManager","bkNm="+encodeURI(bkNm)+"&pId="+encodeURI(payId)+"&pmtd="+encodeURI(method)+"&action=updBill&bId="+baseId+"&pmt="+newVal,function(resp){
            if(resp.includes("success")){
                showMes(resp,false);
            }else{
                showMes(resp,true);
            }
        });
    }
//    $("#payMethod"+baseId).select(0);
    $("#payMethod"+baseId).attr("disabled","true");
    $("#bkNm"+baseId).attr("disabled","true");
    $("#amt"+baseId).attr("disabled","true");
    $("#payId"+baseId).attr("disabled","true");
        }
    </script>
        </tbody>
    </table>
        
         
    </div>