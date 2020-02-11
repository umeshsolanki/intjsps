<%-- 
    Document   : LoginForm
    Created on : 21 Sep, 2016, 3:41:33 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.InwardManager"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="utils.ConnectionString"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.JSONException"%>
<%@page import="entities.Admins"%>
<%@page import="entities.PPControl"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="entities.Material"%>
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
    return; }
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    List<Material> mat=sess.createCriteria(Material.class).list();
    JSONArray matArr=new JSONArray(mat);
%>
<div class="loginForm" style="background-color: #333">  
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
    <span class="close fa fa-close" id="close" onclick="clrLSP()"></span>
        <div class="fullWidWithBGContainer">
                <span class="white"><h2 class="nomargin nopadding centAlText">New Purchase Record</h2></span><hr>
                <center>
        <form id="importMaterial" onsubmit="return false;">
            <br><br>
                <input type="text"  name="action" value="importBill" hidden/>
                <input class="textField" type="date" name="dt" value="<%=Utils.DbFmt.format(new Date())%>" placeholder="Date"/>
                <%if(role.getBranch()==null){%>
                <select title="For branch" class="textField" name="br"><option>Select Production Branch</option>
                <%
                            List<ProductionBranch> b=sess.createCriteria(ProductionBranch.class).list();
                        for(ProductionBranch brr:b){
                        %>
                <option value="<%=brr.getBrId()%>"><%=brr.getBrName()%></option>
                <%}%>
                </select>
                <%}else{%>
                <input type="hidden" value="<%=role.getBranch().getBrId()%>" name="br"/>
                <%}%>
                <select onchange="showUnits(this.value)" class="textField" id="mts" name="mat">
                <option>Select Material</option>
                <%
                for(Material m:mat){
                %>
                <option value="<%=m.getMatId()%>"><%=m.getMatName()%></option>
                <%
                }
                %>
                </select><br>
            <input  class="textField" id="purUnit" type="text"  name="qty" placeholder="Purchase Quantity"/>
            <input class="textField" type="text" id="inUnit"  name="ppcqty" placeholder="Inward Quantity"/>
            <input class="textField" type="text" id="pF"  name="pF" list="rmSel" placeholder="Purchased From"/><br>
            <datalist id="rmSel" style="display: none;">
                <%
                List<String> slrs=sess.createQuery("select distinct(purFrom) from InwardManager").list();
                for(String s:slrs){%>
                    <option value="<%=s%>"/>
                <%}
                %>
            </datalist>
            <input class="textField" type="number" id="amt"  name="amt" placeholder="Amount"/>
            <input class="textField" type="tax" id="tax"  name="igst" placeholder="IGST amount"/>
            <input class="textField" type="tax" id="tax"  name="cgst" placeholder="CGST amount"/><br>
            <input class="textField" type="tax" id="tax"  name="sgst" placeholder="SGST amount"/>
            <input class="textField" type="text" id="bNo"  name="bNo" placeholder="Bill No"/><br><br>
            <button onclick='return subForm("importMaterial","FormManager")' class="button">Save</button>
            <br><br>
        </form>
       </center>
            </div>
        </div>
<%
sess.close();
%>