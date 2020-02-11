<%-- 
    Document   : index
    Created on : May 5, 2019, 5:21:45 PM
    Author     : umesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<div class="row">
    <%@include file="adminMenu.jsp" %>
    <div class=" col s10">
        <div class="linkLoader">
            
        </div>
    </div>
</div>
<script>
      $(".loader").on("click",function(){
          $(".linkLoader").load("${ctx}/api"+$(this).attr("src"));
      })
</script>