<%-- 
    Document   : DisFinance
    Created on : Oct 12, 2017, 10:20:53 PM
    Author     : sunil
    optimgraphics@gmail.com
--%>

<%@page import="entities.FinanceRequest"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="entities.BankAccount"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="utils.UT"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.DistFinance"%>
<%@page import="entities.Admins"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
        if(dist==null||LU!=null&&!LU.getRoles().matches(".*\\(.Fin\\).*")){
            out.print("<script>window.location.replace(\"?msg=You don't have permission to access this page\");</script>");
            return;
        }

        sess.refresh(dist);
        Date nw=new Date();
        List<Object[]> todays = sess.createQuery("select sum(credit),sum(debit) from DistFinance where dist=:d and txnDate=CURDATE()").setParameter("d", dist).list();
        double tCr=0,tDr=0;
        if(!todays.isEmpty()){
            Object[] tt=todays.get(0);
            tCr=new Double((tt[0]!=null)?""+tt[0]:"0");
            tDr=new Double((tt[1]!=null)?""+tt[1]:"0");
        }
        Date[] curr=Utils.gCMon(new Date());
        String pm=request.getParameter("pm"),m=request.getParameter("p"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),v=request.getParameter("v"),d=request.getParameter("d");
        boolean vc=false;
        vc=v!=null&&v.equals("1");
        double mCr=0,mDr=0;
//        System.out.println(sess.createQuery("delete from DistFinance where debit<0").executeUpdate());
        todays = sess.createQuery("select sum(credit),sum(debit) from DistFinance where dist=:d and ( txnDate between :iDt and :fDt )")
        .setParameter("iDt", curr[0])
        .setParameter("fDt", curr[1])
        .setParameter("d", dist).list();
        if(!todays.isEmpty()){
            Object[] tt=todays.get(0);
            mCr=new Double((tt[0]!=null)?""+tt[0]:"0");
            mDr=new Double((tt[1]!=null)?""+tt[1]:"0");
        }
        double OCr=0; 
        todays = sess.createQuery("select sum(credit) from DistFinance where dist=:d and docketNo like '2%' and ( txnDate between :iDt and :fDt )")
        .setParameter("iDt", curr[0])
        .setParameter("fDt", curr[1])
        .setParameter("d", dist).list();
        if(!todays.isEmpty()){
            Object tt=todays.get(0);
            OCr=new Double((tt!=null)?""+tt:"0");
        }
        double CCr=0; 
        todays = sess.createQuery("select sum(credit) from DistFinance where dist=:d and docketNo like '3%' and ( txnDate between :iDt and :fDt )")
        .setParameter("iDt", curr[0])
        .setParameter("fDt", curr[1])
        .setParameter("d", dist).list();
        if(!todays.isEmpty()){
            Object tt=todays.get(0);
            CCr=new Double((tt!=null)?""+tt:"0");
        }
        double 
//                tBal=0,
                tTP=0,tPaid=0; 
        todays = sess.createQuery("select sum(toPay-disc),sum(paid+instCharge) from"
        + " DistSaleManager where dist=:d and docketNo like '2%' and ( dt between :iDt and :fDt )")
        .setParameter("iDt", curr[0])
        .setParameter("fDt", curr[1])
        .setParameter("d", dist).list();
        if(!todays.isEmpty()){
            Object[] tt=todays.get(0);
//            tBal=new Double((tt[0]!=null)?""+tt[0]:"0");
            tTP=new Double((tt[0]!=null)?""+tt[0]:"0");
            tPaid=new Double((tt[1]!=null)?""+tt[1]:"0");
        }
        double tCBal=0,tCTP=0,tCPaid=0; 
        todays = sess.createQuery("select sum(bal),sum(toPay),sum(paid+instCharge) from"
        + " DistSaleManager where dist=:d and docketNo like '3%' and ( dt between :iDt and :fDt )")
        .setParameter("iDt", curr[0])
        .setParameter("fDt", curr[1])
        .setParameter("d", dist).list();
        if(!todays.isEmpty()){
            Object[] tt=todays.get(0);
            tCBal=new Double((tt[0]!=null)?""+tt[0]:"0");
            tCTP=new Double((tt[1]!=null)?""+tt[1]:"0");
            tCPaid=new Double((tt[2]!=null)?""+tt[2]:"0");
        }
        double tRBal=0,tRTP=0,tRPaid=0; 
        double pCre=0,pDeb=0;
        todays = sess.createQuery("select sum(credit),sum(debit) from DistFinance where pending=true and dist=:d")
        .setParameter("d", dist).list();
        if(!todays.isEmpty()){
            Object[] tt=todays.get(0);
            pCre=new Double((tt[0]!=null)?""+tt[0]:"0");
            pDeb=new Double((tt[1]!=null)?""+tt[1]:"0");
        }
        todays = sess.createQuery("select sum(totalpayment-paid-discount),sum(totalPayment),sum(paid) from"
        + " DistOrderManager where distributor=:d and ( orderDate between :iDt and :fDt )")
        .setParameter("iDt", curr[0])
        .setParameter("fDt", curr[1])
        .setParameter("d", dist).list();
        if(!todays.isEmpty()){
            Object[] tt=todays.get(0);
            tRBal=new Double((tt[0]!=null)?""+tt[0]:"0");
            tRTP=new Double((tt[1]!=null)?""+tt[1]:"0");
            tRPaid=new Double((tt[2]!=null)?""+tt[2]:"0");
        }
        Criteria c = sess.createCriteria(DistFinance.class)
                .add(Restrictions.eq("pending", false))
                .add(Restrictions.eq("dist", dist))
                .addOrder(Order.desc("txnDate"));
        if(!UT.ie(pm)){
            c.add(Restrictions.eq("method",DistFinance.PaymentMethod.valueOf(pm)));
        }
        
        if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
            c.add(Restrictions.between("txnDate", Utils.DbFmt.parse(iD), Utils.DbFmt.parse(fD)));
            curr[0]=Utils.DbFmt.parse(iD);
            curr[1]=Utils.DbFmt.parse(fD);
        }else if(iD!=null&&iD.matches(".{10}")){
            c.add(Restrictions.eq("txnDate", Utils.DbFmt.parse(iD)));       
            curr[0]=Utils.DbFmt.parse(iD);
        }else{
        }
        List<DistFinance> list=c.list();
        Query qr=sess.createQuery("select sum(credit),sum(debit),txnDate from DistFinance finId where dist=:d and pending=false and txnDate between :id"
                + " and :fd group by txnDate order by txnDate  desc")
                .setParameter("id", curr[0])
                .setParameter("d", dist)
                .setParameter("fd", curr[1]);
        List<Object[]> dw=null;
        if(vc){
            list=c.list();
        }else{
            dw=qr.list();
        }
        double receivable=0,payable=0;
        String finT="";
        List<Object[]> dockPend=sess.createQuery("select sum(bal+scExp-instCharge),scExp-instCharge from DistSaleManager "
            + " where (bal>0 or scExp-instCharge>0) and dist=:d")
                .setParameter("d", dist).list();
        if(!dockPend.isEmpty()){
            Object[] tt=dockPend.get(0);
            receivable+=new Double((tt[0]!=null)?""+tt[0]:"0");
            finT+="\nOrder and Complaint Pending   : ₹"+tt[0];
//            payable=new Double((tt[1]!=null)?""+tt[1]:"0");
        }
    List<Object> os=sess.createQuery("select sum(dom.totalPayment-dom.paid-dom.discount) from DistOrderManager dom where dom.seen=true"
                + " and dom.distributor=:d ").setParameter("d", dist).list();
    String pyTitle="";
    if(!os.isEmpty()){
        Object tt=os.get(0);
        payable+=new Double((tt!=null)?""+tt:"0");
        pyTitle+="\nRequisition  Pending : ₹"+tt;
//            payable=new Double((tt[1]!=null)?""+tt[1]:"0");
    }
//        Transaction tr = sess.beginTransaction();
%>
<script>
    var payMethod="";
function setPayMethod(val){
    payMethod=val;
    if(val==="Select Payment Method"){
        $("#payId").attr("disabled","disabled");
        $("#payId").val("");
        $("#bkNm").attr("disabled","disabled");
        $("#bkNm").val("");
        $("#amt").attr("disabled","disabled");
        $("#amt").val("");
    }else if(val==="Cash"){
        $("#amt").removeAttr("disabled");
        $("#amt").attr("placeholder","Amount*");
        $("#payId").attr("disabled","disabled");
        $("#payId").val("");
        $("#bkNm").attr("disabled","disabled");
        $("#bkNm").val("");
    }
    else if(val==="DD"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","DD No.*");
        $("#amt").removeAttr("Disabled");
        $("#amt").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");   
    }
    else if(val==="NEFT"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Transaction-Id*");
        $("#amt").removeAttr("Disabled");
        $("#amt").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    else if(val==="RTGS"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Transaction-Id*");
        $("#amt").removeAttr("Disabled");
        $("#amt").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    else if(val==="Cheque"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Cheque No.*");
        $("#amt").removeAttr("Disabled");
        $("#amt").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    else if(val==="Online"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Transaction-Id*");
        $("#amt").removeAttr("Disabled");
        $("#amt").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    }

    function buildJSON(){
    var distJson=[];
    for(var i=0;i<distJson.length;i++){ 
//                            var credit=new Number($("#payType"+distJson[i]).val());
//                            var debit=new Number($("#payType"+distJson[i]).val());
                            var amnt=new Number($("#amt"+distJson[i]).val());
                            
                            if(isNaN(amnt)){
                                showMes("Enter valid amount",true);
                                return ;
                            }
                        
                    }
    var req={payType:$("#payType").val(),payMethod:$("#payMethod").val(),payId:$("#payId").val(),amount:$("#amt").val(),
        bank:$("#bkNm").val(),summ:$("#summary").val(),action:$("#action").val()};
//    showMes(JSON.stringify(req));
    sendDataForResp("FormManager",JSON.stringify(req),true);
    }

</script>
<div class="loginForm" style="max-width: 100%;">
    <span class="close" id="close" onclick="closeMe();">x</span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">
            <p class="white pointer <%=(LU==null||LU!=null&&LU.getRoles().matches(".*\\(CFin\\).*")?"":"invisible")%>" onclick="popsl('df/adfin.jsp')"><span class="button white"><i class="fa fa-plus-circle"></i> Add New Record</span></p>
        </div>
        <div class="d3 left leftAlText ">
            <p class="greenFont">Todays collection:&#8377;<%=tCr%></p>
        </div>
        <div class="d3 left leftAlText">
            <p class="redFont">Todays Expenses:&#8377;<%=tDr%></p>
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left" style="">
<!--            <span class="white"><h2 class="nomargin nopadding">Finance Record</h2></span><hr>-->
<div style="margin: 1px;padding: 1px;border: 1px white solid;" class="bgcolef">
    <p class="nomargin nopadding white bgcolt8">Month: <%=Utils.getWMon.format(new Date())%> </p><hr>
    <ul>
        <li title="Filters" class="bgcolef">
            <br>
            <form id="dfinFil" name="dfinFil">
            <input title="Start date" value="<%=UT.ie(iD)?Utils.DbFmt.format(curr[0]):iD%>" class="textField" type="date" name="iD"/><br>
            <input class="textField" value="<%=UT.ie(fD)?Utils.DbFmt.format(curr[1]):fD%>" title="End Date" type="date" name="fD"/><br>
            <select name="pm" class="textField">
                <option value="">Select Payment Mode</option>
                <option>Cash</option>
                <option>Cheque</option>
                <option>DD</option>
                <option>NEFT</option>
                <option>Online</option>
                <option>RTGS</option>
            </select><br><br>
            
            <span><input type="radio" name="v" value="1" <%=!vc?"":"checked"%>/>Voucher Wise <input <%=!vc?"checked":""%> type="radio" name="v" value="0" />Date wise<br></span><br>
            <span class="right" onclick="loadPg('df/fin.jsp?'+gfd('dfinFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
        
    </ul>
</div>
    <div style="margin-top: 10px;padding: 1px;border: 1px white solid;" class="bgcolef">
    <p class="nomargin nopadding white bgcolt8">Quick Links</p><hr>
    <ul>
<!--        <li class="navLink leftAlText">Collection <span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Expenditures<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Recd from Complaints<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Recd from Orders<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Paid for Purchase<span class="right fa fa-angle-double-right"></span></li><hr>-->
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','df/r/fin.jsp',false)">Performance Meter<span class="right "> <i class="fa fa-angle-double-right"></i></span></li><hr>
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','df/fin/pendingdock.jsp',false)">Pending Balance<span class="right "> <i class="fa fa-angle-double-right"></i></span></li><hr>
        <li class="navLink leftAlText" title="<%=finT+"\nOthers   "+pCre%>" onclick="loadPageIn('linkLoader','df/fin/receivable.jsp',false)">Receivable Pending<span class="right ">&#8377;<%=pCre+receivable%> <i class="fa fa-angle-double-right"></i></span></li><hr>
        <li class="navLink leftAlText" title="<%=pyTitle+"\nOthers   "+pDeb%>" onclick="loadPageIn('linkLoader','df/fin/payableRec.jsp',false)">Payable Pending<span class="right ">&#8377;<%=payable+pDeb%> <i class="fa fa-angle-double-right"></i></span></li>
    </ul>
    </div>
        <br>
        </div>
        <div class="right sbnvLdr" id="linkLoader" ><hr>
              <h2 class="nomargin nopadding bgcolef">Finance History</h2><hr>
              <div class="scrollable">
            <%
            if(vc){
            %>
              <table width="100%" cellpadding="5" border="1px">
                <thead>
                    <tr rowspan="2" align="left" >
                        <th>Date</th><th>Received</th><th>Paid</th><th>DocketNo</th><th>Invoice</th>
                        <th colspan="2"  style="max-width: 250px;">Detail</th>
                        <%if(LU==null){%>
                        <th>Action</th>
                        <%}%>
                    </tr>
                </thead>
              <%
              for(DistFinance df:list){
              %>
              <tr id="row<%=df.getFinId()%>">
                  <td><%=df.getTxnDate()%></td>
                  <td><%=df.getCredit()%></td>
                  <td><%=df.getDebit()%></td>
                  <td onclick="popsl('df/dockRec.jsp?d=<%=df.getDocketNo()%>')"><%=df.getDocketNo()%></td>    
                  <td><%=df.getInvoice()%></td>    
                  <td><%=df.getMethod()%>,
                      <%if(df.getMethod()!=DistFinance.PaymentMethod.Cash){
                        out.print(df.getBankName()+","+df.getPayId());
                      }%></td>    
                  <td  style="max-width: 250px;"><div class="scrollable" style="max-width: 100%;"><%=df.getSummary()%></div></td>
                  <%if(LU==null){%>
                  <td><span onclick="sendDataForResp('a','action=TUP&mod=DFin&i=<%=df.getFinId()%>')" id="adf<%=df.getFinId()%>" class="button <%=df.isApproved()?"greenFont":"redFont"%> fa fa-thumbs-up" title="Approve"></span>
                      <span onclick="showDial('action=del&mod=DFin&i=<%=df.getFinId()%>','del','Delete??','You can\'t undo this action');" class="button fa fa-trash" title="Delete"></span></td>    
                  <%}%>
              </tr>
              <%}%>
              </table>
              <%}else{%>
            <table id="mainTable" width="100%" border='1px' cellpadding='5'>        
                <thead>
                    <tr align='left'><th>Date</th><th>Credit</th><th>Debit</th><th>Outcome</th></tr>
                </thead>
                <%
                    double debitSum=0;
                    double credSum=0;
                    for(Object[] req:dw){
                    debitSum+=(Double)req[0];
                    credSum+=(Double)req[1];
                %>
                <tr onclick="loadPg('df/fin.jsp?iD=<%=req[2]%>&v=1')">
                <td><%=req[2]%></td>
                <td title="click to view all credits of the day" style='cursor: default;color:green'>&#8377; <%=req[0]%></td>
                <td style='cursor: default;color:red' title="click to view all debits of the day">&#8377; <%=req[1]%></td>
                <td>&#8377; <%=((Double)req[0]-(Double)req[1])%></td>
                 </tr>
                    <%}%>
          </table>
          <%}%>
          
                </div>  
          </div>
        </div>
        
</div>
<script>
<%=UT.ie(pm)?"":"dfinFil.pm.value='"+pm+"'"%>;

</script>
<%
//    sess.getTransaction().
sess.close();
%>
