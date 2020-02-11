    <%@page import="entities.Admins.ROLE"%>
<%@page import="entities.FinishedProductStock"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="entities.StockManager"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="java.util.List"%>
<%@page import="entities.Admins"%>
<center>
<%
              Session sess=null;
              try{
                sess=sessionMan.SessionFact.getSessionFact().openSession();
                }catch(Exception e){
                    e.printStackTrace();
                    out.print("<script>showMes('App Initialization Error was Detected at server',true);</script>");
                    return;
                }
              ProductionBranch br=(ProductionBranch)sess.get(ProductionBranch.class, Long.parseLong(request.getParameter("id")));
              Admins role=(Admins)session.getAttribute("role");
              role.setBranch(br);
              if(role.getRole().matches("(.*Global.*)|(.*"+ROLE.BrStock+".*)")){
                List<StockManager> prods=sess.createCriteria(StockManager.class).addOrder(Order.asc("mat")).add(Restrictions.isNotNull("mat")).add(Restrictions.eq("inBr", role.getBranch())).list();
%>
            <div class="fullWidWithBGContainer">
                <span class="close" onclick="clearViewIn('summary');">&Cross;</span>
                <div class="half left">
                    <span class="white"><h2 class="nopadding nomargin">Material's Stock In <%=role.getBranch().getBrName()%></h2></span>
                <div class="scrollable" >
                <hr><table border='1px' width="100%" cellpadding="5px">
        <thead>
            <tr align="left">
                <!--<th>Date</th>-->
                <th>Material</th>
                <th>In Stock(PPC Unit)</th>
            </tr>
        </thead>
        <tbody>
<%for(StockManager in:prods){%>
            <tr>
                <td><span class="pointer" title="Click to view whole trace of material stock" onclick="loadPageIn('detailCont','brManForms/MaterialConsumedSummary.jsp?i=<%=in.getMat().getMatId()%>')"><%=in.getMat().getMatName()%></span></td>
                <td><%=in.getQty()+" "+in.getMat().getPpcUnit()%></td>
                <!--<td><in.getQtyInPPC()%></td>-->
<%}%>
        </tbody>
        </table>
                </div>
         <!--<br><span class="button">View More...</span>-->
         <br><br>
                </div>
                <div class="half right scrollable" >
                    <!--<span class="white"><h2> Branch : <%=role.getBranch().getBrName()%></h2></span>-->
    <!--<hr><br>-->
                    <div id='detailCont'>        
                    </div>
                </div>
            </div>
    <%}%>
    <div class="fullWidWithBGContainer">
        <div class="half left" >
            <span class="white"><h2 class="nomargin nopadding">Product's Stock in <%=role.getBranch().getBrName()%></h2></span><hr>
        <div class="scrollable boxPcMinHeight" >
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
    <table style="margin:0px" border='1px' width="100%" cellpadding="5px" >
        <thead>
            <tr align="left">
                <th>Product</th>
                <th>Quantity</th>
            </tr>
        </thead>
        <tbody id="MoreCont" border='1px' style="max-height: 500px;overflow: auto">
            <%
            List<StockManager> finProds=sess.createCriteria(StockManager.class).add(Restrictions.eq("inBr", role.getBranch())).add(Restrictions.isNotNull("semiProd")).addOrder(Order.desc("semiProd")).list();
            for(StockManager fp:finProds){
            %>
            <tr>
                <td><span class="pointer" title="Click for details" onclick="loadPageIn('prodRecord','brManForms/ProductConsumedSummary.jsp?i=<%=fp.getSemiProd().getFPId()%>',false)"><%=fp.getSemiProd().getFPName()%></span></td>
                <td><%=fp.getQty()%></td>
            </tr>
            <%}%>
        </tbody>
    </table>
    </form>
        </div>
        </div>
        <div class="half right scrollable lightBlue" id="prodRecord">
            
        </div>
    </div>
        
    </center>