<%-- 
    Document   : MaterialConsumption
    Created on : 28 Jul, 2017, 10:36:18 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="java.util.regex.Pattern"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URL"%>
<%@page import="entities.Tracker"%>
<%@page import="entities.Material"%>
<%@page import="utils.UT"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="entities.Admins"%>
<%@page import="entities.MaterialConsumed"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.StockManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div  class="loginForm" style="background-color: #fff;">
    <!--<span></span>-->
    <style>
        table tr th{
            border-bottom: 1px solid #000;
        }
    </style>
<%
    String p=request.getParameter("p");
    Admins role=(Admins)session.getAttribute("role");
    if(role==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login");
        </script>
        <%
    return ;
}
    if(!UT.ia(role, "17")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
            return;
        }
    
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    String iLim=request.getParameter("ini");
    Date nw=new Date();
    Date[] curr=Utils.gCMon(nw);
    String iD=request.getParameter("iD"),fD=request.getParameter("fD");
    Criteria c=sess.createCriteria(Tracker.class).addOrder(Order.desc("hitTime"));

    if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
        c.add(Restrictions.between("hitTime", Utils.DbFmt.parse(iD), Utils.DbFmt.parse(fD)));
    }else{
        c.add(Restrictions.between("hitTime", curr[0],curr[1]));
    }
    
    %>
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left leftAlText">&nbsp;</div>
        <div class="d3 left leftAlText"></div>
    </div>
    <div class="fullWidWithBGContainer">
        <br>
        <div class="subNav left" style="">
        <i class="fa btn fa-arrow-circle-left fa-1pt25x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
        <div style="padding: 1px;border: 1px white solid;" class="bgcolef">
        <p class="nomargin nopadding white bgcolt8"></p>
        <hr>
            <%
//            List<Object[]> visits=sess.createQuery("select count(*),target "
//                + "from Tracker tk where ( tk.hitTime between :id and :fd ) group by target")
//                .setParameter("id", curr[0]).setParameter("fd", curr[1]).list();
            double totalVisits=0;
            List<Object[]> domainWise;
            List<Object[]> cityWise;
            List<Object[]> countryWise;
            List<Object[]> tgtWise;
            %>
            <ul>
                <li>
                <br>
                <form id="mktForm">
                <input title="Start date" class="textField" value="" type="date" name="iD"/><br>
                <input class="textField" title="End Date" value="" type="date" name="fD"/><br><br>
                <span class="right" onclick="loadPg('marketing/marketing.jsp?'+gfd('mktForm'))">
                <span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
                <br><br>
                </form>
                </li>
            </ul>
        </div><br>
        </div>
        <div class="right sbnvLdr" >
        <div class="fullWidWithBGContainer">
            <!--<h3 class="bgcolef nomargin nopadding">Website User Activities</h3>-->
            <div class="fullWidWithBGContainer">
                <p class="d3 left"><b class="greenFont">Total Hits </b></p>
                <p class="d3 left"><b class="bluFnt">Total Visits</b></p>
                <p class="d3 left"><b class="redFont">Total Visits</b></p>
            </div>
                <hr>
            <div >
                <div class="d3 left">
                    <div class="tileCont">
                    <div class="tile">
                        <p class="">Today Visits</p>
                    </div>   
                    <div class="tile">
                        <p class="">Order Page Visit</p>
                    </div>   
                    <br><br>
                </div>
                </div>
                <div class="d3 left">
                    <div class="tileCont">
                    <div class="tile">
                        <p class="">Today Visits</p>
                    </div>   
                    <div class="tile">
                        <p class="">Order Page Visit</p>
                    </div>   
                    <br><br>
                </div>
                </div>
                <div class="d3 left">
                    <div class="tileCont">
                    <div class="tile">
                        <p class="">Today Visits</p>
                    </div>   
                    <div class="tile">
                        <p class="">Order Page Visit</p>
                    </div>   
                    <br><br>
                </div>
                </div>
                
            <%
        //    List<Object[]> visits=sess.createQuery("select count(*),target "
        //        + "from Tracker tk where ( tk.hitTime between :id and :fd ) group by target")
        //        .setParameter("id", curr[0]).setParameter("fd", curr[1]).list();
            %>
            <table width="100%" border="1px" cellpadding="2px">
                <thead><tr><th>Time</th><th>Domain</th><th>Region</th><th>Page</th><th>Query</th><th>IP</th></tr></thead>
            <%
            List<Tracker> tkr=c.list();
            for(Tracker t:tkr){%>
            <tr>
                <td><%=t.getHitTime()%></td>
                <td><%=t.getDomen()%></td>
                <td><%=t.getCity()+" "+t.getProvince()+" "+t.getCountry()+" "+t.getContinent()%></td>
                <td><%=t.getPageInfo()%></td>
                <td><%=t.getQuery()%></td>
                <td><%=t.getIp()%></td>
            </tr>  
            <%}%>
            </table>
            </div>
        </div>
        <style>
        .popSMLE{
            box-shadow: 4px 4px 25px black;
        }
        </style>
    </div>
    </div>
    </div>       