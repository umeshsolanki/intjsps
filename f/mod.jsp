<%-- 
    Document   : BranchManagement
    Created on : 30 Jul, 2017, 12:32:45 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="entities.SaleInfo"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="entities.DistSaleManager"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="entities.InwardManager"%>
<%@page import="entities.Material"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.FinishedProductStock"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="entities.Admins"%>
<%@page import="java.util.List"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Admins role=(Admins)session.getAttribute("role");
    DistributorInfo dis=(DistributorInfo)session.getAttribute("dis");
    if(role==null&&dis==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
<%
    return ;
}

String o=request.getParameter("o");
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
DistSaleManager odr=(DistSaleManager)sess.get(DistSaleManager.class, new Long(o));
dis=odr.getDist();
%>
<center>
    <span class="close fa fa-close" id="close" onclick="clrLSP();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <span class="white"><h2 class="nopadding nomargin bgcolt8">Update Docket No <%=odr.getDocketNo()%></h2></span><hr>
        <!--<br>-->
        <!--<marquee class="ylFnt" behavior="alternate">Before edit please delete all finance entries(if executed the docket)</marquee>-->
<script>
    var payMethod="";
    <%
    List<FinishedProduct> pr=new ArrayList(dis.getMyProds());
    out.print("var prodJsonArr="+new JSONArray(pr).toString()+";");  
    %>
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
                var fieldHtml=sel+"<input name='prodQnt"+prodCount+"' id='prodQnt"+prodCount+"' class='autoFitTextField' type='text' placeholder='*Quantity' />\n\
                <input name='prodSP"+prodCount+"' id='prodSP"+prodCount+"' class='autoFitTextField' type='text' placeholder='*Sale Price' />\n\
                <button onclick='return addProduct();' class='button fa fa-plus-circle' title='Add more product'></button>\
                <button onclick='remProd("+prodCount+");' class='button fa fa-trash' title='Remove this product'></button>\n\
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
                    function buildJSON(fm,t) {
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
                    
var req={revStock:$("#revStock").prop("checked"),delFin:$("#delFin").prop("checked"),com:$("#com"),isO:$("#isO").prop('checked'),o:<%=o%>,from:$("#from").val(),exe:$("#exe").val(),sno:$("#sno").val(),to:$("#to").val(),by:$("#by").val(),r1:$("#r1").val(),r2:$("#r2").val(),ref:$("#ref").val(),cPin:$("#cPIN").val(),cApt:$("#cApt").val(),exps:exps,dis:$("#sel").val(),dt:$("#dt").val(),
    payDtl:$("#payMethod").val(),adv:$("#advPaid").val(),instC:$("#instChg").val(),cName:$("#cName").val(),
    disc:$("#disc").val(),cMob:$("#cMob").val(),cAMob:$("#cAMob").val(),cFlat:$("#cFlat").val(),cAdd:$("#cAdd").val(),
    gstNo:$("#gst").val(),ip:$("#ipName").val(),veh:$("#veh").val(),iKm:$("#iKm").val(),fKm:$("#fKm").val(),
    action:$("#action").val(),upro:$('#up').prop("checked"),prods:products,OLOdrNo:$("#oodno").val()
    ,delDate:$("#dlvrDt").val(),disDate:$("#dcpchDt").val(),sccol:$("#sccol").val()};
//    showMes(JSON.stringify(req));
//    sendDataForResp(t,JSON.stringify(req),true);
    showDial(JSON.stringify(req),t,'Continue Update','Do you really want to Update Order/Complaint detail',true);
    clrLLP();
    clrLSP();
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
        <%
            List<DistributorInfo> dists=sess.createCriteria(DistributorInfo.class).list();
            String selSource="";
            for(DistributorInfo d:dists){
                if(!d.getType().matches("(.*Referer.*)|(.*User.*)")&&!d.isDeleted()){
                    selSource+="<option value=\""+d.getDisId()+"\">"+d.getDisId()+"</option>";
                }
            }
        %>    
        <form action="FormManager" onsubmit="return false;" method="post" name="loginForm" id='loginForm' >
            <input type="hidden" name="action" id="action" class="" value="USale"/>
            <div class="fullWidWithBGContainer">
                <div class="halfnc left">
                    <p class="nopadding spdn">Docket Details</p>
                    <select id="sel" name='seller' class="textField"  >
                        <option value="">Select Seller</option>
                        <%=selSource%>
                    </select>
                    <select id="from" name='seller' class="textField"  >
                        <option value="">Received from seller</option>
                        <%=selSource%>
                    </select>
            <input title="Order date" class="textField" value="<%=Utils.DbFmt.format(odr.getDt())%>" type="text" id="dt" name="dt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Date"/>
            <input title="Execution date" class="textField" value="<%=odr.getExeDate()!=null?Utils.DbFmt.format(odr.getExeDate()):""%>" type="text" id="exe" name="dt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Execution Date"/>
            <input class="textField" type="text"  id="r2" name="r2" placeholder="Remark 2/Choice" value="<%=odr.getRemark2()%>" title="Ramark 2"/>
            <input class="textField" type="text"  id="by" name="by" placeholder="Booked By" value="<%=odr.getThrough()%>" title="Booked by (Entered by)"/>
            <select id="ref" class="textField" name="ref" value='<%=odr.getRefBy()%>' title="Referrer">
                <option>Select Referrer</option>
                <%
                List<DistributorInfo> refs=sess.createCriteria(DistributorInfo.class).add(Restrictions.eq("type", DistributorInfo.Type.Referer.name())).addOrder(Order.asc("disId")).list();
                for(DistributorInfo r:refs){%>
                <option value="<%=r.getDisId().replace("00R-","")%>"><%=r.getDisId().replace("00R-","")%></option>
                <%}%>
            </select>
            <script>
                $('#ref').val("<%=odr.getRefBy().replaceAll("\"", "&quot;")%>");
            </script>
            <input class="textField" type="text"  id="r1" name="r1" placeholder="Remark 1" value="<%=odr.getRemark1()%>" title="Remark"/>
            </div>
            <div class="halfnc left">
                <p class="nopadding spdn">Customer Details</p>
                <input class="textField" title="Cust Name" type="text" value="<%=odr.getCust().getName()%>"  id="cName" name="cName" placeholder="Customer Name"/>
                <input class="textField" type="text" title="Mobile No" value="<%=odr.getCust().getMob()%>" id="cMob" name="cMob" placeholder="Customer Mobile"/>
                <input class="textField" type="text"  id="cAMob" title="Alt Mob" name="cAMob" value="<%=odr.getCust().getAltMob()%>" placeholder="Alternate Mobile"/>
                <input class="textField" type="text"  id="cFlat" name="cFlat"  value="<%=odr.getCust().getFlatno()%>" placeholder="Flat No." title="Flat No."/>
                <input class="textField" type="text"  id="cApt" name="cApt" value="<%=odr.getCust().getAptName()%>" placeholder="Apartment Name" title="Apartment Name"/>
                <input class="textField" type="text"  id="cPIN" name="cPIN" value="<%=odr.getCust().getPIN()%>" placeholder="PIN" title="PIN"/>
                <input class="textField" type="text"  id="cAdd" name="address" placeholder="Address" title="Address" value="<%=odr.getCust().getAddress()%>"/>
                <input class="textField" type="text"  id="gst" name="gst" placeholder="GST No." value="<%=odr.getGstNo()%>" title="GST"/>

            </div>
            </div>
            <div class="fullWidWithBGContainer">
                <div class="halfnc left">
                    <p class="nopadding spdn">Finance Details</p>
                    <input class="textField" type="text"  id="disc" name="discount" placeholder="Discount" value="<%=odr.getDisc()%>" title="Discount"/>
                    <input class="textField" type="text"  id="com" name="com" placeholder="Commission"/>
                    <input class="textField" type="text"  id="advPaid" name="advPaid" placeholder="Advance Received" value="<%=odr.getAdvPayment()%>" title="Advance"/>
                    <input class="textField" type="text"  id="instChg" name="instChg" title="Service Charge Expected" value="<%=odr.getScExp()%>" placeholder="Serv. Charge Expected"/>
                    <input class="textField" type="text"  id="sccol" name="sccol" title="Service Charge Collected" value="<%=odr.getScExp()%>" placeholder="Serv. Charge Collected"/>
                </div>
                <div class="halfnc left">
                    <p class="nopadding spdn">Other Details</p>
                    <input class="textField" type="text"  id="ipName" name="ipName" placeholder="Installed by" value="<%=odr.getInstPerson()%>" title="Installed by"/>
                    <input class="textField" type="text"  id="sno" name="sno" placeholder="Service No" value="<%=odr.getSerNo()%>" title="Service no"/>
                    <input class="textField" type="text"  id="oodno" name="oodno" placeholder="Order No" value="<%=odr.getOdrNo()%>" title="Order no"/>
                    <%
//                        boolean hcd=odr.getCourRec()!=null;
                    
                    %>
<!--                    <input title="Delivery date" class="textField"  type="text" id="dlvrDt" name="dt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Dispatch Date"/>
                    <input title="Dispatch date" class="textField" type="text" id="dcpchDt" name="dt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Delivery Date"/>-->
                </div>
            </div>
            <!--<input class="textField" type="text"  id="to" name="to" placeholder="To/Distributor Id"/>-->
            <!--<p>Installation Details</p>-->
            <!--<input class="textField" type="text"  id="veh" name="vehicleNo" placeholder="Vehicle No."/>-->
            <!--<input class="textField" type="text"  id="iKm" name="iKm" placeholder="Initial Km. Reading"/>-->
            <br>
            Change It to  <input type='radio' name='isO' value="true" id="isO"  <%=odr.getDocketNo().startsWith("2")?"checked":""%>/> Order 
            <input type='radio' value="true" <%=odr.getDocketNo().startsWith("3")?"checked":""%> name='isO' /> Complaint<br><br>
            <input type='checkbox' value="true" id="up"/> Update products
            <input type='checkbox' value="true" id="revStock"/> Revert Stock Changes
            <input type='checkbox' value="true" id="delFin"/> Delete Finance<br><br>
            <button onclick='return addProduct()' id="editBtn" class="button">Add Product</button>
            <br>
            <div id="prodCont" class="scrollable" style="max-height:200px;">
                <%--int i=0;for(SaleInfo si:odr.getSaleRecord()){%>
                <input name='prodQnt<%=i%>' id='prodQnt<%=i%>' class='autoFitTextField' type='text' placeholder='*Quantity' />
                <input name='prodSP<%=i%>' id='prodSP<%=i%>' class='autoFitTextField' type='text' placeholder='*Sale Price' />
                <button onclick='return addProduct();' class='button fa fa-plus-circle'></button>
                <button onclick='remProd("<%=i%>");' class='button fa fa-trash'></button>
                <%i++;}--%>
            </div>
            <br>
            <button onclick='return buildJSON("loginForm","U")' id="editBtn" class="button">Save</button>
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
