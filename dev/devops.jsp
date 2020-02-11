<%-- 
    Document   : devops
    Created on : 8 Jun, 2018, 3:54:03 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="loginForm" style="max-width: 100%;">
    <style>
        .yellow{
            background-color: yellow !important;
            transition: all 1s;
            color: #449955;
        }
        .normal{
                  background-color: transparent;
                  transition: all 1s;
              }
        .inputWrapper {
	position: relative;
	width: auto;
        display: inline-block;
        min-height: 50px;
}
        .inputWrapper .inputText{
                width: 100%;
                outline: none;
                border:none;
                border-bottom: 1px solid #777;
        }
        .inputWrapper .inputText:invalid {
                box-shadow: none !important;
        }
        .inputWrapper .inputText:focus{
                border-color: blue;
                border-width: medium medium 2px;
        }
        .inputWrapper .movLabel {
                position: absolute;
                pointer-events: none;
                font-size: 15px;
                top: 7px;
                left: 5px;
                transition: 0.2s ease all;
        }
        .inputWrapper input::-webkit-input-placeholder {
            color:white;

        }
        .inputWrapper input:focus ~ .movLabel,
        .inputWrapper input:not(:focus):valid ~ .movLabel{
	top: -10px;
	left: 5px;
	font-size: 10px;
	opacity: 1;
}
    </style>
    
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left" style="">
            <i class="fa btn fa-toggle-left fa-1pt25x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<!--            <span class="white"><h2 class="nomargin nopadding">Finance Record</h2></span><hr>-->
<div style="margin: 1px;padding: 1px;border: 1px white solid;">
    <p class="nomargin nopadding white bgcolt8">Filters</p><hr>
    <ul class="bgcolef">
        <li class="navLink leftAlText">Create Form<span class="right fa fa-angle-double-right"></span></li><hr>
    </ul>
</div>
    <div style="margin-top: 10px;padding: 1px;border: 1px white solid;" class="bgcolef">
    <p class="nomargin nopadding white bgcolt8">Quick Links </p><hr>
        <ul>
            <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','quicklinks/openingRec.jsp',false);"><span class="right fa fa-angle-double-right"></span></li><hr>
            <li class="navLink leftAlText" onclick="popLR('quicklinks/stockVouchers.jsp?'+gfd('dtFilt'),false);"><span class="right fa fa-angle-double-right"></span></li><hr>
        </ul>
    </div><br>
    </div>
        <script>
            
        </script>
    <div class="right sbnvLdr" id="linkLoader">
        <div class="fullWidWithBGContainer">
            <form id="uimainform"  name="uimainform" onsubmit="return false;" action="" method="post">
            <p class="bgcolef nmgn npdn">UI Manager</p><hr>
            <div class="">
                <p class="bgcolef nmgn spdn">Entity Options</p>
            
                <br>
                <input type="hidden" name="action" value="uiman"/>
                <input type="hidden" name="fields" id="fields" value=""/>
                
                <select class="textField" name="tgtClass" id="tgtClass">
                <option value="">Target Entity</option>
                <%
                File[] fls=new File(request.getRealPath("")+"/WEB-INF/classes/entities").listFiles();
                for(File f:fls){
                    if(!f.getName().contains("$")){%>
                    <option><%=f.getName().replaceAll(".class", "")%></option>
                    <%
                    }
                }
                %>
                </select><br>
                <input class="textField" type="text" name="ent" placeholder="Entity Name" id="ent"/><br>
                Create New Entity <input  type="checkbox" name="newent" id="newent"/><br>
                <input class="textField" type="text" name="ent" placeholder="Entity Name" id="ent"/><br><br>
            
            </div>
                <div class="">
                    <div class="bgcolef nmgn spdn">UI Options <span class="button fa invisible">OM</span><span class="right">
                            <i class="fa fa-plus greenFont button" id="addField"> Add Field</i>
                            <i class="fa fa-plus greenFont button" id="generate"> Generate</i></span></div>
                    <div id="uiopt">
                        <br>
                    </div>
                    <br>
                </div>
            </form>
        </div>
    </div>
    </div>
</div>
<script>
    var ele=0;
    $("#addField").on("click",function(){addField()});
    $("#generate").on("click",function(){subForm('uimainform','dev/generate.jsp')});
    function addField() {
        ele++;
        $("#fields").val(ele);
//        alert(ele);
        $("#uiopt").append("<input class='textField' tgt='"+ele+"' name='field"+ele+"' placeholder='Field Name' id='field"+ele+"'/>\n\
          <input name='placeholder"+ele+"'  class='textField' placeholder='placeholder' id='placeholder"+ele+"'/>\n\
            <select class='textField' name='type"+ele+"' ><option vlue=''>Select Type</option>\n\
                <option>String</option><option>Int</option><option>Long</option><option>Date</option><option>DateTime</option><option>Entity</option>\n\
            </select>\n\
            <select class='textField' name='validate"+ele+"' ><option value=''>Validation pattern</option>\n\
            <option>Not Null</option><option>Mobile(10)</option><option>Date</option><option>Number(With Float)</option><option>Mail</option>\n\
            <option>Password (Min 8 Char)</option>\n\
            </select>\
            Editable<input type='checkbox' class='textField' name='editable"+ele+"' checked  id='editable"+ele+"'/>\n\
        MovablePlaceholer<input type='checkbox' checked class='textField' name='movablePlaceholer"+ele+"'  id='movablePlaceholer"+ele+"'/><br>\n\
           ");
        $("#field"+ele).on("keyup",function(){
            var tgt=this.getAttribute("tgt");
//            alert(tgt);
            $("#placeholder"+tgt).val(this.value.charAt(0).toUpperCase()+this.value.substr(1));
        });
        return false;
    }
    function generate(){
        
        
        
    }
    
</script>