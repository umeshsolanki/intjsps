<%-- 
    Document   : LoginForm
    Created on : 21 Sep, 2016, 3:41:33 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="org.hibernate.Transaction"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="utils.ConnectionString"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.JSONException"%>
<%@page import="entities.Admins"%>
<%@page import="entities.PPControl"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="entities.Material"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(!(session.getAttribute("role") instanceof Admins)){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
<%return; }
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
%>

<div class="loginForm">
    <%
                    List<FinishedProduct> fp= sess.createCriteria(FinishedProduct.class).list();
        %>
        
    <script>
        var picCount=0;
                        function addPicField(){
                            picCount++;
                                var fieldHtml="<input type='file' name='pic"+picCount+"' id='pic'"+picCount+"' class='button' /><br>";
                                $("#picCont").append(fieldHtml);
                            }
       
    </script>
    <span class="close" id="close" onclick="closeMe();">x</span>
    <span class="white"><h2>Update Product Images</h2></span><hr>
        <br>
        <div class="fullWidWithBGContainer">
            <div class="half left">
                <center>
        
                    <form  method="post" name="ui" id='ui' action="/PullNDry/UploadManager" enctype="multipart/form-data" >
            <input type="hidden"  id="action" value="ui"/>
            <input type="hidden"  id="proId" value=""/>
            <select class="textField" id='proId' name="proId">
                <option>Select product</option>
                <%
                for(FinishedProduct prod:fp){
                %>
                <option value="<%=prod.getFPId()%>"><%=prod.getFPName()%></option>
                <%}%>
            </select>
            <br>
            <div id="picCont" style="max-height: 300px;overflow: auto"></div>
            <br><img onclick="addPicField()" title="click to add new image" src="/PullNDry/images/add_image1600.png" width="100" height="70" alt="add_image1600"/>
            <!--<button class="button" onclick="addPicField()">Add Image</button>-->
            <br><br>
            <button class="button">Upload</button>
            <br><br>
        </form>
       </center>
            </div>
            <div class="half right">
                <div class="scrollable lightBlue">
                    <table border="1" width="100%" cellpadding="5">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Images</th>
                        </tr>
                    </thead>
                    <tbody id="matCont">
                          <%
                for(FinishedProduct p:fp){
                %>
                
                <tr> <td><span class="navLink" onclick='loadPageIn("container","/PullNDry/ResourseManager/images/<%=p.getFPId()%>",false);'><%=p.getFPName()%></span></td>
                    <td><%if(p.getPics()!=null&&p.getPics().contains(";")){
                        out.print(p.getPics().split(";").length);
                        }else{
                        out.print("0");
                            }%></td>
                                </tr>
                                <%}%>
                    </tbody>
                </table>
                </div>
            </div>
            </div>
                    <div id="container">
                        
                    </div>
</div>
<%
sess.close();
%>