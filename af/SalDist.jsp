<%-- 
    Document   : FinanceReq
    Created on : 15 Aug, 2017, 8:54:01 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.FinanceRequest.RMK"%>
<%@page import="utils.UT"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.Employee"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="entities.Admins"%>
<%@page import="entities.FinanceRequest"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
Admins role=(Admins)request.getSession().getAttribute("role");
if(role==null){
    response.sendRedirect("?msg=Login Please");
    return;
}
if(!UT.ia(role, "14")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
        return;
}
//Transaction tr = sess.beginTransaction();
%>
<div class="loginForm" style="max-width: 100%;">
    <script>
var payMethod="";
function setPayMethod(val){
    payMethod=val;
    if(val==="Select Payment Method"){
        $("#payId").attr("disabled","disabled");
        $("#payId").val("");
        $("#bkNm").attr("disabled","disabled");
        $("#bkNm").val("");
        $("#amt").attr("disabled","disabled");
        $("#amt").val("");
    }else if(val==="Cash"){
        $("#amt").removeAttr("disabled");
        $("#amt").attr("placeholder","Amount*");
        $("#payId").attr("disabled","disabled");
        $("#payId").val("");
        $("#bkNm").attr("disabled","disabled");
        $("#bkNm").val("");
    }
    else if(val==="DD"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","DD No.*");
        $("#amt").removeAttr("Disabled");
        $("#amt").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");   
    }
    else if(val==="NEFT"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Transaction-Id*");
        $("#amt").removeAttr("Disabled");
        $("#amt").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    else if(val==="RTGS"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Transaction-Id*");
        $("#amt").removeAttr("Disabled");
        $("#amt").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    else if(val==="Cheque"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Cheque No.*");
        $("#amt").removeAttr("Disabled");
        $("#amt").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    else if(val==="Online"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Transaction-Id*");
        $("#amt").removeAttr("Disabled");
        $("#amt").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    }
    <%
                List<DistributorInfo> fin=sess.createCriteria(DistributorInfo.class).list();
                List<Employee> emps=sess.createCriteria(Employee.class)
//                        .add(Restrictions.eq("working",true))
                        .list();
                JSONArray jar = new JSONArray(fin);
                out.print("var fin = JSON.parse(JSON.stringify("+jar.toString()+"));");
    %>
    function getFinId(source){
        
        var selSrc = "<option >Select Source</option>";
        for(var ind in fin){
            var obj = JSON.parse(fin[ind]);
//            alert(fin[ind]);
            if(obj.type===source){
                selSrc +="<option value='"+obj.disId+"'>"+obj.disId+"</option>";
            }
        }
        $("#selSource").html(selSrc);
    }
    var payType="";
    function setPayType(val){
        payType=val;
        if(val==="Select Type"){
            $("#selExp").html(selExp);
//            $("#docket").attr("disabled","disabled");
//            $("#docket").val("");
//            $("#cust_name").attr("disabled","disabled");
//            $("#cust_name").val("");
//            $("#cust_mob").attr("disabled","disabled");
//            $("#cust_mob").val("");
//            $("#cust_bank").attr("disabled","disabled");
//            $("#cust_bank").val("");
//            $("#source").attr("disabled","disabled");
//            $("#selSource").attr("disabled","disabled");
        }
        else if(val==="Credit/Receivable"){
            $("#selExp").html(selCre);
//            $("#docket").removeAttr("disabled");
//            $("#docket").attr("Placeholder","Docket No.*");
//            $("#cust_name").removeAttr("disabled");
//            $("#cust_name").attr("Placeholder","Customer Name*");
//            $("#cust_mob").removeAttr("disabled");
//            $("#cust_mob").attr("Placeholder","Customer Mobile*");
////            $("#cust_bank").removeAttr("disabled");
////            $("#cust_bank").attr("Placeholder","Customer Bank Name*");
//            $("#source").removeAttr("disabled");
//            $("#source").attr("Placeholder","Select Source*");
//            $("#selSource").removeAttr("disabled");
//            $("#selSource").attr("Placeholder","Select Source Name*");
        }
        else if(val==="Debit/Payable"){
            $("#selExp").html(selExp);
//            $("#docket").attr("disabled","disabled");
//            $("#docket").val("");
//            $("#cust_name").attr("disabled","disabled");
//            $("#cust_name").val("");
//            $("#cust_mob").attr("disabled","disabled");
//            $("#cust_mob").val("");
//            $("#cust_bank").attr("disabled","disabled");
//            $("#cust_bank").val("");
//            $("#source").attr("disabled","disabled");
//            $("#selSource").attr("disabled","disabled");
        }
    }
    var selExp="<option>Select Subject</option>\n" +
"                <option>Raw Material Purchase</option>\n" +
"                <option>Sales DepartMent</option>\n" +
"                <option>Employee</option>\n" +
"                <option>ESI</option>\n" +
"                <option>PF</option>\n" +
"                <option>Salaries and PAys</option>\n" +
"                <option>Employer Drawings</option>\n" +
"                <option>Power Bill</option>\n" +
"                <option>Water Bill</option>\n" +
"                <option>Goods Outward Transportation</option>\n" +
"                <option>Goods Inward Transportation</option>\n" +
"                <option>Consultation Charges</option>\n" +
"                <option>Audit Fees</option>\n" +
"                <option>Taxes and Duties</option>\n" +
"                <option>Other</option>";

    var selCre="<option>Select Subject</option><option id=\"prodSale\" name=\"prodSale\">Product Sale</option>\n" +
"                <option id=\"ServiceChrgs\" name=\"ServiceChrgs\">Service Charges(Repair Charges)</option>\n" +
"                <option id=\"comisnChrgs\" name=\"comisnChrgs\">Commission Charges</option>\n";
</script>

    <span class="close" id="close" onclick="closeMe();">x</span>
    <div class="fullWidWithBGContainer">
        <div class="tFivePer left">
    <span class="white"><h2 class="nopadding nomargin">Salary Distribution</h2></span><hr>
        <br>
    <center>
        <form action="FormManager " method="post" name="loginForm" id='finForm' >
            <input type="hidden" name="action" id="action" value="salDist"/>
            <select onchange="setPayType(this.value)" class="textField" type="text" name="emp">
                <option>Select Employee</option>
                <%
                for(Employee e:emps){%>
                <option value="<%=e.getEmpId()%>"><%=e.getEmpId()%></option>
                <%}
                %>
            </select>
            <input class="textField" type="text" id="amt" name="mon" placeholder="Salary Month"/>
            <!--<input class="textField" type="text" id="cust_name" name="cust_name" placeholder="Customer Name*"/>-->
            <!--<input class="textField" type="text" id="cust_mob" name="cust_mob" title="Mobile must be numeric & 10-digit long!!!" placeholder="Customer Mobile*"/>-->
            <select onchange="setPayMethod(this.value)" class="textField" type="text"  id="payMethod" name="payMethod">
                <option>Select Payment Method</option>
                <option>Cash</option>
                <option>DD</option>
                <option>NEFT</option>
                <option>RTGS</option>
                <option>Cheque</option>
                <option>Online</option>
            </select>
            <input class="textField" type="text" id="payId" disabled="true" name="payId" placeholder="Txn-Id/DD/Cheque No.*"/>
            <input class="textField" type="number" id="amt" name="amt" placeholder="Paid Amount*"/>
            
        <input class="textField" type="text" id="bkNm" name="bkNm" disabled="true" placeholder="Bank Name"/><br>
        <textarea class="txtArea"  id="summary" name="summary" placeholder="Details*" ></textarea>
        <br><br>
            <button onclick='return subForm("finForm","FormManager")' id="editBtn" class="button">Save</button>
            <br><br>
        </form>
       </center>           
        </div>
        <div class="sixtyFivePer right">
            <h2 class="nopadding nomargin white">Salary Paid</h2><hr>
              <div class="scrollable">
              <%
//                 Transaction tr = sess.beginTransaction();
      out.write("            <table width=\"100%\" cellpadding='5'>\n");
      out.write("                <thead>\n");
      out.write("                    <tr align='left'><th>Date</th><th>Amount</th><th>Employee</th><th>Summary</th>\n");
      if(role.getRole().matches("Global")){
          out.print("<th>Approved</th>");
      }
      if(role.getRole().matches("(.*Global.*)|(.*"+ROLE.Fin_D+".*)")){
        out.print("<th>Action</th>");
      }
      out.write("            </tr>    </thead>\n");
      out.write("                \n");
      out.write("                ");
                List<FinanceRequest> fins=sess.createCriteria(FinanceRequest.class).add(Restrictions.eq("remark",RMK.Salary)).addOrder(Order.desc("finId")).list();
                for(FinanceRequest req:fins){
      out.write("\n");
      out.write("                <tr>\n");
      out.write("                    <td>");
      out.print(""+req.getTxnDate());
      out.write("</td>\n");
//      
//                out.print("<td style='color:#449944;' onclick='loadPage(\"adminForms/FinanceHistory.jsp?i=0"+req.getCredit()+");'>"+req.getCredit()+"</td>"
//                        +"<td>"+req.getProDesc().getFPName()+"</td>"
//                        +"<td>"+req.getProDesc().getMRP()+"</td>");
                out.print("<td style='color:#ff4444;'>"+req.getDebit()+"</td>");
//                out.print("<td>"+req.getDocketNo()+"</td>");
                
out.write("   <td>"+req.getPersonName()+"</td>");
out.write("   <td>"+req.getSummary()+"</td>");
if(role.getRole().matches("Global")){
      out.print("<td><span class='button' ");
      if(req.isApproved()){
        out.print("style='color:#449944;' >Yes");
      }else{
        out.print("style='color:#ff4444;' onclick=\"sendDataWithCallback('FormManager','i="+req.getFinId()+"&e=1&action=UFA',false,function(){this.innerHTML='Yes';});\" title='click to mark as received'>No");
      }
      out.print("</span></td>");
      }
if(role.getRole().matches("(.*Global.*)|(.*FinanceUpdate.*)")){
    out.print("<td><span class='button'"
    + " onclick=\"sendDataWithCallback('FormManager','i="+req.getFinId()+"&action=DelFin',false,function(){this.innerHTML='Deleted';});\""
    + " title='click to delete this entry'>X</span></td>");  
}
      
      out.write("                </tr>        \n");
      out.write("            ");

                }
                
      out.write("\n");
      out.write("        </table>\n");
      out.write("        </form>\n");
      out.write("       </center>           \n");
      out.write("</div>\n");

              %>
                  </div>
                    
          </div>
        </div>
        
</div>
<%
sess.close();
%>
