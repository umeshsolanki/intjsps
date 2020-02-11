
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
<div class="border" style="max-width: 100%;">
    <%
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        if(sess==null){
            out.print("Login please");
            return ;
        }
//            DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
//            sess.refresh(dist);
            List<FinishedProduct> pr=sess.createCriteria(FinishedProduct.class).list();
    %>
    <span class="close fa fa-close" id="close" onclick="clrLSP();"></span>
    <div class="fullWidWithBGContainer">
            <span class="white"><h2 class="centAlText nopadding nomargin white">Requisition</h2></span><hr><br>
            <center>
                <form method="post" onsubmit="return false;" name="loginForm" id='loginForm'>
                    <input type="hidden" name="action" id="action" value="order"/>
                      <input type="hidden" name="rId" id="rId" value=""/>
                    <!--<input class="textField" type="text" id="name" name="name" placeholder="Name*"/><br><br>-->
                    <input class="textField" value="<%=(Utils.DbFmt.format(new Date()))%>" type="date" id="date" name="date" />
                    <select id="sel" class="textField" name="sel">
                        <option value="---">Select Seller</option>
                        <%
                        List<DistributorInfo> s=sess.createCriteria(DistributorInfo.class).add(Restrictions.eq("deleted", false)).add(Restrictions.ne("type", "User")).add(Restrictions.ne("type", "Referer")).list();
                        for(DistributorInfo r:s){%>
                        <option value="<%=r.getDisId()%>"><%=r.getDisId()%></option>
                        <%}%>
                    </select><br>
                    <input class="textField" value="" type="number" placeholder="Discount" id="disc" name="disc" />
                    <input class="textField" value="" type="number" id="cmm" name="cmm" placeholder="Commission" /><br>
                    <!--Search for products you want to order( To search All type (..) without brackets)<br><br>-->
                    <input onclick="getProds(this.value);" title="Enter at least 2 Characters, It is smart search" type="search" placeholder="Search Product" id="srch" name="srch" class="textField" onkeyup="getProds(this.value)"/>
                    <div id="proRes" style="font-size: 14px;max-width: 300px;z-index: 9999;overflow: auto;margin: 0px;max-height: 250px;;display: none;" >
                    </div>
                <div id="purProd" class="scrollable">
            <script>
                var prodArr=<%=pr.toString()%>;
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
                            \<input class='smTF' placeholder='Price' value='"+obj.mrp+"' name='mrp' id='mrp"+prodCount+"'></span>\
                                <input class=\"autoFitTextField\" style='max-width:100px;' type=\"number\" id=\"qnt"+prodCount+"\" proid=\""+obj.fpId+"\" placeholder=\"Quantity\" />";
                            var fieldHtml=sel+"<button onclick='remProd("+prodCount+");' class=button>&Cross;</button></div>";
                            $("#purProd").append(fieldHtml);
                            prodCount++;
                        }
                    }
                        return false;
//                            console.log(JSON.stringify(matIds));
                    }
                function remProd(id) {
//                        alert(id);
                        $("div").remove("#pro"+id);
                        prodIds.splice(prodIds.indexOf(id),1);
//        alert(JSON.stringify(prodIds));
                                        
//        console.log(JSON.stringify(prodIds));
                    }
                    function makeReq() {
                                var proIds=[];
                                var req={action:$("#action").val(),cmm:$('#cmm').val(),disc:$('#disc').val(),dis:$('#sel').val(),rId:$('#rId').val(),not:"",dt:"",orders:[]};
                                req.not=$("#feed").val();
                                for(var c=0;c<prodIds.length;c++){
                                    var order={pro:0,qnt:0,price:0};                    
                                    order.qnt=$("#qnt"+prodIds[c]).val();
                                    order.pro=$("#qnt"+prodIds[c]).attr("proid");
                                    order.price=$("#mrp"+prodIds[c]).val();
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
                
                    <textarea class="txtArea"  id="feed" name="feed" placeholder="Remark" ></textarea><br><br>
                    <button onclick='return makeReq();' id="editBtn" class="button">Proceed</button>
                    <br><br>
                </form>
            </center>
        </div>
</div>