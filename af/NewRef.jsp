<%-- 
    Document   : NewRef
    Created on : 17 Nov, 2017, 6:55:20 PM
    Author     : UMESH-ADMIN
--%>
<%@page import="entities.Admins"%>
<%-- 
    Document   : DistributorInfoForm
    Created on : Aug 2, 2017, 5:25:23 PM
    Author     : sunil
--%>

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
Admins role=(Admins)request.getSession().getAttribute("role");
if(role==null){
    response.sendRedirect("?msg=Login Please");
    return;
}
//Transaction tr = sess.beginTransaction();
%>
<div class="loginForm" >
    <span class="close" id="close" onclick="closeMe();">x</span>
    <div class="fullWidWithBGContainer">
    <div class="tFivePer left nomargin nopadding" style="overflow: auto">
        <span class="white"><h2 class="nomargin nopadding">Create Referrer</h2><hr></span><hr>
    <center>
        <form action="FormManager " method="post" name="loginForm" id='loginForm' >
            <input type="hidden" name="action" value="NReferer" /><br>
            <input class="textField" type="text"  id="rfN" name="rfN" placeholder="Referrer Name" autocomplete="off" /><br>
            <input class="textField" type="text"  id="zip" name="ZIP" placeholder="ZIP Code" autocomplete="off" /><br>
            <input class="textField" type="text"  id="cp" name="cp" placeholder="Contact Person" autocomplete="off" /><br>
            <input class="textField" type="text"  id="mob" name="mob" placeholder="Mobile No.*"/><br>
            <textarea class="txtArea"  id="address" name="address" placeholder="Enter address here*" ></textarea><br>
            <button onclick='return subForm("loginForm","FormManager")' id="editBtn" class="button">Save</button>
            <br><br>
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
                            var type,pass,mob,address,prod;
//                            var arr = JSON.parse(disJsonArr);
                            for(var ind in disJsonArr){
                                var obj = JSON.parse(disJsonArr[ind]);
//                                alert(obj.disId);
                                if(obj.disId==disId){
                                    type=obj.type;
                                    pass="";
                                    mob=obj.mob;
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
        <span class="white"><h2 class="nomargin nopadding">Existing Referrers</h2></span><hr>
        
        <%
                List <DistributorInfo> list=sess.createQuery("from DistributorInfo where deleted=false  and type='Referer' order by type asc").list();
                if(!list.isEmpty()){
                    out.print("<table id='header-fixed' border=\"1px\" cellpadding=\"2\" style=\"margin:0px;\" width=\"100%\"> </table>");
                    out.print("<div class='scrollable'>");
                out.print("<table id='mainTable' border= \"1px solid\" cellspacing=\"0px\"  width = \"100%\" cellpadding = \"5px\" </table>");
                out.print("<thead><tr align= left><th>Distributor</th><th>Mobile No.</th>"
                        +"<th>Address</th>"+"<th>Action</th></tr></thead>");

    for(DistributorInfo dis: list){
    out.print("<tr>"
            +"<td style='cursor:pointer;' >"+dis.getDisId().replace("00R-","")+"</td>"
            +"<td>"+dis.getMob()+"</td><td>"+dis.getAddress()+"</td>"
            +"<td>");
            if(role.getRole().matches("(.*Global.*)|(.*U11.*)")){        
                out.print("<span class='button fa fa-edit' onclick='showUpdDisForm(escape(\""+dis.getDisId()+"\"));' title='edit'></span>");
            }
            if(role.getRole().matches("(.*Global.*)|(.*D11.*)")){        
                out.print("<span class='fa fa-trash button'id='deleteBtn' title='delete' onclick='sendDataForResp(\"del\",\"action=dD&id="+dis.getDisId()+"\",false);'></span>");
            }
            out.print("</td>"
            +"</tr>");     
            }
        out.print("</tbody></table</div>");
        }
                %>  
                <script>  
                    copyHdr("mainTable","header-fixed");    
                </script>
    </div>
    </div>
  </div>
<%
sess.close();
%>