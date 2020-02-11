<%-- 
    Document   : quickLinkTemplate
    Created on : 7 Aug, 2018, 11:44:20 AM
    Author     : UMESH-ADMIN
--%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.springframework.beans.propertyeditors.URLEditor"%>
<%@page import="org.springframework.web.util.HtmlUtils"%>
<%@page import="java.util.regex.Matcher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../header.jsp" %>
<div class="row">
    <%@include file="../adminMenu.jsp" %>
    <div class="col s12">
        <c:forEach items="${roots}" var="f">
        <div class="col s3 m2 l1">
            
            <a href="/api/admin/file/list?q=${(f.absolutePath)}">
            <div class="card">
                <div class="card-content via-m0 via-p2 root">
                    ${f.absolutePath}
                </div>
            </div>
            </a>
        </div>
        </c:forEach>
        <div class="col s3 m2 l1">
            <a href="#recentSheet" class="modal-trigger">
            <div class="card">
                <div class="card-content via-m0 via-p2 root">
                    Recent
                </div>
            </div>
            </a>
        </div>
        <div class="col s12 m6 l5">
            <form method="post" enctype="multipart/form-data" action="/api/admin/file/upload">
                <input type="hidden" name="q" value="${q}" />
                <div class="file-field col s12 m6 l6">
                <div class="col s12">
                  <input type="file" name="file" multiple/>
                </div>
                <div class="file-path-wrapper">
                  <input class="file-path validate" type="text" placeholder="Upload one or more files">
                </div>
                </div>
                <div class="via-p2">
                <div class="via-p2">
                    <input type="submit" value="Upload" class="btn-small"/>
                </div>
                </div>
            </form>
        </div>
        <div class="col s12 m12">
            <div class="card  blue white-text">
                <div class="card-content via-m0 via-p2">
                    <p class="via-bold"><span><a href="/api/admin/file/list?q=${parent}" class="white-text">${parent}</a></span><span class="right">${cwd}</span></p>
                    
                </div>
            </div>
        </div>
                    <div style="max-height: 60vh;overflow-y: auto" class="col s12">
        <c:forEach items="${files}" var="f">
        <div class="col s12 m4 l3">
            <div class="card ${f.directory?"yellow-text grey":"grey white-text"}  via-m2">
<!--                <div class="card-image">
                </div>-->
                <div class="card-content via-m0 via-p2 root truncate ">
                    <div class=" row via-m0 via-m0">
                    <p class="col s11 via-m0 via-m0">
                        <a class=" via-m0 via-m0 black-text" href="/api/admin/file/list?q=${f.absolutePath}">
                            <span class="${f.directory?"yellow":"green"}  via-m0 via-p2">&nbsp;&nbsp;&nbsp;</span>
                            <span>${f.name}</span>
                        </a>
                    </p>
                    <span class="pink right via-arrowCursor via-m0 via-m0 white-text targetAction" target="${f.absolutePath}" size="${f.length()}">&nbsp;:&nbsp;</span>
                    </div>
                </div>
            </div>
        </div>
        </c:forEach>
        </div>
    </div>
</div>
<div id="renameSheet" class="modal bottom-sheet" >
    <p class="">&nbsp;&nbsp;Target: <span id="file" class="file via-bold"></span> [<span id="size" class="blue-text"></span>]</p>
    <div class="modal-content">
    <div class="row">
    <div class="input-field col s12 m3">
        <input id="newName" name="newName"  type="text" class="validate">
        <label for="newName">New Name</label>
    </div>
    <div class="col s12">
        <span class="col s4 m2 btn red delete">Delete</span>
        <span class="col s4 m2  btn green copy-dir">Copy Dir</span>
        <span class="col s4 m2  btn blue copy-file">Copy File</span>
        <span class="col s4 m2 btn rename green">Rename</span>
        <span class="col s4 m2  btn blue newDir">new dir</span>
        <span class="col s4 m2  btn green newFile">new file</span>
    </div>
    </div>
</div>
<div class="modal-footer">
  <!--<a href="#!" class="modal-close waves-effect waves-green btn-flat green">Save</a>-->
  <a href="#!" class="modal-close waves-effect waves-green btn-flat red">Cancel</a>
</div>
</div>
<div id="recentSheet" class="modal bottom-sheet" >
    <p class="">&nbsp;&nbsp;Recent</p>
    <div class="modal-content">
    <div class="row">
    <c:forEach items="${recent}" var="f">
        <div class="col s12 m4 l3">
            <div class="card ${f.directory?"yellow-text grey":"grey white-text"}  via-m2">
<!--                <div class="card-image">
                </div>-->
                <div class="card-content via-m0 via-p2 root truncate ">
                    <div class=" row via-m0 via-m0">
                    <p class="col s11 via-m0 via-m0">
                        <a class=" via-m0 via-m0 black-text" href="/api/admin/file/list?q=${f.absolutePath}">
                            <span class="${f.directory?"yellow":"green"}  via-m0 via-p2">&nbsp;&nbsp;&nbsp;</span>
                            <span>${f.name}</span>
                        </a>
                    </p>
                    <span class="pink right via-arrowCursor via-m0 via-m0 white-text targetAction" target="${f.absolutePath}" size="${f.length()}">&nbsp;:&nbsp;</span>
                    </div>
                </div>
            </div>
        </div>
        </c:forEach>
    </div>
</div>
<div class="modal-footer">
  <!--<a href="#!" class="modal-close waves-effect waves-green btn-flat green">Save</a>-->
  <a href="#!" class="modal-close waves-effect waves-green btn-flat red">Cancel</a>
</div>
</div>
<script>
    $('.modal').modal();
    $("select").formSelect();
    var rename=M.Modal.getInstance(document.getElementById("renameSheet"));
    $(".targetAction").on("click",function(){
        $(".file").text(""+this.getAttribute("target"));
        var size=this.getAttribute("size");
        var gb=size/(1024*1024*1024)
        var mb=size/(1024*1024)
        var kb=size/(1024)
        if(gb>=1){
            size=gb.toFixed(2)+" GB"
        }else if(mb>=1){
            size=mb.toFixed(2)+" MB"
        }else if(kb>=1){
            size=kb.toFixed(2)+" KB"
        }else{
            size=size+"bytes"
        }
        $("#size").html(size);
        $("#newName").val(""+this.getAttribute("target"));
        rename.open(); 
        M.updateTextFields();
    });
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
    $(".delete").on("click",function(){
       var file=$("#file").text();
       $.ajax({url: "/api/admin/file/delete?q="+escape(file),type :"DELETE" ,
        success : function(result) {
            console.log(result)
            try{
                M.toast({html:result});
                rename.close()
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
    $(".rename").on("click",function(){
       var file=$("#file").text();
       $.ajax({url: "/api/admin/file/rename?name="+escape($("#newName").val())+"&q="+escape(file),type :"GET" ,
        success : function(result) {
            console.log(result)
            try{
                M.toast({html:result});
                rename.close()
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
    $(".copy-dir").on("click",function(){
       var file=$("#file").text();
       $.ajax({url: "/api/admin/file/copy-dir?path="+escape($("#newName").val())+"&q="+escape(file),type :"GET" ,
        success : function(result) {
            console.log(result)
            try{
                M.toast({html:result});
                rename.close()
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
    $(".copy-file").on("click",function(){
       var file=$("#file").text();
       $.ajax({url: "/api/admin/file/copy?path="+escape($("#newName").val())+"&q="+escape(file),type :"GET" ,
        success : function(result) {
            console.log(result)
            try{
                M.toast({html:result});
                rename.close()
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
    
    $(".newFile").on("click",function(){
       var file=$("#newName").val();
       $.ajax({url: "/api/admin/file/new?type=file&q="+escape(file),type :"GET" ,
        success : function(result) {
            console.log(result)
            try{
                M.toast({html:result});
                rename.close()
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
    $(".newDir").on("click",function(){
       var file=$("#newName").val();
       $.ajax({url: "/api/admin/file/new?type=dir&q="+escape(file),type :"GET" ,
        success : function(result) {
            console.log(result)
            try{
                M.toast({html:result});
                rename.close()
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
    $("#uploader").submit(function(){
//    $('#uploader .list').fadeIn(100).css("width","0px");
    var data = new FormData();
    // if you want to append any other data: data.append("ID","");
    $.each($('#file')[0].files, function(i, file) {
        data.append('file-'+i, file);
    });
    $.ajax({
        url: 'uploadimage.php',
        data: data,
        cache: false,
        contentType: false,
        processData: false,
        type: 'POST',
        xhr: function() {  // custom xhr
            myXhr = $.ajaxSettings.xhr();
            if(myXhr.upload){ // check if upload property exists
                myXhr.upload.addEventListener('progress',progressHandlingFunction, false); // for handling the progress of the upload
            }
            return myXhr;
        },
        success: function(data2){
            $('#uploader .list').css({
                "width":"200px",
                "text-align":"center",
                "margin":"10px 0 10px 0"
            }).html("DONE!").delay(2000).fadeOut(500);
            if (data2 == "ERROR_FILESIZE"){
                return alert("Choose another file");
            }else{ /*change location*/ }
        }
    });
    return false;
    });
</script>
