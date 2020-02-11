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
    <span class="close" id="close" onclick="closeMe();">X</span>
<%
    DistributorInfo dis=(DistributorInfo)session.getAttribute("dis");
    DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
    if(dis==null){
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
                    
    var req={exps:exps,dis:"",dt:$("#dt").val(),payDtl:$("#payMethod").val(),adv:$("#advPaid").val(),instC:$("#instChg").val(),cName:$("#cName").val(),disc:$("#disc").val(),cMob:$("#cMob").val(),
        cAMob:$("#cAMob").val(),cFlat:$("#cFlat").val(),cAdd:$("#cAdd").val(),
        gstNo:$("#gst").val(),iName:$("#ipName").val(),veh:$("#veh").val(),
        iKm:$("#iKm").val(),fKm:$("#fKm").val(),action:$("#action").val(),prods:products};
//    showMes(JSON.stringify(req));
    sendDataForResp("FormManager",JSON.stringify(req),true);
    }
    function getPND(bal,val,idd) {
        $("#"+idd).html(bal-val);
    }
    
    function showPopUp(smId,bal,dkt){
       
        var popup="<div class='loginForm;'>\n\
            <span class='close' id='close' onclick='$(\"#updBal\").html(\"\");'>x</span>\n\
            <span class='white'><center><h3>Docket "+dkt+"</h3></center><hr></span>\n\
            <center>\n\
        <form  method='post' name='loginForm' id='balForm'>\n\
            <input type='hidden'  name='action' id='action' value='updDistBal'/><br>\n\
            <input type='hidden'  name='dsmId' value='"+smId+"'/><br>\n\
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
            <input class='textField' type='text'  name='newBal' id='newBal' value="+bal+" placeholder='Balance '/><br><br>\n\
            <textarea class='txtArea' type='text'  name='rem' id='txn' placeholder='Remark'/><br>\
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
        <div class="half left">
                <p align="left">
        <br>
                    <input class="textField" type="text" id="dkt" name="dkt" onblur="loadPage('distForms/DSR.jsp?dkt='+$('#dkt').val());"  placeholder="Docket No"/><button onclick="loadPage('distForms/DSR.jsp?dkt='+$('#dkt').val());">Go</button>
                </p>
            </div>
            <div class="half left">
            <p align="right">
                <br>
                <input class="textField" type="date" id="dt" name="dt" onblur="loadPage('distForms/DSR.jsp?dt='+$('#dt').val());"  placeholder="Docket No"/><button onclick="loadPage('distForms/DSR.jsp?dt='+$('#dt').val());">Go</button>
            </p>
            </div>
            
            <%
            String dat=request.getParameter("dt");
            String a=request.getParameter("a");
            String dkt=request.getParameter("dkt");
            SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd");
            Date dt=new Date();
            try{
                dt=fmt.parse(dat);
            }catch (Exception ex) {    
//                ex.printStackTrace();    
            }
            
            if(dkt!=null){
            %>
             <h4 style="padding: 0px;margin:0px;">DSR for Docket <%=dkt%></h4>
            <%}else{%>
            <h4 style="padding: 0px;margin:0px;">DSR On <%=new SimpleDateFormat("dd/MM/yy").format(dt)%></h4>
            <%}%>
            <hr>
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
<!--                    <table class="tinyFont" width="100%" cellpadding="2" cellspacing="0" border="1">
                        <tr align="left" id="oProds">
                            <th>Date</th>
                            <th>Docket</th><th>Ref by</th><th>Installed by</th>
                            <th>Customer</th><th>Apartment</th><th>Flat</th><th>Mob</th>
                            <th>Alt Mob</th>
                            <th>Code</th><th>Qty</th>
                            <th>Rate</th><th>Value</th><th>Total</th><th>Disc</th>
                            <th>Adv</th>
                            <th>Paid</th>
                            <th>Bal
                            
                            </th>
                            <th>Recd</th>
                            <th>Clrd On</th>
                            <th>Remark</th><th>Serv Chg</th>
                            <th>APRVD</th><th>Auth</th>
                            <th>Action</th>
                        </tr>
                        
                    </table>    -->
                    <table class="tinyFont" width="100%" cellpadding="2" cellspacing="0" border="1">
                        <tr align="left" id="oProds">
                            <th>Date</th>
                            <th>Docket</th><th>Ref by</th><th>Installed by</th>
                            <th>Customer</th><th>Apartment</th><th>Flat</th><th>Mob</th>
                            <!--<th>Alt Mob</th>-->
                            <th>Code</th><th>Qty</th>
                            <th>Rate</th><th>Value</th><th>Total</th><th>Disc</th>
                            <th>Adv</th>
                            <!--<th>Paid</th>-->
                            <th>Bal
                            
                            </th>
                            <th>Recd</th>
                            <th>Clrd On</th>
                            <th>Remark</th><th>Serv Chg</th>
                            <!--<th>APRVD</th><th>Auth</th>-->
                            <th>Action</th></tr>
                        
            <%
            List<DSRManager> stk=new ArrayList<DSRManager>();
                if(!utils.Utils.isEmpty(dkt)){
                    stk=sess.createQuery("from DSRManager where order.dist=:di and docketNo=:d").setParameter("di", dist).setParameter("d", dkt).list();
                if(a!=null&&a.equals("today")){
                    
                    List<DSRManager> lstk=sess.createQuery("from DSRManager where order.dist=:di and docketNo=:dkt and dt=:d ").setParameter("di", dist).setParameter("dkt", dkt).setParameter("d", dt).list();
                    if(lstk.isEmpty()){
                    Transaction tr=sess.beginTransaction();
                    DSRManager dsm=stk.get(0);
                    DSRManager man=new DSRManager();
                    man.setDocketNo(dsm.getDocketNo());
                    man.setBal(dsm.getOrder().getBal());
                    man.setOrder(dsm.getOrder());
                    man.setDt(new Date());
                    man.setShifted(true);
                    sess.save(man);
                    tr.commit();
                    }else{
                     out.print("<script>showMes('Sorry docket already exists in today\\'s DSR',true);</script>");   
                    }
                }
            
                }else{
//                    List eR=sess.createQuery("select saleMan.SMId from DSRExcecutionRec where exeOn=:d ").setParameter("d", dt).list();
//                    System.out.println("\r\n\r\nSIZE: "+eR.size()+"\r\n\r\n");
//                if(eR.isEmpty()){
                    stk=sess.createQuery("from DSRManager where dt=:d and order.dist=:di order by DSRId desc").setParameter("di", dist).setParameter("d", dt).list();
//                }
                }
            
            double saleCol=0,pnd=0,due=0,sc=0,adv=0,dsc=0,dcol=0;
            for(DSRManager odr:stk){
                
                saleCol+=odr.getRecd()+odr.getAdv();
                sc+=odr.getSerChg();
                
//                pnd+=odr.getBal();
//                dsc+=odr.getDisc();
//                adv+=odr.getAdvPayment();
//                due+=(odr.getToPay()-odr.getAdvPayment()-odr.getDisc());
            %>
                
            <%if(odr.isShifted()){%>
            <tr>
                    <td><%=new SimpleDateFormat("dd/MM/yyyy").format(odr.getDt())%></td>
                    <td><%=odr.getDocketNo()%></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td style="width: 50px;max-width:50px;"></td>
                    <td style="width: 100px;max-width: 100px;"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td><input style="max-width: 85px;" value="<%=odr.getBal()%>" name="" onfocus="showPopUp(<%=odr.getDSRId()%>,<%=odr.getBal()%>,<%=odr.getDocketNo()%>);"/></td>
                    <td>
                        <%=odr.getRecd()%>
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                    
                    <td>
                        <%--if(odr.getBal()>0){%>
                        <button onclick="showPopUp(<%=odr.getDSRId()%>,<%=odr.getBal()%>,<%=odr.getDocketNo()%>);" class="button" >Save</button>
                        <%}--%>
                    </td>
                </tr>
            <%}else{%>
            <tr>
                    <td><%=new SimpleDateFormat("dd/MM/yyyy").format(odr.getDt())%></td>
                    <td><%=odr.getDocketNo()%></td>
                    <td><%=odr.getRefBy()%></td>
                    <td><input onblur="sendDataForResp('FormManager','action=updDistBal&dsmId=<%=odr.getDSRId()%>&ip='+this.value,false);" style="max-width: 85px;" name="instPer" value="<%=odr.getInst()%>"/></td>
                    <td><%=odr.getCust().getName()%></td>
                    <td><%=odr.getCust().getAptName()%></td>
                    <td style="width: 50px;max-width:50px;"><%=odr.getCust().getFlatno()%></td>
                    <td style="width: 100px;max-width: 100px;"><%=odr.getCust().getMob()%></td>
                    <td><%try{%><%=odr.getOrder().getSaleRecord().iterator().next().getProd().getFPName()%><%}catch(Exception e){}%></td>
                    <td><%try{%><%=odr.getOrder().getSaleRecord().iterator().next().getQnt()%><%}catch(Exception e){}%></td>
                    <td><%try{%><%=odr.getOrder().getSaleRecord().iterator().next().getSoldAt()%><%}catch(Exception e){}%></td>
                    <td><%try{%><%=odr.getOrder().getSaleRecord().iterator().next().getQnt()*odr.getOrder().getSaleRecord().iterator().next().getSoldAt()%><%}catch(Exception e){}%></td>
                    <td>&#8377;<%=odr.getOrder().getToPay()%></td>
                    <td><%=odr.getOrder().getDisc()%></td>
                    <td><%=odr.getAdv()%></td>
                    <td><input style="max-width: 85px;" value="<%=odr.getBal()%>" name="" onfocus="showPopUp(<%=odr.getDSRId()%>,<%=odr.getBal()%>,<%=odr.getDocketNo()%>);" onkeyup="getPND(<%=odr.getBal()%>,this.value,'bal<%=odr.getDSRId()%>')"/></td>
                    <td><%=odr.getRecd()%></td>
                    <td><input type="date" style="max-width: 85px;"  name="" /></td>
                    <td><input style="max-width: 85px;" name="" value="<%=odr.getRemark()%>"/></td>
                    <td><input onblur="sendDataForResp('FormManager','action=updDistBal&dsmId=<%=odr.getDSRId()%>&sc='+this.value,false);" style="max-width: 85px;" name="" value="<%=odr.getSerChg()%>"/></td>
                    
                    <td>
                        <%if(odr.getBal()>0){%>
                        <button onclick="showPopUp(<%=odr.getDSRId()%>,<%=odr.getBal()%>,<%=odr.getDocketNo()%>);" class="button" >Save</button>
                        <%}%>
                    </td>
                    
                </tr>
<%
                Iterator<SaleInfo> sii=odr.getOrder().getSaleRecord().iterator();
                boolean nxt=false;
                try{
                while(sii.hasNext()){
                       if(!nxt){
                           nxt=true;
                           sii.next();
                        }
                       SaleInfo si=sii.next();
                    %>
            <tr>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td><%=si.getProd().getFPName()%></td><td><%=si.getQnt()%></td><td><%=si.getSoldAt()%></td><td><%=si.getQnt()*si.getSoldAt()%></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    
            </tr>
                <%
                }}catch (Exception ex) {}
                }
            %>

                <%}%>
                
            
            </table>
            <br><br><br><br><br><br><br><br><br><br>
            
            <div class="fullWidWithBGContainer">
                
                <div class="tFivePer left">
                <%
                HORecord hor=(HORecord)sess.createQuery("from HORecord where dist=:di and dt=:d").setParameter("di", dist).setParameter("d", dt).uniqueResult();
                %>
                    
            <table width="100%" border="1" cellspacing="0">
                <tr align="center"><th>Detail</th><th>Inc</th><th>Exp</th><th></th></tr>
                <tr align="left"><th>Cash B/F</th><th></th><th></th><th><%if(hor!=null){%><%=hor.getBf()%><%}%></th></tr>
                <tr align="left"><th>Sale Collection</th><th><%=saleCol%></th><th></th><th></th></tr>
                <tr align="left"><th>Serv Charge Collection</th><th><%=sc%></th><th></th><th></th></tr>
                <tr align="left"><th>Total</th><th><%=(saleCol+sc)%></th><th></th><th></th></tr>
                <tr align="left"><td>-</td><td></td><td></td><td></td></tr>
                <tr align="left"><td>-</td><td></td><td></td><td></td></tr>
                <tr align="left"><th>Expenditure</th><th></th><th></th><th><button onclick="newExp('<%=new SimpleDateFormat("yyyy-MM-dd").format(dt)%>');" class="button pointer">Add</button></th></tr>
                <%
                    List<DistFinance> exp=sess.createQuery("from DistFinance where dist=:di and debit>0 and txnDate=:d").setParameter("d", dt).setParameter("di", dist).list();
                double ttlDbt=0;
                
//                HORecord hor=(HORecord)sess.createQuery("from HORecord where dist=:di and dt=:d").setParameter("di", dist).setParameter("d", dt).uniqueResult();
                
                for(DistFinance e:exp){
                ttlDbt+=e.getDebit();
                %>
                <tr align="center"><td style="width:500px;"><%=e.getSummary()%></td><td>-</td><td><%=e.getDebit()%></td><td></td></tr>
                <%}%>
                <tr align="left"><th>Total</th><th><th><%=ttlDbt%></th><th></th></tr>
                <tr align="left"><td>-</td><td></td><td></td><td></td></tr>
                <tr align="left"><th>Bal</th><th></th><th></th><th><%=saleCol+sc-ttlDbt%></th></tr>
                <tr align="left"><th>H/O</th><th></th><th></th><th><input onblur="sendDataForResp('FormManager','action=updDistBal&oc=<%=saleCol+sc-ttlDbt%>&dt=<%=fmt.format(dt)%>&ho='+this.value,false);" style="max-width: 85px;" name="" value="<%if(hor!=null){%><%=hor.getAmt()%><%}%>"/></th></tr>
                <tr align="left"><th>C/O</th><th></th><th></th><th><%if(hor!=null){%><%=saleCol+sc-ttlDbt-hor.getAa()%><%}%></th></tr>
            </table>    
                </div>
                <div class="sixtyFivePer right">
                    <table width="100%" border="1" style="margin-left: 2px;" cellpadding="2px" cellspacing="0">
                <tr align="left"><th>Vehicle</th><th>Used By</th><th>Docket No</th><th>Code</th><th>Apt & Area</th><th>Ini</th>
                    <th>Fin Reading</th><th>Dist</th><th>Total Dist</th><th>Expense</th><th>Amount</th><th>Result</th></tr>
                <tr>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><button class="button" onclick="newVehRec('<%=new SimpleDateFormat("yyyy-MM-dd").format(dt)%>')">Add</button></td>
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




                <%--
                    double tDist=0;
                    for(DistSaleManager sale:stk){
                        tDist+=(sale.getfKm()-sale.getiKm());
                %>
                <tr>
                    <td><%=sale.getVehNo()%></td><td><%=sale.getInstPerson()%></td><td><%=sale.getDocketNo()%></td><td><%=sale.getCust().getAptName()+" "+sale.getCust().getAddress()%></td>
                    <td><%=sale.getiKm()%></td><td><%=sale.getfKm()%></td><td><%=sale.getfKm()-sale.getiKm()%></td><td></td><td><%=sale.getDocketNo()%></td><td>0</td><td>0</td><td><%=sale.getRemark()%></td>
                </tr>
                <%
                    List<DistFinance> fin=sess.createQuery("from DistFinance where docketNo=:d and debit>0").setParameter("d", sale.getDocketNo()).list();
                    for(DistFinance exp:fin){
                    %>
                <tr>
                    <td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td><%=exp.getSummary()%></td><td><%=exp.getDebit()%></td><td><%=sale.getRemark()%></td>
                </tr>
                <%}}%>
            --%>
                </table>
                </div>
            </div>
            <br><br><br><br><br>
                <br><br><br><br><br>
            </form>
                </div>
            </div>
    </div>
</div>
<%
sess.close();
%>
    