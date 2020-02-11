<%-- 
    Document   : imp
    Created on : 4 Feb, 2018, 11:51:36 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.InwardManager"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
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
        String oId=request.getParameter("i");
        InwardManager o=(InwardManager)sess.get(InwardManager.class, new Long(oId));
              
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
<div class="loginForm" style="background-color: #ababbc;max-width: 100%;">
    <span class="fa fa-close close" id="close" onclick="clrRSP();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <span class="white"><h2 class="nomargin nopadding centAlText bgcolt8">Bill Payment- <%=o.getBillNo()%></h2></span><hr>
        <br>
    <center>
        <form action="FormManager " method="post" name="balFM" id='balFM' >
            <input type="hidden" name="action" id="action" value="imp"/>
            <input type="hidden" name="i" id="action" value="<%=oId%>"/>
            <input class="textField" value="<%=Utils.DbFmt.format(new Date())%>" type="text" id="dt" name="dt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Date"/>
<!--            <select class="textField" type="text" name="type" id="payType">
                <option>Select Payment Type</option>
                <option id="credit">Credit/Receivable</option>
                <option id="debit">Debit/Payable</option>
            </select>-->
            <select onchange="setPayMethod(this.value)" class="textField" type="text"  id="payMethod" name="payMethod">
                <option>Select Payment Method</option>
                <option>Cash</option>
                <option>DD</option>
                <option>NEFT</option>
                <option>RTGS</option>
                <option>Cheque</option>
                <option>Online</option>
            </select>
<input class="textField" type="text" id="payId" disabled="true" name="txn" placeholder="Txn-Id/DD/Cheque No.*"/><br>
            <input class="textField" type="text" id="bkNm" name="bkNm" disabled="true" placeholder="Bank Name*"/>
            <input class="textField" type="number" id="amt" name="newBal" value="<%=o.getPrice()-o.getPaid()%>" placeholder="Amount*"/>
            <br><!--
<!--            <select class="textField" type="text" id="selExp" name="selExp">
                <option>Select Subject</option>   
            </select><br>-->
            <textarea class="txtArea"  id="summary" name="sm" placeholder="Details*" ></textarea><br><br>
            <button onclick='return subForm("balFM","U");' id="editBtn" class="button">Save</button>
            <br><br>
        </form>
       </center>           
</div>
            <style>
                            .popSMRt{
                                box-shadow: 4px 4px 25px black;
                            }
                        </style>
<%
sess.close();
%>
