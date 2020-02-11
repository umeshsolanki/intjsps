<%-- 
    Document   : productsCardView
    Created on : May 5, 2019, 9:10:41 PM
    Author     : umesh
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%
String ctx="PullWebsiteMay19";
%>
<%@include file="header.jsp" %>
<div class="row">
    <%@include file="adminMenu.jsp" %>
    <div class="col s10">
    <div>
        <table>
            <tr><th>Date</th><th>Order No</th><th>Vendor</th><th>Total</th><th>Customer</th><th>Mobile</th><th>Action</th></tr>
        <c:forEach var="o" items="${orders}">
            <tr class="${o.cancelled?"red light-4":""}">
                <td class=""><f:formatDate pattern="dd/MM/yy" value="${o.dt}"/></td>
            <td class="">${o.odrNo}</td>
            <td class="">${o.dist.disId}</td>
            <td class="">&#8377;${o.paid}</td>
            <td class="">${o.cust.name}</td>
            <td class="">${o.cust.mob}</td>
            <td>
                <a accesskey="" class="blue-text via-pointerCursor" href="/api/order/${o.odrNo}">View</a>
            </td>
        </tr>
        </c:forEach>
        </table>    
    </div>
    <ul class="pagination">
        <li class="btn-small waves-effect"><span src="/products/table/${start-15}/15" class="pager">Previous</span></li>
        <li class="waves-effect btn-small"><span src="/products/table/${start+15}/15" class="pager" href="#!">Next</span></li>
    </ul>
    </div>
<script>
      $(".viewOrder").on("click",function(){
          $(".orderSummary").load("${ctx}/api"+$(this).attr("src"));
      })
      
      $(".action").on("click",function(){
          var src=$(this).attr("src")
          var ele=this;
         $.ajax({url:src,type :"GET" ,
                success : function(result) {
                    console.log(result)
                    try{
                        M.toast({html:result})
                        if(result.indexOf("success")>-1){
                            $(ele).html("");
                        }
                    }catch(e){
                        console.log(e)
                    }
//                                alert(result)
                },
                error: function(xhr, resp, text) {
                    M.toast({html:text})
                    console.log(xhr, resp, text);
                }
                });
//          console.log(JSON.stringify(payload))
//        var product={"name":productForm.proName.value,};
    });   
      
</script>
</div>