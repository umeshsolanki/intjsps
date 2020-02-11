<%-- 
    Document   : LoginForm
    Created on : 21 Sep, 2016, 3:41:33 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.Admins"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="entities.FinishedProductStock"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="entities.StockManager"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.criterion.Criterion"%>
<%@page import="entities.InwardManager"%>
<%@page import="entities.Material"%>
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
if(role.getRole().matches(".*Global.*")){
%>
<div class="loginForm" style="margin: 0px;padding: 0px;">
    <span class="close" id="close" onclick="closeMe()">&Cross;</span>
    <!--<span></span>-->
    
    
    <style>
        table tr th{
            border-bottom: 1px solid #000;
        }
    </style>
    <div>
        <span class="white"><h2>Raw Material Stock Closing</h2></span>
    <hr><br>
    <table style="margin:0px" width="100%" border='1px' cellpadding="5" >
        <thead>
            <tr align="left">
                <!--<th>FinProduct-Id</th>-->
                <th>Material</th>
                <th>Qty</th>
                <!--<th>Rate-Unit</th>-->
            </tr>
        </thead>
        <tbody>
            <%
            List<StockManager> availStock= sess.createQuery("from StockManager where inBr =:br").setParameter("br", role.getBranch()).list();
            for(StockManager im:availStock){
             out.print("<tr><td>"+im.getMat().getMatId()+"</td>");
            if(im.getQty()<0){
             out.print("<td style='color:#ff7777'>"+im.getQty()+" "+im.getMat().getPpcUnit()+"</td></tr>");   
            }else{
                out.print("<td>"+im.getQty()+" "+im.getMat().getPpcUnit()+"</td></tr>");   
            }
            }
            %>
        </tbody>
    </table>
</div>
        
    
    <style>
        table tr th{
            border-bottom: 1px solid #000;
        }
    </style>
    <div>
        <span class="white"><h2>Production Manager </h2></span><hr><br>
    <form id="initProduction">
    <table style="margin:0px" width="100%" cellspacing="5" >
        <thead>
            <tr align="left">
                <th>Product Id</th>
                <!--<th>Materials used</th>-->
                <th>Updated on</th>
                <th>Quantity</th>
<!--                <th>Finished</th>
                <th>Balance</th>
                <th>Action</th>-->
                <!--<th>Rate-Unit</th>-->
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <input type="text"  name="action" value="initProduction" hidden/>
                <select class="autoFitTextField" name="prod">
                        <option>Select Finished Product</option>
                <%
                List<FinishedProduct> prods=sess.createCriteria(FinishedProduct.class).list();
                for(FinishedProduct fp:prods){
                %>
                        <option><%=fp.getFPId()%></option>
                <%}%>
                    </select>
                </td>
            <td><input class="autoFitTextField" type="date" name="dt" placeholder="Date"/></td>
            <td><input class="textField" type="text"  name="qty" placeholder="Quantity"/></td>
            <td>-</td><td>-</td>
            <td><button onclick='return subForm("initProduction","FormManager")' class="button">Add</button></td>
        
            </tr>
            <%
            List<FinishedProductStock> finProds=sess.createCriteria(FinishedProductStock.class).list();
                for(FinishedProductStock fp:finProds){
                
            %>
            <tr>
                <td><%=fp.getFPId().getFPId()%></td>
                <td><%=fp.getUpdatedOn()%></td>
                <td><%=fp.getQnt()%></td>
                <td><input type="number" 
onclick="return sendDataForResp('ActionManager','strId=<%=fp.getStoreId()%>&action=updFPStock&finished='+this.value,false);"
placeholder="Finished" class="autoFitTextField"/><span class="button">Update</span></td>
                <!--<td></td>-->
            </tr>
            <%}%>
        </tbody>
    </table>
    </form>
</div>
    
  
    
    <style>
        table tr th{
            border-bottom: 1px solid #000;
        }
    </style>
    <div style="background-color: #445599;margin: 0px;padding: 1px">
        <span class="white"><h2>Raw Material Inward</h2></span><hr><br>
    <form id="importMaterial">
    <table style="margin:0px" width="100%" cellspacing="5" >
        <thead>
            <tr align="left">
                <th>Material-Id</th>
                <th>Date</th>
                <th>Qty imported</th>
                <th>Qty in PPC Unit</th>
                <th>Action</th>
                <!--<th>Rate-Unit</th>-->
            </tr>
        </thead>
        <tbody>
            <tr>
                
                <td><input type="text"  name="action" value="importMaterial" hidden/>
                <select class="autoFitTextField" name="mat" >
                    <option>Select Material</option>
                    <%
                    List<Material> mat=sess.createCriteria(Material.class).list();
                    for(Material m:mat){
                    %>
                    <option><%=m.getMatId()%></option>
                        <%
                        }
                        %>
                </select></td>
                <td><input type="text"  name="action" id="action" value="addProdBranch" hidden/>
                    <input class="autoFitTextField" type="text" id="brId" name="brId" placeholder="Branch-Id"/></td>
                <td><input class="autoFitTextField" type="text" id="pass" name="pass" placeholder="Password"/></td>
                <td><input class="autoFitTextField" type="text" id="brLoc" name="brLoc" placeholder="Location"/></td>
                <td><button onclick='return subForm("prodForm","FormManager")' id="editBtn" class="button">Add</button> 
                </td>
            </tr>
            <script>
                <%
                    List<ProductionBranch> updateBr = sess.createCriteria(ProductionBranch.class).list();
                    JSONArray jar = new JSONArray();
                    for(ProductionBranch pb:updateBr)
                    {
                        jar.put(new JSONObject(pb.toString()));
                    }
                    out.print("var brJsonArr=JSON.stringify("+jar.toString()+");");        
                %>
                    function showUpdateBr(brId){
                        brId = unescape(brId);
                        var pass,loc;
                        var arr=JSON.parse(brJsonArr);
                        for(var ind in arr){
                            var obj = arr[ind];
//            alert(obj.brId,true);            
            if(obj.brId===brId){
                                pass="";
                                loc=obj.brLoc;
                            }
                        }
                        $("#pass").val(pass);
                        $("#brLoc").val(loc);
                        $("#brId").val(brId);
                        $("#action").val("updBr");
                        $("#editBtn").html("Update");
                        $("#brId").on("keydown",function(){return false;});
                    }
            </script>
            <%
              
                Criterion rest=Restrictions.eq("inBr", role.getBranch());
                List<InwardManager> impHist=sess.createCriteria(InwardManager.class).add(rest).list();
                if(impHist.isEmpty()){
                 out.print("<marquee>No Import History available</marquee>");   
                }
                 for(InwardManager im:impHist){
                 
                 %>
            
            <tr>
                <td> <%=im.getMatId().getMatId()%></td>
                <td> <%=im.getImportOn()%></td>
                <td> <%=im.getQty()+" "+im.getMatId().getImportUnit()%></td>
                <td> <%=im.getQtyInPPC()+" "+im.getMatId().getPpcUnit()%></td>
                <td>-</td>
            </tr>
            <%}%>
        </tbody>
    </table>
    </form>
</div>
  
    
    <style>
        table tr th{
            border-bottom: 1px solid #000;
        }
    </style>
    <div style="background-color: #445599;margin: 0px;padding: 1px">
        <span class="white"><b>Material Consumption</b></span><hr><br>
    <form id="rawMaterialForm">
    <table style="margin:0px" width="100%" cellspacing="5" >
        <thead>
            <tr align="left">
                <th>Finished Product-Id</th>
                <!--<th>Materials used</th>-->
                <th>Date</th>
                <th>Qty</th>
                <th>Action</th>
                <!--<th>Rate-Unit</th>-->
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><input type="text"  name="action" value="importMaterial" hidden/>
                <select class="autoFitTextField" name="mat">
                        <option>Select Finished Product</option>
                        <option>FP1</option>
                    </select></td>
            
                <td><input type="text"  name="action" value="importMaterial" hidden/>
                <select class="autoFitTextField" name="mat" placeholder="">
                        <option>Select Material</option>
                        <option>M1</option>
                    </select></td>
            
            <td><input class="autoFitTextField" type="date" name="dt" placeholder="Date"/></td>
            <td><input class="textField" type="text"  name="qty" placeholder="Quantity"/></td>
            <td><button onclick='return subForm("rawMaterialForm","FormManager")' class="button">Add</button></td>
        
            </tr>
            <tr>
                <td>Pipe-205D-5L</td>
                <td>19/07/2017</td>
                <td>140</td>
                <td>-</td>
                <!--<td></td>-->
            </tr>
        </tbody>
    </table>
    </form>
</div>
    
     <br><span class="button">View More...</span><br><br>
</div>
<%
sess.close();
%>
<br>