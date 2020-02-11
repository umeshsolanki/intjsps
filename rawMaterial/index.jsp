<%-- 
    Document   : LoginForm
    Created on : 21 Sep, 2016, 3:41:33 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="utils.UT"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.Date"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.ConnectionString"%>
<%@page import="utils.Utils"%>
<%@page import="entities.Admins"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="entities.Material"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div  class="loginForm">
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
    if(!UT.ia(role, "21")){
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
        Criteria c=sess.createCriteria(Material.class).add(Restrictions.eq("deleted",false)).addOrder(Order.asc("matName"));
  
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
        
List<ProductionBranch> branches=sess.createCriteria(ProductionBranch.class).list();

%>
<script>
                <%
                    List<Material> mats=sess.createCriteria(Material.class).list();
                    JSONArray jar=new JSONArray();
                    for(Material mt:mats){
                        jar.put(new JSONObject(mt.toString()));
                    }
                    out.print("var matJsonArr="+jar.toString()+";");
                %>
            
                function showUpdateForm(x) {
//                   var matId=document.getElementById(x).innerHTML;
//                   alert();
                    $("#leftPop").load('rawMaterial/newMat.jsp',function(){
                     var rate,name,deadline;
                    for(var ind in matJsonArr){
                        var obj=matJsonArr[ind];
                        if(obj.id==x){
                            name=obj.matName;
                            rate=obj.rate;
                            deadline=obj.deadLine;
                        }
                    }
                        $("#minQnt").val(deadline);
                        $("#rate").val(rate);
                        $("#id").val(x);
                        $("#action").val("updMat");
                        $("#adButton").html("Update");
                        $("#matName").val(name);
    //                    $("#matName").on("keydown",function(){return false});
    //                    document.getElementById("topScroll").scrollIntoView();    
                    });
                }
        </script>
        
    <span class="close" id="close" onclick="closeMe();">x</span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\(C8\\).*)")?"":"invisible"%>" onclick="popsl('rawMaterial/newMat.jsp')">
                <span class="button white"><i class="fa fa-plus-circle"></i> Add Material</span></p>
        </div>
        <div class="d3 left leftAlText ">
            <p class="greenFont">&nbsp;</p>
        </div>
        <div class="d3 left leftAlText">
            <p class="redFont">&nbsp;</p>
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left rShadow" style="">
            <i class="fa btn fa-arrow-circle-left fa-2x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<div style="">
    <p class="nomargin p-15 white bgcolt8  bold">Month: <%=Utils.getWMon.format(new Date())%> </p><hr>
    <ul class="bgcolef">
        <li title="Filters">
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
            <span class="right" onclick="loadPg('rawMaterial/AddMaterial.jsp?'+gfd('prodFil'))">
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
    <div class="right sbnvLdr lShadow" >
        <!--<span class="white"><h2 class="nomargin nopadding centAlText">Existing Materials </h2></span>-->
        <hr>
        <table id="header-fixed" border="1px" cellpadding="2" style="margin:0px;" width="100%">
            </table>
        <center>
            <div class="scrollable" >
                <form id="initProduction" onsubmit="return false;">       
            <!--<hr>-->
        <%
                List<Material> mat=sess.createCriteria(Material.class).add(Restrictions.eq("deleted",false)).addOrder(Order.asc("matName")).list();
                if(!mat.isEmpty()){
                        out.print("<table  id='mainTable' border = \"1px #0ff\" width = \"100%\" cellspacing = \"5\" cellpadding = \"1\">");
                out.print("<thead><tr  align=left><th>SNo</th><th>Material</th>"
                        + " <th>Import Unit</th> <th>PPC Unit</th> <th>Rate/Price Per Unit</th><th>Stock Deadline</th><th>Action</th></tr></thead>"
                        + "<tbody style=\"max-height: 500px;overflow: auto\">");
                int i=0;
                for(Material mt:mat){
                    i++;
                    out.print("<tr id='row"+mt.getMatId()+"'><td>"+i+"</td><td id=mat"+mt.getMatId()+">"+mt.getMatName()+"</td>"
                            + " <td>"+mt.getImportUnit()+" </td> <td>"+mt.getPpcUnit()+" </td>"
                            + " <td>"+UT.df.format(mt.getRate())+"</td>"
                            + "<td>"+UT.df.format(mt.getMinQnt())+" "+mt.getPpcUnit()+"</td>");
                    %>
        <td>
            <%if(role.getRole().matches("(.*Global.*)|(.*\\(D21\\).*)")){%>
            <button class="fa fa-trash" onclick="showDial('action=dMat&i=<%=mt.getMatId()%>','del','<i class=\'redFont\'>Delete</i> <%=mt.getMatName().replaceAll("\"", "&quot;").replaceAll("'", "\'")%>','You can\'t undo it');"></button>
            <%}if(role.getRole().matches("(.*Global.*)|(.*\\(U21\\).*)")){%>
                
                <span class='button fa fa-edit' title='edit' onclick='showUpdateForm("<%=mt.getMatId()%>");'></span>
            <%}%>
        </td>
        </tr>
                <%}
                out.print("</tbody></table>");
         }
        %>
        <script>
            copyHdr("mainTable","header-fixed");
        </script>
         </div>
        </div>
    </div>
<!--</center>-->
</div>
<%
sess.close();
%>