<%@page import="entities.DistFinance.PaymentMethod"%>
<%@page import="java.util.Calendar"%>
<%@page import="entities.COBF"%>
<%@page import="utils.UT"%>
<%@page import="org.hibernate.Query"%>
<%@page import="utils.Utils"%>
<%@page import="entities.HORecord"%>
<%@page import="entities.DSRBottom"%>
<%@page import="entities.DSRManager"%>
<%@page import="entities.DSRExcecutionRec"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.DistFinance"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="entities.SaleInfo"%>
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
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
<%
    DistributorInfo dis=(DistributorInfo)session.getAttribute("dis");
    DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
    if(dis==null||LU!=null&&!LU.getRoles().matches(".*\\(.DSR\\).*")){
        out.print("<script>window.location.replace(\"?msg=You don't have permission to access this page\");</script>");
        return;
    }
    
%>
    <div class="fullWidWithBGContainer ">
        <script>
            <%
                Session sess=sessionMan.SessionFact.getSessionFact().openSession();
                DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
                sess.refresh(dist);
                out.print("var prodJsonArr="+dist.getMyProds().toString()+";");   
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
        var expCount=0;
        function addExp(){
                var sel="<div id='expCont"+expCount+"'>";
                var fieldHtml=sel+"<input name='exp"+expCount+"' id='exp"+expCount+"'\n\
                    class='autoFitTextField' type='text' placeholder='Expenditure Message' />\n\
                    <input name='xpA"+expCount+"' id='xpA"+expCount+"' class='autoFitTextField' type='text' placeholder='Amount' />\n\</div>";
                $("#prodCont").append(fieldHtml);
                expCount++;    
                return false;
//                            console.log(JSON.stringify(matIds));
                }
        function newExp(dt) {
            var popup="<div class='loginForm;'>\n\
            \n\<center>\<span class='close' id='close' onclick='$(\"#expPopCont\").html(\"\");'>x</span>\n\
            <span class='white'><center><h3>Add Expenditure on "+dt+"</h3></center><hr></span>\n\
<form  method='post' name='expForm' id='expForm'>\n\
            <input type='hidden'  name='action' id='action' value='disExp'/><br>\n\
            <input type='hidden'  name='dt' value='"+dt+"'/><br>\n\
            <select onchange='setPayType(this.value)' class='textField' type='text'  id='payMethod' name='payMethod' >\n\
                <option>Select Payment Method</option>\n\
                <option>Cash</option>\n\
                <option>DD</option>\n\
                <option>NEFT</option>\n\
                <option>RTGS</option>\n\
                <option>Cheque</option>\n\
                <option>Online</option>\n\
            </select>\n\
            <input class='textField' type='text'  name='bknm' id='bknm' placeholder='Enter Bank Name'/><br>\n\
            <input class='textField' type='text'  name='txn' id='txn' placeholder='Enter Transaction-Id'/>\n\
            <input class='textField' type='text'  name='newBal' id='newBal' placeholder='Amount'/><br><br>\n\
            <textarea class='txtArea' type='text'  name='rem' id='txn' placeholder='Remark'/><br>\
            <button onclick=\"return subForm('expForm','FormManager');\" class='button'>Save</button>\n\
        </form>\n\
       </center>\n\
        <br><br><br>\n\
    </div>";
        $("#expPopCont").html(popup);
        }
        
        function newVehRec(dt){
            var popup="<div class='loginForm;' style='min-width:300px;'> \n\
            \n\<center>\<span class='close' id='close' onclick='$(\"#newEntryCont\").html(\"\");'>x</span>\n\
            <span class='white'><center><h3>New Record on "+dt+"</h3></center><hr></span>\n\
<form  method='post' name='expForm' id='expForm'>\n\
            <input type='hidden'  name='action' id='action' value='disExpEntry'/><br>\n\
            <input type='hidden'  name='dt' value='"+dt+"'/><br>\n\
    <input class='textField' type='text'  name='veh' id='veh' placeholder='Vehicle'/><br>\n\
    \n\<input class='textField' type='text'  name='ub' id='ub' placeholder='Used by'/><br>\n\
    \n\<input class='textField' type='text'  name='doc' id='doc' placeholder='Docket No'/><br>\n\
    \n\<input class='textField' type='text'  name='ana' id='ana' placeholder='Apt and Area'/><br>\n\
\n\n\<input class='textField' type='text'  name='pro' id='ana' placeholder='Code'/><br>\n\
    \n\<input class='textField' type='text'  name='or' id='or' placeholder='Opening Reading'/><br>\n\
    \n\n\<input class='textField' type='text'  name='cr' id='cr' placeholder='Closing Reading'/><br>\n\
    \n\<input class='textField' type='text'  name='exp' id='exp' placeholder='Expense'/><br>\n\
    \n\n\<input class='textField' type='text'  name='amt' id='amt' placeholder='Amount'/><br>\n\
\n\n\n\<input class='textField' type='text'  name='res' id='res' placeholder='Result'/><br>\n\
    <button onclick=\"return subForm('expForm','FormManager');\" class='button'>Save</button>\n\
        </form>\n\
       </center>\n\
        <br><br><br>\n\
    </div>";
        $("#newEntryCont").html(popup);
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
                                        
//        console.log(JSON.stringify(prodIds));
                    }
                function buildJSON() {
                    var products=[],exps=[];
                    for(var i=0;i<prodIds.length;i++){
                        var qty=new Number($("#prodQnt"+prodIds[i]).val());
                        var psp=new Number($("#prodSP"+prodIds[i]).val());
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
                var req={exps:exps,dis:"",dt:$("#dt").val(),payDtl:$("#payMethod").val(),adv:$("#advPaid").val(),instC:$("#instChg").val(),cName:$("#cName").val(),disc:$("#disc").val(),cMob:$("#cMob").val(),
                    cAMob:$("#cAMob").val(),cFlat:$("#cFlat").val(),cAdd:$("#cAdd").val(),
                    gstNo:$("#gst").val(),iName:$("#ipName").val(),veh:$("#veh").val(),
                    iKm:$("#iKm").val(),fKm:$("#fKm").val(),action:$("#action").val(),prods:products};
                sendDataForResp("FormManager",JSON.stringify(req),true);
                }
            function getPND(bal,val,idd) {
                $("#"+idd).html(bal-val);
            }
        </script>
        <%
            String dat=request.getParameter("dt");
            String a=request.getParameter("a");
            String dkt=request.getParameter("dkt");
            Date dt=new Date();
            try{
                dt=Utils.DbFmt.parse(dat);
            }catch (Exception ex) {    
            }
            %>
        <div id="oProds" class="bgcolt8">
            <div class="fullWidWithBGContainer bgcolef spdn">
            <div class="d3 left centAlText">
                <p class="nomargin nopadding white centAlText">
                    <input class="textField" type="text" id="dkt" name="dkt" value="<%=dkt!=null?dkt:""%>" onblur="loadPage('df/DSR.jsp?dkt='+$('#dkt').val());"  placeholder="Docket No"/>
                    <button class="fa fa-refresh button" onclick="loadPage('df/DSR.jsp?dkt='+$('#dkt').val());"></button>
                </p>
            </div>
            <div class="d3 left centAlText">
                
                <h2 class="nopadding nomargin">DSR <%=dkt==null?"on "+Utils.HRFmt.format(dt):"for Docket "+dkt%></h2>
            </div>
            <div class="d3 left">
                <p class="nomargin nopadding white centAlText" >
                    <input class="textField" type="date" id="dt" name="dt" value="<%=dt!=null?dt:Utils.DbFmt.format(new Date())%>"  onblur="loadPage('df/DSR.jsp?dt='+$('#dt').val());"  placeholder="Docket No"/><button class="fa fa-refresh button" onclick="loadPage('df/DSR.jsp?dt='+$('#dt').val());"></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </p>
            </div>
            </div>
                <div>
                    <style>
                        .tinyFont *{
                            font-size: 14px;
                        }
                    </style>
                    <div id="updBal" style="max-width: 500px;" class="popUp"></div>
                    <div id="expPopCont" style="max-width: 500px;" class="popUp"></div>
                    <div id="newEntryCont" style="max-width: 500px;" class="popUpRight"></div>
                    <form onsubmit="return false;">
                    <table class="tinyFont" width="100%" cellpadding="2" cellspacing="0" border="1">
                        <tr align="left" id="oProds">
                            <th>Date</th>
                            <th>Docket</th><th>Ref by</th><th>Installed by</th>
                            <th>Customer</th><th>Address<th>Mob</th>
                            <th>Code</th><th>Qty</th>
                            <th>Rate</th>
                            <!--<th>Value</th>-->
                            <th>Disc</th>
                            <th>Total</th>
                            <th>Adv</th>
                            <th>Bal</th>
                            <th>SC (Expected)</th>
                            <th>SC (Collected)</th>
                            <!--<th>Recd</th>-->
                            <th>Booked By</th>
                            <th>SNo.</th>
                            <th>Action</th>
                        </tr>
                        <tr><th colspan="22">Executed Today</th></tr>
            <%
            Query q=sess.createQuery("from DistSaleManager where dist=:di  "+(dkt==null?"and exeDate=:dt ":"and docketNo=:dkt")+" order by SMId").setParameter("di", dist);
            if(dkt==null){
                q.setParameter("dt", dt);
            }else{
                q.setParameter("dkt", dkt);
            }
            List<DistSaleManager> exeRec=q.list();
            double saleCol=0,sc=0,adv=0,tCol=0;
            for(DistSaleManager odr:exeRec){
%>              
            <tr align="center">
                    <td style="width: 70px;"><%=new SimpleDateFormat("dd/MM/yy").format(odr.getDt())%></td>
                    <td style="width: 100px;"><span class="navLink blkFnt docketRef" ><%=odr.getDocketNo()%></span></td>
                    <td style="width: 100px;"><%=odr.getRefBy()%></td>
                    <td style="width: 200px;text-transform: capitalize"><%=odr.getInstPerson()%></td>
                    <td style="width: 200px;text-transform: capitalize"><%=odr.getCust().getName()%></td>
                    <td style="width: 100px;text-transform: capitalize" title="<%=odr.getCust().getAptName()+","+odr.getCust().getFlatno()+","+odr.getCust().getAddress()%>"><%=odr.getCust().getAddress().length()>10?""+odr.getCust().getAddress().substring(0, 10)+"..":odr.getCust().getAddress()%></td>
                    <td style="width: 100px;max-width: 100px;" title="Alt Mob <%=odr.getCust().getAltMob()%>"><%=odr.getCust().getMob()%></td>
                    <td style="min-width: 100px;"><%try{%><%=odr.getSaleRecord().iterator().next().getProd().getFPName()%><%}catch(Exception e){}%></td>
                    <td style="width: 50px;"><%try{%><%=odr.getSaleRecord().iterator().next().getQnt()%><%}catch(Exception e){}%></td>
                    <td style="width: 50px;"><%try{%><%=odr.getSaleRecord().iterator().next().getSoldAt()%><%}catch(Exception e){}%></td>
                    <td style="width: 80px;"><%=odr.getDisc()%></td>
                    <td style="width: 50px;"><%=odr.getToPay()%></td>
                    <td style="width: 80px;"><%=odr.getAdvPayment()%></td>
                    <td style="width: 100px;"><%=odr.getBal()%></td>
                    <td style="width: 200px;"><%=odr.getScExp()%></td>
                    <td style="width: 200px;"><%=odr.getInstCharge()%></td>
                    <td style="width: 200px;"><%=odr.getThrough()%></td>
                    <td style="width: 200px;"><%=odr.getSerNo()%></td>
                    <td><%if((LU==null||LU.getRoles().matches("(.*EOdr.*)|(.*CFin.*)"))&&(odr.getBal()>0||(odr.getInstCharge()-odr.getScExp()<0)||UT.ie(odr.getInstPerson()))){%><span class='button fa fa-cc-mastercard' onclick='popsr("df/payBal.jsp?o=<%=odr.getSMId()%>")' title='Click to pay'></span><%}%></td>
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
            <br><br><br>
            
            <div class="fullWidWithBGContainer bgcolef">
                
                <div class="tFivePer left">
                <%
                    COBF cor=(COBF)sess.createQuery("from COBF where id=:id").setParameter("id", Utils.DbFmt.format(dt)+"_"+dist.getDisId()).uniqueResult();
                    double co=0,bf=0;
                    if(cor!=null){
                        co=cor.getCo();
                        bf=cor.getBf();
                    }   
                %>
            <table width="100%" border="1" cellpadding="3px">
                <tr align="left"><th>Type</th><th>Remark</th><th>Cash</th><th>Cheque</th><th>Debit</th><th>Action</th></tr>
                <tr align="left"><td>B/F</td><td></td><td class="rightAlText">
                        <%=LU==null?"<input type=\"number\" class='smTF' value='"+bf+"'   onblur='svbf(this.value);'/>":bf%>
                    </td><td></td><td></td><td></td></tr>
                <tr align="left"><td>Total Sale Col</td><td></td><td class="greenFont rightAlText" id="SL_COL"></td><td></td><td></td><td></td></tr>
                <tr align="left"><td>Cash Col.</td><td></td><td class="greenFont rightAlText" id="Cash_COL"></td><td></td><td></td><td></td></tr>
                <tr align="left"><td>Adv Col.</td><td></td><td class="greenFont rightAlText" id="ADV">&#8377;<%=adv%></td><td></td><td></td><td></td></tr>
                <tr align="left"><td>SCh Col.</td><td></td><td class="greenFont rightAlText" id="SCC">&#8377;<%=sc%></td><td></td><td></td><td></td></tr>
                <tr align="left"><td>Total</td><td></td><td class="rightAlText" id="TTL_COL"></td><td></td><td></td><td></td></tr>
                <!--<tr align="left"><td>-</td><td></td><td></td></tr>-->
                <tr align="left"><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td><td></td></tr>
            <%
            q=sess.createQuery("from DistFinance df where credit>0 and pending=false and dist=:di "+(dkt==null?"and txnDate=:dt":"and docketNo=:dkt")+" order by docketNo ").setParameter("di", dist);
            if(dkt==null){
                q.setParameter("dt", dt);
            }else{
                q.setParameter("dkt", dkt);
            }
            List<DistFinance> fReq=q.list();
//            double cTl=0,dTl=0;
            double cashCol=0;
            for(DistFinance odr:fReq){
                double amt=odr.getCredit()>0?odr.getCredit():odr.getDebit();
                if(odr.getCat()==null){
                    
                }else if(odr.getCat()==DistFinance.REF.BAL){
                    saleCol+=amt;
                }else if(odr.getCat()==DistFinance.REF.ADV){
                    adv+=amt;
                }else if(odr.getCat()==DistFinance.REF.SC){
                    sc+=amt;
                }
                if(odr.getMethod()==PaymentMethod.Cash){
                    cashCol+=odr.getCredit();
                }
                tCol+=odr.getCredit();
            %>
            <tr>
                <td style="width: 100px;" onclick="popsl('df/dockRec.jsp?d=<%=odr.getDocketNo()%>')"><%=odr.getDocketNo()%></td>
                <td><%=odr.getSummary()+"("+odr.getMethod()+")"%></td>
                <td class="rightAlText"><%="<i class='greenFont'>"+(odr.getMethod()==PaymentMethod.Cash&&odr.getCredit()>0?"&#8377;"+amt:"")+"</i>"%></td>
                <td class="rightAlText"><%="<i class='greenFont'>"+(odr.getMethod()!=PaymentMethod.Cash&&odr.getCredit()>0?"&#8377;"+amt:"")+"</i>"%></td>
                <td class="rightAlText"><%="<i class='redFont'>"+(odr.getDebit()>0?"&#8377;"+amt:"")+"</i>"%></td>
                <!--<td><%=odr.getMethod()%></td>-->
                <td><span class="fa fa-check-circle <%=odr.isApproved()?"greenFont\" title='approved' ":"redFont\" title='Not approved'"%>"></span></td>
            </tr>
            <%}%>
            
           <% q=sess.createQuery("from DistFinance df where debit>0 and pending=false and dist=:di "+(dkt==null?"and txnDate=:dt":"and docketNo=:dkt")+" order by docketNo ").setParameter("di", dist);
            if(dkt==null){
                q.setParameter("dt", dt);
            }else{
                q.setParameter("dkt", dkt);
            }
            fReq=q.list();
            double dTl=0;
            for(DistFinance odr:fReq){
                double amt=odr.getCredit()>0?odr.getCredit():odr.getDebit();
                dTl+=amt;
//                if(odr.getCredit()>0){
//                    cTl+=amt;
//                }else{
//                    dTl+=amt;
//                }
            %>
            <tr align="">
                <td style="width: 100px;" class="docketRef" ><%=odr.getDocketNo()%></td>
                    <td><%=odr.getSummary()%></td>
                    <td></td>
                    <td></td>
                    <td class="rightAlText"><%="<i class='redFont'>"+(odr.getDebit()>0?"&#8377;"+amt:"")+"</i>"%></td>
                    <!--<td><%=odr.getMethod()%></td>-->
                    <!--<td></td>-->
                    <td><span class="fa fa-check-circle <%=odr.isApproved()?"greenFont\" title='approved' ":"redFont\" title='Not approved'"%>"></span></td>
                </tr>
            <%}%>
                <tr align="left"><td>Total Exp.</td><td></td><td></td><td></td><td class="redFont rightAlText">&#8377;<%=dTl%></td><td class="rightAlText"><button onclick="newExp('<%=new SimpleDateFormat("yyyy-MM-dd").format(dt)%>');" class="button pointer">Add</button></td></tr>
                <tr align="left"><td>--</td><td></td><td></td><td></td><td class="rightAlText">
                    <%--<%=LU==null?"<input class='smTF' type=\"number\" value='"+co+"'   onblur='svco(this.value);'/>":co%>--%>
                    </td><td></td></tr>
                <tr align="left"><td>C/O</td><td></td><td></td><td></td><td></td><td class="rightAlText">&#8377;<%=cashCol-dTl+bf%></td></tr>
                
                <tr align="left"><td>--</td><td></td><td></td><td></td><td class="rightAlText">
                    <%--<%=LU==null?"<input class='smTF' type=\"number\" value='"+co+"'   onblur='svco(this.value);'/>":co%>--%>
                    </td><td></td></tr>
                <tr align="left"><td>DSR Note</td><td colspan="4" class=""><textarea onblur="" class="txtArea" placeholder="Write note here"><%=cor!=null?(cor.getRemark()==null?"":cor.getRemark()):""%></textarea></td><td></td></tr>
            </table>    
                </div>
            <script>
                function svco(cov){
                    var coO=<%=co%>;
                    if(cov!=coO)
                    sdfr('U','action=cobf&dt=<%=Utils.DbFmt.format(dt)%>&co='+cov,false);
                }
                function svbf(bfv){
                    var bfo=<%=bf%>;
                    if(bfv!=bfo)
                    sdfr('U','action=cobf&dt=<%=Utils.DbFmt.format(dt)%>&bf='+bfv,false);
                }
                $("#ADV").html("&#8377;<%=adv%>");$("#TTL_COL").html("&#8377;<%=tCol+bf%>");
                $("#SL_COL").html("&#8377;<%=saleCol%>");$("#SCC").html("&#8377;<%=sc%>");
                $("#Cash_COL").html("&#8377;<%=(cashCol)%>")
//                $("#dt").val('<%=dt%>');
            </script>
                <div class="sixtyFivePer right">
                <table width="100%" border="1" cellpadding="2px" cellspacing="0">
                    <tr align="left"><th>Vehicle</th><th>Used By</th><th>Docket No</th><th>Code</th><th>Apt & Area</th><th>Ini</th>
                        <th>Fin Reading</th><th>Dist</th><th>Total Dist</th><th>Expense</th><th>Amount</th><th>Result</th></tr>
                    <tr>
                        <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><button class="button" onclick="newVehRec('<%=new SimpleDateFormat("yyyy-MM-dd").format(dt)%>')">Add</button></td>
                    </tr>
                <%
                    List<DSRBottom> dsrB=sess.createQuery("from DSRBottom  where dist=:di and dt=:d").setParameter("di", dist).setParameter("d", dt).list();
                    for(DSRBottom db:dsrB){
                %>
                <tr>
                    <td><%=db.getVeh()%></td><td><%=db.getUsedBy()%></td><td><%=db.getDocketNo()%></td><td><%=db.getDocketNo()%></td><td><%=db.getAptnA()%></td><td><%=db.getiR()%></td>
                    <td><%=db.getfR()%></td><td><%=db.getfR()-db.getiR()%></td><td>-</td><td><%=db.getExp()%></td><td><%=db.getAmt()%></td><td><%=db.getRes()%></td>
                </tr>
                <%}%>
                </table>
            
                </div>
            </div>
            <!--<br><br><br><br><br>-->
                <br><br><br><br><br>
            </form>
                </div>
            </div>
                <script>
                    $(".docketRef").on("click",function(){
                        popsl('df/dockRec.jsp?d='+this.innerHTML);
//                        alert(this.getAttribute('data'));
//                        alert(this.innerHTML);
                    });
                </script>
    </div>
</div>
<%
    
sess.close();
%>
    