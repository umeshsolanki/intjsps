<%-- 
    Document   : newBr
    Created on : Jan 2, 2018, 5:38:21 PM
    Author     : sunil
--%>
<%@page import="utils.UT"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="org.json.JSONArray"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.Admins"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
            List<ProductionBranch> pr=sess.createCriteria(ProductionBranch.class).list();
    %>
<div class="loginForm" style="background-color: #333">
    <span class="close fa fa-close" id="close" onclick="clrLSP()"></span>
        <!--<div class="half left">-->
        <center>
            <span class="white"><h2 class="nomargin nopadding">Create Production Branch</h2></span><hr>
                <form id="prodForm" name='prodForm' onsubmit="return false;">
                    <br>
                <input type="text"  name="action" id="action" value="addProdBranch" hidden/>
                <input class="textField" type="text" id="brId" name="brId" placeholder="Branch Name"/><br><br>
                <input class="textField" type="text" id="pass" name="pass" placeholder="Password"/><br><br>
                <input class="textField" type="text" id="brLoc" name="brLoc"  onsubmit="return false;"placeholder="Location"/><br><br>
                <button onclick='return subForm("prodForm","FormManager")' id="editBtn" class="button">Save</button> 
                </form>
            <br><br>
        </center>
        <!--</div>-->
</div>
        <%
        sess.close();
        %>