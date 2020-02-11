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
    <div class="col s10">
        <div class="col s12 m2">
            <div class="card green">
                <div class="card-content via-m0 via-p2">Drives:</div>
            </div>
        </div>
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
            <form action="/api/admin/file/save" id="saveForm" method="post">
                <input type="hidden" name="q" value="${parent}/${cwd}"/>
            <textarea name="content" class="col s12"  style="min-height:70vh;">${content.replaceAll("<","&lt;")}</textarea>
            <div class="right">
                <span type="submit" class="btn green save">Save</span>&nbsp;<span class="btn red">Close</span>
            </div>
            </form>
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