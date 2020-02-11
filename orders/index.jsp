<%@page import="utils.UT"%>
<%@page import="java.util.Iterator"%>
<%@page import="entities.SaleInfo"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entities.DistSaleManager"%>
<%@page import="org.hibernate.Query"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="entities.InwardManager"%>
<%@page import="entities.Material"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.DistFinance"%>
<%@page import="entities.Admins"%>
<%@page import="entities.FinanceRequest"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        Admins role=(Admins)session.getAttribute("role");
        if(!UT.ia(role, "6")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
            return;
        }
    
//        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
        sess.refresh(role);
        Date nw=new Date();
        Date[] curr=Utils.gCMon(nw);
        String m=request.getParameter("r"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),br=request.getParameter("d");
        Criteria c=sess.createCriteria(DistSaleManager.class).add(Restrictions.like("docketNo", "2%")).addOrder(Order.desc("dt"));
        if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
            c.add(Restrictions.between("dt", Utils.DbFmt.parse(iD), Utils.DbFmt.parse(fD)));
        }else if(iD!=null&&iD.matches(".{10}")){
            c.add(Restrictions.eq("dt", Utils.DbFmt.parse(iD)));       
        }else{
               c.add(Restrictions.between("dt", curr[0],curr[1]));
        }
        if(br!=null&&br.matches(".{2,}")){
            c.add(Restrictions.eq("dist.disId",br));
        }
        if(m!=null&&m.matches("00R-.+")){
            c.add(Restrictions.eq("refBy",m.replaceFirst("00R-", "")));
        }
//            setFirstResult(ini).setMaxResults(20).
            
        List<InwardManager> prods=c.list();
        double ttlPrice=0,ttlBal=0;
%>    
<div class="loginForm" style="max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">   
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\(C6\\).*)")?"":"invisible"%>" onclick="popsl('orders/newodr.jsp')">
                <span class="button white"><i class="fa fa-plus-circle"></i> New Order</span></p>
        </div>
        <div class="d3 left leftAlText ">
            <p class="greenFont"><%=iD!=null?"from "+iD:"from "+Utils.HRFmt.format(curr[0])%></p>
        </div>
        <div class="d3 left leftAlText">
            <p class="redFont"><%=iD!=null?"to "+fD:"to "+Utils.HRFmt.format(curr[1])%></p>
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left rShadow" style="">
            <i class="fa spdn fa-arrow-circle-left fa-1pt25x right white" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<!--            <span class="white"><h2 class="nomargin nopadding">Finance Record</h2></span><hr>-->
<div style="">
    <p class="nomargin white spdn bgcolt8">Month: <%=Utils.getWMon.format(new Date())%> </p><hr>
    <ul>
        <li title="Filters" class="bgcolef">
            <br>
            <form id="purFil" name="purFil">
                <select  title="For branch" class="textField" name="d"><option value="">Select Sale Center</option>
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
                    <%}%>
            </select><br>
            <input title="Start date" value="<%=UT.ie(iD)?Utils.DbFmt.format(curr[0]):iD%>" class="textField" type="date" name="iD"/><br>
            <input class="textField" value="<%=UT.ie(fD)?Utils.DbFmt.format(curr[1]):fD%>" title="End Date" type="date" name="fD"/><br><br>
            <span class="right" onclick="loadPg('orders/index.jsp?'+gfd('purFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
    </ul>
</div>
    <br>
    <div class=>
        <p class="nomargin white spdn bgcolt8">Report </p><hr>
        <ul>
            <li class="navLink leftAlText" title="Change date to get specific time report" onclick="loadPageIn('linkLoader','report/saleSellerWise.jsp?'+gfd('purFil'))">Seller Wise<span class="right fa fa-angle-double-right"></span></li><hr>
            <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','report/saleProductWise.jsp?'+gfd('purFil'))">Product Wise<span class="right fa fa-angle-double-right"></span></li><hr>
        </ul>
        <br>
        <br>
    </div>
        <br>
    </div>
        <div class="right sbnvLdr lShadow" id="linkLoader">
    <hr>
    <table id="header-fixed" border="1px" cellpadding="2" style="margin:0px;" width="100%">
    </table>
    <div class="scrollable" >
    <form id="importMaterial" onsubmit="return false;">
      <table style="margin:0px" id="mainTable" width="100%" border='1px' cellpadding="2" >
          <thead>
            <tr align="center" id="oProds">
                <th>SNo</th>
            <th> <i onclick="sortTable('mainTable',0)" class="fa fa-exchange fa-rotate-90"></i> Date</th>
            <th> <i onclick="sortTable('mainTable',1)" class="fa fa-exchange fa-rotate-90"></i> Docket</th>
            <!--<th>Installed by</th><th>Ini KM</th><th>Fin KM</th>-->
            <th> <i onclick="sortTable('mainTable',2)" class="fa fa-exchange fa-rotate-90"></i> Ref by</th>
            <th> <i onclick="sortTable('mainTable',3)" class="fa fa-exchange fa-rotate-90"></i> Customer</th>
            <!--<th>Apartment</th><th>Flat</th>-->
            <!--<th >Address</th>-->
            <th>Mob</th>
            <!--<th>Alt Mob</th>-->
            <th>Product</th><th>Qty</th><th>Rate</th><th>Disc</th><th>Total</th><th>Adv</th><th>ServCh</th><th>Bal</th>
            <!--<th>Remark 1</th><th>Remark 2</th>-->
            <th>By</th><th> <i onclick="sortTable('mainTable',13)" class="fa fa-exchange fa-rotate-90"></i> SNo</th><th>From</th><th>Seller</th><th style="min-width: 130px;">Action</th></tr>
        </thead>
        <tbody id="dataCont">
               <%
            List<DistributorInfo> dists=sess.createCriteria(DistributorInfo.class).list();
            String selSource="<option>Transfer to</option>";
            for(DistributorInfo d:dists){
                if(!d.getType().matches("(.*Referer.*)|(.*User.*)")&&!d.isDeleted()){
                    selSource+="<option>"+d.getDisId()+"</option>";
                }
            }
//            Query q=sess.createQuery("from DistSaleManager where  docketNo like '2%'");
//                if(ini>-1){
//                    q.setMaxResults(20).setFirstResult(ini);
//                }
                List<DistSaleManager> stk=c.list();
//                StringBuilder refArr=new StringBuilder();
//                refArr.append("[");
            double ttlSCExp=0,ttlSCCol=0,ttlToPay=0,ttlDisc=0;
            int count=0;
            for(DistSaleManager odr:stk){
                count++;
                ttlPrice+=odr.getPaid();
                ttlToPay+=odr.getToPay();
                ttlBal+=odr.getBal();
                ttlSCExp+=odr.getScExp();
                ttlSCCol+=odr.getInstCharge();
                ttlDisc+=odr.getDisc();
                
            Iterator<SaleInfo> si=odr.getSaleRecord().iterator();
            SaleInfo s=null;
            if(si.hasNext())
                s=si.next();
            %>
            <tr align="center" id="row<%=odr.getSMId()%>">
                    <td><%=count%></td>
                    <td ><%=new SimpleDateFormat("dd/MM/yy").format(odr.getDt())%></td>
                    <td onclick="popsl('dockets/dockRec.jsp?d=<%=odr.getDocketNo()%>')"><span class="navLink greenFont"><%=odr.getDocketNo()%></span></td>
                    <td  <%=role.getRole().matches("(Global)|.*\\(V6\\).*")?"onclick=\"popsl('af/refRec.jsp?r="+URLEncoder.encode(odr.getRefBy())+"')":""%> title="<%=odr.getRefBy()%>"><span class="navLink bluFnt"><%=odr.getRefBy()%></span></td>
                    <td style="text-transform: capitalize" title="<%=odr.getAddress().getApt()+","+odr.getAddress().getFlat()+","+odr.getAddress().getAddr()%>"><%=odr.getCust().getName()%></td>
<!--                    <td style="width: 100px;text-transform: capitalize;min-width: 100px;"><%=odr.getCust().getAptName()%></td>
                    <td style="width: 50px;text-transform: capitalize;max-width: 50px;"><%=odr.getCust().getFlatno()%></td>-->
                    <!--<td style="text-transform: capitalize" title="<%=odr.getAddress().getApt()+","+odr.getAddress().getFlat()+","+odr.getAddress().getAddr()%>"><%=odr.getCust().getName()%></td>-->
                    <td title="ALT Mob: <%=odr.getCust().getAltMob()%>"><%=odr.getCust().getMob()%></td>
                    <!--<td style="width: 100px;max-width: 100px;"><%=odr.getCust().getAltMob()%></td>-->
                    <!--<td><%=odr.getInstPerson()%></td>-->
                    <!--<td><%=odr.getiKm()+"KM"%></td>-->
                    <!--<td><%=odr.getfKm()+"KM"%></td>-->
<!--                    <td><%=odr.getSaleRecord()%></td>-->
                    <td><%try{%><%=s.getProd().getFPName()%><%}catch(Exception e){}%></td>
                    <td><%try{%><%=s.getQnt()%><%}catch(Exception e){}%></td>
                    <td><%try{%><%=s.getSoldAt()%><%}catch(Exception e){}%></td>
                    <td ><%=odr.getDisc()%></td>
                    <td ><%=odr.getToPay()%></td>
                    <td ><%=odr.getAdvPayment()%></td>
                    <td ><%=odr.getInstCharge()%></td>
                    <td id="bal<%=odr.getSMId()%>"><%=odr.getBal()%></td>
                    <!--<td >&#8377;<%=odr.getInstCharge()%></td>-->
<!--                    <td style="width: 200px;"><%=odr.getRemark1()%></td>
                    <td style="width: 200px;"><%=odr.getRemark2()%></td>-->
                    <td><%=odr.getThrough()%></td>
                    <td><%=odr.getSerNo()%></td>
                    <td>
                        <%if(!odr.isExecuted()&&odr.getFromDist()==null&&role.getRole().matches("(.*Global.*)|(.*\\(U6\\).*)")){%>
                            <select style="max-width: 85px" id='odr<%=odr.getSMId()%>'><%=selSource%></select>
                            <button onclick="sendDataForResp('FormManager','action=mvsale&dis='+$('#odr<%=odr.getSMId()%>').val()+'&oId=<%=odr.getSMId()%>',false)">Go</button>
                        <%}else if(odr.isExecuted()&&role.getRole().matches("(.*Global.*)|(.*\\((V|U)6\\).*)")){%>
                            <span title="Executed" class="greenFont fa fa-check-circle-o"> <%=odr.getDist().getDisId()%></span>
                        <%}else if(odr.getFromDist()!=null&&role.getRole().matches("(.*Global.*)|(.*\\((V|U)6\\).*)")){%>
                            <span title="Transferred" class="redFont fa fa-check-circle-o"> <%=odr.getFromDist().getDisId()%></span>
                        <%}%>
                    </td>
                    <td ><%=odr.getDist().getDisId()%></td>
                    <td style="min-width: 130px;" id="aptgt<%=odr.getSMId()%>">
                    <%
                    if(odr.isApproved()&&!odr.isExecuted()&&role.getRole().matches("(.*Global.*)|(.*\\((V|U)6\\).*)")){%>
                        <button onclick="popsr('f/exedock.jsp?i=<%=odr.getSMId()%>&r=aptgt',false);" class="button fa fa-arrow-circle-right" title='click to Execute'></button>      
                    <%}else if(!odr.isApproved()&&role.getRole().matches("(.*Global.*)|(.*\\(A6\\).*)")){
                    %>
                        <button title='Click to Approve' onclick="sendDataForResp('FormManager','action=TUP&mod=DO&i=<%=odr.getSMId()%>',false);" class="button fa fa-thumbs-up redFont"></button>  
                    <%}else if((odr.getBal()>0||odr.getInstCharge()==0)&&role.getRole().matches("(.*Global.*)|(.*\\(U6\\).*)")){%>
                        <button title='Pay Balance' onclick='popsr("af/payBal.jsp?o=<%=odr.getSMId()%>")' class="button fa fa-credit-card"></button>  
                    <%}if(role.getRole().matches("(.*Global.*)|(.*\\(U6\\).*)")){%>
                    <button title='Edit' onclick="popsl('f/mod.jsp?o=<%=odr.getSMId()%>')" class="button fa fa-edit"></button>  
                    <%}if(role.getRole().matches("(.*Global.*)|(.*\\(D6\\).*)")){%>
                    <button title='Delete' onclick="showDial('action=del&mod=DO&i=<%=odr.getSMId()%>&r=row<%=odr.getSMId()%>','del','Do you really want to delete??','It\'ll affect stock and finance');" class="button fa fa-trash"></button>  
                    <%}
                     if(role.getRole().matches("(.*Global.*)|(.*\\(U6\\).*)")&&odr.getPaid()>0){%>
                    <button title='Delete' onclick="sendDataForResp('FM','action=fin&i=<%=odr.getSMId()%>',false);" class="button fa fa-reorder"></button>  
                    <%}%>
                    </td>
                </tr>
            <%
            while(si.hasNext()){
                s=si.next();%>
                <tr align="center">
                <td></td><td></td><td></td><td></td><td></td>    
                <!--<td></td><td></td>-->
                <!--<td></td><td></td>-->
                    <td><%=s.getProd().getFPName()%></td>
                    <td><%=s.getQnt()%></td>
                    <td><%=s.getSoldAt()%></td>
                    <!--<td><%=s.getSoldAt()%></td><td><%=s.getQnt()*s.getSoldAt()%></td>-->
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td>
                    <!--<td></td>-->
                </tr>
            <%}}%>
            <tr align="center">
                <td><b>Total</b></td><td></td><td></td><td></td><td></td>    
                <td></td>
                <td></td>
                <td></td>
                <td><b>&#8377;<%=ttlDisc%></b></td><td><b>&#8377;<%=ttlToPay%></b></td><td></td><td></td><td><b>&#8377;<%=ttlBal%></b></td><td></td><td></td><td></td><td></td>
                <td></td><td></td>
            </tr>
        </tbody>
    </table>
        <script>
        copyHdr("mainTable","header-fixed");
        </script>
    </form>
            </div>
          </div>
        </div>
</div>
<script>
    
</script>
<%
sess.close();
%>