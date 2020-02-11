<%-- 
    Document   : BrTransfer
    Created on : 25 Oct, 2017, 8:27:34 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.Admins.ROLE"%>
<%@page import="entities.MatTransferManager"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="entities.BranchTransfer"%>
<%@page import="entities.Material"%>
<%@page import="java.util.List"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.Admins"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
List<ProductionBranch> branches=sess.createCriteria(ProductionBranch.class).list();
List<Material> matsList=sess.createCriteria(Material.class).list();

%>


<div class="loginForm" style="max-width: 100%;">
    <span class="close" id="close" onclick="closeMe();">X</span>
    <div class="fullWidWithBGContainer boxPcMinHeight">
        <%
        if(role.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_BR_RMTE+".*)")){
        %>
        <div class="half left">
            <span class="white"><h2 class="nopadding nomargin">Material Transfer</h2></span><hr>
    <form id="matTransfer" name='matTransfer' onsubmit="return false;">
                    <input type="text"  name="action" id="action" value="transMats" hidden/>
                     <input class="textField" type="text" id="dt" name="dt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Date"/><br>
                    <!--Search for materials you want to transfer( To search All type (..) without brackets)<br><br>-->
                    <input onclick="getMats(this.value);" type="search" placeholder="Search Material to Transfer" id="srch" name="srch" class="textField" onkeyup="getMats(this.value)"/>
                    <div id="matRes" style="cursor: pointer;font-size: 14px;max-width: 500px;z-index: 9999;overflow: auto;margin: 0px;max-height: 250px;;display: none;" ></div><br>
                    <div id="purMat" class="scrollable">
                        
                        <script>
                            
                var matsArr=<%=matsList%>;
                
                function getMats(filter) {
                        if(filter.toString().length>1){
                            $("#matRes").html("");
                            $("#matRes").css("display","block");
                            var patt=new RegExp(".*"+filter+".*","i");
                            for(var i=0;i<matsArr.length;i++){
                            var mat=matsArr[i];
                            if(patt.test(mat.matName)){
                                $("#matRes").append("<div class='textField' onclick=\"addMat("+mat.id+");\">"+mat.matName+"</div>");
                            }
                        }
                    }else{
                            $("#matRes").html("");
                            $("#matRes").css("display","none");
                    }
                    }
                            
            var matCount=0,matIds=[];
                    function addMat(id){
                    $("#matRes").html("");
                    $("#srch").val("");
                    $("#matRes").css("display","none");
//                    showMes("Total Materials used in "+prodName.value+" = "+matCount,false);
                    
                    for(var ind in matsArr){
                            var obj=matsArr[ind];
                        if(obj.id===id){
                            matIds.push(matCount);
//                            alert(JSON.stringify(prodIds));
                            var sel="<div id='mat"+matCount+"'>";
                            sel+="<input class=\"textField\" type=\"text\" disabled=\"true\" value=\""+obj.matName.replaceAll("\"","&quot;")+"\"/>\n\
                                <input class=\"autoFitTextField\" type=\"number\" id=\"qnt"+matCount+"\" matid=\""+obj.id+"\" placeholder=\"Quantity\" />";
                            var fieldHtml=sel+"<button onclick='remMat("+matCount+");' class=button>&Cross;</button></div>";
                            $("#purMat").append(fieldHtml);
                            matCount++;
                        }
                    }
                        return false;
//                            console.log(JSON.stringify(matIds));
                    }
                            function remMat(id) {
//                        alert(id);
                        $("div").remove("#mat"+id);
                        matIds.splice(matIds.indexOf(id),1);
//        alert(JSON.stringify(prodIds));
                                        
        console.log(JSON.stringify(matIds));
                    }
                    
                    function buildJson(){
                         var mIds=[];
                         var req={action:"matTFR",dt:$("#dt").val(),srcBr:$("#sendingBr").val(),destiBr:$("#receivingBr").val(),mats:[]};
                                
                                for(var c=0;c<matIds.length;c++){
                                    var order={pro:0,qnt:0};                    
                                    order.qnt=$("#qnt"+matIds[c]).val();
                                    order.pro=$("#qnt"+matIds[c]).attr("matid");
//                                    alert(JSON.stringify(order));
                                    if(order.qnt>0){
                                        mIds.push(order);
//                                        alert(proIds.length);
                                    }
                                }
                                req.mats=mIds;
//                                req.dt=$("#date").val();
//                      console.log(JSON.stringify(req));  
        sendDataForResp("FormManager",JSON.stringify(req),true);
//        alert(JSON.stringify(req));                
//                        showMes(,false);
                      return false;
                    }
                
                    
                            </script>
                    </div>
                    <select id='sendingBr' class="textField" name="sendingBr"><option>Select Source Branch</option>
                        <%for(ProductionBranch br:branches){
                    %>
                    <option value="<%=br.getBrId()%>"><%=br.getBrName()%></option>
                    <%}%>
                    </select><br>
                    <select id='receivingBr' class="textField" name="receivingBr"><option>Select Destination Branch</option>
                        <%for(ProductionBranch br:branches){
                    %>
                    <option value="<%=br.getBrId()%>"><%=br.getBrName()%></option>
                    <%}%>
                    </select><br><br>
                <!--<input class="textField" type="text" id="qty" name="qty" placeholder="Quantity"/><br><br>-->
                <button onclick='return buildJson();' id="editBtn" class="button">Send</button> 
                </form>
        </div>
                    
    <div class="half right" >
        <span class="white"><h2 class="nopadding nomargin">Transfer Details</h2></span><hr>
        <div class="scrollable">
        <table border="0" width="100%" style='margin: 0px;padding: 0px;' cellpadding="5">
            <thead align='left'>
                <tr>
                    <th>Date</th>
                    <th>Mats</th>
                    <th>Source</th>
                    <th>Destination</th>
                    <th>Action</th>
                </tr>
            </thead>        
        <tbody>
        <%
            List<MatTransferManager> matTr=sess.createCriteria(MatTransferManager.class).list();
            for(MatTransferManager mtm:matTr){  
        %>           
        <tr>
            <td><%=mtm.getTfrOn()%></td>
            <td><%=mtm.getTfrRecord()%></td>
            <td><%=mtm.getFromBr().getBrName()%></td>
            <td><%=mtm.getToBr().getBrName()%></td>
            <td><button  onclick='showUpdateBr(escape("<%=mtm.getTrId()%>"))' class="button" >Edit</button></td>
        </tr> 
        <%
            }}
sess.close();
            %>
            </tbody>
                        </table>
                </div>
            </div>
        </div>
</div>
        

