<%-- 
    Document   : Feedback
    Created on : Sep 30, 2017, 10:48:40 AM
    Author     : sunil
--%>

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
<div class="loginForm border" style="max-width: 100%;">
    <%
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
        if(dist==null||LU!=null&&!LU.getRoles().matches(".*\\(.Req\\).*")){
            out.print("<script>window.location.replace(\"?msg=You don't have permission to access this page\");</script>");
            return;
        }
        sess.refresh(dist);
    %>
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer">
        <div class="tFivePer left ">
            <span class="white"><h2 class="nopadding nomargin white">Requisition</h2></span><hr>
            <br>
            <center>
                <form method="post" onsubmit="return false;" name="loginForm" id='loginForm'>
                    <input type="hidden" name="action" id="action" value="order"/>
                      <input type="hidden" name="rId" id="rId" value=""/>
                    <input class="textField" type="date" id="date" name="date" /><br>
                    <input onclick="getProds(this.value);" title="Enter at least 2 Characters, It is smart search" type="search" placeholder="Search Product" id="srch" name="srch" class="textField" onkeyup="getProds(this.value)"/>
                    <div id="proRes" style="font-size: 14px;max-width: 300px;z-index: 9999;overflow: auto;margin: 0px;max-height: 250px;;display: none;" >
                    </div>
            <div id="purProd" class="scrollable">
            <script>
                var prodArr=<%=dist.getMyProds().toString()%>;
                function getProds(filter) {
                        if(filter.toString().length>1){
                            $("#proRes").html("");
                            $("#proRes").css("display","block");
                            var patt=new RegExp(".*"+filter+".*","i");
                            for(var i=0;i<prodArr.length;i++){
                            var mat=prodArr[i];
                            if(patt.test(mat.fpName)){
                                $("#proRes").append("<div class='textField' onclick=\"addProduct("+mat.fpId+");\"><p align=left style='padding:0px;margin:0px'>"+mat.fpName+"</p></div>");
                            }
                        }
                    }else{
                            $("#proRes").html("");
                            $("#proRes").css("display","none");
                    }
                    }
                            
            var prodCount=0,prodIds=[];
                    function addProduct(id){
                    $("#proRes").html("");
                    $("#srch").val("");
                    $("#proRes").css("display","none");
//                    showMes("Total Materials used in "+prodName.value+" = "+matCount,false);
                    
                    for(ind in prodArr){
                            var obj=prodArr[ind];
                        if(obj.fpId==id){
                            prodIds.push(prodCount);
//                            alert(JSON.stringify(prodIds));
                            var sel="<div id='pro"+prodCount+"'>";
                            sel+="<input class=\"textField\" type=\"text\" disabled=\"true\" value=\""+obj.fpName.replaceAll("\"","&quot;")+"\"/>\n\
                            \<span class='white'>&#8377;<i id='mrp"+prodCount+"' val='"+obj.mrp+"'>"+obj.mrp+"</i></span>\
                                <input class=\"autoFitTextField\" style='max-width:100px;' type=\"number\" id=\"qnt"+prodCount+"\" proid=\""+obj.fpId+"\" placeholder=\"Quantity\" />";
                            var fieldHtml=sel+"<button onclick='remProd("+prodCount+");' class=button>&Cross;</button></div>";
                            $("#purProd").append(fieldHtml);
                            prodCount++;
                        }
                    }
                        return false;
                    }
                            function remProd(id) {
                        $("div").remove("#pro"+id);
                        prodIds.splice(prodIds.indexOf(id),1);
                    }
                    function makeReq() {
                                var proIds=[];
                                var req={action:$("#action").val(),rId:$('#rId').val(),not:"",dt:"",orders:[]};
                                req.not=$("#feed").val();
                                for(var c=0;c<prodIds.length;c++){
                                    var order={pro:0,qnt:0,price:0};                    
                                    order.qnt=$("#qnt"+prodIds[c]).val();
                                    order.pro=$("#qnt"+prodIds[c]).attr("proid");
                                    order.price=$("#mrp"+prodIds[c]).attr("val");
//                                    alert(JSON.stringify(order));
                                    if(order.qnt>0){
                                        proIds.push(order);
//                                        alert(proIds.length);
                                    }
                                }
                                req.orders=proIds;
                                req.dt=$("#date").val();
//                                alert(JSON.stringify(req));
                                sendDataForResp("FormManager",JSON.stringify(req),true);
                                return false;
                            }
                        </script>
                    </div>
                    
                    <textarea class="txtArea"  id="feed" name="feed" placeholder="Enter note for this order" ></textarea><br><br>
                    <button onclick='return makeReq();' id="editBtn" class="button">Proceed</button>
                    <br><br>
                </form>
            </center>
        </div>
        <div class="sixtyFivePer right " >
            <h2 class="nomargin nopadding white">Recent Requisitions</h2><hr>
            <div class="scrollable">
            <table width="100%" border='1px' cellpadding='5px'>
                <tr align="left"><th>Date</th><th>Order No</th><th>Products</th><th>Received</th><th>Amount</th><th>Discount</th><th>Paid amount</th><th>Payable</th><th>Message</th><th>Action</th></tr>
            <%
            
            List<DistOrderManager> orders=sess.createCriteria(DistOrderManager.class).setFetchSize(20).add(Restrictions.eq("distributor", dist))
                    .addOrder(Order.desc("orderId")).list();
            JSONArray jar=new JSONArray();
            String labels="";
            for(DistOrderManager odr:orders){
                JSONObject obj=new JSONObject();
                obj.put("oId",odr.getOrderId()).put("prods",odr.getProds());
                jar.put(obj);
            %>
                <tr id="row<%=odr.getOrderId()%>">
                    <td><%=Utils.HRFmt.format(odr.getOrderDate())%></td>
                    <td title="click to view products detail" style="cursor: pointer;" onclick="showProds(<%=odr.getOrderId()%>);"><%=odr.getDocketNo()%></td>
                    <td title="click to view products detail" style="cursor: pointer;" onclick="showProds(<%=odr.getOrderId()%>);"><%=odr.getProds().size()%></td>
                    <td><%if(odr.isStockUpdated())out.print("Yes");else out.print("No");%></td><td>&#8377;<%=odr.getTotalPayment()%></td><td>&#8377;<%=odr.getDiscount()%></td><td>&#8377;<%=odr.getPaid()%></td><td>&#8377;<%=odr.getTotalPayment()-odr.getDiscount()-odr.getPaid()%></td><td><%=(odr.getOrderNotice())%></td>
                    <td id="reqa<%=odr.getOrderId()%>">
                        <%if(!odr.isDisApp()&&(LU==null||(LU!=null&&LU.getRoles().matches("(.*\\(DReq\\).*)")))){%>
                        <span onclick="sendDataForResp('a','action=TUP&mod=DReq&i=<%=odr.getOrderId()%>');return false;" class="fa <%=odr.isDisApp()?"greenFont fa-thumbs-up":"redFont fa-thumbs-down"%>  button" title="click to Approve"></span>
                        <%if((LU==null||(LU!=null&&LU.getRoles().matches("(.*\\(AReq\\).*)")))&&!odr.isDisApp()){%>
                        <span onclick="showDial('action=del&mod=DReq&i=<%=odr.getOrderId()%>','del','Do you really want to delete??','You can\'t undo this action');return false;" class="fa <%=odr.isDeleted()?"redFont":"greenFont"%> fa-trash-o button" title=" click to delete"></span><%}%>
                        <%}if((LU==null||(LU!=null&&LU.getRoles().matches("(.*\\(UReq\\).*)")))&&!odr.isDisApp()){%>
                        <span onclick="initEditReq(<%=odr.getOrderId()%>)" class="fa fa-edit button" title="Edit"></span>
                        <%}if((LU==null||(LU!=null&&LU.getRoles().matches("(.*\\(UReq\\).*)")))){%>
                        <%if(!odr.isReturned()){%><span onclick="popsr('df/retReq.jsp?o=<%=odr.getOrderId()%>');" class="fa fa-reply button" title="Mark as Return"></span><%}else{%>
                        Returned
                        <%}%>
                        <%}%>
                    </td>
                </tr>
            <%}%>
        <script>
            <%="var orders="+jar.toString()+";"%>
            function showProds(oId) {
                
//                        alert(JSON.stringify(orders));
                        var content="<style>.msg{background-color:#efefef !important;min-width:60%;color:black;}</style><div>\n\
                <center><h2 class='nopadding nomargin white'>Total products Ordered</h2>\n\</center><hr>\n\
                <table border='1px' cellpadding='5px' width='100%'>\n\
                    <tr align='left'><th>Product</th><th>Quantity</th><th>MRP</th></tr>";
                        for(var ind in orders){
                            var o=orders[ind]
//                            alert(o.oId);
                            if(o.oId==oId){
                                for(var p in o.prods){
                                    var pro=JSON.parse(o.prods[p]);
//                                    alert(pro);
                                content+="<tr><td>"+pro.name+"</td><td>"+pro.qnt+"</td><td> &#8377; "+pro.mrp+"</td></tr>";
                            }
                            break;                                        
                            }
                        }
                        content+="</table><div><br><br><p style='color:green;'>Click To Close [X]</p>"
//                        alert(content);
                        showMes(content,false);
                        
            }
            function initEditReq(oId) {
                prodCount=0;
                prodIds=[];
                $("#purProd").html("");
                $("#proRes").html("");
                    $("#srch").val("");
                    $("#proRes").css("display","none");
                        for(var ind in orders){
                            var o=orders[ind]
//                            alert(o.oId);
                            if(o.oId==oId){
                                for(var p in o.prods){
                                    var pro=JSON.parse(o.prods[p]);
//                                    alert(pro);
                            prodIds.push(prodCount);
//                            alert(JSON.stringify(prodIds));
                            var sel="<div id='pro"+prodCount+"'>";
                            sel+="<input class=\"textField\" type=\"text\" disabled=\"true\" value=\""+pro.name.replaceAll("\"","&quot;")+"\"/>\n\
                            \<span class='white'>&#8377;"+pro.mrp+"</span>\
                                <input class=\"autoFitTextField\" style='max-width:100px;' type=\"number\" id=\"qnt"+prodCount+"\" proid=\""+pro.proId+"\" placeholder=\"Quantity\" />";
                            var fieldHtml=sel+"<button onclick='remProd("+prodCount+");' class=button>&Cross;</button></div>";
                            $("#purProd").append(fieldHtml);
                            prodCount++;
//                                content+="<tr><td>"+pro.name+"</td><td>"+pro.qnt+"</td><td> &#8377; "+pro.mrp+"</td></tr>";
                            }
                            break;                                        
                            }
                        }
        $("#action").val("EDorder");                
        $("#editBtn").text("Save");
        $("#rId").val(oId);                
            }
        </script>
            </table>
            </div>
        </div>
    </div>
</div>
<%
sess.close();
%>
    