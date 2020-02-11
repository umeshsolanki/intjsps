<%-- 
    Document   : invoice
    Created on : 20 Oct, 2018, 12:52:52 PM
    Author     : UMESH-ADMIN
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="utils.UT"%>
<%@page import="org.hibernate.type.TypeResolver"%>
<%@page import="entities.StockManager"%>
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

<!DOCTYPE html>

<%
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        Admins role=(Admins)session.getAttribute("role");
        if(!UT.ia(role, "19")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
            return;
        }
    
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
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\((C|U)19\\).*)")?"":"invisible"%>" onclick="popsl('f/ustk.jsp')" >
            <span class="button white"><i class="fa fa-plus-circle"></i> Update Stock</span></p>
        </div>
        <div class="d3 left leftAlText ">
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\((C|U)19\\).*)")?"":"invisible"%>" onclick="popsl('f/pof.jsp')">
            <span class="button white"><i class="fa fa-plus-circle"></i> Stock Opening</span></p>
        </div>
        <div class="d3 left leftAlText">
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\(U19\\).*)")?"":"invisible"%>" onclick="popsl('af/cskutr.jsp')">
            <span class="button white"><i class="fa fa-plus-circle"></i> CSKU Transfer</span></p>
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left rShadow" style="">
        <i class="fa btn fa-arrow-circle-left fa-2x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<div style="">
    <p class="nomargin p-15 white bgcolt8  bold">Filters </p><hr>
    <ul>
        <li title="Filters" class="bgcolef">
            <br>
            <form id="purFil" name="purFil">
                <select title="For branch" class="textField" name="r">
                <option value="">Select Raw Material</option>
                <option value="**M">All Materials Stock</option>
                <option value="**MDL">Materials below deadline</option>
                <%
                List<Material> mts=sess.createCriteria(Material.class).list();
                for(Material brr:mts){
                %>
                <option value="<%=brr.getMatId()%>"><%=brr.getMatName()%></option>
                <%}%>
            </select><br>
            <select class="textField" name="p" >
                <option value="">Select Product</option>
                    <option value="**P">All Products Stock</option>
                    <!--<option value="**PDL">Products below deadline</option>-->
                    <%
                        List<FinishedProduct> fp=sess.createCriteria(FinishedProduct.class).add(Restrictions.eq("deleted", false)).list();
                        for(FinishedProduct mm:fp){
                    %>
                    <option value="<%=mm.getFPId()%>"><%=mm.getFPName()%></option>
                    <%}%>
                    </select><br>
            <%if(role.getBranch()==null){%>
                <select title="For branch" class="textField" name="br"><option>Select Production Branch</option>
                <%
                    List<ProductionBranch> b=sess.createCriteria(ProductionBranch.class).list();
                for(ProductionBranch brr:b){
                %>
                <option value="<%=brr.getBrId()%>"><%=brr.getBrName()%></option>
                <%}%>
            </select>
            <%}else{%>
            <input type="hidden" value="<%=role.getBranch().getBrId()%>" name="br"/>
            <%}%>
            <br><br>
            <span class="right" onclick="loadPg('inventory/index.jsp?'+gfd('purFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
    </ul>
</div>
    <%
        if(role.isA()){
    %>
    <div style="" class="bgcolef">
    <p class="nomargin p-15 white bgcolt8  bold">Quick Links </p><hr>
        <ul>
            <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','quicklinks/openingRec.jsp',false);">Show out Report<span class="right fa fa-angle-double-right"></span></li><hr><br>
            <li>
                <form id="dtFilt">
                <input title="Start date" class="textField" type="date" name="iD"/><br>
                <input class="textField" title="End Date" type="date" name="fD"/><br><br><hr>
                </form>
            </li>
            <li class="navLink leftAlText" onclick="popLR('quicklinks/stockVouchers.jsp?'+gfd('dtFilt'),false);">View Stock Vouchers<span class="right fa fa-angle-double-right"></span></li><hr>
        </ul>
    </div><br>
    <%}%>
    </div>
    <div class="right sbnvLdr lShadow" id="linkLoader">
    <hr>
    <div class="fullWidWithBGContainer">
        <div class="half left">
        <script>
            function filterKeys(filter) {
            if(filter.toString().length>1){
                $("#matSRes").html("");
                $("#matSRes").css("display","block");
                var patt=new RegExp(".*"+filter+".*","i");
for(var i=0;i<mats.length;i++){
    var mat=mats[i];
    if(patt.test(mat.name)){
        $("#matSRes").append("<div onclick='scrollToMat("+mat.id+");' style='cursor:default;padding:5px;'>"+mat.name+"</div>");

    }
    }

}else{
            $("#matSRes").html("");
                $("#matSRes").css("display","none");
        }
        }

            function scrollToMat(matId) {
                var matScroll=document.getElementById("matScroll"+matId);
                if(matScroll!=null){
                matScroll.scrollIntoView();
                $(matScroll).css("transition","background 1s");
                var preE=matScroll.innerHTML;
                matScroll.firstElementChild.className='yellow';
                setTimeout(function(){matScroll.firstElementChild.className='normal';},4000);
                window.scroll(0,0);
            }
            else{
                showMes('Material Not found in stock!!',true,true);
            }
            $("#matSRes").html('');
            $("#brMatStkScroller").val('');
        }
        </script>
        <span class="white">
            <h3 class="nopadding nomargin">Raw Material Stock
<!--                <span>
                    <input type="search" placeholder="Search" id='brMatStkScroller' onkeyup="filterKeys(this.value);"/>
                </span>-->
            </h3>
                <div class="scrollable" >
<!--            <div class="scrollable" style="position: absolute;background-color: #778899;max-width: 350px;max-height: 200px;overflow: auto;" id="matSRes">                
            </div>-->
        </span>
    <hr>
      <table  style="margin:0px" width="100%" cellpadding="5px"  border='1' >
        <thead>
            <tr align="left">
                <th>Material</th>
                <th>Branch</th>
                <th>Qty</th>
            </tr>
        </thead>
        <tbody>
<%
    for(StockManager in:prods){
%>
            <tr class="pointer" id="matScroll<%=(in.getMat().getMatId())%>" align="left">
                <td title="Click to view material stock update history" onclick="popsr('inventory/MaterialConsumedSummary.jsp?i=<%=in.getMat().getMatId()%>&b=<%=in.getInBr().getBrId()%>')">
                    <span class="greenFont"><%=in.getMat().getMatName()%></span></td>
                <td><%=in.getInBr().getBrName()%></td>
                <td><%=UT.df.format(in.getQty())+" "+in.getMat().getPpcUnit()%></td>
            </tr>
<%}%>
        </tbody>
        </table>
    </div>
    </div>
    <div class="half right" style="">
            <span class="white"><h3 class="nomargin nopadding">Product Stock</h3></span><hr>
        <div class="scrollable" >
            <form id="initProduction">
        <script>
            function updateDev(idVal) {
                $('.msg').html("<center><img src='images/loader.svg' width=100 height=100 /></center>");    
                $.post("FormManager","strId="+idVal+"&action=updProdtn&fin="+$("#"+idVal).val(),function(dat){
                    if(dat.includes("success")){
                        showMes(dat,false);
                    }else{
                        showMes(dat,true);
                    }
                });
            }
        </script>
    <table style="margin:0px" width="100%" cellpadding="5px" border='1px' >
        <thead>
            <tr align="left">
                <th>Product</th>
                <th>Branch</th>
                <th>Quantity</th>
            </tr>
        </thead>
        <tbody id="MoreCont">
            <%
            prods=pq.list();
            for(StockManager ps:prods){
            %>
            <tr>
                <td><span class="greenFont" title="Click for details" onclick="popsr('inventory/ProductConsumedSummary.jsp?i=<%=ps.getSemiProd().getFPId()%>&b=<%=ps.getInBr().getBrId()%>',false)"><%=ps.getSemiProd().getFPName()%></span></td>
                <td><%=ps.getInBr().getBrName()%></td>
                <td><%=ps.getQty()%></td>
            </tr>
            <%}%>
        </tbody>
    </table>
    </form>
        </div>
      </div>
        </div>
    </div>
</div>
</div>
<%
sess.close();
%>