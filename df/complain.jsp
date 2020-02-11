<%@page import="utils.UT"%>
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
                if(dist==null||LU!=null&&!LU.getRoles().matches(".*\\(.Comp\\).*")){
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
    List<DistributorInfo> dists=sess.createCriteria(DistributorInfo.class).list();
    Date[] curr=Utils.gCMon(new Date());
    double te=0,tp=0,tmv=0;
//    Date[] curr=Utils.gCMon(new Date());
    String m=request.getParameter("r"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),mv=request.getParameter("m");
    String cMob=request.getParameter("cn"),dk=request.getParameter("dk");
    Criteria c=sess.createCriteria(DistSaleManager.class).add(Restrictions.or(Restrictions.eq("fromDist", dist),Restrictions.eq("dist", dist))).add(Restrictions.like("docketNo", "3%")).addOrder(Order.desc("dt"));
    c.createAlias("cust", "cust");
    if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
        curr[0]=Utils.DbFmt.parse(iD);
        curr[1]=Utils.DbFmt.parse(fD);
            
        c.add(Restrictions.between("dt", curr[0],curr[1]));
    }else if(iD!=null&&iD.matches(".{10}")){
        c.add(Restrictions.eq("dt", Utils.DbFmt.parse(iD)));       
    }else{
           c.add(Restrictions.between("dt", curr[0],curr[1]));
    }
    if(mv!=null&&mv.matches(".{1,}")){
        c.add(Restrictions.eq("dist.disId",mv));
    }
    if(m!=null&&m.matches("00R-.+")){
        c.add(Restrictions.eq("refBy",m.replaceFirst("00R-", "")));
    }
    if(cMob!=null&&cMob.matches(".{10}")){
        c.add(Restrictions.or(Restrictions.eq("cust.mob",cMob),Restrictions.eq("cust.altMob",cMob)));
    }
    if(dk!=null&&dk.matches("\\d{1,}")){
        c.add(Restrictions.or(Restrictions.eq("docketNo",dk),Restrictions.eq("serNo",dk)));
//        c.add();
    }
    
    List<Object[]> tod = sess.createQuery("select count(*),executed from DistSaleManager"
            + " where docketNo like '3%' and dist=:d and dt=CURDATE() group by executed")
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
    
    List<Object[]> mon = sess.createQuery("select count(*),executed from DistSaleManager where docketNo like '3%' and dist=:d and ( dt between :iDt and :fDt ) group by executed")
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
    Long ttlmoved = (Long)sess.createQuery("select count(*) from DistSaleManager where docketNo like '3%' and fromDist=:d and dist is not :d and ( dt between :iDt and :fDt )")
    .setParameter("iDt", curr[0])
    .setParameter("fDt", curr[1])
    .setParameter("d", dist).uniqueResult();
    if(ttlmoved!=null){
      tMoved=ttlmoved;   
    }

//                List<String> refrs=sess.createQuery("from DistSaleManager ").list();
                
                
%>
<div class="loginForm" style="max-width: 100%;">
    <!--<span class="close" onclick="toggleVisibility('refererForm');" style="right:30px;">Help</span>-->
    <!--<span class="close" onclick="toggleVisibility('ODRFmCont');" style="right:180px;">Hide/Show Form</span>-->
    <span class="fa fa-close close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolt8" >
        <div class="fullWidWithBGContainer bgcolef">
        <div class="d4 left">
            <p class="white pointer <%=(isA||LU!=null&&LU.getRoles().matches(".*\\(CComp\\).*")?"":"invisible")%>" onclick="popsl('df/newcompl.jsp')">
                <span class="button white"><i class="fa fa-plus-circle"></i> New Complaint</span></p>
        </div>
        <div class="d4 left leftAlText ">
            <p class="greenFont">Received Today: <%=te+tp%></p>
        </div>
        <div class="d4 left leftAlText">
            <p class="blkFnt">Executed Today: <%=te%></p>
        </div>
        <div class="d4 left leftAlText">
            <!--<p class="greenFont">Moved Today: </p>-->
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
            <select class="textField" name="r" >
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
            <!--<span class="button right fa fa-arrow-circle-right"></span><i class="right"></i>-->
            <input title="docket no to search" class="textField" type="text" placeholder="Docket No/Service No" name="dk"/><br>
            <input title="Mobile no to search" class="textField" type="text" placeholder="Customer Mob" name="cn"/><br>
            <input title="Start date" value="<%=UT.ie(iD)?"":iD%>" class="textField" type="date" name="iD"/><br>
            <input class="textField" value="<%=UT.ie(fD)?"":fD%>" title="End Date" type="date" name="fD"/><br><br>
            <span class="right" onclick="loadPg('df/complain.jsp?'+gfd('purFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
    </ul>
</div>
            <div style="margin-top: 10px;padding: 1px;border: 1px white solid;" class="bgcolef">
    <p class="nomargin nopadding white bgcolt8">Current Month Complaints</p><hr>
    <ul>
        <li  onclick="loadPageIn('linkLoader','df/r/saleKPI.jsp',false);" class="navLink leftAlText blkFnt" title="Compare performance">Performance Matrix<span class="right fa fa-angle-double-right"></span><i class="right">&nbsp;</i></li><hr>
        <li class="navLink leftAlText blkFnt" title="">Total Recd. Complaints<span class="right fa fa-angle-double-right"></span><i class="right"><%=tExe+tPend%> &nbsp</i></li><hr>
        <li class="navLink leftAlText blkFnt" title="">Executed Complaints<span class="right fa fa-angle-double-right"></span><i class="right"><%=tExe%> &nbsp;</i></li><hr>
        <li class="navLink leftAlText blkFnt" title="">Moved Complaints<span class="right fa fa-angle-double-right"></span><i class="right"><%=ttlmoved%> &nbsp;</i></li><hr> 
        <li class="navLink leftAlText blkFnt" title="">Pending Complaints<span class="right fa fa-angle-double-right"></span><i class="right"><%=tPend%> &nbsp;</i></li><hr> 
        
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
            <h2 class="nomargin nopadding white bgcolef" >Complaints</h2>
                <div>
                    <!--width="100%"-->
                    <table  cellpadding="2" cellspacing="0" border="1">
                        <tr align="center" id="oProds">
                            <th>SNo</th>
                            <th style="width: 50px;">Date</th><th>Docket</th>
                            <!--<th>Installed by</th><th>Ini KM</th><th>Fin KM</th>-->
                            <th>Ref by</th><th>Customer</th>
                            <!--<th>Apartment</th><th>Flat</th>-->
                            <!--<th >Address</th>-->
                            <th>Mob</th>
                            <!--<th>Alt Mob</th>-->
                            <th>Product</th><th>Qty</th><th>Rate</th><th>SC</th><th>Disc</th><th>Total</th><th>Adv</th><th>Bal</th>
                            <!--<th>Remark 1</th><th>Remark 2</th>-->
                            <th>By</th><th>SNo</th><th>To</th><th style="min-width: 150px">Action</th>
                        </tr>
            <%
                List<DistSaleManager> stk=c.list();
                int sr=0;
                for(DistSaleManager odr:stk){
                boolean isMvd=odr.getFromDist()!=null;
                sr++;
            %>
                        <tr align="center" id="row<%=odr.getSMId()%>">
                            <td><%=sr%></td>
                    <td style="width: 70px;"><%=new SimpleDateFormat("dd/MM/yy").format(odr.getDt())%></td>
                    <td style="width: 100px;" onclick="popsl('df/dockRec.jsp?d=<%=odr.getDocketNo()%>')"><span class="navLink greenFont"><%=odr.getDocketNo()%></span></td>
                    <td style="width: 100px;" onclick="popsl('df/refRec.jsp?r=<%=URLEncoder.encode(odr.getRefBy())%>')" title="<%=odr.getRefBy()%>"><span class="navLink bluFnt"><%=odr.getRefBy()%></span></td>
                    <td style="text-transform: capitalize" title="<%=odr.getAddress().getApt()+","+odr.getAddress().getFlat()+","+odr.getAddress().getAddr()%>"><%=odr.getCust().getName()%></td>
<!--                    <td style="width: 100px;text-transform: capitalize;min-width: 100px;"><%=odr.getCust().getAptName()%></td>
                    <td style="width: 50px;text-transform: capitalize;max-width: 50px;"><%=odr.getCust().getFlatno()%></td>-->
                    <!--<td style="width: 100px;text-transform: capitalize" title="<%=odr.getCust().getAptName()+","+odr.getCust().getFlatno()+","+odr.getCust().getAddress()%>"><%=odr.getCust().getAddress().length()>10?""+odr.getCust().getAddress().substring(0, 10)+"..":odr.getCust().getAddress()%></td>-->
                    <td style="width: 100px;max-width: 100px;" title="ALT Mob: <%=odr.getCust().getAltMob()%>"><%=odr.getCust().getMob()%></td>
                    <!--<td style="width: 100px;max-width: 100px;"><%=odr.getCust().getAltMob()%></td>-->
                    <!--<td><%=odr.getInstPerson()%></td>-->
                    <!--<td><%=odr.getiKm()+"KM"%></td>-->
                    <!--<td><%=odr.getfKm()+"KM"%></td>-->
<!--                    <td><%=odr.getSaleRecord()%></td>-->
                    <td style="min-width: 100px;"><%try{%><%=odr.getSaleRecord().iterator().next().getProd().getFPName()%><%}catch(Exception e){}%></td>
                    <td style="width: 50px;"><%try{%><%=odr.getSaleRecord().iterator().next().getQnt()%><%}catch(Exception e){}%></td>
                    <td style="width: 50px;"><%try{%><%=odr.getSaleRecord().iterator().next().getSoldAt()%><%}catch(Exception e){}%></td>
                    <td style="width: 80px;"><%=odr.getInstCharge()%></td>
                    <td style="width: 80px;"><%=odr.getDisc()%></td>
                    <td style="width: 50px;"><%=odr.getToPay()%></td>
                    <td style="width: 80px;"><%=odr.getAdvPayment()%></td>
                    <td style="width: 100px;" id="bal<%=odr.getSMId()%>"><%=odr.getBal()%></td>
                    <!--<td >&#8377;<%=odr.getInstCharge()%></td>-->
<!--                    <td style="width: 200px;"><%=odr.getRemark1()%></td>
                    <td style="width: 200px;"><%=odr.getRemark2()%></td>-->
                    <td style="width: 200px;"><%=odr.getThrough()%></td>
                    <td style="width: 200px;"><%=odr.getSerNo()%></td>
                    <td>
                    <%
                        if(isMvd){%>
                        <span title="Transferred"><%=odr.getDist().getDisId()%></span>
                        <%}else if((odr.getExeDate()!=null&&!odr.isExecuted())&&isA||(!isA&&LU.getRoles().matches(".*\\(TComp\\).*"))){
                    %>
                    <!--<select class="" style="max-width: 85px" id='odr<%=odr.getSMId()%>'><%=selSource%></select>-->
                    <!--<button class="right " onclick="sendDataForResp('FormManager','action=mvsale&dis='+$('#odr<%=odr.getSMId()%>').val()+'&oId=<%=odr.getSMId()%>',false)">Go</button>-->
                    <%}%>
                    </td>
                    <td style="min-width:150px" class="leftAlText" id="aptgt<%=odr.getSMId()%>">
                        <%if(odr.getDist()==dist&&(isA||(!isA&&LU.getRoles().matches(".*\\(UComp\\).*")))){%>
                        <button title='Edit' onclick="popsl('f/mod.jsp?o=<%=odr.getSMId()%>')" class="button fa fa-edit"></button>  
                        <%}
                            if(odr.getDist()==dist&&odr.isApproved()){
                                if(odr.isExecuted()){
                        %>
                            <span class='button fa fa-eye' onclick='loadPage("df/DSR.jsp?dkt=<%=odr.getDocketNo()%>");' title='Executed on <%=new SimpleDateFormat("dd.MM.yy").format(odr.getExeDate())%>, Click to view payment details in DSR'></span>
                            <%--<span class='button fa fa-user-circle' onclick='loadPage("df/DSR.jsp?dkt=<%=odr.getDocketNo()%>");' title='Click to send SMS to user'></span>--%>
                           <%if(odr.getInstCharge()==0||odr.getBal()!=0){%><span class='button fa fa-cc-mastercard' onclick='popsr("df/payBal.jsp?o=<%=odr.getSMId()%>")' title='Click to pay'></span><%}%>
                        <%}else{
                        if(isA||(!isA&&LU.getRoles().matches(".*\\((E|U)Comp\\).*"))){
                           if(!isMvd||(odr.getDist()==dist)){
                        %>
                            <button onclick="popsr('f/exedock.jsp?i=<%=odr.getSMId()%>&r=aptgt',false);" class="button fa fa-arrow-circle-right" title='click to Execute'></button>      
                        <%}}}
                        }if(odr.getDist()==dist){
                                if(!odr.isApproved()&&(isA||(!isA&&LU.getRoles().matches(".*\\(AComp\\).*")))){%>
                                    <button title='Approve' onclick="sendDataForResp('a','action=TUP&mod=DO&i=<%=odr.getSMId()%>&r=aptgt<%=odr.getSMId()%>',false);" class="button fa fa-thumbs-down"></button>  
                        <%}if(isA||(!isA&&LU.getRoles().matches(".*\\(DComp\\).*"))){%>
                                <%--<button title='Delete' onclick="showDial('action=del&mod=DO&i=<%=odr.getSMId()%>&r=row<%=odr.getSMId()%>','del','Do you really want to delete??','It\'ll affect stock and finance');" class="button fa fa-trash"></button>--%>  
                        <%}}%>
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