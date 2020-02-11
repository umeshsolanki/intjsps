<%-- 
    Document   : DistributorInfoForm
    Created on : Aug 2, 2017, 5:25:23 PM
    Author     : sunil
--%>

<%@page import="utils.UT"%>
<%@page import="entities.Admins"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        Admins role=(Admins)session.getAttribute("role");
        if(!UT.ia(role, "5")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
        return;
        }
//Transaction tr = sess.beginTransaction();
%>
<div class="loginForm" >
    <span class="close" id="close" onclick="closeMe();">x</span>
    <div class="fullWidWithBGContainer">
    <div class="tFivePer left nomargin nopadding" style="overflow: auto">
        <span class="white"><h2 class="nomargin nopadding">New Sale Center</h2></span><hr>
        <br>
    <center>
        <form action="FormManager " method="post" name="loginForm" id='loginForm' >
            <input type="hidden" name="action" id="action" value="distributionForm"/>
            <select class="textField" name="disType" id="distype">
                <option>Type</option>
                <option>Franchise</option>
                <option>Dealer</option>
                <option>Distributor</option>
                <option>Direct Sale</option>
                <option>Online Sale</option>
            </select><br>
            <input class="textField" type="text"  id="disId" name="id" placeholder="Distributor-Id*" autocomplete="off" /><br>
            <input class="textField" type="password" id="pass" name="pass" placeholder="Password*" autocomplete="off"/><br/>
            <input class="textField" type="text"  id="mob" name="mob" placeholder="Mobile No.*"/><br>
            <input class="textField" type="text"  id="mail" name="mail" placeholder="Mail*"/><br>
            <span class="white">Owned By Company: <input type="checkbox" name="own" value="1" /></span><br>
                        <textarea class="txtArea"  id="address" name="address" placeholder="Enter address here*" ></textarea>
            <br>Select Products <br>
                        <div class="txtArea scrollable" id="chkdProds" style="max-height: 200px">
                <script>
                        function selAll(chkd) {
//                            var boxes=$("input [type='checkbox']");
//                            alert(boxes);
//                            for( boxes)
                            
                        }
                    </script>
                <p align="left" id="chkBoxes">
                    <input type="checkbox" name="selAll" id="selAll">Select All</input><br>
                    <script>
                        $('#selAll').click(function(){
//                            alert(this.checked);
                            $(".checkbox").attr("checked",this.checked);
                        });
                    </script>
                <%
                List<FinishedProduct> fp= sess.createCriteria(FinishedProduct.class).add(Restrictions.eq("deleted", false)).addOrder(Order.asc("FPName")).list();  
                for(FinishedProduct p:fp){
                %>
                <input type="checkbox" class="checkbox" name="prods" id="prods<%=p.getFPId()%>" value="<%=p.getFPId()%>"><%=p.getFPName()%></input><br>
                <%
                }   
                %>
            </p>
            </div><br>
            <button onclick='return subForm("loginForm","FormManager")' id="editBtn" class="button">Add</button><br><br>
                <script>
                    <%
                        List <DistributorInfo> updDisForm = sess.createQuery("from DistributorInfo di where di.type is not 'Referer' ").list();
                        JSONArray jar = new JSONArray(updDisForm);
                        out.print("var disJsonArr = "+jar.toString()+";");
                
                    %>
                    function showUpdDisForm(disId){
                            var ele=$("#chkBoxes").children();
//                            alert(ele.length);
                            for(var i=0;i<ele.length;i++){
                                try{
                                    var iid=ele[i].id;
//                                    alert(iid);
                                $("#"+iid).attr("checked",false);
                            }catch(e){}
                            }
                            disId = unescape(disId);
                            var type,pass,mob,address,prod,mail;
//                            var arr = JSON.parse(disJsonArr);
                            for(var ind in disJsonArr){
                                var obj = JSON.parse(disJsonArr[ind]);
//                                alert(obj.disId);
                                if(obj.disId==disId){
                                    type=obj.type;
                                    pass="";
                                    mob=obj.mob;
                                    mail=obj.mail;
                                    address=obj.address;
                                    prod=obj.myProds;
                                    for(var i=0;i<prod.length;i++){
                                        var pro=JSON.parse(prod[i]);
//                                        alert(prod[i]+""+pro.fpId);
                                        $("#prods"+pro.fpId).attr("checked",true);   
                                    }  
                            } 
                        }
                            $("#distype").val(type);
                            $("#pass").val(pass);
                            $("#mail").val(mail);
                            $("#mob").val(mob);
                            $("#address").val(address);
                            $("#disId").val(disId);
                            $("#editBtn").html("Update");
                            $("#action").val("updDisForm");
                            $("#disId").on("keydown",function () {return false;});
                            
                        }
                </script>
        </form>
    </center>
    </div>
    <div class="sixtyFivePer right" style=" margin: 0px;padding: 0px;height: 400px;max-height: 400px;overflow: auto">
        <span class="white"><h2 class="nomargin nopadding">Existing Sale Centers</h2></span><hr>
          <%
                List <DistributorInfo> list=sess.createQuery("from DistributorInfo where deleted=false  and type is not 'Referer' order by type asc").list();
                if(!list.isEmpty()){
                out.print("<table id='loginForm' border= \"1px solid\" cellspacing=\"0px\"  width = \"100%\" cellpadding = \"5px\" </table>");
                out.print("<tr align= left><th>Type</th>"
                +"<th>Distributor</th>"+"<th>Password</th><th>Company Owned</th>"+"<th>Mobile No.</th>"
                        +"<th>Address</th>"+"<th>Action</th></tr>");

    for(DistributorInfo dis: list){
    out.print("<tr><td>"+dis.getType()+"</td>"
            +"<td style='cursor:pointer;' >"+dis.getDisId()+"</td><td>"+dis.getPass()+
            "</td><td>"+(dis.isOwnedByGA()?"Yes":"No")+"</td>"
            +"<td>"+dis.getMob()+"</td><td>"+dis.getAddress()+"</td>"
            +"<td>"
//            + "<span class='button' title='click to view today's DSR' onclick='loadPageIn(\"dsrCont\",\"af/DSR.jsp?i="+dis.getDisId()+"\");'>DSR</span>"
//            + "<span class='button' onclick='loadPageIn(\"dsrCont\",\"af/distSale.jsp?i="+dis.getDisId()+"\");'>Odrs</span>"
//            + "<span class='button' onclick='loadPageIn(\"dsrCont\",\"af/distComplaint.jsp?i="+dis.getDisId()+"\");'>Comps</span>"
            + "<span class='fa fa-edit button' title='click to Edit/Update Info'  onclick='showUpdDisForm(escape(\""+dis.getDisId()+"\"));'></span>"
            + "<span class='button fa fa-trash' title='click to Delete' id='deleteBtn' onclick='sendDataForResp(\"FormManager\",\"action=dD&id="+dis.getDisId()+"\",false);'></span></td>"
            +"</tr>");
            }
        out.print("</tbody></table");
        }
                %>            

    </div>
    </div>
                <!--<div class="half left" ></div>-->
                
                <div class="popUp" id="dsrCont">
                    
                </div>
</div>
<%
sess.close();
%>
