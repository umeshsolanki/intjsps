<%@page import="entities.SaleInfo"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.text.SimpleDateFormat"%>
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
<%
Admins role=(Admins)session.getAttribute("role");
    if(role==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
        <%
    return ;
}%>


<div class="" style="max-width: 100%;">
    <span class="fa fa-close close" id="close" onclick="clr('dsrCont');"></span>
    <div class="fullWidWithBGContainer">
        <div id="updBal" class="popUp"></div>
        <script>
            <%
            String disId=request.getParameter("i");
            Session sess=sessionMan.SessionFact.getSessionFact().openSession();
            DistributorInfo dist=(DistributorInfo)sess.get(DistributorInfo.class, disId);
            out.print("var prodJsonArr="+dist.getMyProds().toString()+";");  
            List<DistributorInfo> dists=sess.createCriteria(DistributorInfo.class).list();
//                List<String> refrs=sess.createQuery("from DistSaleManager ").list();
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
        var req={to:$("#to").val(),by:$("#by").val(),r1:$("#r1").val(),r2:$("#r2").val(),ref:$("#ref").val(),cPin:$("#cPIN").val(),cApt:$("#cApt").val(),exps:exps,dis:"",dt:$("#dt").val(),
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
        <div id="oProds">
            <h2 class="nomargin nopadding white">Recent Orders</h2><hr>
                <div class=" scrollable">
                    <table
                    width="100%"
                    cellpadding="0" cellspacing="0" border="1px" style="border-color: black;font-size: 13px;">
                        <tr align="center" id="oProds"><th style="width: 50px;">Date</th><th>Docket</th>
                            <!--<th>Installed by</th><th>Ini KM</th><th>Fin KM</th>-->
                            <th>Ref by</th><th style="max-width: 100px;">Customer</th><th style="max-width: 70px;">Apartment</th><th>Flat</th><th style="max-width: 70px;" >Address</th><th>Mob</th><th>Alt Mob</th>
                            <th>Code</th><th>Qty</th><th>Rate</th><th>Total</th><th>Disc</th><th>Adv</th><th>Bal</th><th>Remark 1</th><th>Remark 2</th><th>By</th>
                            <th style="max-width: 100px;">To</th><th style="max-width: 100px;">SNo</th>
                            <th>Action</th></tr>
            <%
        List<DistSaleManager> stk=sess.createQuery("from DistSaleManager where dist=:d and docketNo like '2%' order by SMId desc")
            .setParameter("d", dist).list();
            for(DistSaleManager odr:stk){
            %>
                <tr align="center">
                    <td style="width: 50px;"><%=new SimpleDateFormat("dd/MM/yy").format(odr.getDt())%></td>
                    <td style="width: 100px;"><%=odr.getDocketNo()%></td>
                    <td style="width: 100px;"><%=odr.getRefBy()%></td>
                    <td style="max-width: 100px;"><%=odr.getCust().getName()%></td>
                    <td style="width: 70px;max-width: 70px;"><%=odr.getCust().getAptName()%></td>
                    <td style="width: 50px;max-width: 50px;"><%=odr.getCust().getFlatno()%></td>
                    <td style="max-width: 70px;" title="<%=odr.getCust().getAddress()%>"><%=odr.getCust().getAddress().length()>10?""+odr.getCust().getAddress().substring(0, 10)+"..":""%></td>
                    <td style="width: 100px;max-width: 100px;"><%=odr.getCust().getMob()%></td>
                    <td style="width: 100px;max-width: 100px;"><%=odr.getCust().getAltMob()%></td>
                    <!--<td><%=odr.getInstPerson()%></td>-->
                    <!--<td><%=odr.getiKm()+"KM"%></td>-->
                    <!--<td><%=odr.getfKm()+"KM"%></td>-->
<!--                    <td><%=odr.getSaleRecord()%></td>-->
                    <td style="min-width: 100px;"><%try{%><%=odr.getSaleRecord().iterator().next().getProd().getFPName()%><%}catch(Exception e){}%></td>
                    <td style="max-width: 50px;"><%try{%><%=odr.getSaleRecord().iterator().next().getQnt()%><%}catch(Exception e){}%></td>
                    <td style="max-width: 50px;"><%try{%><%=odr.getSaleRecord().iterator().next().getSoldAt()%><%}catch(Exception e){}%></td>
                    <td style="max-width: 50px;"><%=odr.getToPay()-odr.getDisc()%></td>
                    <td style="max-width: 80px;"><%=odr.getDisc()%></td>
                    <td style="max-width: 80px;"><%=odr.getAdvPayment()%></td>
                    <td style="max-width: 100px;"><%=odr.getBal()%></td>
                    <!--<td >&#8377;<%=odr.getInstCharge()%></td>-->
                    <td style="max-width: 100px;"><%=odr.getRemark1()%></td>
                    <td style="max-width: 100px;"><%=odr.getRemark2()%></td>
                    <td style="max-width: 100px;"><%=odr.getThrough()%></td>
                    
                    <td style="max-width: 70px;">                        
                    <%if(!odr.isExecuted()){%>
                    <input style="max-width: 70px;" placeholder="Move To" value="<%=odr.getOdrTo()%>" onblur="sendDataForResp('FormManager','action=mvsale&dis='+this.value+'&oId=<%=odr.getSMId()%>',false)"/>
                    <%}else{%>
                    <%=odr.getOdrTo()%>
                    <%}%>
                    </td>
                    <td style="max-width: 70px;">                        
                    <%if(!odr.isExecuted()){%>
                    <input style="max-width: 70px;" placeholder="ServNo" value="<%=odr.getSerNo()%>" onblur="sendDataForResp('FormManager','action=mvsale&sNo='+this.value+'&oId=<%=odr.getSMId()%>',false)"/>
                    <%}else{%>
                    <%=odr.getOdrTo()%>
                    <%}%>
                    </td>
                    
                    <td style="max-width: 120px;">
                        <%if(!odr.isExecuted()){%>
                        <input style="max-width: 100px;"  type="date" id="dt<%=odr.getSMId()%>" />
                        <button onclick="sendDataForResp('FormManager','action=executed&dt='+$('#dt<%=odr.getSMId()%>').val()+'&i=<%=odr.getSMId()%>',false);this.innerText='Executed';" class="button fa fa-forward redFont" title="Click to execute" ></button>
                        <button onclick="sendDataForResp('FormManager','action=dOdr&oId=<%=odr.getSMId()%>',false);this.innerText='Deleted';" class="button fa fa-trash" ></button>
                        <%}else{%>
                        <%if(odr.getExeDate()!=null)out.print("<span class='greenFont navLink' onclick='loadPage(\"distForms/DSR.jsp?dkt="+odr.getDocketNo()+"\");'>"+new SimpleDateFormat("dd.MM.yy").format(odr.getExeDate())+"</span>");%>
                        <%}%>
                    </td>
                </tr>
            
            <%
                Iterator<SaleInfo> sii=odr.getSaleRecord().iterator();
                boolean nxt=false;
                try{
                while(sii.hasNext()){
                       if(!nxt){
                           nxt=true;
                           sii.next();
                        }
                       SaleInfo si=sii.next();
            %>
            <tr align="center">
                <td></td><td></td><td></td><td></td><td></td>    
                <td></td><td></td><td></td><td></td>
                    <td><%=si.getProd().getFPName()%></td><td><%=si.getQnt()%></td>
                    <td><%=si.getSoldAt()%></td>
                    <!--<td><%=si.getSoldAt()%></td><td><%=si.getQnt()*si.getSoldAt()%></td>-->
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
            </tr>
            <%
                }}catch (Exception ex) {}    }
            %>
            </table>
            </div>
            </div>
    </div>
</div>
<%
sess.close();
%>
    