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
<script src="/addon/fold/xml-fold.js"></script>
<script src="/addon/edit/matchtags.js"></script>
<div class="row">
    <%@include file="../adminMenu.jsp" %>
    <div class="col s12">
        <form action="/api/admin/cms/page/publish" method="post">
            <div class="input-field col s12  m6 ">
                <input id="url" name="url" value="${url}" type="hidden" class="validate">
                <input id="domain" autocomplete="off" name="domain" type="text" class="validate">
                <label for="url">Domain</label>
            </div>
            <div class="input-field col s12  m6 ">
                <input id="Sitemap" name="sitemap"  type="text" class="validate">
                <label for="Sitemap">Sitemap</label>
            </div>
            <div class="input-field col s12  m6 ">
                <input id="file" name="file"  type="text" value="${title}.html" class="validate">
                <label for="file">File</label>
            </div>
            <div class="input-field col s12 m6">
                <input id="SelectLocation" autocomplete="off" name="SelectLocation"  type="text" class="validate"/>
                <label for="SelectLocation">Root Directory</label>
            </div>
            <div class="input-field col s12">
                <textarea class="col s12" id="responseHtml">${response.replaceAll("“","\"").replaceAll("”","\"").replaceAll("’","'").replaceAll(">","&gt;").replaceAll("<","&lt;").replaceAll("\"","&quot;").replaceAll('\'',"&apos;")}</textarea>
            </div>
            <br>
            &nbsp;<span class="btn blue contentPreviewButton" >Preview</span>
            &nbsp;<span class="btn blue publish">Publish</span>
            
        </form>
    </div>
    <div class="col s12">
        <p>&nbsp;</p>
    </div>
    <div class="previewRenderContainer col s12"  >
       
    </div>
    <script>
        $("#SelectLocation").autocomplete({data:{"/var/www/cms/":"","/var/www/technology/":"","/var/www/":"","/var/www/cms/android/interview-questions":""}});
        $("#domain").autocomplete({data:{"https://cms.viatusk.com/":"","https://cms.viatusk.com/java/":"","https://cms.viatusk.com/android/":"","https://cms.viatusk.com/java/interview-questions":""}});
        var tArea=document.getElementById("responseHtml");
        var editor = CodeMirror.fromTextArea(tArea, {
        lineNumbers: true
        ,mode: "application/xml"
        ,htmlMode: true
        ,indentUnit: 4
        ,matchTags: {bothTags: true}
        ,extraKeys: {"Ctrl-J": "toMatchingTag"}
        ,lineWrapping:true
        ,indentWithTabs: true
    });
    editor.setSize(null,"70vh");
    $(".convertButton").on("click",function(){
        $.ajax({url: '/api/admin/cms/page/convert',type : "post" ,data : "url="+encodeURIComponent($("#url").val()),
                success : function(result) {
                    console.log(result)
                    try{
                        M.toast({html:result})
                    }catch(e){
                        console.log(e)
                    }
                },
                error: function(xhr, resp, text) {
                    M.toast({html:text})
                    console.log(xhr, resp, text);
                }
                }) 
    });
    $(".publish").on("click",function(){
        var data="domain="+encodeURIComponent($("#domain").val())+"&url="+encodeURIComponent($("#url").val())+"&content="+encodeURIComponent(editor.getValue())+"&file="+encodeURIComponent($("#file").val())+"&dir="+encodeURIComponent($("#SelectLocation").val());
        $.ajax({url: '/api/admin/cms/page/converted/publish',type :"post" ,data : data,
            success : function(result) {
                M.toast({html:result})
            },
            error: function(xhr, resp, text) {
                M.toast({html:text})
                console.log(xhr, resp, text);
            }
        }) 
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
        
    $(".previewButton").on("click",function(){
        $(".previewRenderContainer").height("80vh")
//        $.ajax({url: '/api/admin/cms/page/preview',type :"get" ,data : "content="+encodeURIComponent(editor.getValue()),
//            success : function(result) {
            $(".previewRenderContainer").html("<iframe height='100%' class='col s12 previewRend' src='/api/admin/cms/page/urlpreview?url="+encodeURIComponent($("#url").val())+"'></iframe>")
//            },
//            error: function(xhr, resp, text) {
//                M.toast({html:text})
//                console.log(xhr, resp, text);
//            }
//        }) 
    });
</script>
</div>