<%-- 
    Document   : updateRet
    Created on : 28 Apr, 2018, 4:57:13 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.RepairRecord"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.CustReturns"%>
<%@page import="entities.Material"%>
<%@page import="utils.UT"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="entities.FinishedProduct"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.Date"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.DistFinance"%>
<%@page import="entities.Admins"%>
<%@page import="entities.FinanceRequest"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>

<%
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        Admins role=(Admins)session.getAttribute("role");
        if(!UT.ia(role, "22")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
            return;
        }
        List<FinishedProduct> pr=sess.createCriteria(FinishedProduct.class).add(Restrictions.eq("deleted", false)).addOrder(Order.asc("FPName")).list();
        List<DistributorInfo> dr=sess.createCriteria(DistributorInfo.class).add(Restrictions.eq("deleted", false)).add(Restrictions.ne("type", "User")).add(Restrictions.ne("type", "Referer")).list();
        
        String retId = request.getParameter("i");
        CustReturns cr = (CustReturns) sess.get(CustReturns.class, new Long(retId));
%>
<script>
    <%
        List<Material> mat=sess.createCriteria(Material.class).list();
        JSONArray jar=new JSONArray();
        for(Material m:mat){
            jar.put(new JSONObject(m.toString()));
        }
        out.print("var matJsonArr="+jar.toString()+";");
    %>
        var  matCount=0,matIds=[];
        var  prodCount=0,prodIds=[];
        var prodCode="",prodName="",MRP=0.0;
    function addMatField(){
//            prodCode=$("#proCode").val();
//            prodName=$("#name").val();
//            if(prodCode.length>1){
            matCount++;
            matIds.push(matCount);
    //                                showMes(JSON.stringify(matIds));
    //                                showMes("Total Materials used in "+prodName.value+" = "+matCount,false);
            var sel="<div id='mat"+matCount+"'><select name='matId"+matCount+"' id='matId"+matCount+"' class='textField' ><option>Select Material</option>";
            for(ind in matJsonArr){
                    var obj=matJsonArr[ind];
    //                                        alert(obj['id']);
                    sel+="<option value='"+(obj.id)+"'>"+obj.matName+"</option>";
            }
            sel+="</select>";
            var fieldHtml=sel+"<input name='qnt"+matCount+"' id='qnt"+matCount+"' class='autoFitTextField' type='text' placeholder='*Quantity(PPC-Unit)' />\n\
        <button onclick='remMat("+matCount+");' class=button>&Cross;</button></div>";
            $("#materialsCont").append(fieldHtml);
//        }else{
//            showMes("Product-Id must be larger than 2 characters",true);
//        }
        console.log(JSON.stringify(matIds));
        }
        
        function remMat(id) {
                $("div").remove("#mat"+id);
                matIds.splice(matIds.indexOf(id),1);
                console.log(JSON.stringify(matIds));
            }
   
    function remProd(id) {
//      alert(id);
        $("div").remove("#pro"+id);
        prodIds.splice(prodIds.indexOf(id),1);
//      showMes(JSON.stringify(prodIds));                                
        console.log(JSON.stringify(prodIds));
        }
    function buildJSON() {
        
        var materials=[];
        for(var i=0;i<matIds.length;i++){
            var matId=document.getElementById("matId"+matIds[i]);
            var qnt=document.getElementById("qnt"+matIds[i]);
//                            alert(matIds[i]);
            var qty=Number(qnt.value);
//                            showMes();
            console.log(matId.value);
        if(isNaN(qty)){
            showMes("Enter valid Quantity for Material",true);
            return false;
        }
        if(isNaN(matId.value)){
            showMes("Select Material",true);
            return false;
        }
            var mat={"mat":Number(matId.value),"qnt":Number(qty)};
            if(materials.indexOf(mat)<0){
                materials.push(mat);
            }else{
                showMes("Sorry!! material added twice ",true);
                return false;
            }
        }    
        
//        showMes(JSON.stringify(req));
        return JSON.stringify(materials);
    }
</script>
    <div class="loginForm" style="background-color: #ababbc;max-width: 100%;">
        <form id="updRetRep" onsubmit="return false;">
        <span class="close fa fa-close" id="close" onclick="clrRSP()();"></span>
    <div class="fullWidWithBGContainer">
    <h2 class="centAlText nomargin nopadding white bgcolt8">Update Returns/Repairing</h2><hr>
    <center>
        <div class="fullWidWithBGContainer">
            <div class="">
                <input type="hidden" id="action" name="action" value="updReturnRepair"/>
                <input type="hidden"  name="retId" value="<%=cr.getRetId()%>"/>
                <input type="hidden"  name="brId" value="<%=cr.getRepIn().getBrId()%>"/>
                <input class="textField" placeholder="Repairing Charges" value="0" name="repChg"/>
                <input class="textField" placeholder="Refundable Charges" value="0" name="refChg"/>         
                <select class="textField" name="stat" >
                    <option value="">Select Status</option>
                    <option value="Received">Received for Replacement</option>
                    <option value="ShiftedInBranch">Sent to Production Unit</option>
                    <option value="Repairing">Sent for servicing</option>
                    <option value="Received">Sent for Replacement</option>
                    <option value="ProceedToDistribution">Kept in CSKU</option>
                    <option value="ProceedToLSKU">Kept in Local Store</option>
                </select>
                <table border="1">
                    <thead>
                    <h4 class="white">Materials used in repairing</h4><hr>
                        <tr>
                            <th>Material Name</th><th>Quantity</th></tr>
                                <%
                                    for(RepairRecord cs:cr.getRepRec()){
                                %>
                        <tr>
                            <td><%=cs.getMat().getMatName()%></td>
                            <td><%=cs.getQnt()%></td>
                        </tr>
                            <%}%>
                    </thead>
                </table>
            <div id="materialsCont" style="max-height: 300px;overflow: auto"></div>
            <br>            
            <button class="button white" onclick="addMatField()"><i class="fa fa-plus-circle"></i>Add Material</button>
            </div>
            <br>
            <button onclick="sendDataForResp('FormManager',gfd('updRetRep')+'&mats='+escape(buildJSON()),false,false);">Save</button><br><br><br>
        </div>
    
    </center>
    </div>
        </form
    </div>
<style>
    .popSMRt{
        box-shadow: 4px 4px 25px black;
    }
</style>
<%
sess.close();
%>
