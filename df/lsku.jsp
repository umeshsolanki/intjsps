<%@page import="entities.DistStockListener"%>
<%@page import="entities.DistStock"%>
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String p=request.getParameter("p");
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
            DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
            if(dist==null||LU!=null&&!LU.getRoles().matches(".*\\(.Stk\\).*")){
                out.print("<script>window.location.replace(\"?msg=You don't have permission to access this page\");</script>");
                return;
            }
    sess.refresh(dist);
    
    String m=request.getParameter("r"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),mv=request.getParameter("m");
    String cMob=request.getParameter("cn"),dk=request.getParameter("dk");
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
        <div class="d3 left leftAlText">   
            <p class="white pointer " >
                <span class="button white <%=(LU!=null&&!LU.getRoles().matches(".*\\(CStk\\).*")?"invisible":"")%>" onclick="popsl('df/ostk.jsp')" ><i class="fa fa-plus-circle"></i> Stock Opening</span>        
                <span class="button white <%=(LU!=null&&!LU.getRoles().matches(".*\\(UStk\\).*")?"invisible":"")%>" onclick="popsl('df/ustk.jsp')" ><i class="fa fa-plus-circle"></i> Update Stock</span>
                
            </p>
            
        </div>
        <div class="d3 left leftAlText ">
            <p class="white pointer ">&nbsp;</p>
        </div>
        <div class="d3 left leftAlText">
            <p class="white pointer ">&nbsp;</p>
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left"><hr>
        <div style="margin: 1px;padding: 1px;border: 1px white solid;" class="bgcolef">
    <p class="nomargin nopadding white bgcolt8">Filters </p><hr>
    <ul>
        <li><br>
        <form id="purFil" name="purFil">
            
            <input title="Start date" value="<%=UT.ie(iD)?"":iD%>" class="textField" type="date" name="iD"/><br>
            <input class="textField" value="<%=UT.ie(fD)?"":fD%>" title="End Date" type="date" name="fD"/><br><br>
            <span class="right" onclick="loadPg('df/lsku.jsp?'+gfd('purFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
    </ul>
</div>
</div>
        <div class="sbnvLdr right">
        <div class="half left">
            <h2 class="nomargin nopadding bgcolt8 white">Month Record</h2><hr>
                <div class="scrollable">
                <table border="1" cellpadding="5px">
                <thead>
                    <tr><th>Date</th><th>Product</th><th>Qnt</th><th>Remark</th></tr>
                </thead>
                <tbody>
    <%
        Date[] curr=Utils.gCMon(new Date());
        Criteria c=sess.createCriteria(DistStockListener.class).add(Restrictions.eq("dist",dist))
        .addOrder(Order.desc("dt"));
        
            if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
                c.add(Restrictions.between("dt", Utils.DbFmt.parse(iD), Utils.DbFmt.parse(fD)));
            }else if(iD!=null&&iD.matches(".{10}")){
                c.add(Restrictions.eq("dt", Utils.DbFmt.parse(iD)));       
            }else{
                c.add(Restrictions.between("dt", curr[0],curr[1]));
            }
            
            
        
        List<DistStockListener> prods=c.list();
        double op=0,cl=0;
        for(DistStockListener in:prods){
            double qnt=in.getClosing()-in.getOpening();
//            op=cl;
//            cl=cl+qnt;
    %>
            <tr align="center">
                <td><%=in.getDt()%></td>
                <td><%=in.getProd().getFPName()%></td>
                <!--<td><%=op%></td>-->
                <td class="<%=qnt>=0?"greenFont":"redFont"%>"><%=qnt<0?-qnt:qnt%></td>
                <!--<td><%=cl%></td>-->
                <td><%=in.getRemark()%></td>
            </tr>
                <%}%>
                </tbody>
            </table>
            </div>
        </div>
        <div class="half right">
              <span class="white"><h2 class="nomargin nopadding bgcolt8">Stock</h2></span><hr>
    <div class="scrollable" >
    <div class="fullWidWithBGContainer">
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
            <div class="scrollable">        
            <table border="1px" >
                <tr align="left"><th>Product</th><th>Current Stock</th><th>Action</th></tr>
        <%
            List<DistStock> stk=sess.createQuery("from DistStock where dist=:dist order by prod.FPName asc").setParameter("dist",dist ).list();
            for(DistStock odr:stk){
        %>
                <tr id="STOCK_SC_PR_<%=odr.getProd().getFPId()%>">
                    <!--<td><%=odr.getOpnDt()%></td>-->
                    <td class="pointer"  title="click to view Purchase and Sale History" ><%=odr.getProd().getFPName()%></td>
                    <!--<td><%=odr.getOpening()%></td>-->
                    <td><%=odr.getStock()%></td>
                    <td>
                        <button onclick="popsl('df/stkLis.jsp?p=<%=odr.getProd().getFPId()%>');" class="button fa fa-eye" title="View Stock History"></button>
                    </td>
                </tr>
            <%
            }
            %>
        </div>
        </div>
        </div>
        </div>
</div>
</div>
<%
sess.close();
%>