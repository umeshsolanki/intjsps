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
<script src="/mode/xml/xml.js"></script>
<div class="row">
    <%@include file="../adminMenu.jsp" %>
    <div class="col s12">
        <form action="/api/admin/cms/page/fetch" method="post">
            <div class="input-field col s12  m6 ">
                <input id="url" name="url" value="${url}" type="text" class="validate">
                <label for="url">URL</label>
            </div>
            <div class="input-field col s12  m6 ">
                <input id="Sitemap" name="sitemap"  type="text" class="validate">
                <label for="Sitemap">Sitemap</label>
            </div>
            <div class="input-field col s12">
                <textarea class="col s12" id="responseHtml">${response.replaceAll(">","&gt;").replaceAll("<","&lt;").replaceAll("\"","&quot;").replaceAll('\'',"&apos;")}</textarea>
            </div>
            <br>
            <input type="submit" value="Fetch" class="btn blue"/>
            &nbsp;<a href="/api/admin/cms/page/content-edit?url=${url}"><span class="btn blue editButton">Edit</span></a>
            &nbsp;<span class="btn blue previewButton" >Preview URL</span>
            &nbsp;<span class="btn blue contentPreviewButton" >Content Preview</span>
            &nbsp;<a href="/api/admin/cms/page/convert?url=${url}"><span class="btn blue convertButton" >Convert</span></a>
            &nbsp;<a href="/api/admin/cms/page/smart-convert?url=${url}"><span class="btn blue convertButton" >Smart Convert</span></a>
        </form>
    </div>
    <div class="col s12">
        <p>&nbsp;</p>
    </div>
    <div class="previewRenderContainer col s12"  >
       
    </div>
    <script>
        var tArea=document.getElementById("responseHtml");
        var editor = CodeMirror.fromTextArea(tArea, {
        lineNumbers: true
        ,lineWrapping:true
        ,mode: "application/xml"
        ,htmlMode: true
        ,indentUnit: 4
        ,indentWithTabs: true
    });
    editor.setSize(null,"70vh");
    $(".contentPreviewButton").on("click",function(){
        $(".previewRenderContainer").height("80vh")
        $.ajax({url: '/api/admin/cms/page/preview',type :"post" ,data : "content="+encodeURIComponent(editor.getValue()),
            success : function(result) {
                $(".previewRenderContainer").html(result);
            },
            error: function(xhr, resp, text) {
                M.toast({html:text})
                console.log(xhr, resp, text);
            }
        }) 
    });
    $(".liveedit").on("click",function(){
        $(".previewRenderContainer").height("80vh")
        $.ajax({url: '/api/admin/cms/page/preview',type :"post" ,data : "content="+encodeURIComponent(editor.getValue()),
            success : function(result) {
                $(".previewRenderContainer").html(result);
            },
            error: function(xhr, resp, text) {
                M.toast({html:text})
                console.log(xhr, resp, text);
            }
        }) 
    });
    
    $(".previewButton").on("click",function(){
        $(".previewRenderContainer").height("80vh")
        $(".previewRenderContainer").html("<iframe height='100%' class='col s12 previewRend' src='/api/admin/cms/page/urlpreview?url="+encodeURIComponent($("#url").val())+"'></iframe>")
    });
</script>
</div>