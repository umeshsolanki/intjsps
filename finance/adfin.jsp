<%-- 
    Document   : DisFinance
    Created on : Oct 12, 2017, 10:20:53 PM
    Author     : sunil
--%>

<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="entities.ProductionBranch"%>
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
    <%
                List<DistributorInfo> fin=sess.createCriteria(DistributorInfo.class).list();
                JSONArray jar = new JSONArray(fin);
                out.print("var fin = JSON.parse(JSON.stringify("+jar.toString()+"));");
    %>
    function getFinId(source){
        
        var selSrc = "<option >Select Source</option>";
        for(var ind in fin){
            var obj = JSON.parse(fin[ind]);
//            alert(fin[ind]);
            if(obj.type===source){
                selSrc +="<option value='"+obj.disId+"'>"+obj.disId+"</option>";
            }
        }
        $("#selSource").html(selSrc);
    }
    var payType="";
    function setPayType(val){
        payType=val;
        if(val==="Select Type"){
            $("#selExp").html(selExp);
//            $("#docket").attr("disabled","disabled");
//            $("#docket").val("");
//            $("#cust_name").attr("disabled","disabled");
//            $("#cust_name").val("");
//            $("#cust_mob").attr("disabled","disabled");
//            $("#cust_mob").val("");
//            $("#cust_bank").attr("disabled","disabled");
//            $("#cust_bank").val("");
//            $("#source").attr("disabled","disabled");
//            $("#selSource").attr("disabled","disabled");
        }
        else if(val==="Credit/Receivable"){
            $("#selExp").html(selCre);
//            $("#docket").removeAttr("disabled");
//            $("#docket").attr("Placeholder","Docket No.*");
//            $("#cust_name").removeAttr("disabled");
//            $("#cust_name").attr("Placeholder","Customer Name*");
//            $("#cust_mob").removeAttr("disabled");
//            $("#cust_mob").attr("Placeholder","Customer Mobile*");
////            $("#cust_bank").removeAttr("disabled");
////            $("#cust_bank").attr("Placeholder","Customer Bank Name*");
//            $("#source").removeAttr("disabled");
//            $("#source").attr("Placeholder","Select Source*");
//            $("#selSource").removeAttr("disabled");
//            $("#selSource").attr("Placeholder","Select Source Name*");
        }
        else if(val==="Debit/Payable"){
            $("#selExp").html(selExp);
//            $("#docket").attr("disabled","disabled");
//            $("#docket").val("");
//            $("#cust_name").attr("disabled","disabled");
//            $("#cust_name").val("");
//            $("#cust_mob").attr("disabled","disabled");
//            $("#cust_mob").val("");
//            $("#cust_bank").attr("disabled","disabled");
//            $("#cust_bank").val("");
//            $("#source").attr("disabled","disabled");
//            $("#selSource").attr("disabled","disabled");
        }
    }
    var selExp="<option>Select Subject</option>\n" +
"                <option>Raw Material Purchase</option>\n" +
"                <option>Sales DepartMent</option>\n" +
"                <option>Employee</option>\n" +
"                <option>ESI</option>\n" +
"                <option>PF</option>\n" +
"                <option>Salaries and PAys</option>\n" +
"                <option>Employer Drawings</option>\n" +
"                <option>Power Bill</option>\n" +
"                <option>Water Bill</option>\n" +
"                <option>Goods Outward Transportation</option>\n" +
"                <option>Goods Inward Transportation</option>\n" +
"                <option>Consultation Charges</option>\n" +
"                <option>Audit Fees</option>\n" +
"                <option>Taxes and Duties</option>\n" +
"                <option>Other</option>";

    var selCre="<option>Select Subject</option><option id=\"prodSale\" name=\"prodSale\">Product Sale</option>\n" +
"                <option id=\"ServiceChrgs\" name=\"ServiceChrgs\">Service Charges(Repair Charges)</option>\n" +
"                <option id=\"comisnChrgs\" name=\"comisnChrgs\">Commission Charges</option>\n";
</script>

<div class="loginForm" style="background-color: #ababbc;max-width: 100%;">
    <span class="close" id="close" onclick="clrLSP();">x</span>
    <div class="fullWidWithBGContainer">
        
            <span class="white"><h2 class="nomargin nopadding centAlText">Finance Record</h2></span><hr>
        <br>
    <center>
        <form action="FormManager " method="post" name="loginForm" id='finForm' >
            <input type="hidden" name="action" id="action" value="finReq"/>
            <input title="Enter Date" class="textField" type="date" name="dt" value="<%=Utils.DbFmt.format(new Date())%>"/>
            <select onchange="setPayType(this.value)" class="textField" type="text" name="type" id="payType">
                <option value="" hidden="">Select Type</option>
                <option id="credit" title="Receivable">Credit</option>
                <option id="debit" title="Payable">Debit</option>
            </select><br>
            <select class="textField" name="sel"><option value="">Select Seller</option>
            <%
                List<DistributorInfo> b=sess.createQuery("from DistributorInfo where type is not 'referer' and deleted=false order by disId").list();
                for(DistributorInfo brr:b){
                %>
                <option value="<%=brr.getDisId()%>"><%=brr.getDisId()%></option>
                <%}%>
            </select>
            <select title="Branch" class="textField" name="b"><option value="" hidden="">Select Branch</option>
                <%
                List<ProductionBranch> br=sess.createQuery("from ProductionBranch order by brName").list();
                for(ProductionBranch brr:br){
                %>
                <option value="<%=brr.getBrId()%>"><%=brr.getBrName()%></option>
                <%}%>
            </select><br>
            <select onchange="setPayMethod(this.value)" class="textField" type="text"  id="payMethod" name="payMethod">
                <option value="" hidden="">Select Payment Method</option>
                <option>Cash</option>
                <option>DD</option>
                <option>NEFT</option>
                <option>RTGS</option>
                <option>Cheque</option>
                <option>Online</option>
            </select>
            <input class="textField" type="text" id="payId" disabled="true" name="payId" placeholder="Txn-Id/DD/Cheque No.*"/><br>
            <input class="textField" type="number" id="amt" name="amt" placeholder="Amount*"/>
            <input class="textField" type="text" id="bkNm" name="bkNm" disabled="true" placeholder="Bank Name"/><br>
            <input class="textField" type="text" id="dock" name="dock" placeholder="Docket No"/>
            <select class="textField" type="text" name="qs">
                <option value="" hidden="">Select Subject</option>
                <option>Labour Welfare</option>
                <option>Miscellaneous</option>
                <option>Requisition Balance Received</option>
                <option>Salary Adv</option>
                <option>Salary Arrears</option>
                <option>Service Charge Received</option>
                <option>Raw Material Purchase</option>
                <option>Transportation charge</option>
                <option>Taxes/Audit</option>
                <option>Water/Elec Bill</option>
                <option>Other</option>
            </select><br>
            Is Pending <input type="checkbox" name="fe" value="fe" title="is it pending"/><br>
            
            <textarea class="txtArea"  id="summary" name="summary" placeholder="Remark*" ></textarea><br><br>
            <button onclick='return subForm("finForm","FormManager")' id="editBtn" class="button">Save</button>
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
