<%-- 
    Document   : MaterialConsumption
    Created on : 28 Jul, 2017, 10:36:18 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="org.hibernate.Transaction"%>
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
    <span class="fa fa-close close" id="close" onclick="clrRSP()"></span>
    <!--<span></span>-->
    
    
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
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    String iLim=request.getParameter("ini");
    String pId=request.getParameter("i");String b=request.getParameter("b");
    int ini=0;
    if(iLim!=null&&iLim.matches("\\d+")){
        ini=Integer.parseInt(iLim);
    }
    List<MaterialStockListener> prods=sess.createQuery("from MaterialStockListener where br.brId=:br and semi.FPId=:pId order by d").setParameter("pId", Long.parseLong(pId)).setParameter("br",new Long(b) ).list();
//    Transaction tr=sess.beginTransaction();
//    double op=0,cl=0;
//    for(MaterialStockListener lis:prods){
//        double diff=lis.getOpeningStock()-lis.getClosingStock();
//        lis.setOpeningStock(op);
//    }
//    tr.commit();
    if(!prods.isEmpty()){
        out.print("<h2 class=\"nmgn spdn centAlText ylFnt\">" +prods.get(0).getSemi().getFPName()+"</h2> <hr>");
    }
    %>
    <div>
        <table class="" style="margin:0px" border='1px'  width="100%" cellpadding="5px" >
        <thead>
            <tr align="left">
                <th>Date</th>
                <th>Opening</th>
                <th>Qty</th>
                <th>Closing</th>
                <th>Detail</th>
            </tr>
        </thead>
        <tbody style="overflow: auto">
            <%
                double op=0,cl=0;
                for(MaterialStockListener in:prods){
                    try{
                    op=cl;
                    double ad=in.getClosingStock()-in.getOpeningStock();
                    cl=cl+ad;
            %>
            <tr>
                <td><%=in.getD()%></td>
                <td><%=op%></td>
                <td class="<%=ad>=0?"greenFont":"redFont"%>"><%=ad>=0?ad:-ad%></td>
                <td><%=cl%></td>
                <td><%=""+in.getType().name()+" "+(in.getRemark()==null?"":", "+in.getRemark())
                    +(in.getConsumed()==null?"":" "+in.getConsumed().getStoreId().getProduct().getFPName()+" Manufactured")
                +(in.getpReq()==null?"":" "+in.getpReq().getProduct().getFPName()+" Manufactured")%></td>
            </tr>    
            <%}catch(Exception ex){
                ex.printStackTrace();
            }
            }
            sess.close();%>
        </tbody>
        </table>
         <br>
         <!--<span class="button">View More...</span><br><br>-->
    </div>
</div>