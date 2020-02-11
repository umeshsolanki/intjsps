<%-- 
    Document   : retReq
    Created on : 27 Apr, 2018, 1:01:17 PM
    Author     : UMESH-ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

<%
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        String o=request.getParameter("o");
    DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
    DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
    if(dist==null||LU!=null&&!LU.getRoles().matches(".*\\(.Ret\\).*")){
        out.print("<script>window.location.replace(\"?msg=You don't have permission to access this page\");</script>");
        return;
    }

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
                prods:products,retBy:$("#retBy").val()};
//        showMes(JSON.stringify(req));
        sendDataForResp("FormManager",JSON.stringify(req),true);
    }
    
    
        </script>
        <div class="loginForm" style="background-color: #ababbc;max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="clrRSP();"></span>
    <div class="fullWidWithBGContainer">
    <h2 class="centAlText nomargin nopadding white bgcolt8">Customer Return</h2><hr>
    <center>
        <form action="FormManager" onsubmit="return false;" method="post" name="retreqForm" id='retreqForm' >
                    <input type="hidden" name="action" id="action" value="retDock"/>   
                <input type="hidden" name="o" id="o" value="<%=o%>"/>   
                <br>
                <input class="textField" value="<%=Utils.DbFmt.format(new Date())%>" type="text" id="dt" name="dt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Date"/><br>
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
                    <textarea class="txtArea"  id="r1" name="r1" placeholder="Return Reason"></textarea><br>
                    <br>
                    <br>
                    <button onclick='return subForm("retreqForm","FormManager")' class="button">Save</button>
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
