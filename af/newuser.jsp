
<%@page import="entities.Modules"%>
<%@page import="utils.UT"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="java.util.List"%>
<%@page import="entities.UserFeedback"%>
<%@page import="entities.Admins"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="border" style="min-width: 800px">
    <%
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        if(sess==null){
            out.print("Login please");
            return ;
        }
        String us=request.getParameter("u");
        
        Admins a=null;
        if(!UT.ie(us))
        a=(Admins)sess.get(Admins.class, us);
//            DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
//            sess.refresh(dist);
            List<FinishedProduct> pr=sess.createCriteria(FinishedProduct.class).list();
    %>
    <span class="close fa fa-close" id="close" onclick="clrLSP();"></span>
    <center>
        <span class="white"><h2 class="nomargin nopadding centAlText"><%=UT.ie(a)?"Create New":"Update"%> User</h2></span><hr>
        <div class="fullWidWithBGContainer tinyScroll" style="max-height: 500px;">
    <form id="prodForm" name='prodForm' onsubmit="return false;">
        <input type="text"  name="action" id="action" value="<%=UT.ie(a)?"nUser":"UU"%>" hidden/><br>
                <input class="textField" type="text" id="brId" name="uId" placeholder="User Id" value="<%=UT.ie(a)?"":""+a.getAdminId()+"\" onkeydown=\"return false;"%>"/>
                <input class="textField" type="text" id="pass" name="pass" placeholder="Password" value="<%=UT.ie(a)?"":""+a.getAdminPass()%>"/>
                <input class="textField" type="text" id="pass" name="limit" value="<%=UT.ie(a)?"":""+a.getLimitDays()%>" placeholder="Restrict up to Days"/>
                <script>
                    function selModule(mod) {
                    }
                </script>
<select id='linkedBr' class="textField" name="branch" title="No need to select branch if you want to give access to all brances
Select Branch if you want to restrict user to access selected branch
(Stock,Production,Purchase,Finance etc)">
                    <option value="">Select Branch</option>
                    <%
                        List<ProductionBranch> branches=sess.createCriteria(ProductionBranch.class).list();
                        for(ProductionBranch br:branches){
                    %>
                    <option value="<%=br.getBrId()%>"><%=br.getBrName()%></option>
                    <%}%>
                    </select>
                    <div class=""><br>
                    <div  id='branchModule' class="fullWidWithBGContainer">
                        <%
                        List<Modules> mods=sess.createCriteria(Modules.class).list();
                        for(Modules m:mods){%>
                        <div class="leftAlText fullWidWithBGContainer">
                            <div class="half left"><p style="margin:0px;padding: 5px" ><%=m.getTileName()%></p></div>
                            <div class="half right">
                                <p style="margin:0px;padding: 4px" >
                                    <input type="checkbox" name="perm" value="(V<%=m.getModId()%>)" <%=(a!=null&&a.getRole().matches(".*\\(V"+m.getModId()+"\\).*"))?"checked='true'":""%>/>View
                                    <input type="checkbox" name="perm" value="(C<%=m.getModId()%>)" <%=(a!=null&&a.getRole().matches(".*\\(C"+m.getModId()+"\\).*"))?"checked='true'":""%>/>Create
                                    <input type="checkbox" name="perm" value="(U<%=m.getModId()%>)" <%=(a!=null&&a.getRole().matches(".*\\(U"+m.getModId()+"\\).*"))?"checked='true'":""%>/>Update
                                    <input type="checkbox" name="perm" value="(A<%=m.getModId()%>)" <%=(a!=null&&a.getRole().matches(".*\\(A"+m.getModId()+"\\).*"))?"checked='true'":""%>/>Approve
                                    <input type="checkbox" name="perm" value="(D<%=m.getModId()%>)" <%=(a!=null&&a.getRole().matches(".*\\(D"+m.getModId()+"\\).*"))?"checked='true'":""%>/>Delete
                                </p>
                            </div>
                        </div>
                        <%}%>
                    </div>
    </div>
        </form>
        </div>
        <br><button  onclick='return subForm("prodForm","FormManager")' id="editBtn" class="centAlText button"><%=UT.ie(a)?"Save":"Update"%></button> 
            </center>
</div>