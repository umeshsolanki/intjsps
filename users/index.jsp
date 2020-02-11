<%-- 
    Document   : FinanceReq
    Created on : 15 Aug, 2017, 8:54:01 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="utils.UT"%>
<%@page import="entities.Modules"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="entities.SKU"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.Query"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.Date"%>
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
    if(!UT.ia(role, "0")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
        return;
    }
        Date nw=new Date();
        Date[] curr=Utils.gCMon(nw);
%>    
<div class="loginForm" style="max-width: 100%;">
    <style>
        .yellow{
            background-color: yellow !important;
            transition: all 1s;
            color: #449955;
        }
        .normal{
                  background-color: transparent;
                  transition: all 1s;
              }
    </style>
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">   
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\(C0\\).*)")?"":"invisible"%>" onclick="popsl('af/newuser.jsp')" >
                <span class="button white"><i class="fa fa-plus-circle"></i> New User</span></p>
        </div>
        <div class="d3 left leftAlText ">
            <p class="greenFont"> &nbsp;</p>
        </div>
        <div class="d3 left leftAlText">
            <p class="redFont"> &nbsp;</p>
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left rShadow" style="">
            <i class="fa btn fa-arrow-circle-left fa-2x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<!--            <span class="white"><h2 class="nomargin nopadding">Finance Record</h2></span><hr>-->
<div style="">
    <h4 class="nomargin p-15 white bgcolt8">Month: <%=Utils.getWMon.format(new Date())%> </h4><hr>
    <ul>
        <li title="Filters" class="bgcolef">
            <br>
            <form id="prodFil" name="prodFil">
                <select title="For branch" class="textField" name="br"><option>Select Production Branch</option>
                <%
                    List<ProductionBranch> b=sess.createCriteria(ProductionBranch.class).list();
                for(ProductionBranch brr:b){
                %>
                <option value="<%=brr.getBrId()%>"><%=brr.getBrName()%></option>
                <%}%>
            </select><br>
            <select class="textField" name="p" >
                    <option>Select Product</option>
                    <%
                    List<FinishedProduct> fpa= sess.createCriteria(FinishedProduct.class).add(Restrictions.eq("deleted", false)).addOrder(Order.asc("FPName")).list();
                    for(FinishedProduct f:fpa){
                    %>
                    <option value="<%=f.getFPId()%>"><%=f.getFPName()%></option>
                    <%
                    }
                    %>
            </select><br>
            <!--<span class="button right fa fa-arrow-circle-right"></span><i class="right"></i>-->
            <input title="Start date" class="textField" type="date" name="iD"/><br>
            <input class="textField" title="End Date" type="date" name="fD"/><br><br>
            <span class="right" onclick="loadPg('af/SKUStock.jsp?'+gfd('prodFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li><hr>
    </ul>
</div>
<!--<div style="">
    <p class="nomargin nopadding white">Month:Nov </p><hr>
    <ul>
        <li class="navLink leftAlText">Collection <span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Expenditures<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Recd from Complaints<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Recd from Orders<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Paid for Purchase<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Receivable Pending<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Payable Pending<span class="right fa fa-angle-double-right"></span></li>
    </ul>
</div>-->
        <br>
        </div>
        <div class="right sbnvLdr lShadow">
        <!--<span class="white"><h2 class="nomargin nopadding">Existing Users</h2></span>-->
        <hr>
        <table id="header-fixed" border="1px" cellpadding="5" style="margin:0px;" width="100%">
            </table>
        <div class="scrollable">
            <table id="mainTable" class="block" border="1px #000;" width="100%" cellpadding="5">
        <thead class="block" align='left'>
            <tr class="block">
                <th class="cell_4">User Id</th>
                <th class="cell_4">Password</th>
                <!--<th class="cell_4">Permissions</th>-->
                <th class="cell_4">LastLogin</th>
                <th class="cell_4">Branch</th>
                <th class="cell_4">Action</th>
            </tr>
        </thead>        
        <tbody class="block">    
        <%
            List<Admins> admins=sess.createCriteria(Admins.class).add(Restrictions.eq("deleted", false)).list();
            for(Admins pb:admins){  
        %>        
        <tr class="block">
            <td class="cell_4" style="text-transform: capitalize" ><%=pb.getAdminId()%></td>
            <td class="cell_4" ><%=pb.getAdminPass()%></td>
                        <!--<td class="cell_4" style="overflow: auto;min-width: 200px;max-width:250px;"><%=pb.getRole()%></td>-->
                        <td class="cell_4"><%=pb.getLastLogin()%></td>
                        <td class="cell_4"><%if(pb.getBranch()!=null)out.print(pb.getBranch().getBrName());%></td>
                        <td class="cell_4" style="overflow: auto;min-width: 150;max-width: 200;">
                            <button onclick='popsl("af/newuser.jsp?u=<%=URLEncoder.encode(pb.getAdminId())%>")' class="button  fa fa-edit" title="Edit"></button>
                            <button class="button  fa fa-trash-o" onclick="return showDial('action=dU&id=<%=pb.getAdminId()%>','del','Delete User','You can\'t undo this action',false)" title="Delete"></button>
                        </td>
        </tr>        
            <%}%>
        </tbody>
        </table>
        <script>copyHdr("mainTable","header-fixed");</script>
        </div>
      </div>
        </div>
</div>
<%
sess.close();
%>