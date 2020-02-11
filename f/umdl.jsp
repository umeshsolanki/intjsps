<%-- 
    Document   : ustk
    Created on : 6 Jan, 2018, 12:55:20 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="java.io.File"%>
<%@page import="entities.Modules"%>
<%@page import="entities.Material"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.Date"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.FinishedProductStock"%>
<%@page import="entities.FinishedProduct"%>
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
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    String mm=request.getParameter("m");
    Modules m=(Modules)sess.get(Modules.class, new Long(mm));
    
%>
<div class="">
    <span class="fa fa-close close" id="close" onclick="clrLSP();"></span>
    <div class="fullWidWithBGContainer">
    <center>
        <div class="">
            <span class="white"><h2 class="nopadding nomargin">Update Module </h2></span><hr>
        <br>
        <form action="U" class="borderRight" method="post" name="loginForm" id='psf' >
            <input type="hidden" name="action"  id="action" value="umdl"/>
            <input type="hidden" name="m"  id="m" value="<%=mm%>"/>
            <!--<input type="date" name="d" id="dt" class="textField" value="<%=Utils.DbFmt.format(new Date())%>"/>-->
            <input type="text" name="tt" id="tt" class="textField" value="<%=m.getTileName()%>" placeholder="Tile Name" />
            <input type="text" name="tu" id="tt" class="textField" value="<%=m.getReqUrl()%>" placeholder="Tile URL" />
            <input type="text" name="tw" id="tt" class="textField" placeholder="Tile Width" value="<%=m.gettWid()%>" /><br>
            <input type="text" name="th" id="tt" class="textField" placeholder="Tile Height" value="<%=m.gettHei()%>"/>
            <input type="text" name="ii" id="tt" class="textField" placeholder="Icon Path" value="<%=m.getTileImage()%>"/>
            <input type="text" name="iw" id="tt" class="textField" placeholder="Icon Width" value="<%=m.getIw()%>"/><br>
            <input type="text" name="ih" id="tt" class="textField" placeholder="Icon Height" value="<%=m.getIh()%>"/>
            <input type="text" name="fs" id="tt" class="textField" placeholder="Text Size"  value="<%=m.getFntSize()%>"/>
            <select class="textField" name="tgtClass" id="tgtClass">
                <option value="">Target Entity</option>
                <%
                File[] fls=new File(request.getRealPath("")+"/WEB-INF/classes/entities").listFiles();
                for(File f:fls){
                    if(!f.getName().contains("$")){%>
                    <option><%=f.getName().replaceAll(".class", "")%></option>  
                    <% 
                    }
                }
            %>
            </select>
                <script>$("#tgtClass").val('<%=m.getTgtEnt()%>');</script>
            <br><br>
            <button onclick='return subForm("psf","U")' id="editBtn" class="button">Save</button>
        </form>
            <br><br>
    </div>
    </center>