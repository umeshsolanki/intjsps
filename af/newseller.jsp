<%-- 
    Document   : DisFinance
    Created on : Oct 12, 2017, 10:20:53 PM
    Author     : sunil
--%>

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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        String i=request.getParameter("i");
        List<FinishedProduct> pr=sess.createCriteria(FinishedProduct.class).list();
        List<DistributorInfo> dr=sess.createCriteria(DistributorInfo.class).add(Restrictions.eq("deleted", false)).add(Restrictions.ne("type", "User")).add(Restrictions.ne("type", "Referer")).list();
        DistributorInfo dist=null;
        if(!Utils.isEmpty(i))
        dist=(DistributorInfo)sess.get(DistributorInfo.class, i);
//        DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
//        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
//        sess.refresh(dist);
//        Transaction tr = sess.beginTransaction();
%>
<div class="loginForm" style="background-color: #ababbc;max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="clrLSP();"></span>
    <div class="fullWidWithBGContainer">
        <h2 class="centAlText nomargin nopadding white"><%=Utils.isEmpty(i)?"New Sale Center":"Update <i class='ylFnt'>"+i+"</i>"%></h2><hr>
    <center>
        <form action="FormManager " method="post" name="loginForm" id='loginForm' >
            <br>
            <input type="hidden" name="action" id="action" value="distributionForm"/>
            <select class="textField" name="disType" id="distype">
                <option>Type</option>
                <option>Franchise</option>
                <option>Dealer</option>
                <option>Distributor</option>
                <option>Direct Sale</option>
                <option>Online Sale</option>
            </select>
            <input class="textField" type="text"  id="disId" name="id" placeholder="Distributor-Id*" autocomplete="off" /><br>
            <input class="textField" type="password" id="pass" name="pass" placeholder="Password*" autocomplete="off"/>
            <input class="textField" type="text"  id="mob" name="mob" placeholder="Mobile No.*"/><br>
            <input class="textField" type="text"  id="mail" name="mail" placeholder="Mail*"/><br>
            <span class="white">Owned By Company: <input type="checkbox" name="own" value="1" <%=dist!=null?dist.isOwnedByGA()?"checked":"":""%>/></span><br>
            
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
            <button onclick='return subForm("loginForm","FormManager")' id="editBtn" class="button">Add</button>
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
                            $("#mob").val(mob);
                            $("#mail").val(mail);
                            $("#address").val(address);
                            $("#disId").val(disId);
                            $("#editBtn").html("Update");
                            $("#action").val("updDisForm");
                            $("#disId").on("keydown",function () {return false;});
                        }
                        <%=dist!=null?"showUpdDisForm(escape(\""+dist.getDisId()+"\"));":""%>
                </script>
        </form>
       </center>           
</div>
</div>
                        
                    
    <style>
        .popSMLE{
            box-shadow: 4px 4px 25px black;
        }
    </style>
<%
sess.close();
%>
