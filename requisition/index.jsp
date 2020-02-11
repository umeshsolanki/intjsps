<%@page import="entities.OrderInfo"%>
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
        if(!UT.ia(role, "4")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
        return;
        }
//        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
        sess.refresh(role);
        Date nw=new Date();
        Date[] curr=Utils.gCMon(nw);
        String m=request.getParameter("r"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),br=request.getParameter("d");
        Criteria c=sess.createCriteria(DistOrderManager.class).addOrder(Order.desc("orderId"));
        
        if(!role.getRole().matches("(.*Global.*)|(.*\\(A4\\).*)")){
//            c.add(Restrictions.ne("vis", null));
        if(role.getRole().matches("(.*\\(C3\\).*)")){
            c.add(Restrictions.or(Restrictions.eq("vis", DistOrderManager.VIS.Fin),Restrictions.eq("vis", DistOrderManager.VIS.Both)));
        }
        if(role.getRole().matches("(.*\\(A10\\).*)")){
            c.add(Restrictions.or(Restrictions.eq("vis", DistOrderManager.VIS.SKU),Restrictions.eq("vis", DistOrderManager.VIS.Both)));
        }
        }
        if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
            c.add(Restrictions.between("orderDate", Utils.DbFmt.parse(iD), Utils.DbFmt.parse(fD)));
        }else{
               c.add(Restrictions.between("orderDate", curr[0],curr[1]));
        }
        if(br!=null&&br.matches(".{2,}")){
            c.add(Restrictions.eq("distributor.disId",br));
        }
        List<DistOrderManager> orders=c.list();
%>    
<div class="loginForm" style="max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\(C4\\).*)")?"":"invisible"%>" onclick="popsl('af/newreq.jsp')">
                <span class="button white"><i class="fa fa-plus-circle"></i> New Requisition</span></p>
        </div>
        <div class="d3 left leftAlText ">
            <p class="greenFont">Requisition Value</p>
        </div>
        <div class="d3 left leftAlText">
            <p class="redFont">Requisition Bal</p>
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left rShadow" style="">
            <i class="fa btn fa-arrow-circle-left fa-2x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<!--            <span class="white"><h2 class="nomargin nopadding">Finance Record</h2></span><hr>-->
<div style="">
    <h4 class="nomargin p-15 white">Month: <%=Utils.getWMon.format(new Date())%> </h4><hr>
    <ul>
        <li title="Filters" class="bgcolef">
            <br>
            <form id="purFil" name="purFil">
                <select title="For branch" class="textField" name="d">
                <option value="">Select Seller</option>
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
            <span class="right" onclick="loadPg('requisition/index.jsp?'+gfd('purFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
    </ul>
</div>
    <%if(role.isA()){%>
    <div style="" class="bgcolef">
    <p class="nomargin p-15 white bgcolt8  bold">Quick Links</p><hr>
    <ul>
        <li class="navLink leftAlText">Pending Bills<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Payment Done<span class="right fa fa-angle-double-right"></span></li>
    </ul> 
</div>
    <%}%>
        <br>
        </div>
        <div class="right sbnvLdr lShadow" >
              <span class="white"><h2 class="nomargin nopadding">Requisitions</h2></span><hr>
              <table id="header-fixed" border="1px" cellpadding="2" style="margin:0px;" width="100%">
            </table>
            <div class="scrollable" >
                <table id="mainTable" width="100%" border="1px" cellspacing='5' cellpadding='6'>
            <%
            if(role.getRole().matches(".*\\(A10\\).*")){%>
                <tr align="left"><th>Date</th>
                    <th>From</th><th>Docket</th>
                    <th>SKUStatus</th>
                    <th>Product</th><th>Qty</th>
                    <th style="min-width: 110px;">Action</th>
                </tr>
            <%for(DistOrderManager odr:orders){
                Iterator<OrderInfo> it=odr.getProds().iterator();
                OrderInfo ii=it.hasNext()?it.next():null;
            %>
            <tr id="req<%=odr.getOrderId()%>"<% if((odr.getTotalPayment()-odr.getDiscount()-odr.getPaid())>0&&!odr.getFstatus().equals(DistOrderManager.FinStatus.Closed))out.print("style='color:red;'");else if((odr.getTotalPayment()-odr.getDiscount()-odr.getPaid())==0&&odr.getFstatus().equals(DistOrderManager.FinStatus.Closed))out.print("style='color:green;'");%>>
                    <td><%=odr.getOrderDate()%></td>
                    <td><%=odr.getDistributor().getDisId()%></td>
                    <td><%=odr.getDocketNo()%></td>
                    <td><%=odr.getDstatus().equals(DistOrderManager.DisStatus.Delivered)?"<span class='fa fa-check-circle greenFont'> Delivered</span>":"<span class='fa fa-check-circle redFont'> "+odr.getDstatus()+"</span>"%></td>
                    <td><%=ii.getProd().getFPName()%></td>
                    <td><%=ii.getQnt()%></td>
                    <td class="leftAlText">
                    <%if(role.getRole().matches("(.*Global.*)|(.*\\(V4\\).*)|(.*"+ROLE.ADM_ReqA+".*)")){%>
                    <button onclick="popsr('requisition/AjaxMan.jsp?action=viewDetails&oId=<%=odr.getOrderId()%>',false)" class="button fa fa-edit" title="View"></button>
                    <%}if(role.getRole().matches("(.*Global.*)|(.*\\(A4\\).*)|(.*"+ROLE.ADM_ReqA+".*)")){%>
                    <%if(!odr.isDeleted()&&!odr.isSeen()){%>
                        <button title="Approve" onclick="sendDataForResp('a','action=TUP&mod=DReq&i=<%=odr.getOrderId()%>&who=PERM',false);" class="button fa fa-thumbs-up"></button>
                    <%}if(odr.isSeen()&&role.getRole().matches("(.*Global.*)|(.*\\(A4\\).*)")){%>
                    <button title="Update visibility" class="button fa fa-eye" onclick="popsr('requisition/visibility.jsp?i=<%=odr.getOrderId()%>')"></button>
                    <%}}%>
                    <%if(role.getRole().matches("(.*Global.*)|(.*\\(D4\\).*)")){%>
                      <button title="Delete Requisition" class="<%=odr.isDeleted()?"redFont":"greenFont"%> button fa fa-trash" id="deleteBtn"  
                              onclick="showDial('action=del&mod=Dreq&i=<%=odr.getOrderId()%>&r=req<%=odr.getOrderId()%>','del','Do you really want to delete??','It\'ll affect stock and finance');" 
                      ></button>
                    <%}%>
                    </td>
                </tr>
                <%while(it.hasNext()){
                    ii=it.next();
                %>
                <tr><td></td><td></td><td></td><td></td><td><%=ii.getProd().getFPName()%></td><td><%=ii.getQnt()%></td><td></td></tr>
                <%}%>
                <%
            }}else{%>
            <thead>
                <tr align="left"><th>Date</th><th>From</th><th>Docket</th>
                    <th>Visibility</th>
                    <th>SKUStatus</th><th>FinStatus</th><th>Amount</th><th>Discount</th><th>Commission</th><th>Paid</th><th>Bal</th>
                    <th style="min-width: 110px;">Action</th>
                </tr>
            </thead>
        <%
            for(DistOrderManager odr:orders){
        %>
            <tr id="req<%=odr.getOrderId()%>"<% if((odr.getTotalPayment()-odr.getDiscount()-odr.getPaid())>0&&!odr.getFstatus().equals(DistOrderManager.FinStatus.Closed))out.print("style='color:red;'");else if((odr.getTotalPayment()-odr.getDiscount()-odr.getPaid())==0&&odr.getFstatus().equals(DistOrderManager.FinStatus.Closed))out.print("style='color:green;'");%>>
                    <td><%=odr.getOrderDate()%></td>
                    <td><%=odr.getDistributor().getDisId()%></td>
                    <td><span class="navLink greenFont" onclick="popsl('dockets/dockRec.jsp?d=<%=odr.getDocketNo()%>')"><%=odr.getDocketNo()%></span></td>
                    <td id="vis<%=odr.getOrderId()%>"><%=odr.getVis()%></td>
                    <td><%=odr.getDstatus().equals(DistOrderManager.DisStatus.Delivered)?"<span class='fa fa-check-circle greenFont'> Delivered</span>":"<span class='fa fa-check-circle redFont'> "+odr.getDstatus()+"</span>"%></td>
                    <td><%=odr.getFstatus()%></td>
                    <td>&#8377;<%=odr.getTotalPayment()%></td>
                    <td>&#8377;<%=odr.getDiscount()%></td>
                    <td>&#8377;<%=odr.getComm()%></td>
                    <td>&#8377;<%=odr.getPaid()%></td>
                    <td>&#8377;<%=odr.getTotalPayment()-odr.getDiscount()-odr.getPaid()%></td>
                    <td class="leftAlText">
                    <%if(role.getRole().matches("(.*Global.*)|(.*\\(V4\\).*)|(.*"+ROLE.ADM_ReqA+".*)")){%>
                        <button onclick="popsr('requisition/AjaxMan.jsp?action=viewDetails&oId=<%=odr.getOrderId()%>',false)" class="button fa fa-file" title="View"></button>
                    <%}if(role.getRole().matches("(.*Global.*)|(.*\\(A4\\).*)|(.*"+ROLE.ADM_ReqA+".*)")){%>
                    <%if(!odr.isDeleted()&&!odr.isSeen()){%>
                        <button title="Approve" onclick="sendDataForResp('a','action=TUP&mod=DReq&i=<%=odr.getOrderId()%>&who=PERM',false);" class="button fa fa-thumbs-up"></button>
                    <%}if(odr.isSeen()&&role.getRole().matches("(.*Global.*)|(.*\\(A4\\).*)")){%>
                    <button title="Update visibility" class="button fa fa-eye" onclick="popsr('requisition/visibility.jsp?i=<%=odr.getOrderId()%>')"></button>
                    <%}}%>
                    <%if(role.getRole().matches("(.*Global.*)|(.*\\(D4\\).*)")){%>
                      <button title="Delete Requisition" class="<%=odr.isDeleted()?"redFont":"greenFont"%> button fa fa-trash" id="deleteBtn" 
                              onclick="showDial('action=del&mod=DReq&i=<%=odr.getOrderId()%>&r=req<%=odr.getOrderId()%>','del','Do you really want to delete??','It\'ll affect stock and finance');" ></button>
                      <%}%>
                      <%if(role.getRole().matches("(Global)|(.*\\(A4*\\).*)")&&!odr.isDisApp()){%>
                      <!--<button title="Seller has not approved this requisition" class="<%=!odr.isDisApp()?"redFont":"greenFont"%> button fa fa-check-circle" id="deleteBtn" ></button>-->
                      <%}%>
                      <%if(role.getRole().matches("(Global)|(.*\\(U4.*\\).*)")){%>
                      <button title="Edit" class="button fa fa-edit" id="deleteBtn" onclick="popsl('af/uReq.jsp?o=<%=odr.getOrderId()%>')"></button>
                      <%}%>
                    </td>
                </tr>
            <%
            }
}
            %>
            </table>
            <script>
                copyHdr("mainTable","header-fixed");
            </script>
            </div>
          </div>
        </div>
</div>
<%
sess.close();
%>