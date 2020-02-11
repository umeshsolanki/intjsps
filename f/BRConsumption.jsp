<%-- 
    Document   : MaterialConsumption
    Created on : 28 Jul, 2017, 10:36:18 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="utils.UT"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="entities.Admins"%>
<%@page import="entities.MaterialConsumed"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.StockManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div  class="loginForm">
    <!--<span></span>-->
    <style>
        table tr th{
            border-bottom: 1px solid #000;
        }
    </style>
<%
    String p=request.getParameter("p");
    Admins role=(Admins)session.getAttribute("role");
    
    if(role==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
        <%
    return ;
}
    if(!UT.ia(role, "17")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
            return;
        }
    boolean isGA=role.getRole().matches(".*Global.*");
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    String iLim=request.getParameter("ini");
    Date nw=new Date();
    Date[] curr=Utils.gCMon(nw);
    String m=request.getParameter("p"),
                iD=request.getParameter("iD"),
                fD=request.getParameter("fD"),
                br=request.getParameter("br");
    int ini=0;
//    if(iLim!=null&&iLim.matches("\\d+")){
//        ini=Integer.parseInt(iLim);
//    }
//    Criteria c=sess.createCriteria(ProductionRequest.class).add(Restrictions.eq("opening",false))
//                .addOrder(Order.desc("reqId"));
//    if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
//            c.add(Restrictions.between("producedOn", Utils.DbFmt.parse(iD), Utils.DbFmt.parse(fD)));
//        }else{
//               c.add(Restrictions.between("producedOn", curr[0],curr[1]));
//        }
//        if(br!=null&&br.matches("\\d+")){
//            c.add(Restrictions.eq("producedBy.brId",new Long(br)));
//        }
//        if(m!=null&&m.matches("\\d+")){
//            c.add(Restrictions.eq("product.FPId",new Long(m)));
//        }
//    List<FinishedProduct> fpa= sess.createCriteria(FinishedProduct.class).add(Restrictions.eq("deleted", false))
//            .addOrder(Order.asc("FPName")).list();
    List<MaterialConsumed> prods=sess.createQuery("from MaterialConsumed mc "+((p!=null&&p.matches("\\d+"))?"where mc.storeId.reqId="+new Long(p):"")+" order by mc.consumeId desc").list();
    
    ProductionRequest pr=null;
    if(!prods.isEmpty())
    pr=prods.get(0).getStoreId();
    %>
    <span class="close fa fa-close" id="close" onclick="<%=p!=null?"clrLSP()":"closeMe()"%>"></span>
    <div class="fullWidWithBGContainer">
<!--        <div class="d3 left">
            <p class="white pointer" onclick="popsl('af/newprodrec.jsp')">
                <span class="button white"><i class="fa fa-plus-circle"></i> Add Production Request</span></p>
        </div>-->
        <div class="d3 left leftAlText">
            <!--<p class="greenFont"><%=p!=null?"from "+p:"from : "+Utils.HRFmt.format(curr[0])%></p>-->
        </div>
        <div class="d3 left leftAlText">
            <!--<p class="redFont"><%=p!=null?"to "+p:"to : "+Utils.HRFmt.format(curr[1])%></p>-->
        </div>
    </div>
    <div class="fullWidWithBGContainer">
        <div>
        
            <span class="white"><h2 class="nomargin nopadding centAlText">Materials Consumed </h2></span>
            <div class="fullWidWithBGContainer">
                <div class="half left borderRight">
                    <p class="nmgn spdn">Date:<%=pr!=null?Utils.HRFmt.format(pr.getProducedOn()):" Record Deleted "%></p><hr>
                    <p class="nmgn spdn">Branch:<%=pr!=null?pr.getProducedBy().getBrName():" Record Deleted"%></p>
                </div>
                <div class="half right">
                    <p class="nmgn spdn">Product:<%=pr!=null?pr.getProduct().getFPName():" Record Deleted"%></p><hr>
                    <p class="nmgn spdn">Qty:<%=pr!=null?UT.df.format(pr.getQnt()):" Record Deleted or Rolled Back "%></p>
                </div>
            </div>
            <div class="scrollable" >
                <form id="initProduction" onsubmit="return false;">

    <!--<span class="close fa fa-close" id="close" onclick="<%=p!=null?"clrLSP()":"closeMe()"%>"></span>-->
    <!--<div>-->
        
        
    <hr>
      <table width="100%" border="1px" cellpadding="5" >
        <thead>
            <tr align="center">
<!--                <th>Date</th>
                <th>Branch</th>
                <th>Product</th>
                <th>Qty</th>-->
                <th>Material</th>
                <th>Consumed</th>
                <%if(isGA){%><th>Value</th><%}%>
            </tr>
        </thead>
        <tbody style="max-height: 500px;overflow: auto">
        <%
            double amt=0,ttl=0;
        for(MaterialConsumed in:prods){
        if(in.getStoreId()==null){
            continue;
        }
        if(isGA){
            amt=(in.getMat()!=null?in.getMat().getRate()*in.getQnt():in.getSemiFinProd().getMRP()*in.getQnt());
            ttl+=amt;
        }
        %>
            <tr align="center">
<!--                <td><%=in.getStoreId().getProducedOn()%></td>
                <td><%=in.getStoreId().getProducedBy().getBrName()%></td>-->
                <!--<td><%=in.getStoreId().getProduct().getFPName()%></td>-->
                <!--<td><%=in.getStoreId().getQnt()%></td>-->
                <td><%=in.getMat()!=null?in.getMat().getMatName():in.getSemiFinProd().getFPName()%></td>
                <td><%=UT.df.format(in.getQnt())+" "+(in.getMat()!=null?in.getMat().getPpcUnit():"")%></td>
                <%if(isGA){%><td>&#8377;<%=UT.df.format(amt)%></td><%}%>
                <%}%>
           <%if(isGA){%> <tr ><td colspan="3">Total&nbsp; &nbsp;&#8377;<%=UT.df.format(ttl)%></td></tr><%}%>
        </tbody>
        </table>
         <!--<br><span class="button">View More...</span><br><br>-->
    </div>
        <style>
        .popSMLE{
            box-shadow: 4px 4px 25px black;
        }
        </style>
</div>
    </div>
    </div>       