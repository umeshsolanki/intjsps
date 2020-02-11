<%-- 
    Document   : newINV
    Created on : 2 Jan, 2018, 2:00:38 PM
    Author     : UMESH-ADMIN
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
//        DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
//        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
//        sess.refresh(dist);
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
    <span class="close fa fa-close" id="close" onclick="clrLSP();"></span>
    <div class="fullWidWithBGContainer">
    <span class="white"><h2 class="nomargin nopadding centAlText">New Invoice Record</h2></span><hr><br>
    <center>
        <form action="FormManager " method="post" name="loginForm" id='finForm' >
            <input type="hidden" name="action" id="action" value="newTax"/>
            <input class="textField" type="text" id="dn" name="dn" placeholder="Docket No(if exist)"/>
            <input class="textField" type="text" id="dn" name="dn" placeholder="Mobile"/>
            <input class="textField" type="text" id="tNm" name="tNm" placeholder="Tax Code or Name"/>
            <input class="textField" type="number" id="perc" name="perc" placeholder="Tax value Percentage"/>
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
