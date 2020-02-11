<%@page import="entities.DistFinance"%>
<%@page import="utils.UT"%>
<%@page import="entities.Customer"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.Date"%>
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
<%
String ii=request.getParameter("ini");
    String f=request.getParameter("f");
    int ini=ii==null?0:new Integer(ii);
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
    DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
    if(dist==null||LU!=null&&!LU.getRoles().matches(".*\\(.Odr\\).*")){
        out.print("<script>window.location.replace(\"?msg=You don't have permission to access this page\");</script>");
        return;
    }

    boolean isA=LU==null;
    try{
    sess.refresh(dist);
    }catch (Exception ex) {
            out.print("Login Please");
            return ;
    }
    Date[] curr=Utils.gCMon(new Date());
    String m=request.getParameter("r"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),mv=request.getParameter("m");
    String cMob=request.getParameter("cn"),dk=request.getParameter("dk");
    Criteria c=sess.createCriteria(DistSaleManager.class).add(Restrictions.or(Restrictions.eq("fromDist", dist),Restrictions.eq("dist", dist))).add(Restrictions.like("docketNo", "2%")).addOrder(Order.desc("dt"));
    if(Utils.isEmpty(cMob,dk)){
        if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
            curr[0]=Utils.DbFmt.parse(iD);
            curr[1]=Utils.DbFmt.parse(fD);
            c.add(Restrictions.between("dt", curr[0], curr[1]));
        }else if(iD!=null&&iD.matches(".{10}")){
            
            c.add(Restrictions.eq("dt", Utils.DbFmt.parse(iD)));       
        }else{
            c.add(Restrictions.between("dt", curr[0],curr[1]));
        }
    }
    if(mv!=null&&mv.matches(".{1,}")){
        c.add(Restrictions.eq("dist.disId",mv));
    }
    if(cMob!=null&&cMob.matches("\\d{10}")){
//        List<Customer> cc=sess.createQuery("from Customer c where c.mob="+cMob+" or c.altMob="+cMob).list();
//        if(!cc.isEmpty()){
        c.add(
//                Restrictions.or(
                        Restrictions.eq("cust.mob",cMob)
//                ,Restrictions.eq("cust.altMob",cMob)
//        )
                );
//        }
    }
    if(dk!=null&&dk.matches(".{1,}")){
        c.add(Restrictions.or(Restrictions.eq("docketNo",dk),Restrictions.eq("serNo",dk)));
//        c.add();
    }
    if(m!=null&&m.matches("00R-.+")){
        c.add(Restrictions.eq("refBy",m.replaceFirst("00R-", "")));
    }
//            setFirstResult(ini).setMaxResults(20).
       
    List<DistributorInfo> dists=sess.createCriteria(DistributorInfo.class).list();
//    Date[] curr=Utils.gCMon(new Date());
    double te=0,tp=0,tmv=0;
    
    List<Object[]> tod = sess.createQuery("select count(*),executed from DistSaleManager where docketNo like '2%' and dist=:d and dt=CURDATE() group by executed")
//    .setParameter("iDt", curr[0])
//    .setParameter("fDt", curr[1])
    .setParameter("d", dist).list();
    for(Object[] t:tod){
     if(new Boolean(""+t[1])){
      te=new Double(""+t[0]);   
     }else{
      tp=new Double(""+t[0]);   
     }
    }
    
    List<Object[]> mon = sess.createQuery("select count(*),executed from DistSaleManager where docketNo like '2%' and dist=:d and ( dt between :iDt and :fDt ) group by executed")
    .setParameter("iDt", curr[0])
    .setParameter("fDt", curr[1])
    .setParameter("d", dist).list();
    

    double tExe=0,tPend=0,tMoved=0;
    for(Object[] t:mon){
     if(new Boolean(""+t[1])){
      tExe=new Double(""+t[0]);   
     }else{
      tPend=new Double(""+t[0]);   
     }
    }
    Long ttlmoved = (Long)sess.createQuery("select count(*) from DistSaleManager where docketNo like '2%' and fromDist=:d and dist is not :d and ( dt between :iDt and :fDt )")
    .setParameter("iDt", curr[0])
    .setParameter("fDt", curr[1])
    .setParameter("d", dist).uniqueResult();
    if(ttlmoved!=null){
      tMoved=ttlmoved;   
    }
    
    

//                List<String> refrs=sess.createQuery("from DistSaleManager ").list();
                
                
%>
<div class="loginForm" style="max-width: 100%;">
<!--    <span class="close" onclick="toggleVisibility('refererForm');" style="right:180px;">Help</span>
    <span class="close" onclick="toggleVisibility('ODRFmCont');" style="right:30px;">Hide/Show Form</span>-->
    <span class="fa fa-close close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="fullWidWithBGContainer bgcolef">
        <div class="d4 left">
            <p class="white pointer <%=(isA||LU!=null&&LU.getRoles().matches(".*\\(COdr\\).*")?"":"invisible")%>" onclick="popsl(<%=dist.getType().equals("Online Sale")?"'df/newonlineODR.jsp'":"'df/newodr.jsp'"%>)">
                <span class="button white"><i class="fa fa-plus-circle"></i> New Order</span></p>
        </div>
        <div class="d4 left leftAlText ">
            <p class="greenFont">Received Today: <%=te+tp%></p>
        </div>
        <div class="d4 left leftAlText">
            <p class="blkFnt">Executed Today: <%=te%></p>
        </div>
        <div class="d4 left leftAlText">
            <p class="greenFont">Moved Today <%=tmv%></p>
        </div>
    </div>
    
    <div class="subNav left">
        <i class="fa btn fa-toggle-left fa-1pt25x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
    <div style="margin: 1px;padding: 1px;border: 1px white solid;" class="bgcolef">
        
    <p class="nomargin nopadding white bgcolt8">Filters </p><hr>
    <ul>
        <li><br>
        <form id="purFil" name="purFil">
                <select title="Select transferred to" class="textField" name="m"><option value="">Select Sale Center</option>
                <%
                List<DistributorInfo> b=sess.createCriteria(DistributorInfo.class).add(Restrictions.eq("deleted", false)).add(Restrictions.ne("type", "User")).add(Restrictions.ne("type", "Referer")).list();
                for(DistributorInfo brr:b){
                %>
                <option value="<%=brr.getDisId()%>"><%=brr.getDisId()%></option>
                <%}%>
            </select><br>
            <select class="textField" name="r" value="<%=UT.ie(m)?"":m%>">
                <option value="">Select Referrer</option>
                    <%
                    b=sess.createCriteria(DistributorInfo.class).add(Restrictions.eq("deleted", false)).add(Restrictions.eq("type", "Referer")).list();
                    for(DistributorInfo mm:b){
                    %>
                    <option value="<%=mm.getDisId()%>"><%=mm.getDisId().split("00R-")[1]%></option>
                    <%
                    }
                    %>
            </select><br>
            <input title="docket no to search" value="<%=dk!=null?dk:""%>" class="textField" type="text" placeholder="Docket No/Service No" name="dk"/><br>
            <input title="Mobile no to search" value="<%=cMob!=null?cMob:""%>" class="textField" type="text" placeholder="Customer Mob" name="cn"/><br>
            <input title="Start date" value="<%=UT.ie(iD)?"":iD%>" class="textField" type="date" name="iD"/><br>
            <input class="textField" value="<%=UT.ie(fD)?"":fD%>" title="End Date" type="date" name="fD"/><br><br>
            <span class="right" onclick="loadPg('df/recentOrders.jsp?'+gfd('purFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
    </ul>
</div>
    <div style="margin-top: 10px;padding: 1px;border: 1px white solid;" class="bgcolef">
    <p class="nomargin nopadding white bgcolt8">Quick Links</p><hr>
    <ul>
        <li  onclick="loadPageIn('linkLoader','df/r/saleKPI.jsp',false);" class="navLink leftAlText blkFnt" title="Compare performance">Performance Matrix<span class="right fa fa-angle-double-right"></span><i class="right">&nbsp;</i></li><hr>
        <li class="navLink leftAlText blkFnt" title="Overall order except Moved">Total Recd. Orders<span class="right fa fa-angle-double-right"></span><i class="right"><%=tExe+tPend%> &nbsp;</i></li><hr>
        <li class="navLink leftAlText blkFnt" title="Executed">Executed Orders<span class="right fa fa-angle-double-right"></span><i class="right"><%=tExe%> &nbsp;</i></li><hr>
        <li class="navLink leftAlText blkFnt" title="Moved by seller">Moved Orders<span class="right fa fa-angle-double-right"></span><i class="right"><%=tMoved%> &nbsp;</i></li><hr> 
        <li class="navLink leftAlText blkFnt" title="Pending">Pending Orders<span class="right fa fa-angle-double-right"></span><i class="right"><%=tPend%> &nbsp;</i></li>
        
    </ul>
    </div>
       
        </div>
        
        <script>
            <%
            
                out.print("var prodJsonArr="+dist.getMyProds().toString()+";");  
                
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
        <div class="sbnvLdr right" id="linkLoader">
        <div id="oProds"><hr>
            <h2 class="nomargin nopadding bgcolef">Orders</h2><hr>
            <div class="scrollable">
                    <!--width="100%"-->
                    <table  cellpadding="2" cellspacing="0" border="1">
                        <tr align="center" id="oProds">
                            <th>SNo</th>
                            <th style="width: 50px;">Date</th><th>Docket</th>
                            <%
        if(!dist.getType().equals("Online Sale")){
        %><th>Ref by</th><%}else{%>
                            <th>OrderNo</th>
                            <%}%>
                            <th>Customer</th>
                            <th>Mob</th>
                            <th>Product</th><th>Qty</th><th>Rate</th>
                            <%
        if(!dist.getType().equals("Online Sale")){
        %>
        <th>Disc</th><%}%>
                            <th>Total</th>
                            <%
        if(!dist.getType().equals("Online Sale")){
        %>
                            <th>Adv</th><th>SC</th>
                            <th>Bal</th>
                            <%}else{%>
                            <th>Received</th>
                            <th>Paid</th>
                            <%}%>  
                            <%
                    if(!dist.getType().equals("Online Sale")){
                    %>
                    
                            <th>By</th><th>SNo</th><th>To</th>
                            <%}%>
                            <th style="min-width: 150px">Action</th></tr>
            <%
            
                List<DistSaleManager> stk=c.list();
//                StringBuilder refArr=new StringBuilder();
//                refArr.append("[");
            int moveCount=0,count=0;
            
            for(DistSaleManager odr:stk){
                boolean isMvd=odr.getFromDist()!=null;
                count++;
//                if(refArr.indexOf("'"+odr.getRefBy().toLowerCase()+"'")<0)
//                refArr.append("'"+odr.getRefBy().replaceAll("'", "&apos;").toLowerCase()+"',");
            %>
                <tr align="center" id="row<%=odr.getSMId()%>">
                    <td><%=count%></td>
                    <td style="width: 70px;"><%=new SimpleDateFormat("dd/MM/yy").format(odr.getDt())%></td>
                    <td style="width: 100px;" onclick="popsl('df/dockRec.jsp?d=<%=odr.getDocketNo()%>')"><span class="navLink greenFont"><%=odr.getDocketNo()%></span></td>
                    <%
        if(!dist.getType().equals("Online Sale")){
        %><td style="width: 100px;" onclick="popsl('df/refRec.jsp?r=<%=URLEncoder.encode(odr.getRefBy())%>')" title="<%=odr.getRefBy()%>"><span class="navLink bluFnt"><%=odr.getRefBy()%></span></td><%}else{%>
                    <td><%=odr.getOdrNo()%></td>
                    <%}%>
                    <td style="text-transform: capitalize" title="<%=odr.getAddress().getApt()+","+odr.getAddress().getFlat()+","+odr.getAddress().getAddr()%>"><%=odr.getCust().getName()%></td>
                    <td style="width: 100px;max-width: 100px;" title="ALT Mob: <%=odr.getCust().getAltMob()%>"><%=odr.getCust().getMob()%></td>
                    <td style="min-width: 100px;"><%try{%><%=odr.getSaleRecord().iterator().next().getProd().getFPName()%><%}catch(Exception e){}%></td>
                    <td style="width: 50px;"><%try{%><%=odr.getSaleRecord().iterator().next().getQnt()%><%}catch(Exception e){}%></td>
                    <td style="width: 50px;"><%try{%><%=odr.getSaleRecord().iterator().next().getSoldAt()%><%}catch(Exception e){}%></td>
                    <%
        if(!dist.getType().equals("Online Sale")){
        %>
        <td style="width: 80px;"><%=odr.getDisc()%></td><%}%>
                    <td style="width: 50px;"><%=odr.getToPay()%></td>
                    <%
                    if(!dist.getType().equals("Online Sale")){
                    %>
                    <td><%=odr.getAdvPayment()%></td>
                    <td><%=odr.getInstCharge()%></td>
                    <td id="bal<%=odr.getSMId()%>"><%=odr.getBal()%></td>
                    <%}else{%>
                    <%
                    Object[] creDebt=(Object[])sess.createQuery("select sum(credit),sum(debit) from DistFinance where docketNo=:dkt or odrInfo=:dsm").setParameter("dsm", odr).setParameter("dkt", odr.getDocketNo()).uniqueResult();
                    %>
                    <td><%=creDebt[0]%></td>
                    <td><%=creDebt[1]%></td>
                    <%}%>    
                    <%
                    if(!dist.getType().equals("Online Sale")){
                    %>
                    <td><%=odr.getThrough()%></td>
                    <td><%=odr.getSerNo()%></td>
                    <td>
                    <%
                        if(isMvd){%>
                        <span title="Transferred"><%=odr.getDist().getDisId()%></span>
                        <%}else if(!odr.isExecuted()&&isA||(!isA&&LU.getRoles().matches(".*\\(TOdr\\).*"))){
                    %>
<%--                    <select class="" style="max-width: 85px" id='odr<%=odr.getSMId()%>'>
                        <%=selSource%>
                    </select>
                        <button class="right " onclick="sendDataForResp('FormManager','action=mvsale&dis='+$('#odr<%=odr.getSMId()%>').val()+'&oId=<%=odr.getSMId()%>',false)">Go</button>--%>
                    <%}%>
                    </td>
                    <%
                    }
                    %>
        <td style="min-width:150px" class="leftAlText" id="aptgt<%=odr.getSMId()%>">
                    <%if(odr.getDist()==dist&&(isA||(!isA&&LU.getRoles().matches(".*\\(UOdr\\).*")))){%>
                    <button title='Edit' onclick="popsl('f/mod.jsp?o=<%=odr.getSMId()%>')" class="button fa fa-edit"></button>  
                    <%}%>
                    <%
                        if(odr.isApproved()){
                            if((odr.getExeDate()!=null&&odr.isExecuted())&&!isMvd&&(isA||(!isA&&LU.getRoles().matches(".*\\((E|U)Odr\\).*")))){
                    %>
                    <span class='button fa fa-eye' onclick='loadPage("df/DSR.jsp?dkt=<%=odr.getDocketNo()%>");' title='Executed on <%=new SimpleDateFormat("dd.MM.yy").format(odr.getExeDate())%>, Click to view payment details in DSR'></span>
                    <!--<span class='button fa fa-user-circle' onclick='loadPage("df/DSR.jsp?dkt=<%=odr.getDocketNo()%>");' title='Click to send SMS to user'></span>-->
                    <%if(odr.getBal()>0||(odr.getInstCharge()-odr.getScExp()<0)||UT.ie(odr.getInstPerson())){%>
                    <%if(!dist.getType().equals("Online Sale")){%>
                    <span class='button fa fa-cc-mastercard' onclick='popsr("df/payBal.jsp?o=<%=odr.getSMId()%>")' title='Click to pay'></span><%}else{%>
                    <span class='button fa fa-paperclip' onclick='popsr("df/atFin.jsp?o=<%=odr.getSMId()%>")' title='Attach Payment Record'></span><%}%>
                    <%}%>
                     <%}else{
                      if(!odr.isCancelled()&&(isA||(!isA&&LU.getRoles().matches(".*\\((E|U)Odr\\).*")))){
                         if(!isMvd||(odr.getDist().getDisId().equals(dist.getDisId()))){
                     %>
                         <button onclick="popsr('f/exedock.jsp?i=<%=odr.getSMId()%>&r=aptgt',false);" class="button fa fa-arrow-circle-right" title='click to Execute'></button>      
                     <%}}
                     }
                     }else if(!odr.isCancelled()&&(isA||(!isA&&LU.getRoles().matches(".*\\(AOdr\\).*")))){%>
                         <button title='Approve' onclick="sendDataForResp('a','action=TUP&mod=DO&i=<%=odr.getSMId()%>&r=aptgt<%=odr.getSMId()%>',false);" class="button fa fa-thumbs-down"></button>  
                     <%}if(!odr.isCancelled()&&(isA||(!isA&&LU.getRoles().matches(".*\\(DOdr\\).*")))){%>
                         <%--<button title='Delete' onclick="showDial('action=del&mod=DO&i=<%=odr.getSMId()%>&r=row<%=odr.getSMId()%>','del','Do you really want to delete??','It\'ll affect stock and finance');" class="button fa fa-trash"></button>--%>
                         <%if(odr.isExecuted()){%><button title='Return' onclick="popsr('df/retDock.jsp?o=<%=odr.getSMId()%>&r=aptgt<%=odr.getSMId()%>');" class="button fa fa-reply"></button><%}%>
                     <%}if(!odr.isCancelled()&&(isA||(!isA&&LU.getRoles().matches(".*\\(DOdr\\).*")))){%>
                        <%if(!odr.isCancelled()){%>
                            <%--<button title='Cancel' onclick="sendDataForResp('a','action=cancel&mod=DO&i=<%=odr.getSMId()%>&r=aptgt<%=odr.getSMId()%>',false);" class="button fa fa-close"></button>--%>     
                        <%}else{%>   
                        <%}%>
                     <%}//if(dist.getType().equals("Online Sale")&&!odr.isReturned()){%>
                     <!--<span class='button fa fa-reply' onclick='popsr("df/retDock.jsp?o=<%=odr.getSMId()%>")' title='Customer Return'></span>-->
                     <%//}%>
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
                    <td><%=si.getProd().getFPName()%></td><td><%=si.getQnt()%></td>
                    <td><%=si.getSoldAt()%></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <!--<td></td>-->   
            </tr>
                <%
                }}catch (Exception ex) {}
                }
            %>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
            <script>
                <%="purFil.iD.value='"+Utils.DbFmt.format(curr[0])+"'"%>;
                <%="purFil.fD.value='"+Utils.DbFmt.format(curr[1])+"'"%>;
                <%=UT.ie(m)?"":"purFil.r.value='00R-"+m+"'"%>;
                <%=UT.ie(cMob)?"":"purFil.cn.value='"+cMob+"'"%>;
                <%=UT.ie(dk)?"":"purFil.dk.value='"+dk+"'"%>;
            </script>
<%
sess.close();
%>