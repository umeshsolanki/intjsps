<%@page import="utils.UT"%>
<%@page import="entities.DistOrderManager"%>
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
//        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
        sess.refresh(role);
        Date nw=new Date();
        Date[] curr=Utils.gCMon(nw);
        String m=request.getParameter("r"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),s=request.getParameter("s");
        Criteria c=sess.createCriteria(DistOrderManager.class).addOrder(Order.desc("orderId"));
        if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
            c.add(Restrictions.between("orderDate", Utils.DbFmt.parse(iD), Utils.DbFmt.parse(fD)));
        }else{
               c.add(Restrictions.between("orderDate", curr[0],curr[1]));
        }
        if(s!=null&&s.matches(".{2,}")){
            c.add(Restrictions.eq("distributor.disId",s));
        }
//        if(m!=null&&m.matches("00R-.+")){
//            c.add(Restrictions.eq("refBy",m.replaceFirst("00R-", "")));
//        }
//            setFirstResult(ini).setMaxResults(20).
            
        List<DistOrderManager> orders=c.list();

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
<div class="boxPcMinHeight" style="max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="clrRSP();"></span>
    <div class="fullWidWithBGContainer">
        <div class="leftAlText ">
            <select title="Selected seller's Requistion only" onchange="popsr('f/requisitionfin.jsp?s='+this.value)" class="textField npdn nmgn"  name="s">
                <option value="">Select Seller</option>
                <%
                List<DistributorInfo> b=sess.createCriteria(DistributorInfo.class).add(Restrictions.eq("deleted", false)).add(Restrictions.ne("type", "User")).add(Restrictions.ne("type", "Referer")).list();
                
                for(DistributorInfo brr:b){
                %>
                <option value="<%=brr.getDisId()%>"><%=brr.getDisId()%></option>
                <%}%>
            </select>
        </div>
    </div>
    <div class="fullWidWithBGContainer">
        <div >
              <span class="white"><h2 class="nomargin nopadding centAlText">Requisitions</h2></span><hr>
            <div class="scrollable" >
            <table width="100%" border="1px" cellspacing='0' cellpadding='2'>
                <tr align="left"><th>Date</th><th>Seller</th><th>Docket</th>
                    <!--<th>StockReleased</th>-->
                    <!--<th>FinApproval</th>-->
                    <!--<th>SKUApproval</th>-->
                    <th>StockStatus</th><th>FinStatus</th><th>Amount</th><th>Discount</th><th>Paid</th><th>Bal</th><th style="min-width: 110px;">Action</th>
                </tr>
                <%
//            out.print(orders.size());
            for(DistOrderManager odr:orders){
            %>
            <tr id="req<%=odr.getOrderId()%>"<% if((odr.getTotalPayment()-odr.getDiscount()-odr.getPaid())>0&&!odr.getFstatus().equals(DistOrderManager.FinStatus.Closed))out.print("style='color:red;'");else if((odr.getTotalPayment()-odr.getDiscount()-odr.getPaid())==0&&odr.getFstatus().equals(DistOrderManager.FinStatus.Closed))out.print("style='color:green;'");%>>
                    <td><%=odr.getOrderDate()%></td>
                    <td><%=odr.getDistributor().getDisId()+", "+odr.getDistributor().getType()%></td>
                    <td><%=odr.getDocketNo()%></td>
                    <!--<td><span class='fa fa-check <%=odr.isStockUpdated()?"greenFont":"redFont"%>'/></td>-->
                    <!--<td><span class='fa fa-check <%=odr.isFinApp()?"greenFont":"redFont"%>'/></td>-->
                    <!--<td><span class='fa fa-check <%=odr.isDisApp()?"greenFont":"redFont"%>'/></td>-->
                    <td><%=odr.getDstatus().equals(DistOrderManager.DisStatus.Delivered)?"<span class='fa fa-check-circle greenFont'> Delivered</span>":"<span class='fa fa-check-circle redFont'> "+odr.getDstatus()+"</span>"%></td>
                    <td><%=odr.getFstatus()%></td>
                    <td>&#8377;<%=odr.getTotalPayment()%></td>
                    <td>&#8377;<%=odr.getDiscount()%></td>
                    <td>&#8377;<%=odr.getPaid()%></td>
                    <td>&#8377;<%=odr.getTotalPayment()-odr.getDiscount()-odr.getPaid()%></td>
                    <td >
                    <button onclick="popsr('f/payreq.jsp?action=viewDetails&oId=<%=odr.getOrderId()%>',false)"class="button fa <%=odr.isSeen()?"fa-credit-card ":"fa-eye"%>" title="View"></button>
                    <%if(role.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_ReqA+".*)")){%>
                    <%if(!odr.isDeleted()&&!odr.isSeen()){%>
                        <button title="Approve" onclick="sendDataForResp('FormManager','action=TUP&mod=DReq&i=<%=odr.getOrderId()%>&who=PERM',false);" class="button fa fa-thumbs-up"></button>
                    <%}if(odr.isSeen()){%>
                        <button title="Approved" class="button fa fa-check greenFont"></button>
                    <%}}%>
                    <%if(role.getRole().matches("(.*Global.*)")){%>
                      <button title="Delete Requisition" class="<%=odr.isDeleted()?"redFont":"greenFont"%> button fa fa-trash" id="deleteBtn" onclick="dm('DReq','<%=odr.getOrderId()%>','req<%=odr.getOrderId()%>');"></button>
                      <%}%>
                    </td>
                </tr>
            <%
            }
            %>
            </table>
            </div>
          </div>
        </div>
</div>
            <style>
                .popSMRt{
                    box-shadow: #000 0px 0px 12px 2px;
                }
            </style>
<%
sess.close();
%>