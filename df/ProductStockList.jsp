<%-- 
    Document   : MaterialConsumption
    Created on : 28 Jul, 2017, 10:36:18 PM
    Author     : UMESH-ADMIN
--%>

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
    <!--<span class="close" id="close" onclick="closeMe()">&Cross;</span>-->
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
    String mat=request.getParameter("i");
    int ini=0;
    if(iLim!=null&&iLim.matches("\\d+")){
        ini=Integer.parseInt(iLim);
    }
//SELECT sum(`materialconsumed`.`noOfProd`),sum(`materialconsumed`.`qnt`),`material`.`matId`,`productionrequest`.`producedOn`,`productionbranch`.`brId` FROM materialconsumed
//LEFT JOIN `pullndrydb`.`productionbranch` ON `materialconsumed`.`branch_brId` = `productionbranch`.`brId` 
//LEFT JOIN `pullndrydb`.`material` ON `materialconsumed`.`mat_matId` = `material`.`matId` 
//LEFT JOIN `pullndrydb`.`productionrequest` ON `materialconsumed`.`storeId_reqId` = `productionrequest`.`reqId` 
//GROUP BY producedOn, brId, matId

    List<MaterialStockListener> prods=sess.createQuery("from MaterialStockListener where br=:br and mat.matId=:mat order by MMId desc").setParameter("mat", Long.parseLong(mat)).setParameter("br", role.getBranch()).list();
    if(!prods.isEmpty()){
        out.print("<h3><u>" +prods.get(0).getMat().getMatName()+"</u> Report</h3> <hr>");
    }
    %>

    <div class="scrollable">
      <table style="margin:0px" width="100%" cellpadding="5" >
        <thead>
            <tr align="left">
                <th>Date</th>
                <th>Opening</th>
                <th>In</th><th>Out</th>
                <th>Closing</th>
                <th>Detail</th>
            </tr>
        </thead>
        
        <tbody style="max-height: 500px;overflow: auto">
            <%for(MaterialStockListener in:prods){%>

            <tr <%if(in.getIm()!=null&&in.getIm().getTick()!=null&&!in.getIm().getTick().isResolved()){out.print("style='color:red;'");}%>>
                <td><%=in.getD()%></td>
                <td><%=in.getOpeningStock()%></td>
                <%if(in.getType().equals(MaterialStockListener.Type.Import)||in.getType().equals(MaterialStockListener.Type.Opening)){%>
                <td><%=in.getIm().getQtyInPPC()+" "+in.getMat().getPpcUnit()%></td>
                <%}else if(in.getType().equals(MaterialStockListener.Type.Process)){%>
                <td><%=in.getConsumed().getQnt()+" "+in.getMat().getPpcUnit()%></td>
                <%}%>
                <td><%=in.getClosingStock()%></td>
                <td>
                    <%
                        if(in.getType().equals(MaterialStockListener.Type.Process)){
                        out.print(in.getConsumed().getNoOfProd()+" <b>"+in.getConsumed().getStoreId().getProduct().getFPName()+"</b> Produced ");
                    }else{
                        out.print(in.getType());
                        if(in.getType().equals(MaterialStockListener.Type.Import)){
                            if(in.getIm().getTick()!=null&&!in.getIm().getTick().isResolved()){
                            %> <button> &Cross; </button>
                            <%}
                            //if(in.getOpeningStock()==0){
                            %>
                            <!--<span onclick="sendDataWithCallback('FormManager','action=toggleOpening&msl=<%=in.getMMId()%>',false,function(){this.innerHTML='Opening'})" class='button' style='margin:15px;padding:2px;' title='click to turn as opening'>Opening</span>-->
                            <%
                            //}
                        }
                    }
            %>

                </td>
                <%}%>
        </tbody>
        </table>
         <br>
         <!--<span class="button">View More...</span><br><br>-->
    </div>
</div>