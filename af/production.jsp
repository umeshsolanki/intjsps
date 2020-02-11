<%-- 
    Document   : FinishedProduct
    Created on : 26 Jul, 2017, 3:22:39 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="utils.UT"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="entities.Admins"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="entities.FinishedProductStock"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.List"%>
<%@page import="entities.FinishedProduct"%>
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
<div class="loginForm" style="margin: 0px;padding: 0px;">
    <span class="close" id="close" onclick="closeMe()">&Cross;</span>
<div style="">
    <span class="white"><h2 class="nomargin nopadding">Production</h2></span><hr>
    <form id="initProduction" onsubmit="return false;">
        <script>
            function updateDev(proReqId) {
                $('.msg').html("<center><img src='images/loader.svg' width=100 height=100 /></center>");    
                $.post("FormManager","strId="+proReqId+"&action=updProdtn&finS="+$("#stk"+proReqId).val()+"&fin="+$("#"+proReqId).val(),
                function(dat){
                    if(dat.includes("success")){
                        showMes(dat,false);
                    }else{
                        showMes(dat,true);
                }
            });
}
        </script>
    <table  border="1px" width="100%" cellpadding="2" >
        <thead>
            <tr>
                <th>Product Id</th>
                <th>Date</th>
                <th>Branch</th>
                <th>Quantity</th>
                <th>Finished</th>
                <th>Balance</th>
                <!--<th>Distributed</th>-->
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="MoreCont" style="max-height: 500px;overflow: auto">
            <tr>
                <td>
                    <input type="text"  name="action" value="initProduction" hidden/>
                <select class="autoFitTextField" name="prod">
                        <option>Select Finished Product</option>
                
                <%
                List<FinishedProduct> prods=sess.createCriteria(FinishedProduct.class).list();
                for(FinishedProduct fp:prods){
                %>
                <option value="<%=fp.getFPId()%>"><%=fp.getFPName()%></option>
                <%}%>
                    </select>
                </td>
            <td><input class="autoFitTextField" type="date" name="dt" placeholder="Date"/></td>
            <td><input class="textField" type="text"  name="qty" placeholder="Quantity"/></td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>
                <button onclick='return subForm("initProduction","FormManager")' class="button">Add</button>
            </td>
            </tr>
            <%
            List<ProductionRequest> finProds=sess.createCriteria(ProductionRequest.class).add(Restrictions.eq("opening",false)).addOrder(Order.desc("reqId")).list();
            for(ProductionRequest fp:finProds){
                
            %>
            <tr>
                <td><%=fp.getProduct().getFPName()%></td>
                <td><%=fp.getProducedOn()%></td>
                <td><%=fp.getProducedBy().getBrName()%></td>
                <td><%=UT.df.format(fp.getQnt())%></td>
                <td><%=UT.df.format(fp.getDeveloped())%></td>
                <td>
                    <%
                        int bal=fp.getQnt()-fp.getDeveloped();
                        out.print(bal);
                        if(bal>0){
                    %>
                </td>
                <td>
                        <%
                        if(fp.isApproved()){
                        if(fp.getProduct().isSemiFinished()){%>
                    <input id='stk<%=fp.getReqId()%>' type="number" placeholder="To SFS" class="autoFitTextField"/>
                        <%}%>
                    <input id='<%=fp.getReqId()%>' type="number" placeholder="To FPS" class="autoFitTextField"/>
                    <button onclick="updateDev('<%=fp.getReqId()%>');" class="button">Move</button>
                    <%
                    }
                    if(role.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_BR_EA+".*)")&&!fp.isApproved()){
                    %>
                        <button onclick="sendDataWithCallback('FormManager','action=apPR&pr=<%=fp.getReqId()%>',false);this.innerHTML='Approved';" class="button">Approve</button>
                    <%}%>
                </td>
                <%
                   }else{
                   out.print("</td><td>-</td>");
                 }
                %>
            </tr>
            <%}%>
        </tbody>
    </table>
    </form>
</div>
        <!--<br><span class="button" onclick="loadMore('finProd')">View More...</span><br><br>-->
</div>