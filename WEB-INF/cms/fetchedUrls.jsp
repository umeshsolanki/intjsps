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
        <table>
            <thead>
                <tr>
                    <th>Date</th>
                    <th>URL</th>
                    <!--<th>File</th>-->
                    <th>Published</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${urls}" var="u">
                <tr>
                    <td>${u.fechedOn}</td>
                    <td>${u.url}</td>
<!--                    <td>${u.contentFile}</td>-->
                    <td>${u.publishedURL}</td>
                    <td>
                        <a href="/api/admin/cms/page/convert?url=${u.url}" class="green-text">Convert</a>
                        <a href="/api/admin/file/list?q=${u.contentFile}">Preview</a>
                    </td>
                    
                </tr>
                </c:forEach>
            </tbody>
        </table>
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
       var data="q="+escape(saveForm.q.value)+"&content="+encodeURIComponent(editor.getValue());
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
    var tArea=document.getElementById("content")

</script>
</div>