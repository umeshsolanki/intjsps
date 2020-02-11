<%-- 
    Document   : DisFinance
    Created on : Oct 12, 2017, 10:20:53 PM
    Author     : sunil
--%>

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
        DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
        if(dist==null||LU!=null&&!LU.getRoles().matches(".*\\(CComp\\).*")){
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
            
            <%
                boolean isA=LU==null;
                out.print("var prodJsonArr="+dist.getMyProds().toString()+";");  
                List<DistributorInfo> dists=sess.createCriteria(DistributorInfo.class).list();
//                List<String> refrs=sess.createQuery("from DistSaleManager ").list();
                
            JSONArray jar=new JSONArray(dists);
//            out.print("var dists=JSON.parse(JSON.stringify("+jar.toString()+"));");
            String selSource="<option>Select Distributor-Id</option>";
            for(DistributorInfo d:dists){
                if(!d.getType().matches("(.*Referer.*)|(.*User.*)")&&!d.isDeleted()){
                    selSource+="<option>"+d.getDisId()+"</option>";
                }
            }
            %>
                
                function getDisIds(type) {
                var selSource="<option>Select Distributor-Id</option>";
                for(var ind in dists){
                    var obj=JSON.parse(dists[ind]);
//                    if(obj.type==type){
                        selSource+="<option value='"+obj.disId+"'>"+obj.disId+"</option>";
//                    }
                }
                $(".moveTo").html(selSource);
        }
        
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
                                        var obj=prodJsonArr[ind];
//                                        alert(obj['id']);
                                        sel+="<option value='"+(obj.fpId)+"'>"+obj.fpName+"</option>";
                                }
                                sel+="</select>";
                                var fieldHtml=sel+"<input name='prodQnt"+prodCount+"' id='prodQnt"+prodCount+"' class='autoFitTextField' type='text' placeholder='*Quantity' />\n\
                                <input name='prodSP"+prodCount+"' id='prodSP"+prodCount+"' class='autoFitTextField' type='text' placeholder='*Sale Price' />\n\
                            <button onclick='return addProduct();' class=button>&plus;</button>\
                            <button onclick='remProd("+prodCount+");' class=button>&Cross;</button>\n\
                            </div>";
                                $("#prodCont").append(fieldHtml);
                                return false;
//                            console.log(JSON.stringify(matIds));
                            }
                            function remProd(id) {
//                        alert(id);
                        $("div").remove("#pro"+id);
                        prodIds.splice(prodIds.indexOf(id),1);
//        showMes(JSON.stringify(prodIds));
                                        
        console.log(JSON.stringify(prodIds));
                    }
                    function buildJSON() {
                        var products=[],exps=[];
                        for(var i=0;i<prodIds.length;i++){
                            
                            var qty=new Number($("#prodQnt"+prodIds[i]).val());
                            var psp=new Number($("#prodSP"+prodIds[i]).val());
//                            showMes();
                        if(isNaN(qty)||isNaN(psp)){
                            showMes("Enter valid Quantity and Selling price of All Product",true);
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
                    
var req={com:$("#com"),sno:$("#sno").val(),to:$("#to").val(),by:$("#by").val(),r1:$("#r1").val(),r2:$("#r2").val(),ref:$("#ref").val(),cPin:$("#cPIN").val(),cApt:$("#cApt").val(),exps:exps,dis:"",dt:$("#dt").val(),
    payDtl:$("#payMethod").val(),adv:$("#advPaid").val(),instC:$("#instChg").val(),cName:$("#cName").val(),
    disc:$("#disc").val(),cMob:$("#cMob").val(),cAMob:$("#cAMob").val(),cFlat:$("#cFlat").val(),cAdd:$("#cAdd").val(),
    gstNo:$("#gst").val(),iName:$("#ipName").val(),veh:$("#veh").val(),iKm:$("#iKm").val(),fKm:$("#fKm").val(),
    action:$("#action").val(),prods:products};
//    showMes(JSON.stringify(req));
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
    <span class="close" id="close" onclick="clrLSP();">x</span>
    <div class="fullWidWithBGContainer">
        <h2 class="centAlText nomargin nopadding white">New Complaint</h2><hr>
    <center>
        
<form action="FormManager" onsubmit="return false;" method="post" name="loginForm" id='loginForm' >
            
                    <input type="hidden" name="action" id="action" value="complaint"/>   
                    <input class="textField" type="text" id="dt" name="dt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Date"/>
                    <select id="ref" class="textField" name="ref">
                        <option>Select Referrer</option>
                    <%
                    List<DistributorInfo> refs=sess.createCriteria(DistributorInfo.class).add(Restrictions.eq("type", DistributorInfo.Type.Referer.name())).list();
                    for(DistributorInfo r:refs){%>
                    <option><%=r.getDisId().split("00R-")[1]%></option>
                    <%}%>
                    </select>
                    <input class="textField" type="text"  id="cName" name="cName" placeholder="Customer Name"/>
                    <input class="textField" type="text"  id="cMob" name="cMob" placeholder="Customer Mobile"/>
                    <input class="textField" type="text"  id="cAMob" name="cAMob" placeholder="Alternate Mobile"/>
                    <input class="textField" type="text"  id="cFlat" name="cFlat" placeholder="Flat No." title="Flat No. is mendatory to fill!"/>
                    <input class="textField" type="text"  id="cApt" name="cApt" placeholder="Apartment Name" title="Apartment Name"/>
                    <input class="textField" type="text"  id="cPIN" name="cPIN" placeholder="PIN" title="PIN"/>
                    <input class="textField" type="text"  id="cAdd" name="address" placeholder="Address"/>
                    <!--<input class="textField" type="text"  id="gst" name="gst" placeholder="GST No."/>-->
                    <input class="textField" type="text"  id="disc" name="discount" placeholder="Discount"/>
                    <input class="textField" type="text"  id="com" name="com" placeholder="Commission"/>
                    <input class="textField" type="text"  id="advPaid" name="advPaid" placeholder="Advance Received"/>
                    <select class="textField" type="text"  id="payMethod" name="payMethod">
                        <option value="">Payment Mode</option>
                        <option>Cash</option>
                        <option>CC</option>
                    </select>
                    
                    <input class="textField" type="text"  id="instChg" name="instChg" title="Service Charge" placeholder="Service Charge To be collected"/>
    <input class="textField" type="text"  id="sno" name="sno" placeholder="Service No"/>
    <input class="textField" type="text"  id="trchg" name="trchg" placeholder="Courier Charge"/>
    <input class="textField" type="text"  id="ono" name="ono" placeholder="Order No"/>                    
    <input class="textField" type="text"  id="by" name="by" placeholder="Booked By"/>
                    <br><textarea class="txtArea" type="text"  id="r1" name="r1" placeholder="Remark"></textarea>
                        <!--<p>Installation Details</p>-->
                        <!--<input class="textField" type="text"  id="ipName" name="ipName" placeholder="Installation Person"/>-->
                        <!--<input class="textField" type="text"  id="veh" name="vehicleNo" placeholder="Vehicle No."/>-->
                        
                        <!--<input class="textField" type="text"  id="iKm" name="iKm" placeholder="Initial Km. Reading"/>-->
                        <!--<input class="textField" type="text"  id="fKm" name="fKm" placeholder="Final Km. Reading"/>-->
                    <br>
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
