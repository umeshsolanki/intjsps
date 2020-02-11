<%-- 
    Document   : addReturn
    Created on : 26 Apr, 2018, 1:22:33 PM
    Author     : UMESH-ADMIN
--%><%-- 
    Document   : DisFinance
    Created on : Oct 12, 2017, 10:20:53 PM
    Author     : sunil
--%>

<%@page import="entities.FinishedProduct"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.Date"%>
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
        List<FinishedProduct> pr=sess.createCriteria(FinishedProduct.class).add(Restrictions.eq("deleted", false)).addOrder(Order.asc("FPName")).list();
        List<DistributorInfo> dr=sess.createCriteria(DistributorInfo.class).add(Restrictions.eq("deleted", false)).add(Restrictions.ne("type", "User")).add(Restrictions.ne("type", "Referer")).list();
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
    <%="var prodJsonArr="+new JSONArray(pr).toString()+";"%>        
    var expCount=0;
    function addExp(){
        var sel="<div id='expCont"+expCount+"'>";
                var fieldHtml=sel+"<input name='exp"+expCount+"' id='exp"+expCount+"'\n\
                    class='autoFitTextField' type='text' placeholder='Expenditure Type' />\n\
                <input name='xpA"+expCount+"' id='xpA"+expCount+"' class='autoFitTextField' type='text' placeholder='Amount' />\n\</div>";
                $("#expCont").append(fieldHtml);
                expCount++;    
                return false;
//                            console.log(JSON.stringify(matIds));
        }

    var prodCount=0,prodIds=[];
        function addProduct(){
        prodCount++;
        prodIds.push(prodCount);
//                                showMes(JSON.stringify(prodIds));
//                                showMes("Total Materials used in "+prodName.value+" = "+matCount,false);
        var sel="<div id='pro"+prodCount+"'><select name='prodId"+prodCount+"' id='prodId"+prodCount+"' class='textField' ><option>Select Product</option>";
        for(ind in prodJsonArr){
                var obj=JSON.parse(prodJsonArr[ind]);
//                                        alert(obj['id']);
                sel+="<option value='"+(obj.fpId)+"'>"+obj.fpName+"</option>";
        }
        sel+="</select>";
        var fieldHtml=sel+"<input name='prodQnt"+prodCount+"' id='prodQnt"+prodCount+"' class='smTF' type='text' placeholder='*Quantity' />";
//        <input name='prodSP"+prodCount+"' id='prodSP"+prodCount+"' class='autoFitTextField' type='text' placeholder='*Sale Price' />
//        <button onclick='return addProduct();' class=button>&plus;</button>
        fieldHtml+="<button onclick='remProd("+prodCount+");' class='button fa fa-trash'></button>\n\
        </div>";
        $("#prodCont").append(fieldHtml);
        return false;
//                            console.log(JSON.stringify(matIds));
    }
   
    function remProd(id) {
//      alert(id);
        $("div").remove("#pro"+id);
        prodIds.splice(prodIds.indexOf(id),1);
//      showMes(JSON.stringify(prodIds));                                
        console.log(JSON.stringify(prodIds));
        }
    function buildJSON() {
        var products=[],exps=[];
        for(var i=0;i<prodIds.length;i++){

            var qty=new Number($("#prodQnt"+prodIds[i]).val());
            var psp=new Number($("#prodSP"+prodIds[i]).val());
//                            showMes();
        if(isNaN(qty)){
            showMes("Enter valid Quantity for All Products",true);
            return false;
        }
        var product={prod:$("#prodId"+prodIds[i]).val(),qnt:qty,sp:psp};
        products.push(product);
    }
        for(var i=0;i<expCount;i++){
            var exp={mes:"",amt:0};
            exp.mes=$("#exp"+i).val();
            exp.amt=Number($("#xpA"+i).val());
            exps.push(exp);
        }    
        var req={sno:$("#sno").val(),r1:$("#r1").val(),r2:$("#r2").val(),cPin:$("#cPIN").val(),cApt:$("#cApt").val(),exps:exps,dis:$("#sel").val(),dt:$("#dt").val(),
                cName:$("#cName").val(),cMob:$("#cMob").val(),cAMob:$("#cAMob").val(),cFlat:$("#cFlat").val(),cAdd:$("#cAdd").val(),action:$("#action").val(),
                prods:products,retBy:$("#retBy").val(),dock:$("#dock").val()};
//        showMes(JSON.stringify(req));
        sendDataForResp("FormManager",JSON.stringify(req),true);
    }
    
    function showPopUp(smId,bal,dkt,iKm,fKm){
       
        var popup="<div class='loginForm;' >\n\
            <span class='close' id='close' onclick='$(\"#updBal\").html(\"\");'>x</span>\n\
            <span class='white'><h2>Docket "+dkt+"</h2></span><hr>\n\
            <center>\n\
        <form  method='post' name='loginForm' id='balForm'>\n\
            <input type='hidden'  name='action' id='action' value='updDistBal'/>\n\
            <input type='hidden'  name='dsmId' value='"+smId+"'/>\n\
            <input type='text' class='textField' name='iR' value='"+iKm+"' placeholder=\"Initial Reading\"/>\n\
            <input type='text' class='textField' name='fR' value='"+fKm+"' placeholder=\"Final Reading\"/><br>\n\
            <input type='text' class='textField' name='servCHG' value='' placeholder=\"Service Charge\"/>\n\
            <select onchange='setPayType(this.value)' class='textField' type='text'  id='payMethod' name='payMethod' >\n\
                <option>Select Payment Method</option>\n\
                <option>Cash</option>\n\
                <option>DD</option>\n\
                <option>NEFT</option>\n\
                <option>RTGS</option>\n\
                <option>Cheque</option>\n\
                <option>Online</option>\n\
            </select><br>\n\
            <input class='textField' type='text'  name='bknm' id='bknm' placeholder='Enter Bank Name'/>\n\
            <input class='textField' type='text'  name='txn' id='txn' placeholder='Enter Transaction-Id'/><br>\n\
            <input class='textField' type='text'  name='newBal' id='newBal' value="+bal+" placeholder='Balance '/>\n\
            \n\<input type='text' class='textField' name='rem' placeholder=\"Remark\"/><br>\n\
                <div id='expCont'></div>\n\
            <button onclick='return addExp()' id=\"editBtn\" class=\"button\">Add Expenses</button>\
            <button onclick=\"return subForm('balForm','FormManager');\" class='button'>Save</button>\n\
        </form>\n\
       </center>\n\
        <br><br><br>\n\
</div>";
        $("#updBal").html(popup);
        return false;
    }
        </script>
        <div class="loginForm" style="background-color: #ababbc;max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="clrLSP();"></span>
    <div class="fullWidWithBGContainer">
    <h2 class="centAlText nomargin nopadding white bgcolt8">New Return</h2><hr>
    <center>
        <form action="FormManager" onsubmit="return false;" method="post" name="loginForm" id='loginForm' >
                    <input type="hidden" name="action" id="action" value="return"/>   
                <div class='halfnc left'>
                <br>
                    <input class="textField" value="<%=Utils.DbFmt.format(new Date())%>" type="text" id="dt" name="dt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Date"/>
                    <script>
                        function selFrom(sel) {
                            if(sel==''){
                                $(".sel").addClass("hidden");
                                $(".cus").addClass("hidden");
                            }else if(sel=='seller'){
                                $(".sel").removeClass("hidden");
                                $(".cus").addClass("hidden");
                            }else{
                                $(".cus").removeClass("hidden");
                                $(".sel").addClass("hidden");
                            }
                        }
                    </script>
                    <select id="retBy" class="textField" name="sel" onchange="selFrom(this.value)">
                        <option value="" hidden="">Select Received from</option>
                        <option value="seller">Seller</option>
                        <option value="consumer">Customer</option>
                    </select>
                    <select id="sel" class="textField sel hidden" name="sel">
                        <option value="">Select Seller</option>
                        <%
                        List<DistributorInfo> s=sess.createCriteria(DistributorInfo.class).add(Restrictions.eq("deleted", false)).add(Restrictions.ne("type", "User")).add(Restrictions.ne("type", "Referer")).list();
                        for(DistributorInfo r:s){
                        %>
                        <option value="<%=r.getDisId()%>"><%=r.getDisId()%></option>
                        <%}%>
                    </select>
                    <input class="textField cus hidden" type="text"  id="cName" name="cName" placeholder="Customer Name"/>
                    <input class="textField cus hidden" type="text"  id="cMob" name="cMob" placeholder="Customer Mobile"/>
                    <input class="textField cus hidden" type="text"  id="cAMob" name="cAMob" placeholder="Alternate Mobile"/>
                    <input class="textField cus hidden" type="text"  id="cPIN" name="cPIN" placeholder="PIN" title="PIN"/>
                    <input class="textField cus hidden" type="text"  id="cAdd" name="address" placeholder="Address"/>
                    </div>
                    <div class='halfnc right'><br>
                        <input class="textField" type="text"  id="dock" name="dock" title="Docket No" placeholder="Docket No."/><br>
                    <!--<input class="textField" type="text"  id="retChg" name="retChg" title="Return Charges" placeholder="Return Charges"/><br>-->
                    <textarea class="txtArea"  id="r1" name="r1" placeholder="Condition Description"></textarea><br>
                    <br><br>
                    </div>
                    <button onclick='return addProduct()' id="editBtn" class="button">Add Product</button>
                    <br>
                    <div id="prodCont" class="scrollable" style="max-height:200px;"></div>
                    <br>
                    <button onclick='return buildJSON("loginForm","FormManager")' id="editBtn" class="button">Save</button>
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
