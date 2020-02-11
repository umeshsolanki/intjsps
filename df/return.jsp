<%-- 
    Document   : return
    Created on : 26 Apr, 2018, 12:55:35 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="utils.UT"%>
<%@page import="java.util.Iterator"%>
<%@page import="entities.Customer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="entities.CustReturns"%>
<%@page import="entities.ReturnInfo"%>
<%@page import="entities.Taxes"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="entities.SKU"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.Query"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.Date"%>
<%@page import="org.hibernate.criterion.Order"%>
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
//    Admins role=(Admins)request.getSession().getAttribute("role");
//    if(!UT.ia(role, "22")){
//        response.sendRedirect("?msg=Login Please");
//        return;
//    }
    DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
    DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
//    if(role==null||role.getAttachedSaleCenter()!=null){
    sess.refresh(dist);
    Date nw=new Date();
    Date[] curr=Utils.gCMon(nw);
        
%>
<div class="loginForm" style="max-width: 100%;">
    <style>
        .yellow{
            background-color: yellow !important;
            transition: all 1s;
            color: #449955;
        }
        .normal{   
                background-color: transparent;
                transition: all 1s;
              }
    </style>
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">   
            <p class="white pointer" onclick="popsl('af/addReturn.jsp')">
                <span class="button white"><i class="fa fa-plus-circle"></i> New Return</span></p>
        </div>
        <div class="left d3 leftAlText">
            <!--<p class="greenFont">Requisition Value</p>-->
        </div>
        <div class="d3 left leftAlText">
            <!--<p class="redFont">Requisition Bal</p>-->
        </div>
    </div>
<div class="fullWidWithBGContainer bgcolt8">        
<div class="subNav left" style="">
<i class="fa btn fa-toggle-left fa-1pt25x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<div style="margin: 1px;padding: 1px;border: 1px white solid;" class="bgcolef">    
    <p class="nomargin nopadding white bgcolt8">Month: <%=Utils.getWMon.format(new Date())%> </p><hr>
    <ul>
        <li title="Filters">
            <br>
            <form id="prodFil" name="prodFil">
                <%--<select title="For branch" class="textField" name="br"><option>Select Production Branch</option>
                <%
                    List<ProductionBranch> b=sess.createCriteria(ProductionBranch.class).list();
                for(ProductionBranch brr:b){
                %>
                <option value="<%=brr.getBrId()%>"><%=brr.getBrName()%></option>
                <%}%>
            </select>--%><br>
            <select class="textField" name="p" >
                    <option>Select Product</option>
                    <%
                    List<FinishedProduct> fpa= sess.createCriteria(FinishedProduct.class).add(Restrictions.eq("deleted", false)).addOrder(Order.asc("FPName")).list();
                    for(FinishedProduct f:fpa){
                    %>
                    <option value="<%=f.getFPId()%>"><%=f.getFPName()%></option>
                    <%
                    }
                    %>
                    </select><br>
            <input title="Start date" class="textField" type="date" name="iD"/><br>
            <input class="textField" title="End Date" type="date" name="fD"/><br><br>
            <span class="right" onclick="loadPg('af/return.jsp?'+gfd('prodFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li><hr>
<!--        <li class="navLink leftAlText blkFnt">Paid Tax <span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText blkFnt">Collected Tax<span class="right fa fa-angle-double-right"></span></li>-->
    </ul>
</div>
<div style="margin-top: 10px;padding: 1px;border: 1px white solid;" class="bgcolef">
    <p class="nomargin nopadding white bgcolt8">Quick Links </p><hr>
    <ul>
<!--        <li class="navLink leftAlText">Collection <span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Expenditures<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Payable Pending<span class="right fa fa-angle-double-right"></span></li>-->
    </ul>
</div>
        <br>
        </div>
        <div class="right sbnvLdr bgcolef"><hr>
        <h3 class="nomargin nopadding blkFnt">Recent Returns</h3>
        <div class="scrollable">
            <table class="spdn" border="1px">
                <tr>
                    <th>RetId</th><th>Date</th><th>DocketNo</th><th>Item</th><th>Qty</th><th>RepairCost</th><th>ReturnedAmount</th><th>RefundableAmt</th><th>Status</th><th>Note</th><th>Action</th>
                </tr>
                <%
                Criteria ct=sess.createCriteria(CustReturns.class).add(Restrictions.eq("fromSeller", dist)).addOrder(Order.desc("retOn"));
                List<CustReturns> res=ct.list();
                for(CustReturns cr:res){
                    boolean fCust=cr.getCust()!=null;
                    Customer c=cr.getCust();
                    DistributorInfo dis=cr.getFromSeller();
                    Iterator<ReturnInfo> retInfp=cr.getProds().iterator();
                    ReturnInfo rr=new ReturnInfo();
                    if(retInfp.hasNext())
                    rr=retInfp.next();
                %>
                <tr id="row<%=cr.getRetId()%>">
                    <td><%=cr.getRetId()%></td>
                    <td><%=cr.getRetOn()%></td>
                    <td><%=cr.getDocketNo()%></td>
                    <td><%=rr.getProd()!=null?rr.getProd().getFPName():""%></td>
                    <td><%=rr.getQnt()%></td>
                    <td>&#8377;<%=cr.getRepCharges()%></td>
                    <td>&#8377;<%=cr.getRetChg()%></td>
                    <td>&#8377;<%=cr.getRefund()%></td>
                    <td><%=cr.getStatus()%></td>
                    <td><%=cr.getProCondition()%></td>
                    <td>
                        <button class="fa fa-trash" title="delete" onclick="showDial('i=<%=cr.getRetId()%>&action=return','del','Confirm delete','Can\'t undo this action');"></button>
                    </td>
                </tr>
                <%
                while(retInfp.hasNext()){
                rr=retInfp.next();
                %>
                <tr>
                    <td></td><td></td><td></td><td></td><td></td><td><%=rr.getProd().getFPName()%></td><td><%=rr.getQnt()%></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td>
                </tr>
                <%}%>
                <%}%>
            </table>
        </div>
      </div>
        </div>
</div>
<%
sess.close();
%>