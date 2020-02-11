<%-- 
    Document   : quickLinkTemplate
    Created on : 7 Aug, 2018, 11:44:20 AM
    Author     : UMESH-ADMIN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../header.jsp" %>
<link rel="stylesheet" href="/lib/codemirror.css">
<script src="/lib/codemirror.js"></script>
<div class="row">
    <%@include file="../adminMenu.jsp" %>
    <div class="col s12 right-loader">
        <c:forEach items="${roots}" var="f">
        <div class="col s3 m2 l1">
            <div class="card">
                <div class="card-content via-m0 via-p2 root">
                    <a href="/api/admin/file/list?q=${f.absolutePath}">${f.absolutePath}</a>
                </div>
            </div>
        </div>
        </c:forEach>
        <div class="col s12 m12">
            <div class="card  blue white-text">
                <div class="card-content via-m0 via-p2">
                    <p class="via-bold"><span><a href="/api/admin/file/list?q=${parent}" class="white-text">${parent}/${cwd}</a></span></p>
                </div>
            </div>
        </div>
        <div class="col s12">
            <img src="/api/admin/file/image?f=${image}" class="col s12"/>
        </div>
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
</script>
</div>