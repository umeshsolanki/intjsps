<%-- 
    Document   : newOrder
    Created on : Aug 27, 2019, 4:17:46 PM
    Author     : umesh
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="header.jsp" %>
<div class="row">
<%@include file="adminMenu.jsp" %>
<div class="col s10">
<div class="col s12 card-panel ">
        <form class="col s12" id="offerForm" onsubmit="return false" method="POST">
                <div class="input-field col s12 l2 m3">
                    <input id="dt" name="dt"   type="date" class="validate">
                    <label for="dt">Date</label>
                </div>
                <div class="input-field col s12 l2 m3">
                    <select id="sel" class="textField" name="sel">
                        <c:forEach var="s" items="${sellers}">
                            <option>${s.disId}</option>
                        </c:forEach>
                    </select>
                    <label for="var">Select Seller</label>
                </div>
                <div class="input-field col s12 l2 m3">
                    <input id="cName" name="cName"  type="text" class="validate">
                    <label for="cName">Customer Name</label>
                </div>
                <div class="input-field col s12 l2 m3">
                    <input id="cMob" name="cMob"  type="text" class="validate">
                    <label for="cMob">Customer Mob</label>
                </div>
                <div class="input-field col s12 l2 m3">
                    <input id="cAMob" name="cAMob"  type="text" class="validate">
                    <label for="cAMob">Alternate Mob</label>
                </div>
                <div class="input-field col s12 l2 m3">
                    <input id="cFlat" name="cFlat"  type="text" class="validate">
                    <label for="cFlat">Flat</label>
                </div>
                <div class="input-field col s12 l2 m3">
                    <input id="cApt" name="cApt"  type="text" class="validate">
                    <label for="cApt">Apartment</label>
                </div>
                <div class="input-field col s12 l2 m3">
                    <input id="PIN" name="PIN"  type="text" class="validate">
                    <label for="PIN">PIN</label>
                </div>
                <div class="input-field col s12 l2 m3">
                    <input id="address" name="address"  type="text" class="validate">
                    <label for="address">Address</label>
                </div>
                <div class="input-field col s12 l2 m3">
                    <input id="gstNo" name="gstNo"  type="text" class="validate">
                    <label for="gstNo">GST No</label>
                </div>
                <div class="input-field col s12 l2 m3">
                    <input id="discount" name="discount"  type="text" class="validate">
                    <label for="discount">Discount</label>
                </div>
                <div class="input-field col s12 l2 m3">
                    <input id="discount" name="discount"  type="text" class="validate">
                    <label for="discount">Discount</label>
                </div>
                <div class="input-field col s12 l2 m3">
                    <input id="advPaid" name="advPaid"  type="text" class="validate">
                    <label for="advPaid">Advance Paid</label>
                </div>
                <div class="input-field col s12 l2 m3">
                <select class="textField"  id="payMethod" name="payMethod">
                    <option value="">Payment Mode</option>
                    <option>Cash</option>
                    <option>CC</option>
                </select>
                <label for="var">Payment Mode</label>
                </div>
                <div class="input-field col s12 l2 m3">
                    <input id="orderNo" name="orderNo"  type="text" class="validate">
                    <label for="orderNo">Order No</label>
                </div>
                <div class="input-field col s12 l2 m3">
                    <input id="ServiceCharge" name="ServiceCharge"  type="text" class="validate">
                    <label for="ServiceCharge">Service Charge</label>
                </div>
                <div class="input-field col s12 l2 m3">
                    <input id="ServiceNo" name="ServiceNo"  type="text" class="validate">
                    <label for="ServiceNo">Service No</label>
                </div>
                <div id="prodCont" class="col s12">
                    
                </div>
                <div class="col s12">
                    <p class="btn waves-effect waves-green offset-m8 offset-l10 col l2 m3 s12 saveOffer">Save</p>  
                </div>
            </form>
            <div class="col s12 m4 l3">
                <div class="card col s12">
                <div class="input-field col s12">
                    <input id="pro" name="pro" type="text" class="validate pro" autocomplete="off"/>
                <%--<select name="obj" class="selectedProduct">
                    <c:forEach items="${products}" var="p">
                        <option value="${p.FPId}">${p.FPName}</option>
                    </c:forEach>
                </select>--%>
                <label for="pro">Product</label>
                </div>
                <div class="input-field col s6">
                    <input id="Product" name="obj"  type="text" class="validate choosenQty"/>
                    <label for="Product">Qty</label>
                </div>
                <div class="input-field col s6">
                        <input id="rate" name="obj"  type="text" class="validate choosenRate"/>
                        <label for="rate">Rate</label>
                </div>
                <p onclick='addProduct()' id="editBtn" class="btn col s12">Add Product</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
   count=0;
   $('#pro').autocomplete({
      data: {
        <c:forEach items="${products}" var="p">"${p.FPName.replaceAll("\"","&quot;")}":null,</c:forEach>
        }
    });
     var sel = M.Autocomplete.getInstance($("#pro"));
function addProduct() {
            count++;
           
            $("#prodCont").append("<div class='col s12 m3'><div class='card'><div class='card-header'><p>"+$("#pro").val()+"</p>\n\
                <p class='col s6'>QTY:"+$(".choosenQty").val()+"</p>\
                <p class='col s6'>Rate:"+$(".choosenRate").val()+"</p>\
                <div class='card-action'><span class='red-text'>Remove</span></div>\
            </div></div></div>")
            return 
        }
    $("select.selectedProduct").autocomplete();
    $("select.textField").formSelect();
    M.updateTextFields();
    
    $(".saveOffer").on("click",function(){
        var arr=$("#offerForm").serializeArray();
        var method=$("#offerForm").attr("method")
        var payload={};
        for(var f in arr){
            var key=arr[f].name;
            if(key.indexOf(".")>-1){
                if(arr[f].value == "null")
                   continue;
                var keys=key.split(".");
                    var subObj={};
                    subObj[keys[1]]=arr[f].value;
                    payload[keys[0]]=(subObj);
            }else{
                var v=arr[f].value;
                payload[key]=v;
            }
          }
          M.toast({html:JSON.stringify(payload)});
          return ;
          $.ajax({url: '${ctx}/api/coupon/new',type :method ,contentType: 'application/json; charset=utf-8',data : JSON.stringify(payload),
                success : function(result) {
                    console.log(result)
                    try{
                        M.toast({html:result})
                    }catch(e){
                        console.log(e)
                    }
//                                alert(result)
                },
                error: function(xhr, resp, text) {
                    M.toast({html:text})
                    console.log(xhr, resp, text);
                }
                })
//          console.log(JSON.stringify(payload))
//        var product={"name":productForm.proName.value,};
    });                  
</script>
      