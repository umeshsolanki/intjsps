<%-- 
    Document   : up
    Created on : 6 Jun, 2018, 11:21:40 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="utils.UT"%>
<%@page import="java.lang.reflect.Field"%>
<%@page import="java.io.File"%>
<%@page import="entities.Modules"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.SaleInfo"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="entities.DistSaleManager"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="entities.InwardManager"%>
<%@page import="entities.Material"%>
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
    DistributorInfo dis=(DistributorInfo)session.getAttribute("dis");
    if(role==null&&dis==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
<%
    return ;
}else{
    
}
String m=request.getParameter("m");
String i=request.getParameter("i");
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
if(UT.ie(m,i)){%>
<div class="hidden" id="selMod">
    <div>
        <select id="mod" name="mod">
        <option>Select Module</option>
    <%
    List<Modules> mods= sess.createCriteria(Modules.class).addOrder(Order.asc("modId")).list();
    for(Modules mo:mods){%>
    <option value="<%=mo.getModId()%>"><%=mo.getTileName()%></option>
    <%}%>
    </select>
    </div>
    
</div>
<script>
    showDial("","","Select Module",$("#selMod").html());
    $("#confYesBtn").click(function(){
                    loadPg("ef/up.jsp?m=1&i=1");
    });
</script>    
<%
    return ;
}
%>
<center>
    <span class="close fa fa-close" id="close" onclick="clrLSP();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <span class="white"><h2 class="nopadding nomargin bgcolt8">Update Module</h2></span><hr>
        <form onsubmit="return false;" method="post" name="entryUpdateForm" id='upPurForm' >
            <input type="hidden" name="action" id="action" class="" value="genupdate"/>
            <input type="hidden" name="mod" id="mod" value="<%=m%>"/>
            <input type="hidden" name="i" id="i" value="<%=i%>"/>
            <br>
            <%
            Modules mod=(Modules)sess.get(Modules.class, new Long(m));
//            System.out.println(""+mod.getTileName());
//           Package.getPackage("entities").getClass()
            
            Object obj=sess.get(mod.getTgtClass(), new Long(i));
//            Field[] fiel=entities.DistSaleManager.class.getDeclaredFields();
            Field[] fiel=obj.getClass().getDeclaredFields();
            for(Field f:fiel){
                f.setAccessible(true);
                String name=f.getName();
                String type=f.getType().getName();
            if(type.equals("boolean")){%>
            <input name="<%=name%>" type="radio" class="textField" placeholder="<%=name%>" value="<%=f.get(obj)%>"/>
            <%}else if(type.matches("long")){%>
                <input name="<%=name%>" type="number"  class="textField" placeholder="<%=name%>" value="<%=f.get(obj)%>"/>  
            <%}else if(type.matches("double")){%>
                <input name="<%=name%>" type="number"  class="textField" placeholder="<%=name%>" value="<%=f.get(obj)%>"/>
            <%}else if(type.matches("int")){%>
                <input name="<%=name%>" type="number"  class="textField" placeholder="<%=name%>" value="<%=f.get(obj)%>"/>
            <%}else if(type.equals("java.lang.String")){%>
              <input name="<%=name%>" type="number"  class="textField" placeholder="<%=name%>" value="<%=f.get(obj)%>"/>  
            <%}else if(type.equals("java.lang.Date")){  %>
            <input name="<%=name%>" type="number"  class="textField" placeholder="<%=name%>" value="<%=f.get(obj)%>"/>  
            <%}%> 
            <%}%>
            <br><br>
            </form>
    </div>
</center>
<style>
    .popSMLE{
        box-shadow: 4px 4px 25px black;
    }
</style>
<%
sess.close();
%>
