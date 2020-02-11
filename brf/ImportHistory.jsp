<%-- 
    Document   : ImportHistory
    Created on : 26 Jul, 2017, 1:31:45 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.Admins.ROLE"%>
<%@page import="org.json.JSONArray"%>
<%@page import="entities.MaterialStockListener"%>
<%@page import="entities.StockManager"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="utils.ConnectionString"%>
<%@page import="java.sql.Connection"%>
<%@page import="entities.Admins"%>
<%@page import="entities.Material"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.InwardManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="loginForm" style="margin: 0px;padding: 0px;">
    <span class="close" id="close" onclick="closeMe()">&Cross;</span>
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
    int ini=0;
    if(iLim!=null&&iLim.matches("\\d+")){
        ini=Integer.parseInt(iLim);
    }
    List<Material> mat=sess.createCriteria(Material.class).list();
    JSONArray matArr=new JSONArray(mat);
   
    List<InwardManager> prods=sess.createCriteria(InwardManager.class).addOrder(Order.desc("importId")).
            setFirstResult(ini).setMaxResults(20).add(Restrictions.eq("inBr", role.getBranch())).list();
    %>

    <div class="popUp" id="vTicket">
        
    </div>
    <div class="popUpRight hidden" style="max-width: 400px;" id="ticketCont" >
        <span class="close" onclick="$('#ticketCont').css('display','none');">&Cross;</span>
        <span class="white"><h2 class="nomargin nopadding">Wrong Entry Ticket</h2></span><hr>
            <center>
                <form action="FormManager" onsubmit="return false;" method="post" name="loginForm" id='ticketForm'>
                    <input type="hidden" name="action" id="action" value="ticket"/>
                    <input type="hidden" name="in" id="in" value=""/>
                    <input class="textField" type="text" id="name" name="name" placeholder="Entry Person Name*"/><br><br>
                    <input class="textField" type="text" id="sub" name="sub" placeholder="Subject*"/><br><br>
                    <!--<input class="textField" type="date" id="date" name="date"/><br><br>-->
                    <textarea class="txtArea"  id="issMes" name="issMes" placeholder="Issue detail*" ></textarea><br><br>
                    <button onclick='return subForm("ticketForm","FormManager")' id="editBtn" class="button">Send</button>
                    <br><br>
                </form>
            </center>
    </div>
    
    <script>
        var matArr=<%=matArr.toString()%>;
        function showUnits(matId) {
//            alert(matId);
            for(var i in matArr){
                var obj=JSON.parse(matArr[i]);
//                alert(obj);
                if(obj.id==matId){
//                alert("found");    
                $("#inUnit").attr("placeholder","Inward Quantity in "+obj.ppc);
                $("#purUnit").attr("placeholder","Purchase Quantity in "+obj.unit);
                break;
                }
            }
        }
        function showTicketBox(mes,id){
         $("#ticketCont").css("display","block");
//         alert("om");
         $("#in").val(id);
         $("#ticketCont").css("visibility","visible");
         $("#issMes").val(mes+"continue your message from here <br>\n");
         $("#sub").val("Import wrong Entry updation");
         return false;
        }
        function viewTicket(Mess,resp) {
//            alert(Mess);
            $('#vTicket').html("<span class=\"close\" onclick=\"$('#vTicket').html('');\">&Cross;</span>"+Mess);
            return false;
        }
    </script>
    
    <div>
        <span class="white"><h2 class="nopadding nomargin">Inward Record in <%=role.getBranch().getBrName()%></h2></span>
    <hr>
    <form id="importMaterial" onsubmit="return false;">
      <table style="margin:0px" width="100%" border='1px' cellpadding="2" >
        <thead>
            <tr align="center">
                <th>Date</th>
                <th>Material</th>
                <th>Opening</th>
                <th>Purchase</th>
                <th>Inward</th>
                <th>Closing</th>
                <th>PurcFrom</th>
                <th>BillRef</th>
                <%--if(role.getRole().matches(".*InwardModify.*")){--%>
                <th>Action</th>
                <%--}--%>
            </tr>
        </thead>
        <tbody id="dataCont">
            <tr align="center">            
                <input type="text"  name="action" value="importMaterial" hidden/>
                      <td style="width: 50px;"><input class="autoFitTextField" type="date" name="dt" placeholder="Date"/></td>
                      <td><select onchange="showUnits(this.value)" class="autoFitTextField" name="mat" >
                    <option>Select Material</option>
                    <%
                    for(Material m:mat){
                    %>
                    <option value="<%=m.getMatId()%>"><%=m.getMatName()%></option>
                        <%
                        }
                        %>
                    </select></td>
            
                    <td><input  class="autoFitTextField" id="purUnit" type="text"  name="qty" placeholder="Purchase Quantity"/></td>
            <td><input class="autoFitTextField" type="text" id="inUnit"  name="ppcqty" placeholder="Inward Quantity"/></td>
            <td><input class="autoFitTextField" type="text" id="pF"  name="pF" placeholder="Purchased From"/></td>
            <td><input class="autoFitTextField" type="text" id="bNo"  name="bNo" placeholder="Bill No"/></td>
            <td></td><td></td>
            <td><button onclick='return subForm("importMaterial","FormManager")' class="button">Add</button></td>
            <td></td>
            </tr>
<%
    for(InwardManager in:prods){
%>

<tr id="IE<%=(in.getImportId())%>" align="center" <%if(in.getTick()!=null){
            out.print("style='color:red;' title='wrong entry ticket generated for this entry'");
                }%>>
                <td><%=in.getImportOn()%></td>
                <td><%=in.getMatId().getMatName()%></td>
                <td><%=in.getInStockBFRTr()+" "+in.getMatId().getPpcUnit()%></td>
                <td><%=in.getQty()+" "+in.getMatId().getImportUnit()%></td>
                <td><%=in.getQtyInPPC()+" "+in.getMatId().getPpcUnit()%></td>
                <td><%=(in.getInStockBFRTr()+in.getQtyInPPC())+" "+in.getMatId().getPpcUnit()%></td>
                <td><%=(in.getPurFrom())%></td>
                <td><%=(in.getBillNo())%></td>
                <%if(role.getRole().matches("(.*"+ROLE.BRM_RMEA+".*)")){%>
                <td>
                    <%if(!in.isApproved()){%>
                    <button class="fa fa-check-circle redFont button" onclick="sendDataWithCallback('FormManager','action=apIE&IE=<%=in.getImportId()%>',false,function(){})"></button>
                    <button class="fa fa-trash button" title="Delete This Entry" onclick='dm("BRP","<%=(in.getImportId())%>","IE<%=(in.getImportId())%>")'></button>
                    <%}%>
                </td>
                <%}%>
            </tr>
<%}%>
        </tbody>
    </table>
    </form>
        
         <!--<br><span class="button">View More...</span><br><br>-->
    </div>