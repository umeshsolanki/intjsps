<%-- 
    Document   : live-editor
    Created on : Nov 8, 2019, 7:27:58 AM
    Author     : umesh
--%>

<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%--<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<%@include file="../header.jsp" %>--%>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="stylesheet" href="/materialize/css/materialize.min.css"/>
        <link  rel="stylesheet" href="/css/via.css" />
        <script type="text/javascript" src="/js/jquery-3.1.0.min.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
        <script src="/materialize/js/materialize.min.js" ></script>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <script src="https://cdn.jsdelivr.net/gh/google/code-prettify@master/loader/run_prettify.js"></script>
    </head>
<!--<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet"/>
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>-->
<!--<div class="row">
    <%--<%@include file="../adminMenu.jsp" %>--%>
    <div class="col s10">
        <form action="/api/admin/cms/page/publish" method="post">
            <div class="input-field col s12">-->
                <div class="col s12" id="editor" style="height: 70vh;">${body}</div>
<!--            </div>
            <br>
            &nbsp;<span class="btn blue contentPreviewButton">Preview</span>
            &nbsp;<span class="btn blue editButton" >Edit</span>-->
            &nbsp;<span class="btn blue publish">Merge</span>
<!--            
        </form>
    </div>
    <div class="col s12">
        <p>&nbsp;</p>
    </div>
    <div class="previewRenderContainer col s12"  >
       
    </div>
</div>
</body>-->
    <!-- Initialize Quill editor -->
    <script>
      var toolbarOptions = [
  ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
  ['blockquote', 'code-block'],
  [{ 'header': 1 }, { 'header': 2 }],               // custom button values
  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
  [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
  [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
  [{ 'direction': 'rtl' }],                         // text direction

  [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
  [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
  [ 'link', 'image', 'video', 'formula' ],          // add's image support
  [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
  [{ 'font': [] }],
  [{ 'align': [] }],
  ['clean']                                         // remove formatting button
];

var quill = new Quill('#editor', {
  modules: {toolbar: toolbarOptions},
  theme: 'snow'
});
      </script>

</html>
