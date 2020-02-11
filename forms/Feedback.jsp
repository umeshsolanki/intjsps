<%-- 
    Document   : Feedback
    Created on : Sep 30, 2017, 10:48:40 AM
    Author     : sunil
--%>

<%@page import="org.hibernate.criterion.Order"%>
<%@page import="utils.Utils"%>
<%@page import="utils.UT"%>
<%@page import="java.util.List"%>
<%@page import="entities.UserFeedback"%>
<%@page import="entities.Admins"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="loginForm" style="max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="halfnc left">
            <span class="white bgcolt8"><h2>Feedback Form</h2></span><hr>
            <br>
            <center>
                <form action="FormManager" method="post" name="loginForm" id='loginForm'>
                    <input type="hidden" name="action" id="action" value="feedback"/>
                    <input class="textField" type="text" id="name" name="name" placeholder="Name*"/><br><br>
                    <input class="textField" type="text" id="sub" name="sub" placeholder="Subject*"/><br><br>
                    <!--<input class="textField" type="date" id="date" name="date"/><br><br>-->
                    <textarea class="txtArea"  id="feed" name="feed" placeholder="Feedback*" ></textarea><br><br>
                    <button onclick='return subForm("loginForm","FormManager")' id="editBtn" class="button">Send</button>
                    <br><br>
                </form>
            </center>
        </div>
        <div class="halfnc right">
            <%
                
    Session sess = sessionMan.SessionFact.getSessionFact().openSession();
    Admins role = (Admins)request.getSession().getAttribute("role");
    if(role!=null&&role.getRole().matches(".*Global.*")){%>
        <h2 class='bgcolt8'>Feedback Details</h2><hr>
      <table width=\"100%\" cellpadding='5px'>
      <thead>
          <tr align='left'><th>Date</th><th>Username</th><th>Docket No</th><th>Rating</th><th>Amount</th><th>Message</th></tr>
      </thead>
      <%
      List<UserFeedback> list = sess.createCriteria(UserFeedback.class).addOrder(Order.desc("feedDate")).list();
      for(UserFeedback uf:list){
          out.write("\n");
      out.write("<tr>\n");%>
      <td><%=Utils.HRFmt.format(uf.getFeedDate())%></td>
      <%out.write("<td>");
      out.print(""+uf.getUname());
      out.write("</td>\n");%>
      <td><%=uf.getDock()%></td>
      <td style=''><%=uf.getRating()%></td>
      <td><%=uf.getAmtnsug()%></td>
      <%out.print("<td style='color:#ff4444;'>"+uf.getFeedback()+"</td>");
      out.write("                </tr>        \n");
    }%>
      </table>
      </form>
      </center>    
      </div>
    <%}%>
</div>
    </div>
</div>
<%
sess.close();
%>
    