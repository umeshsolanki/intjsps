<%-- 
    Document   : FinishedProduct
    Created on : 26 Jul, 2017, 3:22:39 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="utils.Utils"%>
<%@page import="java.util.Date"%>
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
    <!--<span></span>-->
    
    
    
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
                <th >Product</th>
                <th >Date</th>
                <th >Qty</th>
                <th >Produced</th>
                <th >Under Production</th>
                <!--<th>Distributed</th>-->
                <th >Action</th>
        
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
            <td>-</td><td>-</td>
            
            <td>
                <button onclick='return subForm("initProduction","FormManager")' class="button">Add</button>
            </td>
            </tr>
            <%
            List<ProductionRequest> finProds=sess.createCriteria(ProductionRequest.class).add(Restrictions.eq("producedBy", role.getBranch())).add(Restrictions.eq("opening",false)).addOrder(Order.desc("reqId")).list();
            for(ProductionRequest fp:finProds){
                
            %>
            <tr>
                <td><%=fp.getProduct().getFPName()%></td>
                <td><%=fp.getProducedOn()%></td>
                <td><%=fp.getQnt()%></td>
                <td><%=fp.getDeveloped()%></td>
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
                if(bal>0){
        %>
            <input id='fins<%=fp.getReqId()%>' type="number" placeholder="Manufactured" title="Manufactured out of balance" class="smTF"/>
            <input id='da<%=fp.getReqId()%>' type="date" value="<%=Utils.DbFmt.format(new Date())%>" title="Manufactured on" class="smTF"/>
            <button title="Update manufactured" onclick='sdfr("FormManager","strId="+<%=fp.getReqId()%>+"&action=updProdtn&dt="+$("#da<%=fp.getReqId()%>").val()+"&fins="+$("#fins<%=fp.getReqId()%>").val(),false);' class="button fa fa-arrow-circle-right"></button>
            <%}%>
            <button onclick="popsl('af/BRConsumption.jsp?p=<%=fp.getReqId()%>')" class="button fa fa-eye"></button>
            <button  title="Generate Batch Barcodes" onclick="popsl('af/pbars.jsp?p=<%=fp.getReqId()%>')" class="button fa fa-barcode"></button>
            <%
            }else if(role.getRole().matches("Global|.*"+ROLE.BRM_PRODEA+".*")&&!fp.isApproved()){
            %>
            <button class="fa fa-trash button" title="Delete This Entry" onclick='dm("BRPN","<%=(fp.getReqId())%>","PR<%=(fp.getReqId())%>")'></button>
            <button onclick="sendDataWithCallback('FormManager','action=apPR&pr=<%=fp.getReqId()%>',false);this.innerHTML='Approved';" class="button fa fa-thumbs-up redFont"></button>
            <%}%>
                <%
                   }else{
                   out.print("</td><td>-</td>");
                 }
                %>
                </td>
            </tr>
            <%}%>
        </tbody>
    </table>
    </form>
</div>
        <script>
            var next=<%=ini%>;
           function loadMore(loadId){
                next+=20;
                var data="load="+encodeURI(loadId)+"&id="+encodeURI("<%=role.getBranch().getBrId()%>")+"&ini="+next;
                alert(data);
                $.post("ReadMore",data,function(res){
                    $("MoreCont").html(res);
                });
                }
            
        </script>
        <!--<br><span class="button" onclick="loadMore('finProd')">View More...</span><br><br>-->
</div>