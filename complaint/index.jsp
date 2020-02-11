
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
        if(!UT.ia(role, "15")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
            return;
        }
    
//        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
        sess.refresh(role);
        Date nw=new Date();
        Date[] curr=Utils.gCMon(nw);
        String m=request.getParameter("r"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),br=request.getParameter("d");
        Criteria c=sess.createCriteria(DistSaleManager.class).add(Restrictions.like("docketNo", "3%")).addOrder(Order.desc("dt"));
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

//        Transaction tr = sess.beginTransaction();
        
//        List<Object[]> todays = sess.createQuery("select sum(credit),sum(debit) from DistFinance where dist=:d and txnDate=CURDATE()").setParameter("d", dist).list();
//        double tCr=0,tDr=0;
//        if(!todays.isEmpty()){
//            Object[] tt=todays.get(0);
//            tCr=new Double((tt[0]!=null)?""+tt[0]:"0");
//            tDr=new Double((tt[1]!=null)?""+tt[1]:"0");
//        }
        
        double mCr=0,mDr=0;
//        todays = sess.createQuery("select sum(credit),sum(debit) from DistFinance where dist=:d and ( txnDate between :iDt and :fDt )")
//        .setParameter("iDt", curr[0])
//        .setParameter("fDt", curr[1])
//        .setParameter("d", dist).list();
//        if(!todays.isEmpty()){
//            Object[] tt=todays.get(0);
//            mCr=new Double((tt[0]!=null)?""+tt[0]:"0");
//            mDr=new Double((tt[1]!=null)?""+tt[1]:"0");
//        }
        double OCr=0; 
//        todays = sess.createQuery("select sum(credit) from DistFinance where dist=:d and docketNo like '2%' and ( txnDate between :iDt and :fDt )")
//        .setParameter("iDt", curr[0])
//        .setParameter("fDt", curr[1])
//        .setParameter("d", dist).list();
//        if(!todays.isEmpty()){
//            Object tt=todays.get(0);
//            OCr=new Double((tt!=null)?""+tt:"0");
//        }
        double CCr=0; 
//        todays = sess.createQuery("select sum(credit) from DistFinance where dist=:d and docketNo like '3%' and ( txnDate between :iDt and :fDt )")
//        .setParameter("iDt", curr[0])
//        .setParameter("fDt", curr[1])
//        .setParameter("d", dist).list();
//        if(!todays.isEmpty()){
//            Object tt=todays.get(0);
//            CCr=new Double((tt!=null)?""+tt:"0");
//        }
        double 
//                tBal=0,
                tTP=0,tPaid=0; 
//        todays = sess.createQuery("select sum(toPay-disc),sum(paid+instCharge) from"
//        + " DistSaleManager where dist=:d and docketNo like '2%' and ( dt between :iDt and :fDt )")
//        .setParameter("iDt", curr[0])
//        .setParameter("fDt", curr[1])
//        .setParameter("d", dist).list();
//        if(!todays.isEmpty()){
//            Object[] tt=todays.get(0);
////            tBal=new Double((tt[0]!=null)?""+tt[0]:"0");
//            tTP=new Double((tt[0]!=null)?""+tt[0]:"0");
//            tPaid=new Double((tt[1]!=null)?""+tt[1]:"0");
//        }
        double tCBal=0,tCTP=0,tCPaid=0; 
//        todays = sess.createQuery("select sum(bal),sum(toPay),sum(paid+instCharge) from"
//        + " DistSaleManager where dist=:d and docketNo like '3%' and ( dt between :iDt and :fDt )")
//        .setParameter("iDt", curr[0])
//        .setParameter("fDt", curr[1])
//        .setParameter("d", dist).list();
//        if(!todays.isEmpty()){
//            Object[] tt=todays.get(0);
//            tCBal=new Double((tt[0]!=null)?""+tt[0]:"0");
//            tCTP=new Double((tt[1]!=null)?""+tt[1]:"0");
//            tCPaid=new Double((tt[2]!=null)?""+tt[2]:"0");
//        }
        double tRBal=0,tRTP=0,tRPaid=0; 
//        todays = sess.createQuery("select sum(totalpayment-paid-discount),sum(totalPayment),sum(paid) from"
//        + " DistOrderManager where distributor=:d and ( orderDate between :iDt and :fDt )")
//        .setParameter("iDt", curr[0])
//        .setParameter("fDt", curr[1])
//        .setParameter("d", dist).list();
//        if(!todays.isEmpty()){
//            Object[] tt=todays.get(0);
//            tRBal=new Double((tt[0]!=null)?""+tt[0]:"0");
//            tRTP=new Double((tt[1]!=null)?""+tt[1]:"0");
//            tRPaid=new Double((tt[2]!=null)?""+tt[2]:"0");
//        }
//        List<DistFinance> list = sess.createCriteria(DistFinance.class).add(Restrictions.eq("dist", dist)).addOrder(Order.desc("txnDate")).list();
//        Transaction tr = sess.beginTransaction();
%>    
<div class="loginForm" style="max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">   
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\(C15\\).*)")?"":"invisible"%>" onclick="popsl('complaint/newcomp.jsp')" >
                <span class="button white"><i class="fa fa-plus-circle"></i> New Complaint</span></p>
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
            <i class="fa btn fa-arrow-circle-left fa-2x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<!--            <span class="white"><h2 class="nomargin nopadding">Finance Record</h2></span><hr>-->
<div style="">
    <p class="nomargin p-15 white bgcolt8  bold">Month: <%=Utils.getWMon.format(new Date())%> </p><hr>
    <ul>
        <li title="Filters" class="bgcolef">
            <br>
            <form id="purFil" name="purFil">
                <select title="For branch" class="textField" name="d"><option value="">Select Sale Center</option>
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
            <!--<span class="button right fa fa-arrow-circle-right"></span><i class="right"></i>-->
            <input title="Start date" value="<%=UT.ie(iD)?"":iD%>" class="textField" type="date" name="iD"/><br>
            <input class="textField" value="<%=UT.ie(fD)?"":fD%>" title="End Date" type="date" name="fD"/><br><br>
            <span class="right" onclick="loadPg('complaint/index.jsp?'+gfd('purFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
    </ul>
</div>
<!--<div style="">
    <p class="nomargin nopadding white">Month:Nov </p><hr>
    <ul>
        <li class="navLink leftAlText">Executed <span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Approved<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Recd from Complaints<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Recd from Orders<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Paid for Purchase<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Receivable Pending<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Payable Pending<span class="right fa fa-angle-double-right"></span></li>
    </ul>-->
<!--</div>-->
        <br>
        </div>
        <div class="right sbnvLdr lShadow" >
              <!--<span class="white"><h2 class="nomargin nopadding">Complaints</h2></span>-->
              <hr>
              <table id="header-fixed" border="1px" cellpadding="2" style="margin:0px;" width="100%">
            </table>
      
            <div class="scrollable" >
                <form id="importMaterial" onsubmit="return false;">
      <table style="margin:0px" id="mainTable" width="100%" border='1px' cellpadding="2" >
          <thead>
        <tr align="center" id="oProds">
                            <th>SNo</th>
                            <th style="width: 50px;">Date</th><th>Docket</th>
                            <!--<th>Installed by</th><th>Ini KM</th><th>Fin KM</th>-->
                            <th>Ref by</th><th>Customer</th>
                            <!--<th>Apartment</th><th>Flat</th>-->
                            <!--<th >Address</th>-->
                            <th>Mob</th>
                            <!--<th>Alt Mob</th>-->
                            <th>Product</th><th>Qty</th><th>Rate</th><th>Disc</th><th>Total</th><th>Adv</th><th>ServCh</th><th>Bal</th>
                            <!--<th>Remark 1</th><th>Remark 2</th>-->
                            <th>By</th><th>SNo</th><th>From</th><th>Seller</th><th style="min-width: 130px;">Action</th></tr>
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
            int count=0;
            for(DistSaleManager odr:stk){
                count++;
//                if(refArr.indexOf("'"+odr.getRefBy().toLowerCase()+"'")<0)
//                refArr.append("'"+odr.getRefBy().replaceAll("'", "&apos;").toLowerCase()+"',");
            Iterator<SaleInfo> si=odr.getSaleRecord().iterator();
            SaleInfo s=null;
            if(si.hasNext()){
                s=si.next();
            }
            %>
            <tr align="center" id="row<%=odr.getSMId()%>">
                    <td><%=count%></td>
                    <td><%=new SimpleDateFormat("dd/MM/yy").format(odr.getDt())%></td>
                    <td onclick="popsl('dockets/dockRec.jsp?d=<%=odr.getDocketNo()%>')"><span class="navLink greenFont"><%=odr.getDocketNo()%></span></td>
                    <td <%=role.getRole().matches("(Global)|.*\\(V15\\).*")?"onclick=\"popsl('af/refRec.jsp?r="+URLEncoder.encode(odr.getRefBy())+"')":""%> title="<%=odr.getRefBy()%>"><span class="navLink bluFnt"><%=odr.getRefBy()%></span></td>
                    <td style="text-transform: capitalize" title="<%=odr.getAddress().getApt()+","+odr.getAddress().getFlat()+","+odr.getAddress().getAddr()%>"><%=odr.getCust().getName()%></td>
<!--                    <td style="width: 100px;text-transform: capitalize;min-width: 100px;"><%=odr.getCust().getAptName()%></td>
                    <td style="width: 50px;text-transform: capitalize;max-width: 50px;"><%=odr.getCust().getFlatno()%></td>-->
                    <!--<td style="width: 100px;text-transform: capitalize" title="<%=odr.getCust().getAptName()+","+odr.getCust().getFlatno()+","+odr.getCust().getAddress()%>"><%=odr.getCust().getAddress().length()>10?""+odr.getCust().getAddress().substring(0, 10)+"..":odr.getCust().getAddress()%></td>-->
                    <td style="" title="ALT Mob: <%=odr.getCust().getAltMob()%>"><%=odr.getCust().getMob()%></td>
                    <!--<td style="width: 100px;max-width: 100px;"><%=odr.getCust().getAltMob()%></td>-->
                    <!--<td><%=odr.getInstPerson()%></td>-->
                    <!--<td><%=odr.getiKm()+"KM"%></td>-->
                    <!--<td><%=odr.getfKm()+"KM"%></td>-->
<!--                    <td><%=odr.getSaleRecord()%></td>-->
                    <td style=""><%try{%><%=s!=null?s.getProd().getFPName():""%><%}catch(Exception e){}%></td>
                    <td style=""><%try{%><%=s!=null?s.getQnt():""%><%}catch(Exception e){}%></td>
                    <td style=""><%try{%><%=s!=null?s.getSoldAt():""%><%}catch(Exception e){}%></td>
                    <td style=""><%=odr.getDisc()%></td>
                    <td style=""><%=odr.getToPay()%></td>
                    <td style=""><%=odr.getAdvPayment()%></td>
                   <td style=""><%=odr.getInstCharge()%></td>
                   <td style=""><%=odr.getBal()%></td>
                    <!--<td >&#8377;<%=odr.getInstCharge()%></td>-->
<!--                    <td style="width: 200px;"><%=odr.getRemark1()%></td>
                    <td style="width: 200px;"><%=odr.getRemark2()%></td>-->
                    <td style=""><%=odr.getThrough()%></td>
                    <td style=""><%=odr.getSerNo()%></td>
                    <td>
                        <%if(!odr.isExecuted()&&odr.getFromDist()==null&&role.getRole().matches("(.*Global.*)|(.*\\(U15\\).*)")){%>
                            <select style="max-width: 85px" id='odr<%=odr.getSMId()%>'><%=selSource%></select>
                            <button onclick="sendDataForResp('FormManager','action=mvsale&dis='+$('#odr<%=odr.getSMId()%>').val()+'&oId=<%=odr.getSMId()%>',false)">Go</button>
                        <%}else if(odr.isExecuted()&&role.getRole().matches("(.*Global.*)|(.*\\((U|V)15\\).*)")){%>
                            <span title="Executed" class="greenFont fa fa-check-circle-o"> <%=odr.getDist().getDisId()%></span>
                        <%}else if(odr.getFromDist()!=null&&role.getRole().matches("(.*Global.*)|(.*\\((U|V)15\\).*)")){%>
                            <span title="Transferred" class="redFont fa fa-check-circle-o"> <%=odr.getFromDist().getDisId()%></span>
                        <%}%>
                    </td>
                    <td><%=odr.getDist().getDisId()%></td>
                    <td style="min-width: 130px;">
                    <%
                    if(odr.isApproved()&&!odr.isExecuted()&&role.getRole().matches("(.*Global.*)|(.*\\(U15\\).*)")){%>
                        <input type="date" id="dt<%=odr.getSMId()%>" />
                        <button onclick="sendDataForResp('FormManager','action=executed&dt='+$('#dt<%=odr.getSMId()%>').val()+'&i=<%=odr.getSMId()%>',false);" class="right button fa fa-arrow-right" title='click to Execute'></button>
                    <%}else if(!odr.isApproved()&&role.getRole().matches("(.*Global.*)|(.*\\(A15\\).*)")){%>
                        <button title='Approve' onclick="sendDataForResp('FormManager','action=TUP&mod=DO&i=<%=odr.getSMId()%>',false);" class="button fa fa-thumbs-up redFont"></button>  
                        <%}else if(role.getRole().matches("(Global)|.*\\(U15\\).*")&&(odr.getBal()>0||odr.getInstCharge()==0)){%>
                        <button title='Pay Balance' onclick='popsr("af/payBal.jsp?o=<%=odr.getSMId()%>")' class="button fa fa-credit-card"></button>  
                    <%}if(role.getRole().matches("(.*Global.*)|(.*\\(U15\\).*)")){%>
                    <button title='Edit' onclick="popsl('f/mod.jsp?o=<%=odr.getSMId()%>')" class="button fa fa-edit"></button>  
                    <%}if(role.getRole().matches("(.*Global.*)|(.*\\(D15\\).*)")){%>
                    <button title='Delete' onclick="showDial('action=del&mod=DO&i=<%=odr.getSMId()%>&r=row<%=odr.getSMId()%>','del','Do you really want to delete??','It\'ll affect stock and finance');" class="button fa fa-trash"></button>  
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
            </tr>
            <%}}%>
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
<%
sess.close();
%>