<%-- 
    Document   : BranchManagement
    Created on : 30 Jul, 2017, 12:32:45 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.Material"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.Date"%>
<%@page import="utils.UT"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="entities.ActivityTracer"%>
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
        if(!UT.ia(role, "2")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
        return;
        }
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
List<ActivityTracer> tracer=sess.createCriteria(ActivityTracer.class).addOrder(Order.desc("actId")).list();

%>
<div class="loginForm">
    <span class="close" id="close" onclick="closeMe();">&Cross;</span>
    <div class="fullWidWithBGContainer">
        <div class="subNav left rShadow" style="">
        <div style="">
            <p class="nomargin p-15 white bgcolt8  bold">Month: <%=Utils.getWMon.format(new Date())%> </p><hr>
            <ul>
                <li title="Filters" class="bgcolef">
                    <br>
                    <form id="purFil" name="purFil">
                    <input title="Start date" value="" class="textField" type="date" name="iD"/><br>
                    <input class="textField" value="" title="End Date" type="date" name="fD"/><br><br>
                    <span class="right" onclick="loadPg('af/BRPurchases.jsp?'+gfd('purFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
                    </form>
                    <br><br>
                </li>
            </ul>
        </div>
<!--        <div style="">
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
        </div>
        <div class="sbnvLdr right">
        <h2  class="white nomargin spdn">Recent Activities</h2><hr>
        <table id="header-fixed" border="1px" cellpadding="2" style="margin:0px;" width="100%">
            </table>
        <div style=" margin: 0px;padding: 0px;height: 500px;max-height: 500px;overflow: auto" class="scrollable">
                            <table id="mainTable" border="1px" width="100%" cellpadding="2">
                            <thead align='left'>
                                <tr>
                                    <th>User</th>
                                    <th>Time</th>
                                    <th>Remark</th>
                                    <th>Action</th>
                                </tr>
                            </thead>        
                        <tbody>    
                        <%
                            Transaction tr=sess.beginTransaction();
                            for(ActivityTracer pb:tracer){
                        %>
                        <tr <%if(!pb.isSeen()){out.print("style='color:red;background:#efefef;'");}%>>
                            <td style="text-transform: capitalize;"><%=(UT.ie(pb.getAdminId())?(pb.getSeller()!=null?pb.getSeller().getDisId():""):pb.getAdminId().getAdminId())%></td>
                            <td><%=pb.getActTime()%></td>
                            <td><%=pb.getActDesc()%></td>
                            <td></td>
                        </tr>
                            <%
                            pb.setSeen(true);
                            sess.update(pb);
                            }
                            tr.commit();
                            sess.close();
                            %>
                            </tbody>
                    </table>
        <script>
            copyHdr("mainTable","header-fixed");
        </script>
        </div>
        </div>
    </div>
        </div>