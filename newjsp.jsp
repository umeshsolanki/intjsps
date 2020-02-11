<%@page import="java.util.Collection"%>
<%@page import="entities.DistStockListener"%>
<%@page import="entities.DistSaleManager"%>
<%@page import="entities.DistStock"%>
<%@page import="entities.OrderInfo"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
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
<div class="loginForm" style="max-width: 100%;">
    <span class="close" id="close" onclick="closeMe();">X</span>
    <div class="fullWidWithBGContainer">
        <script>
            <%
                Session sess=sessionMan.SessionFact.getSessionFact().openSession();
                DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
                sess.refresh(dist);
            %>
        </script>
        <style>
              .yellow{
                  background-color: yellow !important;
                  transition: all 1s;
                  color: #449955;
              }
              .normal{
                  background-color: transparent;
                  transition: all 1s;
              }
          </style>
          <div id="loginPopUp" style="max-width: 500px;" class="popUp"></div>
        <div class="tFivePer left" >
            <h2 class="nopadding nomargin white">My Stock
                <input type="search" placeholder="Search" id='brMatStkScroller' onkeyup="filterKeys(this.value);"/>
                </h2><hr>
                <div class="scrollable" style="position: absolute;background-color: #778899;max-width: 350px;max-height: 200px;overflow: auto;" id="matSRes">                
                
                </div>
            
            <div class="scrollable">
                <script>
                    <%
                    List<DistStock> updateDS = sess.createCriteria(DistStock.class).list();
                    JSONArray jar = new JSONArray();
                    for(DistStock ds:updateDS){
                        jar.put(new JSONObject(ds.toString()));
                    }
                    out.print("var dsJsonArr=JSON.stringify("+jar.toString()+");");        
                    %>
                
            function filterKeys(filter) {
//                        alert(JSON.stringify(window.event.keyCode));
            if(filter.toString().length>1){
                $("#matSRes").html("");
                $("#matSRes").css("display","block");
//                var offsets = $('#brMatStkScroller').position();
//                var top = offsets.top;
//                var right = offsets.right;
//                alert(right);
//                 $("#matSRes").css("right",right);
                var patt=new RegExp(".*"+filter+".*","i");
    for(var i=0;i<prods.length;i++){
        var product=prods[i];
    //                var patt=new RegExp(".*"+filter+".*","i");
    //                alert(mat.name);
        if(patt.test(product.name)){
            $("#matSRes").append("<div onclick='scrollToMat("+product.fpId+");' style='cursor:default;padding:5px;'>"+product.name+"</div>");
        }
    }
}else{
        $("#matSRes").html("");
        $("#matSRes").css("display","none");
        }
        }

            function scrollToMat(prId) {
//                            alert(mats);

                var matScroll=document.getElementById("STOCK_SC_PR_"+prId);
                if(matScroll!=null){
                matScroll.scrollIntoView();
                $(matScroll).css("transition","background 1s");
                var preE=matScroll.innerHTML;
                matScroll.firstElementChild.className='yellow';
                setTimeout(function(){matScroll.firstElementChild.className='normal';},4000);
                window.scroll(0,0);
            }
            else{
                showMes('Product Not found in stock!!',true,true);
            }
            $("#matSRes").html('');
            $("#brMatStkScroller").val('');
        }
        
        function showPopUp(id){
            var popup="<div class='loginForm' id='editPOPBox' style='background: #369;'  >\n\
        <span class='close' id='close' onclick='$(\"#loginPopUp\").html(\"\");'>x</span>\n\
            <span class='white'><center><h3>Update Stock </h3></center><hr></span>\n\
            <center>\n\
        <form onsubmit='return false;' method='post' name='upf' id='upf'>\n\n\
            <input type='hidden'  name='action' value='UDS' /><br>\n\n\
            <input type='hidden'  name='id' value='"+id+"' /><br>\n\
            <input class='textField' type='text'  name='prod' id='prod' /><br>\n\
            <input class='textField' type='text'  name='op' id='op'/><br>\n\
            <input class='textField' type='text'  name='qty' id='qty'/><br>\n\
            <textarea class='txtArea' type='text'  name='reason' id='reason' placeholder='Why you want to update stock...? '></textarea><br><br>\n\
            <button onclick=\"subForm('upf','FormManager');\" class='button' style='min-width:250px;'>Update</button><br><br><br>\n\
            </form>\n\
       </center>\n\
        <br>\n\
</div>";        
        $("#loginPopUp").html(popup);
        
         var p,op,qty;
                        var arr=JSON.parse(dsJsonArr);
                        for(var ind in arr){
                            var obj = arr[ind];
//            alert(obj.brId,true);            
                        if(obj.stId===id){
                                p=obj.prod;
                                op=obj.op;
                                qty=obj.stock;
                            }
                        }
                       
                        
                        $("#prod").val(p);
                        $("#op").val(op);
                        $("#qty").val(qty);
//                        $("#action").val("UDS");
//                        $("#editBtn").html("Update");
//                        $("#brId").on("keydown",function(){return false;});
                    
        return false;
        }
//        function updateStock(stkId){
//                        var p,op,qty;
//                        var arr=JSON.parse(dsJsonArr);
//                        for(var ind in arr){
//                            var obj = arr[ind];
////            alert(obj.brId,true);            
//                        if(obj.stId===stkId){
//                                p=obj.prod;
//                                op=obj.op;
//                                qty=obj.stock;
//                            }
//                        }
//                        
//                        $("#prod").val(p);
//                        $("#op").val(op);
//                        $("#qty").val(qty);
////                        $("#action").val("UDS");
////                        $("#editBtn").html("Update");
////                        $("#brId").on("keydown",function(){return false;});
//                    }
        </script>
        
        
            <table border="1px" >
                <tr align="left"><th>Product</th><th>Opening</th><th>Qty</th><th>Action</th></tr>
            <%
                StringBuilder proLabels=new StringBuilder(),data=new StringBuilder(),back=new StringBuilder();
                JSONArray arr=new JSONArray();
            List<DistStock> stk=sess.createQuery("from DistStock where dist=:dist order by prod.FPName asc").setParameter("dist",dist ).list();
            for(DistStock odr:stk){
                proLabels.append("'"+odr.getProd().getFPName()+"',");
                data.append(odr.getStock()+",");
                List<DistStockListener> list=sess.createQuery("from DistStockListener where prod=:p and dist=:d order by disListId desc").setParameter("p", odr.getProd()).setParameter("d", dist).list();
                if(!list.isEmpty())
                arr.put(list);
            %>
                <tr id="STOCK_SC_PR_<%=odr.getProd().getFPId()%>">
                    <td class="pointer"  title="click to view Purchase and Sale History" onclick="viewTrace('<%=odr.getDist().getDisId()%>',<%=odr.getProd().getFPId()%>);"><%=odr.getProd().getFPName()%></td>
                    <td><%=odr.getOpening()%></td>
                    <td><%=odr.getStock()%></td>
                    <td><button onclick='showPopUp("<%=odr.getStockId()%>");' class="button fa fa-edit" title="Edit"></button></td>
                </tr>
            <%
            }
            %>
            <script>
                function viewTrace(dist,pId){
                    var ls=<%=arr.toString()%>;
                    var proName="";
                     var content="<style>.msg{min-width:60%;background:#efefef;}</style><div><center>{{PD}}</center><br><hr><table width='100%'>\n\
                    <tr align='left'><th>Date</th><th>Opening</th><th>Purchase</th><th>Sale</th><th>Closing</th><th>Summary</th><th>Update Reason</th></tr>";
                    for(var dis in ls){
                        var obj=ls[dis];
                        for(var p in obj){
                            var desc=JSON.parse(obj[p]);
                            var pro=JSON.parse(desc.pro); 
                            
                            if(desc.dis==dist&&pro.fpId==pId){
//                                    alert(pro);
                                proName=pro.fpName;
                                var pur=0,sale=0,dif=desc.c-desc.o,reason=desc.rsn;
                                if(dif>0){
                                    pur=dif;
                                }else{
                                    sale=0-dif;
                                }
                                
                                content+="<tr><td>"+desc.dt+"</td><td>"+desc.o+"</td><td>"+pur+"</td><td>"+sale+"</td><td>"+desc.c+"</td><td>"+desc.type+", "+desc.sum+"</td><td>"+reason+"</td></tr>";
                            }
                            
                        }
                    }
                        content+="</table><div>";
                        content=content.replace("{{PD}}",proName);
//                        alert(content);
                        showMes(content,false);
                }
            </script>
            </table>
        </div>
        </div>
            <div class="sixtyFivePer right" id="oProds">
                <h2 class="nopadding nomargin white">Opening Entry</h2><hr>
                <form action="FormManager " method="post" name="loginForm" id='loginForm' >
                    <input type="hidden" name="action" id="action" value="DSopening"/>
                    <input type="date" class="textField" name="dt" id="dt" placeholder="Date"/><br>
                    <select name="prod" id="prod" class="textField">
                        
                    <%
                        
                        for(FinishedProduct  prod:dist.getMyProds()){%>
                    <option value="<%=prod.getFPId()%>"><%=prod.getFPName()%></option>
                    <%}%>
                    </select>
                    <br>
                    <input class="textField" type="text"  id="amt" name="amt" placeholder="Opening Amount"/><br><br>
                    <button onclick='return subForm("loginForm","FormManager")' id="editBtn" class="button">Save</button>
            <br><br>
                </form>
            </div>
    </div>
                    <div class="fullWidWithBGContainer">
                <canvas id="reqChart" width="400px" height="100px"></canvas>
                <canvas id="reqIChart" width="400px" height="100px"></canvas>
                <script>
                    var rwChart=new Chart($("#reqChart"),{
    type: 'bar',
    data: {
//        labels: ['Red', "Blue", "Yellow", "Green", "Purple", "Orange","Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
        labels: [<%=proLabels.toString()%>],
        datasets: [{
            label: ['Stock'],
            data: [<%=data.toString()%>],
            backgroundColor:['rgba(190, 20, 255, 1)','rgba(111,222 , 64, 1)','rgba(190, 100, 64, 1)','rgba(190, 250, 64, 1)'],
            borderColor: 
                'rgba(255, 159, 64, 1)',
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});
//var rIChart=new Chart($("#reqIChart"),{
//    type: 'bar',
//    data: {
////        labels: ['Red', "Blue", "Yellow", "Green", "Purple", "Orange","Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
//        labels: ['Requisition','Stock','Orders','Complains','DSR'],
//        datasets: [{
//            label: ['Item Wise Requisition Chart'],
//            data: [1,5,4,8,10],
//            backgroundColor:['rgba(190, 20, 255, 1)','rgba(111,222 , 64, 1)','rgba(190, 100, 64, 1)','rgba(190, 250, 64, 1)'],
//            borderColor: 
//                'rgba(255, 159, 64, 1)',
//            borderWidth: 1
//        }]
//    },
//    options: {
//        scales: {
//            yAxes: [{
//                ticks: {
//                    beginAtZero:true
//                }
//            }]
//        }
//    }});
                </script>
            </div>
</div>
                    
<%
sess.close();
%>
    