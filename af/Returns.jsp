<%-- 
    Document   : BranchManagement
    Created on : 30 Jul, 2017, 12:32:45 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.CustReturns"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="com.oracle.jrockit.jfr.Producer"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="entities.Admins"%>
<%@page import="java.util.List"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if(!(session.getAttribute("role") instanceof Admins)){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
<%
    return ;
}
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
List<FinishedProduct> prods=sess.createCriteria(FinishedProduct.class).list();
List<ProductionBranch> branches=sess.createCriteria(ProductionBranch.class).list();
%>
<div class="loginForm">
    <span class="close" id="close" onclick="closeMe();">x</span>
    <div class="fullWidWithBGContainer">
        <div class="half left" style="background: #449955; margin: 0px;padding: 0px;height: 400px;max-height: 400px;overflow: auto">
        <span class="white"><h2>Product Return Request</h2></span><hr>
        <br>
    <center>
        <form action="FormManager " method="post" name="loginForm" id='loginForm'>
            <input type="hidden" name="action" id="action" value="return"/>
            <select class="textField" name="pId" id="pId">
            <option>Select Product</option>
                <%
                for(FinishedProduct fp:prods){
                    %><option value="<%=fp.getFPId()%>"><%=fp.getFPName()%></option><%
                }
                %>
            </select>
            <input class="textField" type="text"  id="amt" name="amt" placeholder="No of products"/>
            <input class="textField" type="text" title="Franchise/Dealer/Distributor/Direct Sale/Online Sale   with their name"  id="from" name="from" placeholder="Purchased From"/>
            <input class="button" title="Upload Bill photo" type="file"  id="bill" name="bill" placeholder="Bill"/>
            <input class="textField" type="text"  id="custN" name="custN" placeholder="Customer Name"/>
            <input class="textField" type="text"  id="custA" name="custA" placeholder="Customer Address"/>
            <input class="textField" type="text"  id="custC" name="cust" placeholder="Customer Contact No"/>
            <input class="textField" type="text"  id="custC" name="custE" placeholder="Customer E-mail"/>
            <br>Purchased on: <input class="textField" type="date"  id="purDate" name="purDate" placeholder="Purchase Date" title="Purchase Date: On which product was purchased by customer"/>
            <br>
            Repairing/Replacement Branch<select class="textField" name="br" id="br">
            <option>Select Branch</option>
                <%
                for(ProductionBranch fp:branches){
                    %><option value="<%=fp.getBrId()%>"><%=fp.getBrName()%></option><%
                }
                %>
            </select>
            <br>
            <button onclick='return subForm("loginForm","FormManager")' id="editBtn" class="button">Save</button>
            <br><br>
        </form>
       </center>
    </div>
    <div class="half right" style="background: #99bb99; margin: 0px;padding: 0px;height: 400px;max-height: 400px;overflow: auto">
        <span class="white"><h2>Recent Returns</h2></span><hr>
          <%
                List<CustReturns> mat=sess.createQuery("from CustReturns").list();
         if(!mat.isEmpty()){
                        out.print("<table  id='matAdded' border = \"1px #0ff\" width = \"100%\" cellspacing = \"5\" cellpadding = \"5\">");
                out.print("<tr  align=left><th>Date</th>"
                        + " <th>Seller</th> <th>Customer</th> <th>Buy Date</th><th>Product</th><th>Branch</th></tr>"
                        + "<tbody style=\"max-height: 500px;overflow: auto\">");
                for(CustReturns m:mat){
                    out.print("<tr><td id=mat"+m.getRetId()+">"+m.getRetOn()+"</td>"
                            + " <td>"+m.getPurchasedFrom()+" </td> <td>"+m.getCust().getName()+", "+m.getCust().getMob()
                            +" </td> <td>"+m.getPurchaseDate()+"</td>"
                            + "<td>"+m.getProd().getFPName()+" "+m.getStatus()+"</td>"
                            + "<td>"+m.getRepairedBranch().getBrName()+"</span></td>"
                            + "</tr>");
                }
                out.print("</tbody></table>");
         }
        %>
    </div>
    </div>      
</div>
    <center>
                    <div style="padding: 1px;" class="fullWidWithBGContainer" id="subPageContainer">
                        
                    </div>
    </center>