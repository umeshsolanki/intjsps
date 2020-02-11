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
<!DOCTYPE html>
<%
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    Admins role=(Admins)request.getSession().getAttribute("role");
    if(role==null){
        response.sendRedirect("?msg=Login Please");
        return;
    }
    boolean vc=false;
    if(!UT.ia(role, "3")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
        return;
        }
        
        Date nw=new Date();
        String m=request.getParameter("p"),pm=request.getParameter("pm"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),v=request.getParameter("v"),d=request.getParameter("d");
        vc=v!=null&&v.equals("1");
        
        List<Object[]> todays = sess.createQuery("select sum(credit),sum(debit) from FinanceRequest where pending=true)").list();
        
        double tCr=0,tDr=0,payable=0,receivable=0;
        String finT="";
         List<Object[]> os=sess.createQuery("select sum(dom.totalPayment-dom.paid-dom.discount),dom.distributor from DistOrderManager dom where dom.seen=true").list();
        if(!os.isEmpty()){
            Object[] tt=os.get(0);
            receivable+=new Double((tt[0]!=null)?""+tt[0]:"0");
            finT+="Requisition Pending \t    : ₹"+tt[0];
//            payable=new Double((tt[1]!=null)?""+tt[1]:"0");
        }
        
        List<Object[]> dockPend=sess.createQuery("select sum(bal+scExp-instCharge),scExp-instCharge from DistSaleManager "
            + " where (bal>0 or scExp-instCharge>0) and dist.ownedByGA=true").list();
        if(!dockPend.isEmpty()){
            Object[] tt=dockPend.get(0);
            receivable+=new Double((tt[0]!=null)?""+tt[0]:"0");
            finT+="\nOrder and Complaint Pending   : ₹"+tt[0];
//            payable=new Double((tt[1]!=null)?""+tt[1]:"0");
        }
         
       if(!todays.isEmpty()){
            Object[] tt=todays.get(0);
            receivable+=new Double((tt[0]!=null)?""+tt[0]:"0");
            payable+=new Double((tt[1]!=null)?""+tt[1]:"0");
            finT+="\nOthers  \t\t\t    : ₹"+new Double((tt[0]!=null)?""+tt[0]:"0");
        }
        
       String purPendQry="select sum(price-paid) from InwardManager where approved=true";
       Double purPend=(Double)sess.createQuery(purPendQry).uniqueResult();
       if(purPend==null){
           purPend=new Double(0);
       }
//        String paidBal="select sum(paid) from InwardManager ";
        
        todays = sess.createQuery("select sum(credit),sum(debit) from FinanceRequest where pending=false and txnDate=CURDATE()").list();
        Date[] curr=(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}"))?new Date[]{Utils.DbFmt.parse(iD),Utils.DbFmt.parse(fD)}:Utils.gCMon(new Date());
        double mCr=0,mDr=0;
        
        todays = sess.createQuery("select sum(credit),sum(debit) from FinanceRequest where  pending=false and ( txnDate between :iDt and :fDt )")
        .setParameter("iDt", curr[0])
        .setParameter("fDt", curr[1])
        .list();
        if(!todays.isEmpty()){
            Object[] tt=todays.get(0);
            mCr=new Double((tt[0]!=null)?""+tt[0]:"0");
            mDr=new Double((tt[1]!=null)?""+tt[1]:"0");
        }
        double credSum=0,debitSum=0;
        Criteria c = sess.createCriteria(FinanceRequest.class)
                .add(Restrictions.eq("pending", false))
                .addOrder(Order.desc("txnDate"));
        if(!UT.ie(pm)){
            c.add(Restrictions.eq("method",FinanceRequest.PM.valueOf(pm)));
        }
        if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
            c.add(Restrictions.between("txnDate", Utils.DbFmt.parse(iD), Utils.DbFmt.parse(fD)));
//            c.add(Restrictions.eq("dist.disId",d));
        }else if(iD!=null&&iD.matches(".{10}")){
            c.add(Restrictions.eq("txnDate", Utils.DbFmt.parse(iD)));       
        }else{
               c.add(Restrictions.between("txnDate", curr[0],curr[1]));
        }
        if(!Utils.isEmpty(d)){
            c.add(Restrictions.eq("dist.disId",d));
        }
        
    Query qr=sess.createQuery("select sum(credit),sum(debit),txnDate from FinanceRequest finId where"
            + " pending=false and txnDate between :id and :fd group by txnDate order by txnDate  desc")
            .setParameter("id", curr[0]).setParameter("fd", curr[1]);
        List<FinanceRequest> list=null;
        List<Object[]> dw=null;
        if(vc){
            list=c.list();
        }else{
            dw=qr.list();
        }
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
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\(C3\\).*)")?"":"invisible"%>">
                <span onclick="popsl('finance/adfin.jsp')" class="button white"><i class="fa fa-plus-circle"></i> New Entry</span>
                <span onclick="popsl('finance/adacc.jsp')" class="button white <%=role.getRole().matches(".*Global.*")?"":"invisible"%>"><i class="fa fa-plus-circle"></i> Create Account</span>
                <span onclick="popsl('finance/be.jsp')" class="button white"><i class="fa fa-plus-circle"></i> Bank Entry</span>
            </p>
        </div>
        <div class="d3 left leftAlText ">
            <p class="greenFont">Todays collection:&#8377;<%=tCr%></p>
        </div>
        <div class="d3 left leftAlText">
            <p class="redFont">Todays Expenses:&#8377;<%=tDr%></p>
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left rShadow" style="">
            <i class="fa btn fa-arrow-circle-left fa-2x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<!--            <span class="white"><h2 class="nomargin nopadding">Finance Record</h2></span><hr>-->
<div style="">
    <p class="nomargin p-15 white bgcolt8  bold">Month: <%=Utils.getWMon.format(new Date())%> </p><hr>
    <ul>
        <li title="Filters" class="bgcolef">
            <br>
            <form id="prodFil" name="prodFil">
                <select title="For seller" class="textField" name="d"><option value="" hidden="">Select Seller</option>
                <%
                List<DistributorInfo> dd=sess.createQuery("from DistributorInfo where type is not 'referer' and deleted=false order by disId").list();
                for(DistributorInfo brr:dd){
                %>
                <option value="<%=brr.getDisId()%>"><%=brr.getDisId()%></option>
                <%}%>
            </select><br>
            <select title="Branch" class="textField" name="b"><option value="" hidden="">Select Branch</option>
                <%
                List<ProductionBranch> b=sess.createQuery("from ProductionBranch order by brName").list();
                for(ProductionBranch brr:b){
                %>
                <option value="<%=brr.getBrId()%>"><%=brr.getBrName()%></option>
                <%}%>
            </select><br>
            <select title="Account" class="textField" name="d"><option value="" hidden="">Select Account</option>
                <%
                    List<BankAccount> a=sess.createQuery("from BankAccount").list();
                for(BankAccount brr:a){
                %>
                <option title="<%=brr.getBkName()+","+brr.getBkAdd()%>" value="<%=brr.getAccNo()%>"><%=brr.getAccNo()%></option>
                <%}%>
            </select><br>
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
            <span><input type="radio" name="v" value="1" <%=!vc?"":"checked"%>/>Voucher Wise<input <%=!vc?"checked":""%> type="radio" name="v" value="0" />Date wise<br></span>
            <br><br>
            <span class="right" onclick="loadPg('finance/index.jsp?'+gfd('prodFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
    </ul>
</div>
<div style="" class="bgcolef">
    <p class="nomargin p-15 white bgcolt8  bold">Quick Links</p><hr>
    <ul>
        <%
            List<BankAccount> acc=sess.createCriteria(BankAccount.class).list();
            for(BankAccount ac:acc){
        %>
        <li class="navLink leftAlText" title="<%=ac.getBkName()+", "+ac.getBkAdd()%>"><%=ac.getAccNo()%><span class="right fa fa-angle-double-right"></span></li><hr>
        <%}%>
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','report/sellerWiseFinace.jsp?'+gfd('prodFil'))">Seller Wise Collection <span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText"> Received <span class="right" id="credSum"></span></li><hr>
        <li class="navLink leftAlText"> Paid <span class="right" id="debitSum"></span></li><hr>
        <li class="navLink leftAlText" title="<%=finT%>"  onclick="loadPageIn('linkLoader','finance/fin/receivable.jsp',false)">Receivable<span class="right">&#8377;<%=receivable%>&nbsp;</span></li><hr>
        <li class="navLink leftAlText" title="RM Purchase pending: <%=""+purPend+"\n"%>Others     :<%=""+payable%>"  onclick="loadPageIn('linkLoader','finance/fin/payableRec.jsp',false)">Payable<span class="right">&#8377;<%=""+(payable+purPend)%>&nbsp;</span></li>
    </ul>
</div>
        <br>
        </div>
        <div class="right sbnvLdr lShadow" id="linkLoader">
              <hr>
              <jsp:include page="monthly.jsp" flush="true"/>
            <%--<table id="header-fixed" border="1px" cellpadding="2" style="margin:0px;" width="100%">
            </table>
              <div class="scrollable">
                  <%
                  if(vc){
                  %>
                  <table  width="100%" cellpadding="5" border="1px">
                <thead>
                    <tr rowspan="2" align="left">
                        <th>Date</th><th>Received</th><th>Paid</th><th>DocketNo</th><th>BankEntry</th><th colspan="2">Detail</th><th>Trace</th><th>Action</th>
                    </tr>
                </thead>
              <%
            debitSum=0;credSum=0;
              for(FinanceRequest df:list){
                  debitSum+=df.getDebit();
                  credSum+=df.getCredit();
              %>
              <tr id="row<%=df.getFinId()%>">
                  <td><%=df.getTxnDate()%></td>
                  <td><%=df.getCredit()%></td>
                  <td><%=df.getDebit()%></td>
                  <td class="pointer" onclick="popsl('dockets/dockRec.jsp?d=<%=df.getDocketNo()%>')"><%=df.getDocketNo()%></td>    
                  <td><%=df.getRemark()!=null&&df.equals(FinanceRequest.RMK.BankOP)?"<span class='fa fa-check-circle greenFont'></span>":"<span class='fa fa-check-circle redFont'></span>"%></td>    
                  <td><%=df.getMethod()%></td>    
                  <td><%=df.getSummary()%></td>    
                  <td><%=df.getTrace()!=null?df.getTrace():""%></td>
                  <td>
                    <%if(role.getRole().matches("(.*Global.*)|(.*\\(A3\\).*)")){%>
                    <%if(df.isPending()){%>
                        <span onclick="sendDataForResp('U','action=madone&mod=Fin&i=<%=df.getFinId()%>');" class="button  fa fa-check-square" title="Pending"></span> 
                    <%}%> 
                        <span onclick="sendDataForResp('a','action=TUP&mod=Fin&i=<%=df.getFinId()%>')" class="button <%=df.isApproved()?"greenFont":"redFont"%> fa fa-thumbs-up" title="Approve"></span>
                    <%}if(role.getRole().matches("(.*Global.*)|(.*\\(D3\\).*)")){%>
                        <span onclick="showDial('action=del&mod=Fin&i=<%=df.getFinId()%>&r=row<%=df.getFinId()%>','del','Confirm Delete','It\'ll update the docket bal ');"
                          class="button fa fa-trash" title="Delete"></span>
                    <%}%>
                    </td>    
              </tr>
              <%}
              %>
              <script>
                    $("#credSum").html("&#8377;<%=credSum%> ");              
                    $("#debitSum").html("&#8377;<%=debitSum%> ");
              </script>
              </table>
              <%}else{%>
            <table id="mainTable" width="100%" border='1px' cellpadding='5'>        
                <thead>
                    <tr align='left'><th>Date</th><th>Credit</th><th>Debit</th><th>Outcome</th></tr>
                </thead>
                <%
                    for(Object[] req:dw){
                    debitSum+=(Double)req[0];
                    credSum+=(Double)req[1];
                %>
                <tr onclick="loadPg('finance/index.jsp?iD=<%=req[2]%>&v=1')">
                <td><%=req[2]%></td>
                <td title="click to view all credits of the day" style='cursor: default;color:green'>&#8377; <%=req[0]%></td>
                <td style='cursor: default;color:red' title="click to view all debits of the day">&#8377; <%=req[1]%></td>
                <td>&#8377; <%=((Double)req[0]-(Double)req[1])%></td>
                 </tr>
                    <%}%>
          </table>
          
        <script>
            copyHdr("mainTable","header-fixed");
                $("#credSum").html("&#8377;<%=credSum%> ");              
                $("#debitSum").html("&#8377;<%=debitSum%> ");
        </script>      
        <%}--%>
                </div>
          </div>
        </div>
</div>
<%
sess.close();
%>
