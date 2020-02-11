<%-- 
    Document   : stockVouchers
    Created on : 25 Apr, 2018, 12:43:57 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="org.hibernate.Criteria"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.Date"%>
<%@page import="entities.Material"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="entities.InwardManager"%>
<%@page import="entities.MaterialStockListener"%>
<%@page import="entities.PPControl"%>
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
<div  style="margin: 0px;border-radius: 0px;">
    <span class="fa fa-close close" id="close" onclick="clrLRP()"></span>
    <style>
        table tr th{
            border-bottom: 1px solid #000;
        }
    </style>
<%
Admins role=(Admins)session.getAttribute("role");
    if(role==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
        <%
    return ;
    }
    Date nw=new Date();
    Date[] curr=Utils.gCMon(nw);
        
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    String mat=request.getParameter("m"),fD=request.getParameter("fD"),iD=request.getParameter("iD"),pr=request.getParameter("p"),brc=request.getParameter("br");
    Criteria c=sess.createCriteria(MaterialStockListener.class).addOrder(Order.desc("d"));
    if(iD!=null&&iD.matches(".{10}")&&(fD==null||!fD.matches(".{10}"))){
           c.add(Restrictions.eq("d", Utils.DbFmt.parse(iD)));
    }else if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
            c.add(Restrictions.between("d", Utils.DbFmt.parse(iD), Utils.DbFmt.parse(fD)));
    }else{
           c.add(Restrictions.between("d", curr[0],curr[1]));
    }

    List<MaterialStockListener> prods=c.list();
//    if(!prods.isEmpty()){
//        out.print("<h2 class='nopadding nomargin white centAlText ylFnt'>" +prods.get(0).getMat().getMatName()+ "</h2> <hr>");
//    }
    %>
    <table id="vchrHdrTable" border="1px" style="margin:0px" width="100%" cellpadding="4" >
    </table>
    <div class="scrollable">
        <table border="1px" id="voucherSourceTable" style="margin:0px" width="100%" cellpadding="4" >
        <thead>
            <tr align="left">
                <th>Date</th>
                <th>Branch</th>
                <th>Material</th>
                <th>Product</th>
                <th>Qty</th>
                <th>Detail</th>
            </tr>
        </thead>
        <tbody style="overflow: auto">
            <%
                for(MaterialStockListener in:prods){
                    Material m=in.getMat();
                    ProductionBranch bbr=in.getBr();
                    FinishedProduct p=in.getSemi();
                    double ad=in.getClosingStock()-in.getOpeningStock();
            %>
            <tr>
                <td><%=in.getD()%></td>
                <td><%=bbr!=null?bbr.getBrName():""%></td>
                <td><%=m!=null?m.getMatName():""%></td>
                <td><%=p!=null?p.getFPName():""%></td>
                <td class="<%=ad>=0?"greenFont":"redFont"%>"><%=ad>=0?ad:-ad%></td>
                <td><%=""+in.getType().name()+" "+(in.getRemark()==null?"":", "+in.getRemark())
                    +(in.getConsumed()==null?"":" "+in.getConsumed().getStoreId().getProduct().getFPName()+" Manufactured")
                +(in.getpReq()==null?"":" "+in.getpReq().getProduct().getFPName()+" Manufactured")%></td>
            </tr>    
            <%}sess.close();%>
        </tbody>
        </table>
         <br>
         <script>
             copyHdr("voucherSourceTable","vchrHdrTable");
         </script>
    </div>
</div>
        <style>
            .popUpRight{
                box-shadow: #555 0px 0px 15px 5px; 
            }
        </style>