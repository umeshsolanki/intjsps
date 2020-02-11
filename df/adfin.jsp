<%-- 
    Document   : DisFinance
    Created on : Oct 12, 2017, 10:20:53 PM
    Author     : sunil
--%>

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
        DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
        if(dist==null||LU!=null&&!LU.getRoles().matches(".*\\(CFin\\).*")){
            out.print("<script>window.location.replace(\"?msg=You don't have permission to access this page\");</script>");
            return;
        }
        sess.refresh(dist);
 
              
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
    <span class="close" id="close" onclick="clrLSP();">x</span>
    <div class="fullWidWithBGContainer">
        
            <span class="blkFnt"><h2 class="nomargin nopadding bgcolef centAlText">Finance Record</h2></span>
            
        <br>
    <center>
        <form action="FormManager " method="post" name="loginForm" id='loginForm' >
            <input type="hidden" name="action" id="action" value="distFinReq"/>
            <input class="textField" type="text" id="dt" name="dt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Date"/>
            <input class="textField" type="text" id="doc" name="doc" placeholder="Docket No"/>
            <select class="textField" type="text" name="type" id="payType">
                <option value="">Select Payment Type</option>
                <option id="credit" title="Receivable">Credit</option>
                <option id="debit" title="Payable">Debit</option>
                <!--<option id="debit" title="Payable" value="ho">Hand Over</option>-->
            </select><br>
            <input class="textField" type="number" id="amt" name="amt" placeholder="Amount*"/>
            <select onchange="setPayMethod(this.value)" class="textField" type="text"  id="payMethod" name="payMethod">
                <option value="">Select Payment Method</option>
                <option>Cash</option>
                <option>DD</option>
                <option>NEFT</option>
                <option>RTGS</option>
                <option>Cheque</option>
                <option>Online</option>
            </select>
            <input class="textField" type="text" id="payId" disabled="true" name="payId" placeholder="Txn-Id/DD/Cheque No.*"/><br>
            <input class="textField" type="text" id="bkNm" name="bkNm" disabled="true" placeholder="Bank Name*"/><br>
            <textarea class="txtArea"  id="summary" name="summary" placeholder="Details*" ></textarea><br>
            Is Pending <input type="checkbox" name="fe" value="fe" title="Check it if will pay/receive in future"/><br><br>
            <button onclick='return subForm("loginForm","FormManager");' id="editBtn" class="button">Add</button>
            <br><br>
        </form>
       </center>           
</div>
    <style>
                            .popSMLE{
                                box-shadow: 4px 4px 25px black;
                            }
                        </style>
<%
sess.close();
%>
