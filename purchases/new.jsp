<%-- 
    Document   : LoginForm
    Created on : 21 Sep, 2016, 3:41:33 PM
    Author     : UMESH-ADMIN
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="loginForm" style="background-color: #333">  
<script>
        var matArr=${matArr};
        var vendArr=${vendArr};
        var matCount=0;
        var matIds=[];
        
        function showUnits(matId,tgt) {
//            alert(matId);
            for(var i in matArr){
                var obj=JSON.parse(matArr[i]);
//                alert(obj);
                if(obj.id==matId){
//                alert("found");    
                $("#ppc"+tgt).attr("placeholder","Qty in "+obj.ppc);
                $("#pur"+tgt).attr("placeholder","Qty in "+obj.unit);
                $("#price"+tgt).attr("placeholder","Rate per "+obj.unit);
                break;
                }
            }
        }
        var taxes="${tax}";
        function showTicketBox(mes,id){
            $("#ticketCont").css("display","block");
//         alert("om");
            $("#in").val(id);
            $("#ticketCont").css("visibility","visible");
            $("#issMes").val(mes+"continue your message from here <br>\n");
            $("#sub").val("Import wrong Entry updation");
            return false;
        }
        function addMatField(){
//            prodCode=$("#proCode").val();
//            prodName=$("#name").val();
//            if(prodCode.length>1){
            matCount++;
            matIds.push(matCount);
//                                showMes(JSON.stringify(matIds));
//                                showMes("Total Materials used in "+prodName.value+" = "+matCount,false);
            var sel="<div id='mat"+matCount+"'><select onchange=\"showUnits(this.value,'"+matCount+"')\" name='matId"+matCount+"' id='matId"+matCount+"' class='textField' ><option>Select Material</option>";
            for(ind in matArr){
                    var obj=JSON.parse(matArr[ind]);
//                    alert(obj['id']);
                    sel+="<option value='"+(obj.id)+"'>"+obj.matName+"</option>";
            }
            sel+="</select>";
            var fieldHtml=sel+"<input name='qnt"+matCount+"' id='pur"+matCount+"' class='smTF' type='text' placeholder='*Quantity Purchase' />\n\
                <input name='qnt"+matCount+"' id='ppc"+matCount+"' class='smTF' type='text' placeholder='*Quantity PPC' />\n\
                <input name='amt"+matCount+"' id='price"+matCount+"' class='smTF' type='text' placeholder='*Rate' />"+
//                <select  class='smTF' id='taxType"+matCount+"'><option>Applicable Tax</option><option>IGST</option><option>CGST+SGST</option></select>\n\
//                <input name='tax"+matCount+"' id='tax"+matCount+"' class='smTF'  type='text' placeholder='Tax(%)' />\n\
                "<select style='vertical-align:top;height:70px' multiple name='taxes"+matCount+"'>"+taxes+"</select>\
                <textarea name='comment"+matCount+"' id='comment"+matCount+"' style='vertical-align:middle;height:30px' class='smTF' placeholder='Comment' ></textarea>\n\
        <button onclick='remMat("+matCount+");' class=button>&Cross;</button></div>";
            $("#materialsCont").append(fieldHtml);
//            console.log(JSON.stringify(matIds));
        }
        function remMat(id) {
//                        alert(id);
            $("div").remove("#mat"+id);
            matIds.splice(matIds.indexOf(id),1);
//            console.log(JSON.stringify(matIds));
        }
        function buildJson(){
//                        var json="";
//                        prodCode=$("#proCode").val();
//                        prodName=$("#name").val();
                        var materials=[],products=[];
//                        console.log();
                        var br=$("#purBr").val();
                            if(!br.match("\\d+")){
                                showMes("Branch not selected",true);
                                return false;
                            }
                            
                        for(var i=0;i<matIds.length;i++){
                            var ppc=$("#ppc"+matIds[i]).val();
//                            var ttype=$("#taxType"+matIds[i]).val();
                            var tax=JSON.stringify($("select[name=taxes"+matIds[i]+"]").val());
//                            console.log(tax);
                            var pur=$("#pur"+matIds[i]).val();
                            var ttl=$("#price"+matIds[i]).val();
                            var comment=$("#comment"+matIds[i]).val();
                            var matId=document.getElementById("matId"+matIds[i]);
                            if(!matId.value.match("\\d+")){
                                showMes("Material not selected",true);
                                return false;
                            }
                            if(isNaN(pur)||isNaN(ppc)){
                                showMes("Enter valid PPC and Purchase Quantity for Material",true);
                                return false;
                            }
                            if(pur<=0||ppc<=0){
                                showMes("Quantity must be more than 0",true);
                                return false;
                            }
                            
                            var mat={mat:Number(matId.value),comment:comment,ppc:Number(ppc),pur:Number(pur),amt:Number(ttl)*Number(pur),tax:tax.replace("[","").replace("]","").replaceAll("\"","")};
                            if(materials.indexOf(mat)<0){
                                materials.push(mat);
                            }else{
                                showMes("Sorry!! material added twice ",true);
                                return false;
                            }
                        }
            var req={action:$("#action").val(),dt:$("#purDt").val(),vendor:$("#vend").val(),br:br,bNo:$("#bNo").val(),"mats":materials};
                    console.log(JSON.stringify(req));
        sendDataForResp("FormManager",JSON.stringify(req),true);
//        alert(JSON.stringify(req));                
//                        showMes(,false);
                      return false;
                    }
        function viewTicket(Mess,resp) {
//            alert(Mess);
            $('#vTicket').html("<span class=\"close\" onclick=\"$('#vTicket').html('');\">&Cross;</span>"+Mess);
            return false;
        }
    </script>
    <span class="close fa fa-close" id="close" onclick="clrLSP()"></span>
        <div class="fullWidWithBGContainer">
            <span class="white" id="head"><h2 class="nomargin nopadding centAlText">New Purchase Bill</h2></span><hr>
        <center>
        <form id="importMaterial" onsubmit="return false;">
            <br><br>
            <input type="text"  id="action" value="importMaterial" hidden/>
            <input class="textField" type="date" name="dt" id="purDt" placeholder="Date"/>
            <select title="For branch" class="textField" id="purBr"><option>Select Production Branch</option>
                <c:forEach items="${branch}" var="b">
                    <option value="${b.getBrId()}">${brr.getBrName()}</option>
                </c:forEach>

            </select>
            <input class="textField" type="text" id="vend"  name="vend" list="rmSel" placeholder="Vendor" autocomplete='off'/><br>
                
            
            <!--<input class="textField" type="number" id="amt"  name="amt" placeholder="Total Amount"/>-->
<!--            <input class="textField igst" type="text" id="itax"  name="igst" placeholder="IGST amount"/>
            <input class="textField gst" type="text" id="ctax"  name="cgst" placeholder="CGST amount"/><br>
            <input class="textField gst" type="text" id="stax"  name="sgst" placeholder="SGST amount"/>
            <input class="textField gst" type="text" id="stax"  name="sgst" placeholder="GST No"/>-->
            <!--<input class="textField" type="text" id="total"  name="total" placeholder="Tax"/>-->
            <input class="textField" type="text" id="bNo"  name="bNo" placeholder="Bill No"/><br><br>
            <div id="materialsCont" style="max-height: 300px;overflow: auto"></div>
            <button class="button" onclick="addMatField()">Add Material</button><br><br>
            <button onclick='popsr("af/newVendor.jsp")' class="button">Add Vendor</button><button onclick='return buildJson()' class="button">Save</button>
            <br><br>
        </form>
       </center>
            <script>
                $("#itax").on("keyup",function(){
                    if(this.value.length>0){
                        $(".gst").attr("disabled",true);
                        $("#total").val(Number($("#amt").val())+Number(this.value));
                    }else{
                        $(".gst").attr("disabled",false);
                    }
                });
                $(".gst").on("keyup",function(){
                    if($("#stax").val().length>0||$("#ctax").val().length>0){
                        $("#itax").attr("disabled",true);
                        $("#total").val(Number($("#amt").val())+Number($("#stax").val())+Number($("#ctax").val()));
                    }else{
                        $("#itax").attr("disabled",false);
                    }
                });
            </script>
            </div>
        </div>
<%
sess.close();
%>