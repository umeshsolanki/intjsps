<%-- 
    Document   : LoginForm
    Created on : 21 Sep, 2016, 3:41:33 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="utils.ConnectionString"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.JSONException"%>
<%@page import="entities.Admins"%>
<%@page import="entities.PPControl"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="entities.Material"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(!(session.getAttribute("role") instanceof Admins)){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
<%return; }
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
%>

<div class="loginForm">
    
    <script>
        var matCount=0,prodCount=0;
        var matIds=[],prodIds=[];
        var prodCode="",prodName="",MRP=0.0;
        <%
                    List<FinishedProduct> fp= sess.createCriteria(FinishedProduct.class).add(Restrictions.eq("deleted", false)).addOrder(Order.asc("FPName")).list();
                    List<Material> mat=sess.createCriteria(Material.class).list();
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
                            console.log(JSON.stringify(matIds));
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
                                        sel+="<option value='"+(obj.id)+"'>"+obj.matName+"</option>";
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
                        var req={tax:$("#tax").val(),barCode:$("#bar").val(),pName:prodName,sPrice:sPrice,disc:disc,proId:$("#proId").val(),semiFinished:$("#semiFinProduct").prop("checked"),desc:$("#desc").val(),hsn:$("#hsn").val(),action:$("#action").val(),mrp:MRP,proCode:prodCode,prods:products,"mats":materials};
                    console.log(JSON.stringify(req));
        sendDataForResp("FormManager",JSON.stringify(req),true);
//        alert(JSON.stringify(req));                
//                        showMes(,false);
                      return false;
                    }
                    function initUpdate(code,altName,fpId,desc,mrp,hsn,sp,disc,tax,bar) {
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
                        
//                        alert(fpId);
                        var fieldHtml="";
                        for(var i=0;i<ppcMan.length;i++){
                        var obj=ppcMan[i];
                        if(obj.inProd==fpId){
//                            obj.
                            if(obj.ppcId.indexOf("-")>0){
                    fieldHtml+="<div id='ppc"+obj.ppcId+"'><input class='textField' id='semi"+obj.semi+"' value=\""+obj.semiName+"\" disabled/><input name='qnt"+obj.ppcId+"' id='qnt"+obj.ppcId+"' \n\
                               value='"+obj.qnt+"' class='autoFitTextField' type='text' placeholder='*Quantity(PPC-Unit)' />\n\
                            <button onclick='delMat(\""+obj.ppcId+"\");' class=button>&Cross;</button></div>";
                            }else if(obj.ppcId.indexOf("_")>0){
                               fieldHtml+="<div id='ppc"+obj.ppcId+"'><input class='textField' id='mat"+obj.mat+"' value=\""+obj.matName+"\" disabled/><input name='qnt"+obj.ppcId+"' id='qnt"+obj.ppcId+"' class='autoFitTextField' type='text' placeholder='*Quantity(PPC-Unit)' value='"+obj.qnt+"' />\n\
                            <button onclick='delMat(\""+obj.ppcId+"\");' class=button>&Cross;</button></div>";
                            }
//                            alert(JSON.stringify(ppcMan[i]));
                        }
                    }
                    $("#prodId").val(""+fpId);
                        $("#materialsCont").html(fieldHtml);
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
               
                
    </script>
    <span class="close" id="close" onclick="closeMe();">x</span>
        <div class="fullWidWithBGContainer">
            <div class="half left">
                <span class="white"><h2 class="nomargin nopadding">New Product</h2></span><hr>
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
            <input type="text" class="textField" id="tax" name="tax" placeholder="Tax Percentage"/>
            <input type="text" class="textField" id="bar" name="bar" placeholder="BarCode"/><br>
            <textarea class="txtArea" id="desc" name="desc" placeholder="Description"></textarea><br>
            
            <div>Is SemiFinished Product: <input type="checkbox" class="textField" id="semiFinProduct" name="semiFinProduct"/></div>
            <br>
            <div id="materialsCont" style="max-height: 300px;overflow: auto"></div>
            <br>
            <button class="button" onclick="addSemiFinProduct()">Semi Finished</button>
            <button class="button" onclick="addMatField()">Add Material</button><br><br>
            <button onclick='return buildJson();' class="button">Proceed</button>
            <br><br>
        </form>
       </center>
            </div>
            <div class="half right">
    <span class="white"><h2 class="nomargin nopadding">Products</h2></span><hr>
        <center>
            <div class="scrollable" >
                <table border="1" width="100%" cellpadding="5">
                    <thead>
                        <tr>
                            <th>Product Code</th>
                            <th>Description</th>
                            <th>MRP</th>
                            <th>HSN</th>
                            <th>Tax</th>
                            <th>BarCode</th>
                            <th>Semi Finished</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="matCont">
                          <%
                for(FinishedProduct p:fp){
                %>
                
                <tr id="rw<%=p.getFPId()%>"> <td><span class="pointer" onclick='initUpdate(this.innerHTML,&apos;<%if(p.getAltNameForUser()!=null)out.print(p.getAltNameForUser().replaceAll("\"", "&quot;"));%>&apos;,<%=p.getFPId()%>,&apos;<%if(p.getProdDesc()!=null)out.print(p.getProdDesc().replaceAll("\"", "&quot;"));%>&apos;,<%=p.getMRP()%>,&apos;<%=p.getHSNNo()%>&apos;,<%=p.getSalePrice()%>,<%=p.getDiscount()%>,<%=p.getTax()%>,<%=p.getBarCode()%>);'><%=p.getFPName()%></span></td>
                                <td><%=p.getProdDesc()%></td>
                                <td><%=p.getMRP()%></td>
                                <td><%=p.getHSNNo()%></td>
                                <td><%=p.getTax()%></td>
                                <td><%=p.getBarCode()%></td>
                                <td onclick='toggleSemi(<%=p.getFPId()%>,this)'title="click to toggle product type"><%if(p.isSemiFinished()){
                                    out.print("Yes");
                                }else{
                                out.print("No");
                                }%></td>
                                <td><span class='button' onclick="sendDataWithCallback('FormManager','action=dProd&pId=<%=p.getFPId()%>',false,function(){
                                   $('#rw<%=p.getFPId()%>').remove('tr');
                                });">x</span></td>
                                </tr>
                <%}%>
                    </tbody>
                </table>
            </div>
       </center>
            </div>
            </div>
</div>
<%
sess.close();
%>