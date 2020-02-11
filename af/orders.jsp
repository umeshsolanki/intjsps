<%@page import="org.hibernate.Query"%>
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


<div class="loginForm" style="max-width: 100%;">
                <%
            
                String ii=request.getParameter("ini");
                int ini=ii==null?0:new Integer(ii);
                Session sess=sessionMan.SessionFact.getSessionFact().openSession();
//                DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
//                try{
//                sess.refresh(dist);
//                }catch (Exception ex) {
//                        out.print("Login Please");
//                        return ;
//                }
%>
    <span class="close" id="close" onclick="closeMe();">&Cross;</span>
    <div class="fullWidWithBGContainer">
        <div id="updBal" class="popUp"></div>
        <script>        
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
                                        
//        console.log(JSON.stringify(prodIds));
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
        <h2 class="nomargin nopadding white">All Orders</h2><hr>
            <div class=" scrollable">
                <!--width="100%"-->
                <table  cellpadding="2" cellspacing="0" border="1">
        <tr align="center" id="oProds">
            <th style="width: 50px;">Date</th>
            <th>Distributor</th>
            <th>Docket</th>
            <!--<th>Installed by</th><th>Ini KM</th><th>Fin KM</th>-->
            <th>Ref by</th><th>Customer</th><th>Apartment</th><th>Flat</th><th >Address</th><th>Mob</th><th>Alt Mob</th>
            <th>Code</th><th>Qty</th><th>Rate</th><th>Total</th><th>Disc</th><th>Adv</th><th>Bal</th><th>Remark 1</th>
            <th>Remark 2</th><th>By</th><th>ServNo</th><th style="max-width: 90px !important;width: 90px;">To</th>
            <th>Action</th>
        </tr>
            <%
    Query q=sess.createQuery("from DistSaleManager where docketNo like '2%' order by docketNo desc");
    if(ini>-1){
        q.setMaxResults(20).setFirstResult(ini);
    }
    List<DistSaleManager> stk=q.list();
        for(DistSaleManager odr:stk){
                if(odr.isApproved()){
            %>
                <tr align="center">
                    <td style="width: 70px;"><%=new SimpleDateFormat("dd/MM/yy").format(odr.getDt())%></td>
                    <td style="width: 100px;"><%=odr.getDist().getDisId()%></td>
                    <td style="width: 100px;"><%=odr.getDocketNo()%></td>
                    <td style="width: 100px;"><%=odr.getRefBy()%></td>
                    <td style="width: 200px;"><%=odr.getCust().getName()%></td>
                    <td style="width: 100px;min-width: 100px;"><%=odr.getCust().getAptName()%></td>
                    <td style="width: 50px;max-width: 50px;"><%=odr.getCust().getFlatno()%></td>
                    <td style="width: 100px;" title="<%=odr.getCust().getAddress()%>"><%=odr.getCust().getAddress().length()>10?""+odr.getCust().getAddress().substring(0, 10)+"..":""%></td>
                    <td style="width: 100px;max-width: 100px;"><%=odr.getCust().getMob()%></td>
                    <td style="width: 100px;max-width: 100px;"><%=odr.getCust().getAltMob()%></td>
                    <!--<td><%=odr.getInstPerson()%></td>-->
                    <!--<td><%=odr.getiKm()+"KM"%></td>-->
                    <!--<td><%=odr.getfKm()+"KM"%></td>-->
<!--                    <td><%=odr.getSaleRecord()%></td>-->
                    <td style="min-width: 100px;"><%try{%><%=odr.getSaleRecord().iterator().next().getProd().getFPName()%><%}catch(Exception e){}%></td>
                    <td style="width: 50px;"><%try{%><%=odr.getSaleRecord().iterator().next().getQnt()%><%}catch(Exception e){}%></td>
                    <td style="width: 50px;"><%try{%><%=odr.getSaleRecord().iterator().next().getSoldAt()%><%}catch(Exception e){}%></td>
                    <td style="width: 50px;"><%=odr.getToPay()-odr.getDisc()%></td>
                    <td style="width: 80px;"><%=odr.getDisc()%></td>
                    <td style="width: 80px;"><%=odr.getAdvPayment()%></td>
                    <td style="width: 100px;"><%=odr.getBal()%></td>
                    <!--<td >&#8377;<%=odr.getInstCharge()%></td>-->
                    <td style="width: 200px;"><%=odr.getRemark1()%></td>
                    <td style="width: 200px;"><%=odr.getRemark2()%></td>
                    <td style="width: 200px;"><%=odr.getThrough()%></td>
                    <td style="width: 90px;"><%=odr.getSerNo()%></td>
    <td style="width: 90px;max-width: 90px">
    <%if(!odr.isExecuted()){%>
    <input style="max-width: 85px" value="<%=odr.getOdrTo()%>" onblur="sendDataForResp('FormManager','action=mvsale&dis='+this.value+'&oId=<%=odr.getSMId()%>',false)"/>
    <%}else{%><%=odr.getOdrTo()%><%}%>
    </td>
    <td>
    <%if(odr.isApproved()&&!odr.isExecuted()){%>
        <input type="date" id="dt<%=odr.getSMId()%>" />
        <button onclick="sendDataForResp('FormManager','action=executed&dt='+$('#dt<%=odr.getSMId()%>').val()+'&i=<%=odr.getSMId()%>',false);this.innerText='Executed';" class="button" >Pending</button>
        <!--<button onclick="sendDataForResp('FormManager','action=dOdr&oId=<%=odr.getSMId()%>',false);this.innerText='Deleted';" class="button" >&Cross;</button>-->
    <%}else{
    if(odr.isApproved()&&odr.isExecuted()){
    out.print("<span class='pointer' onclick='loadPage(\"adminForms/DSR.jsp?dkt="+odr.getDocketNo()+"\");'>"+new SimpleDateFormat("dd.MM.yy").format(odr.getExeDate())+"</span>");
    }
    if(!odr.isApproved()){%>
    <button title='Edit' class='fa fa-edit button'></button>
    <button title='Approve' onclick="sendDataForResp('FormManager','action=apODR&o=<%=odr.getSMId()%>',false);" class="button fa fa-thumbs-up"></button>
    <button onclick="sendDataForResp('FormManager','action=dOdr&oId=<%=odr.getSMId()%>',false);this.innerText='Deleted';" title="Delete" class="button fa fa-trash"></button>
    <%}
    }
    %>
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
                <td></td><td></td><td></td><td></td><td></td><td></td>    
                <td></td><td></td><td></td><td></td>
                    <td><%=si.getProd().getFPName()%></td><td><%=si.getQnt()%></td>
                    <td><%=odr.getSaleRecord().iterator().next().getSoldAt()%></td>
                    <!--<td><%=si.getSoldAt()%></td><td><%=si.getQnt()*si.getSoldAt()%></td>-->
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
            </tr>
                <%
                }}catch (Exception ex) {}
            %>
              <%  }else{%>
                <tr align="center">
                    <td style="width: 70px;"><input type="date" onblur="sendDataForResp('FormManager','action=EDS&dsmId=<%=odr.getSMId()%>&dt='+this.value,false);" style="max-width: 85px;" name="Date" value="<%=odr.getDt()%>"/></td>
                    <td style="width: 100px;"><input disabled onblur="sendDataForResp('FormManager','action=EDS&dsmId=<%=odr.getSMId()%>&ip='+this.value,false);" style="max-width: 85px;" name="instPer" value="<%=odr.getDist().getDisId()%>"/></td>
                    <td style="width: 100px;"><input onblur="sendDataForResp('FormManager','action=EDS&dsmId=<%=odr.getSMId()%>&dock='+this.value,false);" style="max-width: 85px;" name="instPer" value="<%=odr.getDocketNo()%>"/></td>
                    <td style="width: 100px;"><input onblur="sendDataForResp('FormManager','action=EDS&dsmId=<%=odr.getSMId()%>&ref='+this.value,false);" style="max-width: 85px;" name="instPer" value="<%=odr.getRefBy()%>"/></td>
                    <td style="width: 200px;"><input onblur="sendDataForResp('FormManager','action=EDS&dsmId=<%=odr.getSMId()%>&cN='+this.value,false);" style="max-width: 85px;" name="instPer" value="<%=odr.getCust().getName()%>"/></td>
                    <td style="width: 85px;min-width: 85px;"><input onblur="sendDataForResp('FormManager','action=EDS&dsmId=<%=odr.getSMId()%>&cA='+this.value,false);" style="max-width: 85px;" name="instPer" value="<%=odr.getCust().getAptName()%>"/></td>
                    <td style="max-width: 90px;"><input onblur="sendDataForResp('FormManager','action=EDS&dsmId=<%=odr.getSMId()%>&cF='+this.value,false);" style="max-width: 85px;" name="instPer" value="<%=odr.getCust().getFlatno()%>"/></td>
                    <td style="width: 100px;" title="<%=odr.getCust().getAddress()%>"><input onblur="sendDataForResp('FormManager','action=EDS&dsmId=<%=odr.getSMId()%>&cAd='+this.value,false);" style="max-width: 85px;" name="instPer" value="<%=odr.getCust().getAddress()%>"/></td>
                    <td style="width: 100px;max-width: 100px;"><input onblur="sendDataForResp('FormManager','action=EDS&dsmId=<%=odr.getSMId()%>&cMo='+this.value,false);" style="max-width: 85px;" name="instPer" value="<%=odr.getCust().getMob()%>"/></td>
                    <td style="width: 100px;max-width: 100px;"><%=odr.getCust().getAltMob()%></td>
                    <!--<td><%=odr.getInstPerson()%></td>-->
                    <!--<td><%=odr.getiKm()+"KM"%></td>-->
                    <!--<td><%=odr.getfKm()+"KM"%></td>-->
<!--                    <td><%=odr.getSaleRecord()%></td>-->
                    <td style="min-width: 100px;"><%try{%><%=odr.getSaleRecord().iterator().next().getProd().getFPName()%><%}catch(Exception e){}%></td>
                    <td style="width: 50px;"><%try{%><%=odr.getSaleRecord().iterator().next().getQnt()%><%}catch(Exception e){}%></td>
                    <td style="width: 50px;"><%try{%><%=odr.getSaleRecord().iterator().next().getSoldAt()%><%}catch(Exception e){}%></td>
                    <td style="width: 50px;"><%=odr.getToPay()-odr.getDisc()%></td>
                    <td style="width: 80px;"><%=odr.getDisc()%></td>
                    <td style="width: 80px;"><%=odr.getAdvPayment()%></td>
                    <td style="width: 100px;"><%=odr.getBal()%></td>
                    <!--<td >&#8377;<%=odr.getInstCharge()%></td>-->
                    <td style="width: 200px;"><%=odr.getRemark1()%></td>
                    <td style="width: 200px;"><%=odr.getRemark2()%></td>
                    <td style="width: 200px;"><%=odr.getThrough()%></td>
                    <td style="width: 90px;"><%=odr.getSerNo()%></td>
    <td style="max-width: 80px;width: 80px;">
    <%if(!odr.isExecuted()){%>
        <input style="max-width: 80px;" value="<%=odr.getOdrTo()%>" onblur="sendDataForResp('FormManager','action=mvsale&dis='+this.value+'&oId=<%=odr.getSMId()%>',false)"/>
    <%}else{%><%=odr.getOdrTo()%><%}%>
    </td>
    <td>
    <%if(odr.isApproved()&&!odr.isExecuted()){%>
        <input type="date" id="dt<%=odr.getSMId()%>" />
        <button onclick="sendDataForResp('FormManager','action=executed&dt='+$('#dt<%=odr.getSMId()%>').val()+'&i=<%=odr.getSMId()%>',false);this.innerText='Executed';" class="button" >Pending</button>
        <!--<button onclick="sendDataForResp('FormManager','action=dOdr&oId=<%=odr.getSMId()%>',false);this.innerText='Deleted';" class="button" >&Cross;</button>-->
    <%}else{
    if(odr.isApproved()&&odr.isExecuted()){
    out.print("<span class='pointer' onclick='loadPage(\"adminForms/DSR.jsp?dkt="+odr.getDocketNo()+"\");'>"+new SimpleDateFormat("dd.MM.yy").format(odr.getExeDate())+"</span>");
    }
    if(!odr.isApproved()){%>
   
    <!--<button title='Edit' class='fa fa-edit button'></button>-->
    <button title='Approve' onclick="sendDataForResp('FormManager','action=apODR&o=<%=odr.getSMId()%>',false);" class="button fa fa-thumbs-up"></button>
    <button onclick="sendDataForResp('FormManager','action=dOdr&oId=<%=odr.getSMId()%>',false);this.innerText='Deleted';" title="Delete" class="button fa fa-trash"></button>
    <%}
    }
    %>
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
                <td></td><td></td><td></td><td></td><td></td><td></td>    
                <td></td><td></td><td></td><td></td>
                    <td><%=si.getProd().getFPName()%></td><td><%=si.getQnt()%></td>
                    <td><%=si.getSoldAt()%></td>
                    <!--<td><%=si.getSoldAt()%></td><td><%=si.getQnt()*si.getSoldAt()%></td>-->
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
            </tr>
                <%
                }}catch (Exception ex) {}
                }
            %>
                <%}%>                
            </table>
            </div>
    <center><button class="button" onclick="loadPage('adminForms/AllDistSale.jsp?ini=<%=(ini+20)%>')">View More >></button>
            <button class="button" onclick="loadPage('adminForms/AllDistSale.jsp?ini=-1')">View All</button></center>            
    </div>
    </div>
</div>
<%
sess.close();
%>
    