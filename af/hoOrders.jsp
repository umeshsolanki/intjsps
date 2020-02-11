<%@page import="entities.DistSaleManager"%>
<%@page import="entities.DistStock"%>
<%@page import="entities.OrderInfo"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="java.util.List"%>
<%@page import="entities.UserFeedback"%>
<%@page import="entities.Admins"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="loginForm" style="max-width: 100%;">
    <span class="close" id="close" onclick="closeMe();">&Cross;</span>
    <div class="fullWidWithBGContainer">
        <script>
            <%
                Session sess=sessionMan.SessionFact.getSessionFact().openSession();
                Admins role=(Admins)session.getAttribute("role");
//                sess.refresh(dist);
                List<FinishedProduct> prods=sess.createCriteria(FinishedProduct.class).list();
                out.print("var prodJsonArr="+prods.toString()+";");  
                List<DistributorInfo> dists=sess.createCriteria(DistributorInfo.class).list();
            JSONArray jar=new JSONArray(dists);
            out.print("var dists=JSON.parse(JSON.stringify("+jar.toString()+"));");
            %>
                function getDisIds(type) {
                var selSource="<option>Select Distributor-Id</option>";
                for(var ind in dists){
                    var obj=JSON.parse(dists[ind]);
                    if(obj.type==type){
                        selSource+="<option value='"+obj.disId+"'>"+obj.disId+"</option>";
                    }
                }
                $("#soldTo").html(selSource);
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
                            <button onclick='remProd("+prodCount+");' class=button>&Cross;</button></div>";
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
                        var products=[];
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
    var req={dis:$("#soldTo").val(),dt:$("#dt").val(),payDtl:$("#payMethod").val(),adv:$("#advPaid").val(),instC:$("#instChg").val(),cName:$("#cName").val(),disc:$("#disc").val(),cMob:$("#cMob").val(),
        cAMob:$("#cAMob").val(),cFlat:$("#cFlat").val(),cAdd:$("#cAdd").val(),
        gstNo:$("#gst").val(),iName:$("#ipName").val(),veh:$("#veh").val(),
        iKm:$("#iKm").val(),fKm:$("#fKm").val(),action:$("#action").val(),prods:products};
//    showMes(JSON.stringify(req));
    sendDataForResp("FormManager",JSON.stringify(req),true);
                }
    
        </script>
        <!--<div class="tFivePer left">-->
<!--            <h2>New Sale Entry</h2><hr>
            <div class="scrollable">
            <form action="FormManager" onsubmit="return false;" method="post" name="loginForm" id='loginForm' >
                    <input type="hidden" name="action" id="action" value="DSale"/>   
                    <input class="textField" type="text" id="dt" name="dt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Date"/>
                    <select onchange="getDisIds(this.value);" class="textField" name="disType" id="distype">
                <option>Select Distributor Type</option>
                <option>Franchise</option>
                <option>Dealer</option>
                <option>Distributor</option>
                <option>Direct Sale</option>
                <option>Online Sale</option>
                </select>
                    <select class="textField" name="soldTo" id="soldTo">
                        <option>Select Distributor-Id</option>
                    </select>
                    
                    <input class="textField" type="text"  id="cName" name="cName" placeholder="Customer Name"/>
                    <input class="textField" type="text"  id="cMob" name="cMob" placeholder="Customer Mobile"/>
                    <input class="textField" type="text"  id="cAMob" name="cAMob" placeholder="Alternate Mobile"/>
                    <input class="textField" type="text"  id="cFlat" name="cFlat" placeholder="Flat No.*" title="Flat No. is mendatory to fill!"/>
                    <input class="textField" type="text"  id="cApt" name="cApt" placeholder="Apartment Name" title="Apartment Name"/>
                    <input class="textField" type="text"  id="cAdd" name="address" placeholder="Address"/>
                    <input class="textField" type="text"  id="gst" name="gst" placeholder="GST No."/>
                    <input class="textField" type="text"  id="disc" name="discount" placeholder="Discount"/>
                    <input class="textField" type="text"  id="advPaid" name="advPaid" placeholder="Advance Received"/>
                    <input class="textField" type="text"  id="payMethod" name="payMethod" placeholder="Paid through? cheque,cash,bank etc."/>
                    
                    <br><br>
                    <hr>
                    <div class="serviceChrage" id="serviceCharge">
                        <h2>Installation Details</h2>
                        <input class="textField" type="text"  id="ipName" name="ipName" placeholder="Installation Person"/>
                        <input class="textField" type="text"  id="veh" name="vehicleNo" placeholder="Vehicle No."/>
                        <input class="textField" type="text"  id="instChg" name="instChg" placeholder="Service Charge"/>
                        <input class="textField" type="text"  id="iKm" name="iKm" placeholder="Initial Km. Reading"/>
                        <input class="textField" type="text"  id="fKm" name="fKm" placeholder="Final Km. Reading"/>
                    </div>  
                    <br><br>
                    <div id="prodCont" class="scrollable" style="max-height:250px;"></div>
                    <br><br>
                    <button onclick='return addProduct()' id="editBtn" class="button">Add Product</button>
                    <button onclick='return buildJSON("loginForm","FormManager")' id="editBtn" class="button">Save</button>
                    <br><br>
                    </form>
        </div>
            </div>-->
        <div class="boxPcMinHeight" id="oProds">
            <h2 class="nomargin nopadding white">H/O Orders</h2><hr>
                <div class=" scrollable">
            <table width="100%">
                <tr align="left"><th>Date</th><th>Docket</th><th>Total</th><th>Serv Charge</th><th>Type</th><th>H/O To</th></tr>
            <%
            List<DistSaleManager> stk=sess.createQuery("from DistSaleManager where throughCompany=true").list();
            for(DistSaleManager odr:stk){
            %>
                <tr>
                    <td><%=odr.getDt()%></td>
                    <td><%=odr.getDocketNo()%></td>
                    <td>&#8377;<%=odr.getToPay()%></td>
                    <td>&#8377;<%=odr.getInstCharge()%></td>
                    <td>Sale</td>
                    <td><%=odr.getDist().getDisId()%></td>
                </tr>
            <%
            }
            %>
            </table>
            </div>
            </div>
    </div>
</div>
<%
sess.close();
%>
    