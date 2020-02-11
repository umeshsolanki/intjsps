<%-- 
    Document   : retReq
    Created on : 27 Apr, 2018, 1:01:17 PM
    Author     : UMESH-ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.Date"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.DistFinance"%>
<%@page import="entities.Admins"%>
<%@page import="entities.FinanceRequest"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>

<%
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        String o=request.getParameter("o");
    DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
    DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
    if(dist==null||LU!=null&&!LU.getRoles().matches(".*\\(.Ret\\).*")){
        out.print("<script>window.location.replace(\"?msg=You don't have permission to access this page\");</script>");
        return;
    }

        List<FinishedProduct> pr=sess.createCriteria(FinishedProduct.class).add(Restrictions.eq("deleted", false)).addOrder(Order.asc("FPName")).list();
        List<DistributorInfo> dr=sess.createCriteria(DistributorInfo.class).add(Restrictions.eq("deleted", false)).add(Restrictions.ne("type", "User")).add(Restrictions.ne("type", "Referer")).list();
%>
        <div class="loginForm" style="background-color: #ababbc;max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="clrRSP();"></span>
    <div class="fullWidWithBGContainer">
    <h2 class="centAlText nomargin nopadding white bgcolt8">Requisition Return</h2><hr>
    <center>
        <form action="FormManager" onsubmit="return false;" method="post" name="retreqForm" id='retreqForm' >
                <input type="hidden" name="action" id="action" value="retReq"/>   
                <input type="hidden" name="o" id="o" value="<%=o%>"/>   
                <br>
                <input class="textField" value="<%=Utils.DbFmt.format(new Date())%>" type="text" id="dt" name="dt" onfocus="(this.type='date');" onblur="(this.type='text');" placeholder="Date"/><br>
                    <script>
                        function selFrom(sel) {
                            if(sel==''){
                                $(".sel").addClass("hidden");
                                $(".cus").addClass("hidden");
                            }else if(sel=='seller'){
                                $(".sel").removeClass("hidden");
                                $(".cus").addClass("hidden");
                            }else{
                                $(".cus").removeClass("hidden");
                                $(".sel").addClass("hidden");
                            }
                        }
                    </script>
                    <textarea class="txtArea"  id="r1" name="r1" placeholder="Return Reason"></textarea><br>
                    <br>
                    <br>
                    <button onclick='return subForm("retreqForm","FormManager")' class="button">Save</button>
                    <br><br>
                    </form>
        
       </center>           
</div>
<style>
    .popSMLE{
        box-shadow: 4px 4px 25px black;
    }
</style>
<%
sess.close();
%>
