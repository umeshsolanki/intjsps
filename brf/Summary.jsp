<%-- 
    Document   : Summary
    Created on : 26 Jul, 2017, 2:46:32 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.Admins"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="entities.MaterialStockListener"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    int ini=0;
    if(iLim!=null&&iLim.matches("\\d+")){
        ini=Integer.parseInt(iLim);
    }
    
       %>
       <div class="loginForm" style="background-color: #ffbb99;">
           <span class="close" id="close" onclick="closeMe()">&Cross;</span>
       <%
       List<ProductionRequest> prodReq=sess.createQuery("from ProductionRequest where producedBy=:br").
            setParameter("br", role.getBranch()).list();
    if(!prodReq.isEmpty()){
       %>
                    <h3 class=' georgia'>Production Summary  for <%=role.getBranch().getBrName()%></h3><hr>
                    
                    <table width="100%" cellpadding="5px" border='1px'>
                    <thead>
                    <tr align="left"><th>Date</th><th>Total</th><th>Finished</th><th>Semifinished</th></tr>
                    </thead>
                    <tbody id="container">
                        <%
                        for(ProductionRequest result:prodReq){
                         %>
                         <tr><td><%=result.getProducedOn()%></td><td><%=result.getQnt()%></td><td><%=result.getDeveloped()%></td><td ><%=result.getQnt()-result.getDeveloped()%></td></tr>
                        <%   
                        }
                        %>
                    </tbody>
                    </table><br>
                    <%}%>
                    <h3 class=' georgia'>Material Stock <%=role.getBranch().getBrName()%></h3><hr>
                    <table style="margin:0px;max-height: 500px;overflow: auto" width="100%" cellpadding="5" >
                    <thead>
                    <tr align="left"><th>Date</th><th>Material</th><th>Opening</th><th>Consumed/Import</th><th>closing</th></tr>
                    </thead>
                    <tbody id="container">
    <%
        //SELECT im.importOn,s.mat.matId,CONCAT(im.Qty,' ',"
//        + "s.mat.importUnit),concat(im.inStockBFRTr,' ',s.mat.ppcUnit),concat(im.QtyInPPC,' ',s.mat.ppcUnit),"
//        + "(im.inStockBFRTr+im.QtyInPPC)-s.Qty,concat(s.Qty,' ',s.mat.ppcUnit) FROM StockManager s,InwardManager im where s.mat=im.matId"
//        + " and im.inBr=:imBr and s.inBr=:stBr order by im.importId desc
    List<MaterialStockListener> impHist=sess.createQuery("from MaterialStockListener where br=:br").
            setParameter("br", role.getBranch()).list();
    if(impHist.isEmpty()){
     out.print("<marquee>Nothing is Imported in this branch</marquee>");   
    }
            for (MaterialStockListener result :impHist) {
                if(result.getType()==MaterialStockListener.Type.Import){
                 %>
    <tr>
        <td><%=result.getD()%></td><td><%=result.getMat().getMatId()%></td><td><%=result.getOpeningStock()+" "+result.getMat().getPpcUnit()%></td><td style="background-color: green;color:#fff;"><%=result.getIm().getQty()+" "+result.getMat().getImportUnit()+"/"+result.getIm().getQtyInPPC()+" "+result.getMat().getPpcUnit()%></td><td><%=result.getClosingStock()+" "+result.getMat().getPpcUnit()%></td>
                  </tr>
    
                <%   
                }else{
                  %>
                <tr>
        <td><%=result.getD()%></td><td><%=result.getMat().getMatId()%></td><td><%=result.getOpeningStock()+" "+result.getMat().getPpcUnit()%></td><td style="background-color: red;color:#fff;"><%=result.getConsumed().getQnt()+" "+result.getMat().getPpcUnit()+"/ "+result.getConsumed().getNoOfProd()+" "+result.getConsumed().getStoreId().getFPId().getFPId()%></td><td><%=result.getClosingStock()+" "+result.getMat().getPpcUnit()%></td>
                  </tr>
      
                <%  
                }
                %>        <%}%>
              </tbody>
         </table>
              <br><span class="button">View More...</span><br><br>
    
</div>
              