<%-- 
    Document   : taxman
    Created on : 2 Jan, 2018, 1:31:43 PM
    Author     : UMESH-ADMIN
--%>

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
Admins role=(Admins)request.getSession().getAttribute("role");
if(role==null){
    response.sendRedirect("?msg=Login Please");
    return;
}
//Transaction tr = sess.beginTransaction();
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
            <p class="white pointer" onclick="popsl('tax/addtax.jsp')">
                <span class="button white"><i class="fa fa-plus-circle"></i> Create New Tax</span></p>
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
<!--            <span class="white"><h2 class="nomargin nopadding">Finance Record</h2></span><hr>-->
<div style="" class="bgcolef">
    <p class="nomargin p-15 white bgcolt8  bold">Month: <%=Utils.getWMon.format(new Date())%> </p><hr>
    <ul>
        <li title="Filters">
            <br>
            <form id="prodFil" name="prodFil">
                <select title="For branch" class="textField" name="br"><option>Select Production Branch</option>
                <%
                    List<ProductionBranch> b=sess.createCriteria(ProductionBranch.class).list();
                for(ProductionBranch brr:b){
                %>
                <option value="<%=brr.getBrId()%>"><%=brr.getBrName()%></option>
                <%}%>
            </select><br>
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
            <!--<span class="button right fa fa-arrow-circle-right"></span><i class="right"></i>-->
            <input title="Start date" class="textField" type="date" name="iD"/><br>
            <input class="textField" title="End Date" type="date" name="fD"/><br><br>
            <span class="right" onclick="loadPg('af/SKUStock.jsp?'+gfd('prodFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li><hr>
        <li class="navLink leftAlText blkFnt">Paid Tax <span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText blkFnt">Collected Tax<span class="right fa fa-angle-double-right"></span></li>
    </ul>
</div>
<div style="" class="bgcolef">
    <p class="nomargin p-15 white bgcolt8  bold">Quick Links </p><hr>
    <ul>
        <li class="navLink leftAlText">Collection <span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Expenditures<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Payable Pending<span class="right fa fa-angle-double-right"></span></li>
    </ul>
</div>
        <br>
        </div>
        <div class="right sbnvLdr lShadow bgcolef"><hr>
        <center>
            <div class="tileCont p-15 ">
                <%
                    List<Taxes> taxes=sess.createCriteria(Taxes.class).list();
                    if(taxes.isEmpty()){%>
                      <div class="tile bgwhite m-5 " onclick="popsl('tax/addtax.jsp')">
                    <p class="nmgn lpdn">No Tax</p>
                    <p class="bold bluFnt nmgn p-2">Create New Tax</p>
                </div>  
                    <%}
                for(Taxes t:taxes){
                %>
                <div class="tile bgwhite m-5 ">
                    <p class="nmgn lpdn"><%=t.gettName()%></p>
                    <p class="bold bluFnt nmgn p-2"><%=t.getPerc()%>%</p>
                    <p>
                        <span class="fa fa-trash mesAction" src='api/tax/del/<%=t.getTaxId()%>'></span> &nbsp;&nbsp;
                        <span class="fa fa-edit mesAction" src='api/tax/del/<%=t.getTaxId()%>'></span>
                    </p>
                </div>
                <%}%>
            </div>
            <br><br>
        </center>
      </div>
        </div>
</div>
<script>
    $(".mesAction").on("click",function(){
        sdfr(this.getAttribute("src"),"",false);
    });
    
</script>
<%
sess.close();
%>