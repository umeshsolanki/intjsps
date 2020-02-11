<%@page import="org.hibernate.criterion.Restrictions"%>
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
<div class="loginForm" style="max-width: 100%;">
    <span class="close" onclick="toggleVisibility('refererForm');" style="right:180px;">Help</span>
    <%--
    Object LU=session.getAttribute("LU");
    if(LU==null){
    %>
    <span class="close" onclick="toggleVisibility('refererForm');" style="right:180px;">Create Referrer</span>
    <%}--%>
    <span class="close" onclick="toggleVisibility('ODRFmCont');" style="right:30px;">Hide/Show Form</span>
    <span class="close" id="close" onclick="closeMe();">X</span>
    <%--div class="popUpRight  hidden" style="max-width:400px;" id="refererForm" >
                <span class="close" onclick="toggleVisibility('refererForm');">&Cross;</span>
                <h3 class="nomargin nopadding">Create Referrer</h3><hr>
                <form id="refForm" >
                    <input type="hidden" name="action" value="NReferer" />
                    <br><br>
                    <input type="text" class="textField" name="rfN" placeholder="Referer Name" /><br><br>
                    <button class="button" onclick="return subForm('refForm','FormManager');">save</button><br><br>
                </form>
            </div>
            <div id="updBal" class="popUp"></div--%>
    <div class="fullWidWithBGContainer" >
        <div class="subNav left">
            <div style="margin: 1px;padding: 1px;border: 1px white solid;">
    <p class="nomargin nopadding white">Filters </p><hr>
    <ul>
        <li onclick="loadPg('df/MakeOrder.jsp')" class="navLink leftAlText blkFnt" title="Overall purchase for the Month">Purchases<span class="right fa fa-angle-double-right"></span><i class="right">Paid Orders Only &nbsp;</i></li><hr>
        <li class="navLink leftAlText blkFnt" title="Paid for Purchases made for the Month">Referrer<span class="right fa fa-angle-double-right"></span><i class="right"><select>
                    <option>Select Referrer</option>
                </select> &nbsp;</i></li><hr>
        <li onclick="loadPg('df/MakeOrder.jsp?f=bn0')" class="navLink leftAlText blkFnt" title="Balance payment for purchases made for the Month">Balances<span class="right fa fa-angle-double-right"></span><i class="right">Pending Orders &nbsp;</i></li><hr> 
<!--        <li onclick="loadPg('df/recentOrders.jsp')" class="navLink leftAlText greenFont" title="Overall orders for the  month">Order Value<span class="right fa fa-angle-double-right"></span><i class="right">tTP%> &nbsp;</i></li><hr>
        <li onclick="loadPg('df/recentOrders.jsp?f=b0')" class="navLink leftAlText greenFont" title="Payments received for the orders executed during the month">Payments Received<span class="right fa fa-angle-double-right"></span><i class="right">tPaid%> &nbsp;</i></li><hr>
        <li onclick="loadPg('df/recentOrders.jsp?f=bn0')" class="navLink leftAlText greenFont" title="Payments to be collected for the orders executed during the month">Pending Payments<span class="right fa fa-angle-double-right"></span><i class="right">tTP-tPaid%> &nbsp;</i></li><hr>
        <li onclick="loadPg('df/complain.jsp')" class="navLink leftAlText blkFnt" title="Overall services/complains for the month">Service Value<span class="right fa fa-angle-double-right"></span><i class="right">tCTP%> &nbsp;</i></li><hr>
        <li onclick="loadPg('df/complain.jsp?f=b0')" class="navLink leftAlText blkFnt" title="Service charges for the complaints executed during the month">Service charges Recd.<span class="right fa fa-angle-double-right"></span><i class="right">tCPaid%> &nbsp;</i></li><hr>
        <li onclick="loadPg('df/complain.jsp?f=bn0')" class="navLink leftAlText blkFnt" title="Pending services charges to be collected for the complaints executed during the month">Pending service charges<span class="right fa fa-angle-double-right"></span><i class="right">tCTP-tCPaid%> &nbsp;</i></li><hr>
        <li class="navLink leftAlText greenFont" title="Payment collected for the orders and services during the month">Overall Collection<span class="right fa fa-angle-double-right"></span><i class="right">mCr%> &nbsp;</i></li><hr>
        <li class="navLink leftAlText greenFont" title="Overall expenditures for the month">Expenditures<span class="right fa fa-angle-double-right"></span><i class="right">mDr-tRPaid%> &nbsp;</i></li><hr>-->
        <li class="navLink leftAlText greenFont" title="C/O Pending payments for the orders and services executed during the month">Outstanding<span class="right fa fa-angle-double-right"></span><i class="right">tTP-tPaid+tCTP-tCPaid%> &nbsp;</i></li>
        
    </ul>
</div>
        </div>
        
        <script>
            <%
            
                String ii=request.getParameter("ini");
                String f=request.getParameter("f");
                int ini=ii==null?0:new Integer(ii);
                Session sess=sessionMan.SessionFact.getSessionFact().openSession();
                DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
                DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
                boolean isA=LU==null;
                try{
                sess.refresh(dist);
                }catch (Exception ex) {
                        out.print("Login Please");
                        return ;
                }
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
                    
var req={sno:$("#sno").val(),to:$("#to").val(),by:$("#by").val(),r1:$("#r1").val(),r2:$("#r2").val(),ref:$("#ref").val(),cPin:$("#cPIN").val(),cApt:$("#cApt").val(),exps:exps,dis:"",dt:$("#dt").val(),
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
        <div class="sbnvLdr right">
            <div id="ODRFmCont" style="background-color: #c1b1d1;">
            <form action="FormManager" onsubmit="return false;" method="post" name="loginForm" id='loginForm' >
                <h2 class="nomargin nopadding white">New Order</h2><hr>
                    <input type="hidden" name="action" id="action" value="DSale"/>   
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
                    <input class="textField" type="text"  id="gst" name="gst" placeholder="GST No."/>
                    <input class="textField" type="text"  id="disc" name="discount" placeholder="Discount"/>
                    <input class="textField" type="text"  id="advPaid" name="advPaid" placeholder="Advance Received"/>
                    <select class="textField" type="text"  id="payMethod" name="payMethod">
                        <option value="">Payment Mode</option>
                        <option>Cash</option>
                        <option>CC</option>
                    </select>
                    <input class="textField" type="text"  id="r1" name="r1" placeholder="Remark 1"/>
                    <input class="textField" type="text"  id="r2" name="r2" placeholder="Remark 2/Choice"/>
                    <input class="textField" type="text"  id="by" name="by" placeholder="Booked By"/>
                    <!--<input class="textField" type="text"  id="to" name="to" placeholder="To/Distributor Id"/>-->
                        <!--<p>Installation Details</p>-->
                        <!--<input class="textField" type="text"  id="ipName" name="ipName" placeholder="Installation Person"/>-->
                        <!--<input class="textField" type="text"  id="veh" name="vehicleNo" placeholder="Vehicle No."/>-->
                        <input class="textField" type="text"  id="instChg" name="instChg" title="Service Charge" placeholder="Service Charge To be collected"/>
                        <!--<input class="textField" type="text"  id="iKm" name="iKm" placeholder="Initial Km. Reading"/>-->
                        <input class="textField" type="text"  id="sno" name="sno" placeholder="Service No"/>
                    <br>
                    <button onclick='return addProduct()' id="editBtn" class="button">Add Product</button>
                    
                    <br>
                    <div id="prodCont" class="scrollable" style="max-height:200px;"></div>
                    <br>
                    <button onclick='return buildJSON("loginForm","FormManager")' id="editBtn" class="button">Save</button>
                    <br><br>
                    </form>
        </div>
    
        <div id="oProds">
            <h2 class="nomargin nopadding white">Recent Orders</h2><hr>
                <div>
                    <!--width="100%"-->
                    <table  cellpadding="2" cellspacing="0" border="1">
                        <tr align="center" id="oProds"><th style="width: 50px;">Date</th><th>Docket</th>
                            <!--<th>Installed by</th><th>Ini KM</th><th>Fin KM</th>-->
                            <th>Ref by</th><th>Customer</th>
                            <!--<th>Apartment</th><th>Flat</th>-->
                            <th >Address</th><th>Mob</th>
                            <!--<th>Alt Mob</th>-->
                            <th>Code</th><th>Qty</th><th>Rate</th><th>Disc</th><th>Total</th><th>Adv</th><th>Bal</th><th>Remark 1</th><th>Remark 2</th><th>By</th><th>SNo</th><%=LU==null||(LU!=null&&LU.getRoles().matches(".*DM-TROrders.*"))?"<th>To</th>":""%><th>Action</th></tr>
            <%
            Query q=sess.createQuery("from DistSaleManager where  docketNo like '2%' "+(f==null?"":" and "+(f.equals("b0")?"bal=0":"bal!=0"))+" and (dist=:d or fromDist=:d) order by SMId desc").setParameter("d", dist);
                if(ini>-1){
                    q.setMaxResults(20).setFirstResult(ini);
                }
                List<DistSaleManager> stk=q.list();
//                StringBuilder refArr=new StringBuilder();
//                refArr.append("[");
            for(DistSaleManager odr:stk){
                boolean isMvd=odr.getFromDist()!=null;
                
//                if(refArr.indexOf("'"+odr.getRefBy().toLowerCase()+"'")<0)
//                refArr.append("'"+odr.getRefBy().replaceAll("'", "&apos;").toLowerCase()+"',");
            %>
                <tr align="center">
                    <td style="width: 70px;"><%=new SimpleDateFormat("dd/MM/yy").format(odr.getDt())%></td>
                    <td style="width: 100px;"><%=odr.getDocketNo()%></td>
                    <td style="width: 100px;"><%=odr.getRefBy()%></td>
                    <td style="width: 200px;text-transform: capitalize"><%=odr.getCust().getName()%></td>
<!--                    <td style="width: 100px;text-transform: capitalize;min-width: 100px;"><%=odr.getCust().getAptName()%></td>
                    <td style="width: 50px;text-transform: capitalize;max-width: 50px;"><%=odr.getCust().getFlatno()%></td>-->
                    <td style="width: 100px;text-transform: capitalize" title="<%=odr.getCust().getAptName()+","+odr.getCust().getFlatno()+","+odr.getCust().getAddress()%>"><%=odr.getCust().getAddress().length()>10?""+odr.getCust().getAddress().substring(0, 10)+"..":odr.getCust().getAddress()%></td>
                    <td style="width: 100px;max-width: 100px;"><%=odr.getCust().getMob()%></td>
                    <td style="width: 100px;max-width: 100px;"><%=odr.getCust().getAltMob()%></td>
                    <!--<td><%=odr.getInstPerson()%></td>-->
                    <!--<td><%=odr.getiKm()+"KM"%></td>-->
                    <!--<td><%=odr.getfKm()+"KM"%></td>-->
<!--                    <td><%=odr.getSaleRecord()%></td>-->
                    <td style="min-width: 100px;"><%try{%><%=odr.getSaleRecord().iterator().next().getProd().getFPName()%><%}catch(Exception e){}%></td>
                    <td style="width: 50px;"><%try{%><%=odr.getSaleRecord().iterator().next().getQnt()%><%}catch(Exception e){}%></td>
                    <td style="width: 50px;"><%try{%><%=odr.getSaleRecord().iterator().next().getSoldAt()%><%}catch(Exception e){}%></td>
                    
                    <td style="width: 80px;"><%=odr.getDisc()%></td>
                    <td style="width: 50px;"><%=odr.getToPay()-odr.getDisc()%></td>
                    <td style="width: 80px;"><%=odr.getAdvPayment()%></td>
                    <td style="width: 100px;"><%=odr.getBal()%></td>
                    <!--<td >&#8377;<%=odr.getInstCharge()%></td>-->
                    <td style="width: 200px;"><%=odr.getRemark1()%></td>
                    <td style="width: 200px;"><%=odr.getRemark2()%></td>
                    <td style="width: 200px;"><%=odr.getThrough()%></td>
                    <td style="width: 200px;"><%=odr.getSerNo()%></td>
                    <%
                        if(isA||(!isA&&LU.getRoles().matches(".*DM-TROrders.*"))){
                            if(isMvd){%>
                            <td><%=odr.getDist().getDisId()%></td>
                            <%}else{
                    %>
                    <td><select style="max-width: 85px" id='odr<%=odr.getSMId()%>'>
                    <%=selSource%></select>
                    <button onclick="sendDataWithCallback('FormManager','action=mvsale&dis='+$('#odr<%=odr.getSMId()%>').val()+'&oId=<%=odr.getSMId()%>',false,function(res,obj){
                        if(res.includes('success')){
                         hndl(obj,null,res,'mvsale');   
                        }else{
                            hndl(obj,null,res,'');   
                        }
                    },this)">Go</button>
                    </td>
                    <%}}%>
                    
                    <td>
                        <%if(!odr.isApproved()){
                        if(isA||(!isA&&LU.getRoles().matches(".*DM-OAPR.*"))){
                        %>
                        <button title='Approve' onclick="sendDataForResp('FormManager','action=TUP&mod=DO&i=<%=odr.getSMId()%>',false);" class="button fa fa-thumbs-down"></button>  
                        <%}if(isA||(!isA&&LU.getRoles().matches(".*DM-ODel.*"))){%>
                         <button title='Delete' onclick="sendDataForResp('FormManager','action=del&mod=DO&i=<%=odr.getSMId()%>',false);" class="button fa fa-trash-o"></button>  
                        <%}}
            if(!isMvd&&odr.isApproved()&&!odr.isExecuted()&&(isA||(!isA&&LU.getRoles().matches(".*DM-OExe.*")))){%>
                        <input type="date" id="dt<%=odr.getSMId()%>" />
                        <button onclick="sendDataForResp('FormManager','action=executed&dt='+$('#dt<%=odr.getSMId()%>').val()+'&i=<%=odr.getSMId()%>',false);" class="button fa fa-arrow-right" title='click to Execute'></button>
                        <%}else if(odr.isExecuted()&&!isMvd){%>
                        <%="<span class='navLink greenFont' onclick='loadPage(\"df/DSR.jsp?dkt="+odr.getDocketNo()+"\");'>"+new SimpleDateFormat("dd.MM.yy").format(odr.getExeDate())+"</span>"%>
                        <%}else if(isMvd){%>
                        <%=odr.getDist().getDisId()%>
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
                <!--<td></td><td></td>-->
                <td></td><td></td>
                    <td><%=si.getProd().getFPName()%></td><td><%=si.getQnt()%></td>
                    <td><%=si.getSoldAt()%></td>
                    <!--<td><%=si.getSoldAt()%></td><td><%=si.getQnt()*si.getSoldAt()%></td>-->
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
            </tr>
                <%
                }}catch (Exception ex) {}
                }
            %>
                    </table>
                    <script>
//                        var xarr=[];
//                        var refs=<(refArr.append("'']"))%>;
//                        function getRef(matc,evt){
////                            alert(evt);
//                        var htMl="";
//                            for(var i=0;i<refs.length;i++){
//                                if(refs[i].match("^"+matc+".*")){
//                                    htMl+="<p align='left' style='padding:0px;margin:0px'>"+refs[i]+"</p>";
//                                }
////                                refs[i].m;
//                            }
//                            $("#MCH").html(htMl);
////                            alert(refs.length);
//                        }
                    </script>
                </div>
        
<center><button class="button" onclick="loadPage('df/recentOrders.jsp?<%=f!=null?"f="+f+"&":""%>ini=<%=(ini+20)%>')">View More >></button>
            <button class="button" onclick="loadPage('df/recentOrders.jsp?<%=f!=null?"f="+f+"&":""%>ini=-1')">View All</button></center>    
        
        </div>
            </div>
    </div>
    </div>
<%
sess.close();
%>
    