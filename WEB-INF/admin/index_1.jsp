<%-- 
    Document   : quickLinkTemplate
    Created on : 7 Aug, 2018, 11:44:20 AM
    Author     : UMESH-ADMIN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../header.jsp" %>
<div class="row">
    <%@include file="../adminMenu.jsp" %>
    <div class="col s12">
        
    </div>
<script>
    $(".action").on("click",function(){
        var src=$(this).attr("src");
        var e=this;
       $.ajax({url: src,type :"GET" ,
        success : function(result) {
            console.log(result)
            try{
                M.toast({html:result});
                $(e).html(result);
            }catch(e){
                console.log(e)
            }
        },
        error: function(xhr, resp, text) {
            M.toast({html:text})
            console.log(xhr, resp, text);
        }
        });
    }); 
    $(".save").on("click",function(){
       var data=$("#saveForm").serialize()
       $.ajax({url: "/api/admin/file/save",type :"POST" ,data: data,
        success : function(result) {
            console.log(result)
            try{
                M.toast({html:result});
                $(e).html(result);
            }catch(e){
                console.log(e)
            }
        },
        error: function(xhr, resp, text) {
            M.toast({html:text})
            console.log(xhr, resp, text);
        }
        });
    });
</script>
</div>