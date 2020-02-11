<%@page import="entities.OrdersBackup"%>
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
        if(!UT.ia(role, "25")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
            return;
        }
    
//        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
        sess.refresh(role);
        Date nw=new Date();
        Date[] curr=Utils.gCMon(nw);
        String m=request.getParameter("r"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),br=request.getParameter("d");
        Criteria c=sess.createCriteria(OrdersBackup.class).addOrder(Order.desc("bookedOn"));
        if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
            c.add(Restrictions.between("bookedOn", Utils.DbFmt.parse(iD), Utils.DbFmt.parse(fD)));
        }else if(iD!=null&&iD.matches(".{10}")){
            c.add(Restrictions.eq("bookedOn", Utils.DbFmt.parse(iD)));       
        }else{
               c.add(Restrictions.between("bookedOn", curr[0],curr[1]));
        }
        if(br!=null&&br.matches(".{2,}")){
            c.add(Restrictions.eq("dist.disId",br));
        }
        if(m!=null&&m.matches("00R-.+")){
            c.add(Restrictions.eq("referrer",m.replaceFirst("00R-", "")));
        }
//            setFirstResult(ini).setMaxResults(20).
            
        List<InwardManager> prods=c.list();
        double ttlPrice=0,ttlBal=0;
%>    
<div class="loginForm" style="max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">   
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\(C6\\).*)")?"":"invisible"%>" onclick="popsl('af/newodr.jsp')">
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
            <span class="right" onclick="loadPg('af/ordersBackup.jsp?'+gfd('purFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
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
                <th>SNo</th><th>Date</th><th>Docket</th><th>Ref by</th>
                <th>Customer</th><th>Mob</th><th>Product</th><th>Qty</th><th>Address</th>
                <th>Payment</th><th>Inst By</th>
            </tr>
        </thead>
        <tbody id="dataCont">
            <%
            List<OrdersBackup> stk=c.list();
            int count=0;
            for(OrdersBackup odr:stk){
            count++;
            %>
            <tr align="center" id="row">
                    <td><%=count%></td>
                    <td ><%=new SimpleDateFormat("dd/MM/yy").format(odr.getBookedOn())%></td>
                    <td><%=odr.getDockNo()%></td>
                    <td><%=odr.getReferrer()%></td>
                    <td style="text-transform: capitalize" title="<%=""+odr.getAddress()%>"><%=odr.getCustName()%></td>
                    <td title="ALT Mob: <%=odr.getAltMob()%>"><%=odr.getMob()%></td>
                    <td><%=odr.getProducts()%></td>
                    <td ><%=odr.getQnt()%></td>
                    <td ><%=odr.getAddress()%></td>
                    <td><%=odr.getPayment()%></td>
                    <td><%=odr.getInstBy()%></td>
            </tr>
            <%}%>
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