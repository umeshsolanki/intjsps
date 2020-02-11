<%-- 
    Document   : DisFinance
    Created on : Oct 12, 2017, 10:20:53 PM
    Author     : sunil
--%>

<%@page import="entities.Address"%>
<%@page import="entities.SaleInfo"%>
<%@page import="utils.UT"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="entities.Customer"%>
<%@page import="entities.DistSaleManager"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.DistFinance"%>
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
//        DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
//        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
//        sess.refresh(dist);
        String dkt=request.getParameter("d");
              
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
<div class="loginForm" style="background-color: #efefef;max-width: 100%;">
    <span class="fa fa-close close" id="close" onclick="clrLSP();"></span>
    <div class="fullWidWithBGContainer">
        <h2 class=" nopadding white nmgn bgcolt8 centAlText">Docket-<%=dkt%></h2><hr>
        <%
            List<DistFinance> fd=sess.createCriteria(DistFinance.class).add(Restrictions.eq("docketNo", dkt)).list();
            if(!fd.isEmpty()){
        %>
        <span class="white"><p class="spdn nmgn leftAlText bgcolt8">Finance Record</p></span><hr>
    <center>
        <table border='1px' cellpadding='2'>
            <tr><th>Date</th><th>RefDate</th><th>Amount</th><th>PayMode</th><th>Detail</th></tr>
            <%
            for(DistFinance f:fd){%>
            <tr><td><%=f.getTxnDate()%></td><td><%=f.getRefDate()%></td><td><%=f.getCredit()>0?f.getCredit():f.getDebit()%></td><td><%=f.getMethod()%></td><td><%=f.getSummary()%></td></tr>
            <%}
            %>
        </table>   <br>
        <%}%>
        <span class="white"><p class="spdn nmgn leftAlText bgcolt8">Products Rec</p></span><hr>
        <table border='1px' cellpadding='2'>
            <tr><th>Product</th><th>Qty</th><th>MRP</th><th>Rate</th><th>Total</th></tr>
            <%
            List<SaleInfo> si=sess.createQuery("from SaleInfo s where s.saleMan.docketNo=:d").setParameter("d", dkt).list();
            for(SaleInfo s:si){%>
            <tr><td><%=s.getProd().getFPName()%></td><td><%=s.getQnt()%></td><td>&#8377;<%=s.getMrp()%></td><td>&#8377;<%=s.getSoldAt()%></td><td>&#8377;<%=s.getQnt()*s.getSoldAt()%></td></tr>
            <%}%>
        </table>   <br>
        <div class="fullWidWithBGContainer">
            <div class="half left borderRight">
            <%
            if(dkt.matches("((2)|(3)).*")){
            DistSaleManager d=(DistSaleManager)sess.createCriteria(DistSaleManager.class).add(Restrictions.eq("docketNo", dkt)).uniqueResult();
            if(d==null){
                out.print("No information found");
                return ;
            }
            Customer c=d.getCust();
            Address a=d.getAddress()==null?new Address():d.getAddress();
            if(d!=null){
            %>
            <p class="leftAlText white">&nbsp;Date<span class="right"><%=utils.Utils.HRFmt.format(d.getDt())%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white">&nbsp;Executed on<span class="right"><%=d.getExeDate()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white">&nbsp;SNo.<span class="right"><%=d.getSerNo()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white">&nbsp;Installed By:<span class="right"><%=d.getInstPerson()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white">&nbsp;Remark:<span class="right"><%=d.getRemark()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white">&nbsp;Remark1:<span class="right"><%=d.getRemark1()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white">&nbsp;Remark2:<span class="right"><%=d.getRemark2()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white">&nbsp;Order No:<span class="right"><%=d.getOdrNo()%>&nbsp;&nbsp;</span></p><hr>
            </div>
            <div class="half right">
            <p class="leftAlText white">&nbsp; Customer<span class="right"><%=c.getName()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white ">&nbsp; Mobile  No<span class="right"><%=c.getMob()%>,<%=c.getAltMob()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white ">&nbsp; Add.   <span class="right"><%=a.getFlat()+", "+a.getApt()+", "+a.getAddr()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white ">&nbsp; SC (Expected) <span class="right"><%=d.getScExp()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white">&nbsp;Refund<span class="right"><%=d.getRefund()%>&nbsp;&nbsp;</span></p><hr>
            <%}}else{
                DistOrderManager d=(DistOrderManager)sess.createCriteria(DistOrderManager.class).add(Restrictions.eq("docketNo", dkt)).uniqueResult();
                DistributorInfo dis=d.getDistributor();
                if(d!=null){
            %>
            <p class="leftAlText white">&nbsp;Stock Released On <span class="right"><%=d.getStockRlsOn()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white">&nbsp;Seller Comment <span class="right"><%=d.getOrderNotice()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white">&nbsp;Finance Comment <span class="right"><%=d.getFinMes()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white">&nbsp;SKU Comment <span class="right"><%=d.getDisMes()%>&nbsp;&nbsp;</span></p><hr>
            </div>
            <div class="half right">
            <p class="leftAlText white">&nbsp; Seller<span class="right"><%=dis.getDisId()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white ">&nbsp; Mobile  No<span class="right"><%=dis.getMob()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white ">&nbsp; Add.   <span class="right"><%=dis.getAddress()%>&nbsp;&nbsp;</span></p><hr>
            <p class="leftAlText white ">&nbsp; Commission <span class="right"><%=d.getComm()%>&nbsp;&nbsp;</span></p><hr>
            <%}}%>  
            </div>
        </div>        
        <br><br>
    </center>           
</div>
</div>
            <style>
                            .popSMLE{
                                box-shadow: 4px 4px 25px black;
                            }
                        </style>
<%
sess.close();
%>
