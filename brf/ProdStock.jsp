<%-- 
    Document   : ProdStock
    Created on : 16 Dec, 2017, 7:38:38 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.StockManager"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="java.util.List"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="entities.Admins"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="fullWidWithBGContainer">
        <div class="tFivePer border scrollable left" style="">
        <%
             Session sess=null;
            try{
                sess=sessionMan.SessionFact.getSessionFact().openSession();
            }catch(Exception e){
                e.printStackTrace();
                out.print("<script>showMes('App Initialization Error was Detected at server',true);</script>");
                return;
            }
            
            Admins role=(Admins)session.getAttribute("role");
              if(role.getRole().matches("(.*"+ROLE.BRM_PRODEA+".*)|(.*"+ROLE.BRM_PRODE+".*)")){
            
        %>
        <span class="white"><h2 style="margin: 0;padding: 0;">Product's Stock in <%=role.getBranch().getBrName()%></h2></span><hr><br>
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
    <table style="margin:0px" width="100%" cellspacing="5" >
        <thead>
            <tr align="left">
                <th>Product</th>
                <th>Quantity</th>
            </tr>
        </thead>
        <tbody id="MoreCont" style="max-height: 500px;overflow: auto">
            <%
            List<StockManager> finProds=sess.createCriteria(StockManager.class).add(Restrictions.isNull("mat")).addOrder(Order.asc("mat")).add(Restrictions.eq("inBr", role.getBranch())).list();
            for(StockManager fp:finProds){
            %>
            <tr>
                <td><span class="navLink" title="Click for details" onclick="loadPageIn('prodRecord','brManForms/ProductConsumedSummary.jsp?i=<%=fp.getSemiProd().getFPId()%>',false)"><%=fp.getSemiProd().getFPName()%></span></td>
                <td><%=fp.getQty()%></td>
            </tr>
            <%}%>
        </tbody>
    </table>
    </form>
        </div>
        <div class="sixtyFivePer boxPcMinHeight right " id="prodRecord">    
            
        </div>
    </div>
        <%}%>