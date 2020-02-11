<%-- 
    Document   : MaterialConsumption
    Created on : 28 Jul, 2017, 10:36:18 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="utils.UT"%>
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
        .strike{
            text-decoration: line-through;
        }
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
    String mat=request.getParameter("i");
    String b=request.getParameter("b");
    ProductionBranch br;
    if(b!=null&&b.matches("\\d+")){
        br=(ProductionBranch)sess.get(ProductionBranch.class, new Long(b));
    }else{
        br=role.getBranch();
    }
    int ini=0;
    if(iLim!=null&&iLim.matches("\\d+")){
        ini=Integer.parseInt(iLim);
    }
//SELECT sum(`materialconsumed`.`noOfProd`),sum(`materialconsumed`.`qnt`),`material`.`matId`,`productionrequest`.`producedOn`,`productionbranch`.`brId` FROM materialconsumed
//LEFT JOIN `pullndrydb`.`productionbranch` ON `materialconsumed`.`branch_brId` = `productionbranch`.`brId` 
//LEFT JOIN `pullndrydb`.`material` ON `materialconsumed`.`mat_matId` = `material`.`matId` 
//LEFT JOIN `pullndrydb`.`productionrequest` ON `materialconsumed`.`storeId_reqId` = `productionrequest`.`reqId` 
//GROUP BY producedOn, brId, matId

    List<MaterialStockListener> prods=sess.createQuery("from MaterialStockListener where br=:br and mat.matId=:mat order by d").setParameter("mat", Long.parseLong(mat)).setParameter("br", br).list();
    if(!prods.isEmpty()){
        out.print("<h2 class='nopadding nomargin white centAlText ylFnt'>" +prods.get(0).getMat().getMatName()+ "</h2> <hr>");
    }
    %>

    <div>
        <table border="1px" style="margin:0px" width="100%" class="" cellpadding="4" >
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
                    boolean deleted=in.getRemark().contains("deleted by");
                    op=cl;
                    double ad=in.getClosingStock()-in.getOpeningStock();
                    cl=cl+ad;
                    if(in.getType().equals(in.getType().Updated)){
                        cl=new Double((ad>=0?UT.df.format(ad):UT.df.format(-ad)));
                    }
                    if(deleted){
                        cl=cl-ad;
                    }
            %>
            <tr  class="<%=deleted?"redFont strike":""%>">
                <td><%=in.getD()%></td>
                <td><%=UT.df.format(op)%></td>
                <td class="<%=ad>=0?"greenFont":"redFont"%>"><%=ad>=0?UT.df.format(ad):UT.df.format(-ad)%></td>
                <td><%=cl%></td>
                <td class="<%=deleted?"redFont strike":""%>"><%=""+in.getType().name()+" "+(in.getRemark()==null?"":", "+in.getRemark())
                    +(in.getConsumed()==null?"":" "+in.getConsumed().getStoreId().getProduct().getFPName()+" Manufactured")
                +(in.getpReq()==null?"":" "+in.getpReq().getProduct().getFPName()+" Manufactured")%></td>
            </tr>    
            <%}catch (Exception ex) {
                ex.printStackTrace();
                }}
                sess.close();
            %>
        </tbody>
        </table>
         <br>
         <!--<span class="button">View More...</span><br><br>-->
    </div>
</div>
        <style>
            .popSMRt{
                box-shadow: #555 0px 0px 15px 5px; 
            }
        </style>