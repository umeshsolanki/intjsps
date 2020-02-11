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
    <div class="col s12">
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
                <textarea name="content" id="content" class="col s12"  style="min-height:70vh;">${content.replaceAll("\"","&quot;").replaceAll(">","&gt;").replaceAll("<","&lt;")}</textarea>
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
<c:if test="${cwd.endsWith('.xml') or cwd.endsWith('.html') or cwd.endsWith('.jsp')}">
    <script src="/mode/xml/xml.js"></script>
</c:if>
<c:if test="${cwd.endsWith('.js')}">
    <script src="/mode/javascript/javascript.js"></script>
</c:if>
<c:if test="${parent.contains('nginx') and cwd.endsWith('.conf')}">
    <script src="/mode/nginx/nginx.js"></script>
</c:if>
<c:if test="${cwd.endsWith('.java') or cwd.endsWith('.kt') or cwd.endsWith('.c') or cwd.endsWith('.cpp')}">
    <script src="/mode/clike/clike.js"></script>
</c:if>
<c:if test="${cwd.endsWith('.jsp')}">
    <script src="/mode/htmlembedded/htmlembedded.js"></script>
    <script src="/mode/javascript/javascript.js"></script>
    <script src="/mode/htmlmixed/htmlmixed.js"></script>
    <script src="/addon/mode/multiplex.js"></script>
</c:if> 

<script>
    var editor = CodeMirror.fromTextArea(tArea, {
        lineNumbers: true
    <c:if test="${cwd.endsWith('.jsp')}">
        ,mode: "application/x-ejs"
        ,indentUnit: 4
        ,indentWithTabs: true
    </c:if>
    <c:if test="${cwd.endsWith('.html')}">
        ,mode: "application/xml"
        ,htmlMode: true
//        ,indentUnit: 4
//        ,indentWithTabs: true
    </c:if>
    
    <c:if test="${cwd.endsWith('.xml')}">
        ,mode: "application/xml"
        ,matchClosing: true
    </c:if>
    <c:if test="${cwd.endsWith('.java')}">
        ,mode: "text/x-java"
        ,matchBrackets: true
    </c:if>
    <c:if test="${cwd.endsWith('.c')}">
        ,mode: "text/x-csrc"
        ,matchBrackets: true
    </c:if>
        <c:if test="${cwd.endsWith('.cpp')}">
        ,mode: "text/x-c++src"
        ,matchBrackets: true
    </c:if>
    <c:if test="${cwd.endsWith('.kt')}">
        ,mode: "text/x-kotlin"
        ,matchBrackets: true
    </c:if>
    <c:if test="${parent.contains('nginx') and cwd.endsWith('.conf')}">
        ,mode: "text/x-nginx-conf"
        ,matchBrackets: true
    </c:if>
    });
editor.setSize(null,"70vh");
</script>
</div>