<%-- 
    Document   : BranchManagement
    Created on : 30 Jul, 2017, 12:32:45 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="utils.UT"%>
<%@page import="java.lang.Long"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.Date"%>
<%@page import="entities.Material"%>
<%@page import="utils.Utils"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="entities.Admins"%>
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
    if(!UT.ia(role, "9")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
            return;
        }
    
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        Date nw=new Date();
        Date[] curr=Utils.gCMon(nw);
        String m=request.getParameter("p"),
                iD=request.getParameter("iD"),
                fD=request.getParameter("fD"),
                br=request.getParameter("br");
        Criteria c=sess.createCriteria(Material.class).add(Restrictions.eq("deleted",false));
  
        if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
            c.add(Restrictions.between("producedOn", Utils.DbFmt.parse(iD), Utils.DbFmt.parse(fD)));
        }else{
               c.add(Restrictions.between("producedOn", curr[0],curr[1]));
        }
        if(br!=null&&br.matches("\\d+")){
            c.add(Restrictions.eq("producedBy.brId",new Long(br)));
        }
        if(m!=null&&m.matches("\\d+")){
            c.add(Restrictions.eq("product.FPId",new Long(m)));
        }
        List<Material> mats=sess.createCriteria(Material.class).list();
%>

<div class="loginForm" style="max-width: 100%;">
    <span class="close" id="close" onclick="closeMe();">x</span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\(C9\\).*)")?"":"invisible"%>" onclick="popsl('af/newBr.jsp')">
                <span class="button white"><i class="fa fa-plus-circle"></i> Create New Branch</span></p>
        </div>
        <div class="d3 left leftAlText ">
            <p class="greenFont"><%=iD!=null?"from "+iD:"from "+Utils.HRFmt.format(curr[0])%></p>
        </div>
        <div class="d3 left leftAlText">
            <p class="redFont"><%=iD!=null?"to "+fD:"to "+Utils.HRFmt.format(curr[1])%></p>
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left rShadow" style="">
            <i class="fa btn fa-arrow-circle-left fa-2x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<div style="">
    <p class="nomargin p-15 white bgcolt8  bold">Month: <%=Utils.getWMon.format(new Date())%> </p><hr>
    <ul>
        <li title="Filters" class="bgcolef">
            <br>
            <form id="prodFil" name="prodFil">
                <select title="For branch" class="textField" name="br">
                    <option>Select Branch</option>
                <%
                    List<ProductionBranch> b=sess.createCriteria(ProductionBranch.class).list();
                    for(ProductionBranch brr:b){
                %>
                <option value="<%=brr.getBrId()%>"><%=brr.getBrName()%></option>
                <%}%>
            </select><br>
            <select class="textField" name="p" >
                    <option>Select Material</option>
                    <%
                    for(Material e:mats){
                    %>
                    <option value="<%=e.getMatId()%>"><%=e.getMatName()%></option>
                    <%
                    }
                    %>
                    </select><br>
            <!--<span class="button right fa fa-arrow-circle-right"></span><i class="right"></i>-->
            <input title="Start date" class="textField" type="date" name="iD"/><br>
            <input class="textField" title="End Date" type="date" name="fD"/><br><br>
            <span class="right" onclick="loadPg('af/BranchManagement.jsp?'+gfd('prodFil'))">
            <span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
        <br><br>
        </li>
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
    <center>
        <div style="max-height: 600px;" class="popUp" id="updBr"></div>
    </center>
        <%
        if(role.getRole().matches(".*Global.*")){
        %>
            <script>
                <%
                    List<ProductionBranch> updateBr = sess.createCriteria(ProductionBranch.class).list();
                    JSONArray jar = new JSONArray();
                    for(ProductionBranch pb:updateBr){
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
                        if(obj.brId===brId)
                            {
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
<!--    </form>
        </div>
        <%}
        if(role.getRole().matches("(.*Global.*)?(.*Stock.*)?")){
        %>
-->                    <div class="right sbnvLdr lShadow">
                        <!--<span class="white"><h3  class="nomargin nopadding">Existing Production Branch</h3></span>-->
                        <hr>
                        <table id="header-fixed" border="1px" cellpadding="2" style="margin:0px;" width="100%">
            </table>
                        <div class="scrollable">
                            <table id="mainTable" border="#000; 1px " width="100%" style='margin: 0px;padding: 0px;' cellpadding="5">
                            <thead align='left'>
                                <tr>
                                    <th>Branch</th>
                                    <th>Password</th>
                                    <th>Location</th>
                                    <th>Action</th>
                                </tr>
                            </thead>        
                        <tbody>   
        <%
            List<ProductionBranch> branches=sess.createCriteria(ProductionBranch.class).list();
            for(ProductionBranch pb:branches){  
        %>           <tr>
                        <td><%=pb.getBrName()%></td>
                        <td><%=pb.getBrPass()%></td>
                        <td><%=pb.getBrLoc()%></td>
                        <td >
                            <%if(role.getRole().matches("(.*Global.*)|(.*\\(D|U9\\).*)")){%>
                            <!--<button class="button" onclick="loadInExpandableCont('summary','brManForms/embeddedView.jsp?id=<%=pb.getBrId()%>')">View Stock</button>-->
                            <button onclick='popsl("af/newBr.jsp?u=<%=URLEncoder.encode(pb.getBrName())%>")' class="button  fa fa-edit" title="Edit"></button>
                            <%--<span class="button" onclick="sendDataWithResponse('ActionManager','action=delProdBr&id=<%=pb.getBrId()%>')">Stock Info</span>--%>
                            <%}%>
                        </td>
                    </tr>
                    
<%
}
sess.close();
%>
                </tbody>
            </table>
                <script>
                    copyHdr("mainTable","header-fixed");
                </script>
            </div>
                <%}%>
    </div>
</div>
</div>
   