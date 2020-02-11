<%-- 
    Document   : DisFinance
    Created on : Oct 12, 2017, 10:20:53 PM
    Author     : sunil
--%>

<%@page import="utils.UT"%>
<%@page import="entities.PPControl"%>
<%@page import="entities.Material"%>
<%@page import="entities.FinishedProduct"%>
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
        Admins role=(Admins)session.getAttribute("role");
//        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
        sess.refresh(role);
              
//        Transaction tr = sess.beginTransaction();
%>
<script>
        var matCount=0,prodCount=0;
        var matIds=[],prodIds=[];
        var prodCode="",prodName="",MRP=0.0;
        <%
            String p=request.getParameter("p");
            FinishedProduct f=null;
            if(p!=null){
                f=(FinishedProduct)sess.get(FinishedProduct.class, new Long(p));
            }      
                    List<FinishedProduct> fp= sess.createCriteria(FinishedProduct.class).add(Restrictions.eq("deleted", false)).addOrder(Order.asc("FPName")).list();
                    List<Material> mat=sess.createCriteria(Material.class).addOrder(Order.asc("matName")).list();
                    JSONArray jar=new JSONArray();
                    for(Material m:mat){
                        jar.put(new JSONObject(m.toString()));
                    }
                    out.print("var matJsonArr="+jar.toString()+";");
//                    List<FinishedProduct> semiProd=sess.createQuery("from FinishedProduct where semiFinished=:semi").setParameter("semi", true).list();
                    jar=new JSONArray();
                    for(FinishedProduct m:fp){
                        if(m.isSemiFinished())
                        jar.put(new JSONObject(m.toString()));
                    }
                    out.print("var prodJsonArr="+jar.toString()+";");
                    List<PPControl> prods=sess.createQuery("from PPControl").list();
                    jar=new JSONArray();
                    for(PPControl m:prods){
                        jar.put(new JSONObject(m.toString()));
                    }
                    out.print("var ppcMan="+jar.toString()+";");
                    
        %>
            function addSemiFinProduct(){
                                prodCode=$("#proCode").val();
                                prodCode=$("#name").val();
                                if(prodCode.length>1){
                                prodCount++;
                                prodIds.push(prodCount);
//                                showMes(JSON.stringify(prodIds));
//                                showMes("Total Materials used in "+prodName.value+" = "+matCount,false);
                                var sel="<div id='pro"+prodCount+"'><select name='prodId"+prodCount+"' id='prodId"+prodCount+"' class='textField' ><option>Select SemiFinished Product</option>";
                                for(ind in prodJsonArr){
                                        var obj=prodJsonArr[ind];
//                                        alert(obj['id']);
                                        sel+="<option value='"+(obj.fpId)+"'>"+obj.fpName+"</option>";
                                }
                                sel+="</select>";
                                var fieldHtml=sel+"<input name='prodQnt"+prodCount+"' id='prodQnt"+prodCount+"' class='autoFitTextField' type='text' placeholder='*Quantity' />\n\
                            <button onclick='remProd("+prodCount+");' class=button>&Cross;</button></div>";
                                $("#materialsCont").append(fieldHtml);
                            }else{
                                showMes("Product-Id must be larger than 2 characters",true);
                            }
//                            console.log(JSON.stringify(matIds));
            }
    
            function addMatField(){
                    prodCode=$("#proCode").val();
                    prodName=$("#name").val();
                    if(prodCode.length>1){
                    matCount++;
                    matIds.push(matCount);
//                                showMes(JSON.stringify(matIds));
//                                showMes("Total Materials used in "+prodName.value+" = "+matCount,false);
                    var sel="<div id='mat"+matCount+"'><select name='matId"+matCount+"' id='matId"+matCount+"' class='textField' ><option>Select Material</option>";
                    for(ind in matJsonArr){
                            var obj=matJsonArr[ind];
//                                        alert(obj['id']);
                            sel+="<option value='"+(obj.matId)+"'>"+obj.matName+"</option>";
                    }
                    sel+="</select>";
                    var fieldHtml=sel+"<input name='qnt"+matCount+"' id='qnt"+matCount+"' class='autoFitTextField' type='text' placeholder='*Quantity(PPC-Unit)' />\n\
                    <button onclick='remMat("+matCount+");' class=button>&Cross;</button></div>";
                        $("#materialsCont").append(fieldHtml);
                    }else{
                        showMes("Product-Id must be larger than 2 characters",true);
                    }
                    console.log(JSON.stringify(matIds));
                    }
                function addTaxField(){
                var sel="<div id='mat"+matCount+"'><input name='cgst"+matCount+"' id='cgst"+matCount+"' class='textField' type='text' placeholder='CGST'>\n\
                    <input name='sgst"+matCount+"' id='sgst"+matCount+"' class='textField' type='text' placeholder='SGST'>\n\
                    <input name='gst"+matCount+"' id='gst"+matCount+"' class='textField' type='text' placeholder='GST'>\n\
                    <button onclick='remMat("+matCount+");' class=button>&Cross;</button></div>";
                    $("#materialsCont").append(sel);
                }
                function remMat(id) {
//                        alert(id);
                        $("div").remove("#mat"+id);
                        matIds.splice(matIds.indexOf(id),1);
                        console.log(JSON.stringify(matIds));
                    }
                function remProd(id) {
//                        alert(id);
                        $("div").remove("#pro"+id);
                        prodIds.splice(prodIds.indexOf(id),1);
                        console.log(JSON.stringify(prodIds));
                    }
                    
                function buildJson(){
//                        var json="";
                        prodCode=$("#proCode").val();
                        prodName=$("#name").val();
                        var materials=[],products=[];
                        for(var i=0;i<matIds.length;i++){
                            var matId=document.getElementById("matId"+matIds[i]);
                            var qnt=document.getElementById("qnt"+matIds[i]);
//                            alert(matIds[i]);
                            var qty=Number(qnt.value);
//                            showMes();
                            console.log(matId.value);
                        if(isNaN(qty)){
                            showMes("Enter valid Quantity for Material",true);
                            return false;
                        }
                            var mat={"mat":matId.value,"qnt":qty};
                            if(materials.indexOf(mat)<0){
                                materials.push(mat);
                            }else{
                                showMes("Sorry!! material added twice ",true);
                                return false;
                            }
                        }
                        for(var i=0;i<prodIds.length;i++){
                            var prodId=document.getElementById("prodId"+prodIds[i]);
                            var qnt=document.getElementById("prodQnt"+prodIds[i]);
//                            console.log(prodId.value);
                            var qty=Number(qnt.value);
//                            showMes();
                        if(isNaN(qty)){
                            showMes("Enter valid Quantity for Product",true);
                            return false;
                        }
                        var product={"prod":prodId.value,"qnt":qty};
                            if(products.indexOf(product)<0){
                                products.push(product);
                            }else{
                                showMes("Sorry!! Product added twice ",true);
                                return false;
                            }
                    }
                        MRP=new Number(document.getElementById("mrp").value);
                        var disc=new Number($("#disc").val());
                        var sPrice=new Number($("#sPrice").val());
                        var req={ppcGuide:$("#ppcguide").val(),tax:$("#tax").val(),barCode:$("#bar").val(),pName:prodName,sPrice:sPrice,disc:disc,proId:$("#proId").val(),semiFinished:$("#semiFinProduct").prop("checked"),desc:$("#desc").val(),hsn:$("#hsn").val(),action:$("#action").val(),mrp:MRP,proCode:prodCode,prods:products,"mats":materials};
//                    console.log(JSON.stringify(req));
                    sendDataForResp("FormManager",JSON.stringify(req),true);
                      return false;
                    }
                    function initUpdate(code,altName,fpId,desc,mrp,hsn,sp,disc,tax,bar,ppcguide) {
                        $("#disc").val(disc);
                        $("#sPrice").val(sp);
                        $("#name").val(altName);
                        $("#action").val("updProd");
                        $("#proId").val(fpId);
                        $("#proCode").val(code);
                        $("#mrp").val(mrp);
                        $("#desc").val(desc);
                        $("#hsn").val(hsn);
                        $("#tax").val(tax);
                        $("#bar").val(bar);
                        $("#ppcguide").val(ppcguide);
//                        alert(fpId);
                        var fieldHtml="";
                        for(var i=0;i<ppcMan.length;i++){
                        var obj=ppcMan[i];
                        if(obj.inProd==fpId){
//                            obj.
                        if(obj.ppcId.indexOf("-")>0){
//                            prodCount++;
//                            prodIds.push(obj.semi);
                        fieldHtml+="<div id='ppc"+obj.ppcId+"'><input class='textField' id='semi"+obj.semi+"' value=\""+obj.semiName+"\" disabled/>\n\
                               <input name='qnt"+obj.ppcId+"' id='qnt"+obj.ppcId+"' onblur='' \n\
                               value='"+obj.qnt+"' class='autoFitTextField' type='text' placeholder='*Quantity(PPC-Unit)' onblur='updPPCQnt(this)' />\n\
                            <button onclick='delMat(\""+obj.ppcId+"\");' class=button>&Cross;</button></div>";
                            }else if(obj.ppcId.indexOf("_")>0){
//                                matCount++;
//                                matIds.push(obj.mat);
                               fieldHtml+="<div id='ppc"+obj.ppcId+"'><input class='textField' id='mat"+obj.mat+"' value=\""+obj.matName+"\" disabled/>\n\
                            <input name='qnt"+obj.ppcId+"' onblur='updPPCQnt(this)' id='qnt"+obj.ppcId+"' class='autoFitTextField' type='text' placeholder='*Quantity(PPC-Unit)' value='"+obj.qnt+"' />\n\
                            <button onclick='delMat(\""+obj.ppcId+"\");' class=button>&Cross;</button></div>";
                            }
//                            alert(JSON.stringify(ppcMan[i]));
                        }
                        }
                        $("#prodId").val(""+fpId);
                        $("#materialsCont").html(fieldHtml);
                    }
                    
                    function updPPCQnt(ele){
//                        alert(ele.value+"_"+ele.id)
                            sendDataForResp('U','action=updPPCQnt&ppc='+ele.id.replaceAll('qnt','')+'&nq='+ele.value);
                    }
                    function delMat(ppcId) {
                        showMes("<center><img src='images/loader.svg' width=100 height=100 /></center><br>Please wait...",true);
                        $.get("PPCManager?act=rem&ppc="+ppcId,function(resp){
                            if(resp.includes("success")){
                                showMes(resp,false);
                                $("div").remove("#ppc"+ppcId);
                            }else{
                                showMes(resp,true);
                            }
                        });
                    }
                function toggleSemi(proId,ele) {
                    showMes("<center><img src='images/loader.svg' width=100 height=100 /></center><br>Please wait...",true);
                    $.get("PPCManager?act=tSemi&prod="+proId,function(resp){
                        if(resp.includes("success")){
                            showMes(resp,false);
                            if(ele.innerHTML=="Yes"){
                                ele.innerHTML="No";
                            }else{
                                ele.innerHTML="Yes";
                            }
                        }else{
                            showMes(resp,true);
                        }
                    });
//                    alert(proId);
//                        $("div").remove("#ppc"+ppcId);
                    }
        function copyPPC(PID){
            sendDataForResp("FormManager","action=copyProd&p="+PID,false,false);
        }
                
    </script>
<div class="loginForm" style="background-color: #ababbc;max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="clrLSP();"></span>
    <div class="fullWidWithBGContainer bgcolef">
    <span class="white"><h2 class="nomargin nopadding bgcolt8 centAlText">Create Product 
            <%=UT.ie(p)?"":"<span class=\"fa fa-copy button\" onclick='copyPPC("+p+");' title=\"Create new product with existing PPC\"> Copy</span></h2></span>"%><hr>
    <br>
    <center>
        <form onsubmit="return false;" name="newMaterial" id='newMaterial' >
            <input type="hidden"  id="action" value="addNewFinProd"/>
            <input type="hidden"  id="proId" value=""/>
            <input class="textField" type="text" id='proCode' name="proCode" placeholder="*Product Code"/>
            <input type="text" class="textField" id="mrp" name="mrp" placeholder="*MRP"/>
            <input type="text" class="textField" id="name" name="name" placeholder="*Product Name"/><br>
            <input type="text" class="textField" id="hsn" name="hsn" placeholder="HSN No."/>
            <input type="text" class="textField" id="sPrice" name="sPrice" placeholder="*Selling Price"/>
            <input type="text" class="textField" id="disc" name="disc" placeholder="*Discount"/><br>
            <!--<input type="text" class="textField" id="tax" name="tax" placeholder="Add Tax"/>-->
            <input type="text" class="textField" id="bar" name="bar" placeholder="BarCode"/><br>
            <textarea class="txtArea" id="desc" name="desc" placeholder="Description"></textarea>
            <textarea class="txtArea" id="ppcguide" name="ppcguide" placeholder="PPC Comment"></textarea><br>
            <br>
            <div>Is SemiFinished Product: <input type="checkbox" <%=f!=null?(f.isSemiFinished()?"checked":""):""%> class="textField" id="semiFinProduct" name="semiFinProduct"/></div>
            <br>
            <div id="materialsCont" style="max-height: 300px;overflow: auto"></div>
            <br>
            <button class="button" onclick="addSemiFinProduct()">Semi Finished</button>
            <button class="button" onclick="addMatField()">Add Material</button><br><br>
            <button onclick='return buildJson();' class="button">Proceed</button>
            <br><br>
            
        </form>
    </center>  
        <script>
            <%
            if(f!=null){%>
                initUpdate("<%=f.getFPName().replaceAll("\"", "&quot;")%>","<%=(f.getAltNameForUser()+"").replaceAll("\"", "&quot;")%>",<%=f.getFPId()%>,"<%=(f.getProdDesc()+"").replaceAll("\"", "&quot;")%>","<%=f.getMRP()%>","<%=f.getHSNNo()%>","<%=f.getSalePrice()%>","<%=f.getDiscount()%>","<%=f.getTax()%>","<%=f.getBarCode()%>","<%=(f!=null?(f.getPpcGuide()!=null?f.getPpcGuide().replaceAll("\"", "\\\""):""):"")%>");
            <%}%>
        </script>
</div>
    <style>
        .popSMLE{
            box-shadow: 4px 4px 25px black;
        }
    </style>
<%
sess.close();
%>
