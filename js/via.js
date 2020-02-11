/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
            var score=0;
            var subtopic="";
            var testName="";
            var toggle=true;
            var toggleright=true;
            var redir="";
            var curPage;
            function sync(cont,path){
                $("#"+cont).load(path);
            }
            var dockWindExpended=true;
            function toggleDockWind(){
//                alert(JSON.stringify(this));
//                for(var cc=0;cc< document.cookie){
//                    alert(document.cookie);
//                }
            if(dockWindExpended){
                document.cookie = "expended=false";
                dockWindExpended=false;
            }else{
                document.cookie = "expended=true";
                dockWindExpended=true;
            }
            
                $("i.fa-1pt25x").toggleClass("fa-arrow-circle-right fa-arrow-circle-left");
               $(".subNav").toggleClass("subNavColl");
               $(".sbnvLdr").toggleClass("sbnvLdrExp");
               setTimeout(function(){copyHdr("mainTable","header-fixed");},400);
            }
            function destroy(ele){
                $("#"+ele).remove();
            }
//            var confDat="",confURL="";
            function showDial(data,loc,head,mes,isjson){
//                alert("OM");
                $("#confDialHead").html(head);
                $("#dialMes").html(mes);
//                alert("OM");
                
                $("#confNoBtn").click(function(){hideMe('confirmDialog');});
                $("#confYesBtn").click(function(){
                    sendDataForResp(loc,data,isjson,true);
                });
                showMe("confirmDialog");
//                alert("end");
            }
            function mkTable(bundle){
                var tbl="<table><thead><tr>"
                for(var h=0;h<bundle.header.length;h++){
                    tbl+="<th>"+bundle.header[h]+"</th>";
                }
                tbl+="</tr></thead><tr>"
                for(var r=0;r<bundle.rows.length;r++){
                    
                }
            }
            function showDialWC(data,loc,head,mes,isjson,clbk){
//                alert("OM");
                $("#confDialHead").html(head);
                $("#dialMes").html(mes);
//                alert("OM");
                
                $("#confNoBtn").click(function(){hideMe('confirmDialog');});
                $("#confYesBtn").click(function(){
                    sendDataForResp(loc,data,isjson,true);
                });
                showMe("confirmDialog");
//                alert("end");
                
            }
            function editUI(head,target,action){
//                alert("OM");
                $("#editDialHead").html(head);
                $("#editAction").val(action);
                $('#editForm').html("<center><img src='images/loader.svg' width=100 height=100 /></center>");
                $("#editForm").load(target,function( response, status, xhr ) {
                if ( status == "error" ) {
                    showMes("Sorry!! Failed to Respond");
                    $('#editForm').html("");
        //            $( "#error" ).html( msg + xhr.status + " " + xhr.statusText );
                }else if ( status == "success" ) {
                    afe();
        //            $( "#error" ).html( msg + xhr.status + " " + xhr.statusText );
                }});
//                alert("OM");
                $("#editCancBtn").click(function(){hideMe('editDialog');});
                $("#editUpdateBtn").click(function(){
                    sdfr('edit',$('#globalEditForm').serialize(),false);
                });
                showMe("editDialog");
//                alert("end");
                
            }
            function hideMe(cont,remCont){
                if(remCont){
                    $("#"+cont).html("");
                }
                $("#"+cont).css("display","none");
            }
            function showMe(cont){
                if(cont===true){
                    
                }else{
                    $("#"+cont).css("display","block");
//                    alert("OM");
                }
            }
            function rld(){
                
            }
            function ip(){
            $('.msg').html("<center><img src='images/loader.svg' width=100 height=100 /></center>");    
        }
        function hff(loc,dt){
            try{
                ip();
                $.post(loc,dt,function(data){
                    hideMes();    
                    return data;
                });
            }catch (e){
                showMes(e,true);
            }
        }
        
            function inject(data,cont) {
                
            }
            function pCnt(ii,alCtr,LSS) {
            var cont=$("#"+ii).html();
            var wind=window.open("VIA ERP","Print");
            wind.document.write("<html><head>"+(LSS?"<link href='http://pullandry.org/css/PullNDry.css' rel='stylesheet' type='text/css'/>":"")+"</head><body>"+(alCtr?"<center>"+cont+"</center>":cont)+"</body></html>");
            wind.location="http://localhost:8080/18/";
//            wind.
            wind.print();
//            wind.close();
            return true;
        }
            function inj(data,ref) {
                
            }
            function clr(id){
                $("#"+id).html("");
            }
            
            function popsl(pg){
                $('#leftPop').html("<img src='images/loader.svg' width=100 height=100 />");    
                $("#leftPop").load(pg,function( response, status, xhr ) {
                if ( status == "error" ) {
                    showMes("Sorry!! Failed to Respond");
                    $('#leftPop').html("");
        //            $( "#error" ).html( msg + xhr.status + " " + xhr.statusText );
                }else if(status =="success"){
                    $("#leftPop").addClass("shadow");
                    afe();
                }});
        }
            function popsr(pg){
                $('#rigPop').html("<img src='images/loader.svg' width=100 height=100 />");    
                $("#rigPop").load(pg,function( response, status, xhr ) {
                if ( status == "error" ) {
                    showMes("Sorry!! Failed to Respond");
                    $('#rigPop').html("");
        //            $( "#error" ).html( msg + xhr.status + " " + xhr.statusText );
                }else if(status =="success"){
                    $("#rigPop").addClass("shadow");
                    afe();
                }});
        }
            function popLL(pg) {
                $('#LLPop').html("<img src='images/loader.svg' width=100 height=100 />");    
                $("#LLPop").load(pg,function( response, status, xhr ) {
                if ( status == "error" ) {
                    showMes("Sorry!! Failed to Respond");
                    $('#LLPop').html("");
        //            $( "#error" ).html( msg + xhr.status + " " + xhr.statusText );
                }else if(status =="success"){
                    $("#LLPop").addClass("shadow");
                    afe();
                }});
            }
            function popLR(pg) {
                $('#LRPop').html("<img src='images/loader.svg' width=100 height=100 />");    
                $("#LRPop").load(pg,function( response, status, xhr ) {
                if ( status == "error" ) {
                    showMes("Sorry!! Failed to Respond");
                    $('#LRPop').html("");
        //            $( "#error" ).html( msg + xhr.status + " " + xhr.statusText );
                }else if(status =="success"){
                    $("#LRPop").addClass("shadow");
                    afe();
                }});
            }
            function clrLSP(){
                $("#leftPop").html("");
                $("#leftPop").removeClass("shadow");
            }
            function clrRSP(){
                $("#rigPop").html("");
                $("#rigPop").removeClass("shadow");
            }
            function clrLLP(){
                $("#LLPop").html("");
                $("#LLPop").removeClass("shadow");
            }
            function clrLRP(){
                $("#LRPop").html("");
                $("#LRPop").removeClass("shadow");
            }

            
        function maximizeMe(cont) {
//            var width = window.innerWidth|| document.documentElement.clientWidth|| document.body.clientWidth;
            var height = window.innerHeight|| document.documentElement.clientHeight|| document.body.clientHeight;
            $('#'+cont).height(height-55);
            $('#'+cont).css('max-height',(height-55)+'px');
            $('#'+cont).css('overflow','auto');
            $('#'+cont).html('<style>.scrollable{max-height:'+(height-55)+'px;}</style>'+$('#'+cont).html());
//              $('.scrollable').css('max-height',height-60+'px');
//              var scrl=document.getElementsByClassName("scrollable");
//              alert()
//              for(var v=0;v<scrl.length;v++){
//                  alert(v);
//              }              
//              alert($('.scrollable').maxHeight);
//              $('.scrollable').css('overflow','auto');
//            alert();
//                alert($("#"+cont).height());
        }
        var minimized=[];
            function minimize(id){
                
            }
            function maxizmize(id) {
    
            }
            function collapse(id) {
    
            }
            function decollapse(id) {
    
            }
            
            
            function showMes(content,isError,autoHide) {
                    $(".msg").css("z-index","9999999");
                    $(".msg").css("padding","5px");
                    $(".msg").css("box-shadow","#000 0px 10px 15px");
                    if(isError){
                        $(".msg").css("color","RED");
                    }else{
                        $(".msg").css("color","green");
                    }
                    
                    $(".msg").html("<div class='close' onclick='hideMes()'><p class='blkFnt fa fa-close nmgn lpdg'></p></div><br>"+content+"<br><br>");
//                    if(narrate){
//                    var msg = new SpeechSynthesisUtterance(content);
//                    window.speechSynthesis.speak(msg);
//                    }
                if (autoHide){
                        setTimeout(function(){
                            hideMes();
                        },5000);
                    }
                    }
                  
            /**
             * to hide message popup
             */
            function hideMes() {
                 $(".msg").css("padding","0px");
                 $(".msg").html("");
                 $(".msg").css("box-shadow","none");
                 $(".msg").css("position","fixed");
//                 window.speechSynthesis.cancel();
            }
            function subForm(fm,loc){
                $('.msg').html("<center><img src='images/loader.svg' width=100 height=100 /></center>");    
                $.post(loc,$("#"+fm).serialize(),function(data){
                    if(data.indexOf("success")>0){
                        $("#"+fm)[0].reset();
                        showMes(data,false);
                    }else{
                        showMes(data,true);
                    }
                
            }).fail(function(){showMes("Please try again",true);});
                return false;            
        }
        
        function finEditing(){
            hideMe('editDialog');
        }
    
        String.prototype.replaceAll=function(search,repl){
                            var target=this;
                            return target.replace(new RegExp(search,'g'),repl);
                        };
//}
                        
        
        function createTable(col,row,modalArr){
            for(obj in modalArr){
                
            }
        }
        
            var initX,finalY,reqScrollAmt;
//            var head="head",mes="om";
            function addShortcuts(){
                $(document).on("keydown",function(evt){
                    var pa=window.location.pathname;
//                    alert(pa);
                    var k=evt.key;
//                    showMes(k);
                    if(k==='Escape'){
                        clrLLP();clrLSP();hideMes();
                        clrLRP();clrRSP();
                        clearViewIn("contentLoader");
                        $("#contentLoader").height(0);
                        $("#contentLoader").width(0);
                    }
//                    if(k==='q'){
//                        clearViewIn("contentLoader");
//                        clrLLP();clrLSP();hideMes();
//                        clrLRP();clrRSP();
//                        
//                    }
//                    if(pa.indexOf("sellers")>0){
//                    if(k==='l'){
//                        loadPage("df/LoginForm.jsp")
////                        clrLLP();clrLSP();hideMes();
////                        clrLRP();clrRSP();      
//                    }
//                    }else{
//                        if(k==='l'){
//                            loadPage("forms/LoginForm.jsp");
//                        }else if(k==='p'){
//                            loadPage("af/BRProduction.jsp");
//                        }else if(k==='b'){
//                            loadPage("af/BranchManagement.jsp");
//                        }else if(k==='f'){
//                            loadPage("af/FinanceReq.jsp");
//                        }else if(k==='c'){
//                            loadPage("af/AllDistComp.jsp");
//                        }else if(k==='o'){
//                            loadPage("af/AllDistSale.jsp");
//                        }else if(k==='f'){
//                            loadPage("af/FinanceReq.jsp");
//                        }
//                        }
                    });
            }
            /**
             * remove shortcuts
             */
            function remShortcuts() {
                $(document).on("keydown",function(evt){});
            }
            $(document).ready(function(){
                addShortcuts();
                $(".fullWidWithBGContainer").on("click",function(){hideSideBar();});
                $(".pageContainer").on("click",function(){hideSideBar();});
                $(".half").on("click",function(){hideSideBar();});
//                $("input ").on("focus",function(){remShortcuts()});
//                $("input ").on("blur",function(){addShortcuts()()});
//                $("textarea").on("focus",remShortcuts());
//                $("textarea").on("blur",addShortcuts());
//                $(".half").on("click",function(){hideSideBar();});
//                $(document).on("click",function(){hideSideBar()});
//                var team=document.getElementById("team");
//                team.ch
////                var reqScrollAmt=document.getElementById("content").scrollWidth;
//                reqScrollAmt=(team.scrollWidth-team.offsetWidth)/3.0;
//                team.addEventListener("touchstart",function(e){
//                    var touchObj=e.changedTouches[0];
//                    initX=touchObj.pageX;
//                });
//                team.addEventListener("touchmove",function(e){
//                    e.preventDefault();
//                        var touchObj=e.changedTouches[0];
//                    var scrollAmt=initX-touchObj.pageX;
////                    if(scrollAmt>0)
////                    team.scrollLeft=scrollAmt;
////                else if(scrollAmt<0)
////                    team.scrollLeft=scrollAmt;
//                });
//                team.addEventListener("touchend",function(e){
//                    var touchObj=e.changedTouches[0];
//                    var scrollAmt=initX-touchObj.pageX;
//                    if(scrollAmt>0)
//                    team.scrollLeft+=reqScrollAmt;
//                else if(scrollAmt<0)
//                    team.scrollLeft-=reqScrollAmt;
//                });
                
                
//                var widLeft=$(".leftTest").width(),widRight=$(".rightPortion").width();
//                var midWidth=screen.availWidth-(widLeft+widRight+20);
                
//                $(".middleImages").css("width",midWidth+"px");
//                alert(midWidth);
//                $("#close").click(function(){
//                    $(".leftNavContent").html("");
//                    
////                    alert('om');
//                        if(toggle){
//                            $("#sideBarTitle").text("");
//                            $(".leftNav").css("width","10px");
//                            $(".leftNav").css("background-color","transparent");
//                            $("#close").text(">");
//                            toggle=false;
//                        }else{
//                            $("#sideBarTitle").text("Left Side Bar");
////                            $(".leftNav").removeAttr("box-shadow");
//                            $(".leftNav").css("background-color","#2696bc");
//                            $(".leftNav").css("width","45%");
//                            $("#close").text("<");
//                            toggle=true;
//                        }
//                    
//                });
//                $("#closeRight").click(function(){
//                    $(".rightNavContent").html("");
//                    
////                    alert('om');
//                        if(toggleright){
//                            $("#rightSideBarTitle").text("");
//                            $(".rightNav").css("width","10px");
//                            $(".rightNav").css("background-color","transparent");
//                            $("#closeRight").text("<");
//                            toggleright=false;
//                        }else{
//                            $("#rightSideBarTitle").text("Right Side Bar");
////                            $(".leftNav").removeAttr("box-shadow");
//                            $(".rightNav").css("background-color","#2696bc");
//                            $(".rightNav").css("width","45%");
//                            $("#closeRight").text(">");
//                            toggleright=true;
//                        }
//                    
//                });
//                $(".msg").click(function(){
//                    hideMes();
                    urlSniffer();
//                });
            });
            
            function login(){
                
                $('#contentLoader').html("");
                $('#contentLoader').html("<img src='images/loader.svg' width=100 height=100 />");    
                $('#contentLoader').css("display","block");
                $('#contentLoader').load("LoginForm.jsp");
                hideMes();
            }
            function appLogin(){
                $('#contentLoader').html("");
                $('#contentLoader').html("<img src='images/loader.svg' width=100 height=100 />");    
                $('#contentLoader').css("display","block");
                $('#contentLoader').load("appLoginForm.jsp");
                hideMes();
            }
            function logout(){
                $('.msg').html("<img src='images/loader.svg' width=100 height=100 />");
                window.location.replace("logout.jsp");
                hideMes();
            }
            function register(){ 
                hideMes();
                $('#contentLoader').html("<img src='images/loader.svg' width=100 height=100 />");
                $('#contentLoader').css("display","block");
                $('#contentLoader').load("RegForm.jsp");
                hideMes();
            }
        
    function subReg(){
        $('.msg').html("<img src='images/loader.svg' width=100 height=100 />");
        $.post("Reg",$("#regForm").serialize(),function(data){
        if(data.includes("success")){
            regForm.reset();
            window.location.replace("myAccount.jsp");
        }            
        $(".msg").css("padding","0px 2px 0px 2px");
        $(".msg").html("<center>"+data+"</center>");});
        return false;            
    }
    var toStart="index.jsp";
    function subLog(){
        $('.msg').html("<img src='images/loader.svg' width=100 height=100 />");
            $.post("ChkLogin",$("#loginForm").serialize(),function(data){
        if(data.includes("success")){
            window.location.replace("?Welcome");
        }            
        showMes(data);
    });
                return false;            
    }
    var toStart="index.jsp";
    function subAppLog(){
        $('.msg').html("<img src='images/loader.svg' width=100 height=100 />");
        $.post("ChkAppLogin",$("#apploginForm").serialize(),function(data){
        if(data.includes("success")){
            loginForm.reset();
            window.location.replace(toStart);
        }            
        $(".msg").css("padding","0px 2px 0px 2px");
        $(".msg").html("<center>"+data+"</center>");});
        return false;               
    }
    
    //<editor-fold defaultstate="collapsed" desc="comment">



//    navToggle=false;
//    function toggleNav(){
//        var navCont=document.getElementById("navCont");
////        alert(navCont.scrollHeight);
//        if(navToggle){
//            $(".navContainer").css("display","block");
//            $(".navContainer").css("height",navCont.scrollHeight+"px");
//        navToggle=false;
//    }else{
//        $(".navContainer").css("height","0px");
//        navToggle=true;
//    }
//    }
//</editor-fold>

leftSideToggle=true;
    function toggleSideBar(){
        var navCont=document.getElementById("navCont");
        if(leftSideToggle){
            $(".navContainer").css("height","100vh");
            $('.navContainer').css("width","14em"); 
        leftSideToggle=false;
    }else{
//            $(".navContainer").css("height","0px");
            $('.navContainer').css("width"," 0px");
            
        leftSideToggle=true;
    }
    }
    
    function toggleVisibility(cont,callback) {
        if($('#'+cont).css('display')!='none'){
            $('#'+cont).css('display','none');
        }else{
            $('#'+cont).css('display','block');
        }
        
    }
    function hideSideBar() {
//            var navCont=document.getElementsByClassName("navContainer")[0];
//            $(".navContainer").css("height","0px");
            $('.navContainer').css("width"," 0px");
            leftSideToggle=!leftSideToggle;
//        }
            
    }          
    function loadPg(x){
        try{
        $('#contentLoader').css("display","block");
        $('#contentLoader').css("transition"," opacity 1s");
        $('#contentLoader').css("opacity","1");
        $('#contentLoader').html("<img src='images/loader.svg' width=100 height=100 />");
        $('#contentLoader').load(x,function( response, status, xhr ) {
        if ( status == "error" ) {
            showMes("Sorry!! Failed to Respond");
                closeMe();
//            $( "#error" ).html( msg + xhr.status + " " + xhr.statusText );
        }else if ( status == "success" ) {
            afe();
//            $( "#error" ).html( msg + xhr.status + " " + xhr.statusText );
        }});
        maximizeMe('contentLoader');
        curPage=x;
        //if mobile
        toggleSideBar();
    }catch(ee){
        $('#contentLoader').html("");
        $('#contentLoader').css("display","none");
        $('#contentLoader').css("transition"," opacity 1s");
        $('#contentLoader').css("opacity","0");
        showMes("Loading error at server!! try again after some time",true);
    }
    }
    function refresh() {
        if(curPage!=null&&curPage.length>1)
            loadPage(curPage);
        else
            document.location.replace("");
        clrLSP();
        clrLLP();
        clrLRP();
        clrRSP();
    }
    function loadPage(x){
        $('#contentLoader').css("display","block");
        $('#contentLoader').css("transition"," opacity 1s");
        $('#contentLoader').css("opacity","1");
        $('#contentLoader').html("<img src='images/loader.svg' width=100 height=100 />");
        $('#contentLoader').load(x,function( response, status, xhr ) {
        if ( status == "error" ) {
            showMes("Failed to Respond");
            closeMe();
//            $( "#error" ).html( msg + xhr.status + " " + xhr.statusText );
        }else if ( status == "success" ) {
            afe();
//            $( "#error" ).html( msg + xhr.status + " " + xhr.statusText );
        }});
        maximizeMe('contentLoader');
        curPage=x;
        window.history.pushState({}, null, "#"+x);
//        alert(window.innerHeight);
        //if mobile
//        toggleSideBar();
    }
    
    function loadByJson(loc,dat){
        $('#contentLoader').css("display","block");
        $('#contentLoader').css("transition"," opacity 1s");
        $('#contentLoader').css("opacity","1");
        $('#contentLoader').html("<img src='images/loader.svg' width=100 height=100 />");
        try{
        $.ajax({
                        url:loc,type:"POST",data:dat,contentType: 'application/json;charset=utf-8',
                        success:function(data){
//                            console.log(data);
                            if(data.includes("success"))
                                $('#contentLoader').html(data);
                            else
                                  $('#contentLoader').html(data);
                        }
                    });
                }catch (err){
                    showMes("Error detected At Server: "+err,true);
                }
        //if mobile
//        toggleSideBar();
    }
    
    
    function sendDataForResp(loc,dat,isJson,closeDial){
             $('.msg').html("<center><img src='images/loader.svg' width=100 height=100 /></center>");    
             if(isJson){
                    $.ajax({
                        url:loc,type:"POST",data:dat,contentType: 'application/json;charset=utf-8',
                        success:function(data){
//                            console.log(data);
                            if(data.includes("success")){
                                showMes(data,false);
                                if(closeDial){
                                    hideMe('confirmDialog');
                                }
                            }else{
                                showMes(data,true);
                                if(closeDial){
                                    hideMe('confirmDialog');
                                }
                            }
                        }
                    });
                }else{
                    $.ajax({
                        url:loc,type:"POST",data:dat,
                        success:function(data){
//                            console.log(data);
                            if(data.includes("success")){
                                showMes(data,false);
                                if(closeDial){
                                    hideMe('confirmDialog');
                                }
                            }else{
                                  showMes(data,true);
                                  if(closeDial){
                                    hideMe('confirmDialog');
                                }
                              }
                        }
                    });
                }
    }
    
    function appResp(loc,dat,isJson,cont){
             $('.msg').html("<center><img src='images/loader.svg' width=100 height=100 /></center>");    
             if(isJson){
                    $.ajax({
                        url:loc,type:"POST",data:dat,contentType: 'application/json;charset=utf-8',
                        success:function(data){
//                            console.log(data);
                            hideMes();
                            $("#"+cont).append(data);
//                            showMes(data);
                        }
                    });
                }else{
                    $.ajax({
                        url:loc,type:"POST",data:dat,
                        success:function(data){
//                            console.log(data);
                            hideMes();
                            $("#"+cont).append(data);
//                            showMes(data);
                        }
                    });
                }
    }
    function prepResp(loc,dat,isJson,cont){
             $('.msg').html("<center><img src='images/loader.svg' width=100 height=100 /></center>");    
             if(isJson){
                    $.ajax({
                        url:loc,type:"POST",data:dat,contentType: 'application/json;charset=utf-8',
                        success:function(data){
//                            console.log(data);
                            hideMes();
                            $("#"+cont).prepend(data);
//                            showMes(data);
                        }
                    });
                }else{
                    $.ajax({
                        url:loc,type:"POST",data:dat,
                        success:function(data){
//                            console.log(data);
                            hideMes();
                            $("#"+cont).prepend(data);
//                            showMes(data);
                        }
                    });
                }
    }
        
        function sdfr(loc,dat,isJson){
             $('.msg').html("<center><img src='images/loader.svg' width=100 height=100 /></center>");    
             if(isJson){
                    $.ajax({
                        url:loc,type:"POST",data:dat,contentType: 'application/json;charset=utf-8',
                        success:function(data){
//                            console.log(data);
                            if(data.includes("success"))
                                showMes(data,false);
                            else
                                showMes(data,true);
                        }
                    });
                }else{
                    $.ajax({
                        url:loc,type:"POST",data:dat,
                        success:function(data){
//                            console.log(data);
                            if(data.includes("success"))
                                showMes(data,false);
                            else
                                showMes(data,true);
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            showMes("Please try again",true);
                        }
                    });
                }
        }
        function dm(mod,ui,rwCnt){
            $('.msg').html("<center><img src='images/loader.svg' width=75 height=75 /></center>");    
            $.ajax({
                        url:'FormManager?action=del&i='+ui+'&mod='+mod,contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        success:function(data){
//                            console.log(data);
                            if(data.includes("success")){
                                showMes(data,false);
                                $("tr").remove("#"+rwCnt);
                            }
                            else
                                showMes(data,true);
                        }
                    });
//            showDial('action=del&i='+ui+'&mod='+mod+'&r=','FormManager','Confirm delete','You cant undo the changes<br>It\'ll delete all linked data');
        }
    

        function gfd(fm) {
            return $("#"+fm).serialize();
            
        }
         
        function fm(dat) {
            $('.msg').html("<center><img src='images/loader.svg' width=100 height=100 /></center>");    
                    $.ajax({
                        url:"FormManager",type:"POST",data:dat,
                        success:function(data){
//                            console.log(data);
                            if(data.includes("success"))
                                showMes(data,false);
                            else
                                  showMes(data,true);
                        }
                    });
        }
         
        function sendDataWithCallback(loc,dat,isJson,callBack,obj){
            var fun;
             $('.msg').html("<center><img src='images/loader.svg' width=100 height=100 /></center>");    
             if(isJson){
                    $.ajax({
                        url:loc,type:"POST",data:dat,contentType: 'application/json;charset=utf-8',
                        success:function(data){
                            if(data.includes("success")){
                                fun=function(){callBack(data,obj);}
                                showMes(data,false);
                                fun(data,obj);
                            }else{
                                fun=function(){callBack(data,obj);}
                                showMes(data,true);
                                fun(data,obj);  
                            }
                        }
                    });
                }else{
                    $.ajax({
                        url:loc,type:"POST",data:dat,
                        success:function(data){
//                            console.log(data);
                            if(data.includes("success")){
                                fun=function(){callBack(data,obj);}
                                showMes(data,false);
                                fun(data,obj);  
                            }
                            else{
                                fun=function(){callBack(data,obj);}
                                showMes(data,true);
                                fun(data,obj);  
                              }
                        }
                    });
                }
                
        }

    function loadPageIn(containerId,page,toggle){
        $('#'+containerId).css("display","block");
        $('#'+containerId).css("transition"," opacity 1s");
        $('#'+containerId).css("opacity","1");
        $('#'+containerId).html("<center><img src='images/loader.svg' width=100 height=100 /></center>");
        $('#'+containerId).load(page,function( response, status, xhr ) {
        if ( status == "error" ) {
            showMes("Failed to Load");
            $('#'+containerId).html("");
//            $( "#error" ).html( msg + xhr.status + " " + xhr.statusText );
        }else if ( status == "success" ) {
            afe();
//            $( "#error" ).html( msg + xhr.status + " " + xhr.statusText );
        }});
        //if mobile
//        curPage=page;
        if(toggle)
        toggleSideBar();
    }
    function clearViewIn(container){
                
                $('#'+container).html("");
                hideMes();
    }
    function loadInExpandableCont(cont,url,data,expandId,shrinkId) {
        $('#'+cont).html("<img src='images/loader.svg' width=100 height=100 />");
        $.ajax({
                        url:url,type:"POST",data:data,
                        success:function(da){
//                            console.log(data);
                            shrink(shrinkId);
                            expand(expandId);
                            $('#'+cont).html(da);
                        }
                    });
}

    var allMats=[];
    var newMaterialView="";
    function editPCC(containerId,url,toggle) {
        $('#'+containerId).css("display","block");
        $('#'+containerId).css("transition"," opacity 1s");
        $('#'+containerId).css("opacity","1");
        $('#'+containerId).html("<img src='images/loader.svg' width=100 height=100 />");
        if(toggle)
        toggleSideBar();
        $.ajax({
                        url:url,
                        success:function(da){
//                            console.log(da);
//                            alert(da);
                    var htmlView="<div class='loginForm'><h2 class='white'>Update PPC</h2><hr>"+
                    "<span class='close' onclick='closeMe()'>&Cross;</span>"+
                    "<table id=''>";
                            var obj=JSON.parse(da);
                            allMats=obj.allMats;
                            var ppcArr=obj.ppcArr;
                            var addNewMatView="";
                            for(var ind in ppcArr){
                                var obj=ppcArr[ind];
                                htmlView+="<tr>\n\
    <td><input class='textField' id='matId"+ind+"'"+" value='"+obj.matId+"' /></td>\n\
    <td><input class='textField' id='qntId"+ind+"'"+" value='"+obj.qnt+"' /></td>\n\
    <td><button class='button' onclick=''>&circleddash;</button><button class='button' onclick=''>Update</button></td>";
                            }
                            htmlView+="</table><br><button class='button' >Save</button><br><br></div>";
                            newMaterialView="<form id=''>\n\
                    <select class='autoFitTextField' ><option>Select Material</option>";
                                for(ind in allMat){
                                        var obj=allMats[ind];
//                                        alert(obj['id']);
                                        sel+="<option>"+obj.id+"</option>";
                                }
                                sel+="</select>";
                                var fieldHtml=sel+"\
    <input name='qnt' id='qnt' class='autoFitTextField' type='text' placeholder='*Quantity' /><br>";
                                $("#materialsCont").append(fieldHtml);
                            $("#"+containerId).html(htmlView);
                        }
                    });
        //if mobile
        
    }
            function closeMe(){
                curPage='';
                $('#contentLoader').css("transition"," opacity 1s");
                $('#contentLoader').css("opacity","0");
                hideMes();
                setTimeout(function(){
                    $('#contentLoader').css("display","none");
                },500);
                toggleSideBar();
            }
            

function isLoggedIn(x){
    $('.msg').html("<img src='images/loader.svg' width=100 height=100 />");
    $.post("isLoggedIn",function(data){
        
        if(data==="success"){
            
            window.location.replace("doTest?testId="+x);
        }else{
            toStart="doTest?testId="+x;
            login();
            $(".msg").html("&nbsp;Please Login&nbsp;");
        }
    });
}
            
(function hideAll(){
                var cls=document.querySelectorAll(".layer");
                var cls1=document.querySelectorAll(".layer1");
                for(var ind=0;ind<cls.length;ind++){
                    cls[ind].style.opacity="0";
                }
                for(var ind=0;ind<cls1.length;ind++){
                    cls1[ind].style.opacity="0";
                    alert("layer1");
                }
            })();
            var init=0,init1=0;
            function switchImg(){
                var cls=document.querySelectorAll(".layer");
                var cls1=document.querySelectorAll(".layer1");
                if(init>0){
                    cls[init-1].style.opacity="0";
                }
                if(init>=cls.length){
                    init=0;
                    cls[init].style.opacity="1";
                    init++;
                }else{
                    cls[init].style.opacity="1";
                    init++;
                }
                
                if(init1>0){
                    cls1[init1-1].style.opacity="0";
                }
                if(init1>=cls1.length){
                    init1=0;
                    cls1[init1].style.opacity="1";
                    init1++;
                }else{
                    cls1[init1].style.opacity="1";
                    init1++;
                }
            }
            var expended=false;
            function shrink(container){
                var cont=document.getElementById(container);
                if(cont!=null){
                cont.style.height="75px";
                cont.style.overflow="hidden";
            }
            }
            
            function expand(container){
                var cont=document.getElementById(container);
                    if(cont!=null){
                cont.style.height=cont.scrollHeight+"px";
                cont.overflow="auto";
                    }
            }
            function hndl(ref,on,dat,act){
                var ob;
                if(on!=null){
                ob=$('#'+on);
                alert("obj"+ob);
                }
                if(ref!=null){
                    ob=ref;    
                    if(act=='mvsale'){
                        $(ref).attr("onclick","");
                        $(ref).text("Moved");
                    }
                }
                
            }
            function remClL(ref){
                $(ref).removeAttr("onclick");
            }
            function toggleXpand(container){
//                alert(expended);
                if(expended){
                    expand(container);
                    expended=!expended;
                }else{
                    shrink(container);
                    expended=!expended;
                }
            }
            function urlSniffer(){
//                var us = window.location.;
//                var url = new URL(window.location.href);
//                var c = url.searchParams.get("");
//                console.log(c);
//                showMes("You are on home page",true,true);
//                loadPg("OM")
            }
            
            
//    setInterval(switchImg,3000);
    
    function genCol(){
         return "rgb("+getRandomInt(0,255)+","+getRandomInt(0,255)+","+getRandomInt(0,255)+")";   
    }
    function getRandomInt(min, max) {
            min = Math.ceil(min);
            max = Math.floor(max);
            return Math.floor(Math.random() * (max - min)) + min; //The maximum is exclusive and the minimum is inclusive
    }
                    
    function getBGColrsArr(count) {
        var cols=[];
        for(var i=0;i<count;i++){
            cols.push(genCol());
        }
        return cols;
    }
    
    function copyHdr(from,to){
        var $fixedHeader=$("#"+to).html($("#"+from+" > thead").clone(false));
        $("#"+to+" th").each(function(index){
    var index2 = index;
    $(this).width(function(index2){
        var eee= $("#"+from+" th").eq(index).width();
//        $("#mainTable th").eq(index).html("-");
//        alert(eee);
        return eee;
    });
    });
    }
    var curNot=0;
    function notify(head,mes,go){
        curNot++;
        $("#impNotCont").prepend("<div class=\"notification topMar\" id='notice"+curNot+"'>\
        <i class=\"fa fa-close close\" onclick='destroy(\"notice"+curNot+"\")'></i>\
        <h5 class=\"nomargin spdn leftAlText\">"+head+"</h5><hr>\
        <p>"+mes+"</p>\n\
        <div class='rightAlText'><span title='do not show in future' class='fa fa-trash redFont button'></span>\n\
        <span title='remind after 2 hrs' class='fa fa-clock-o greenFont button'></span>\n\
        "+(go.length>0?"<span title='Click to Go' class='fa fa-reply greenFont button' onclick=\""+go+";$('#impNotCont').toggleClass('nopen nclose');\"></span>":"")+"\
        </div>\n\
        </div>");
//        alert(mes);
        if($("#impNotCont").hasClass("nclose")){
            $("#impNotCont").toggleClass("nopen nclose");
        }
    }
    
//setInterval(function(head,mes){
//        curNot++;
//        $("#impNotCont").append("<div class=\"notification topMar\" id='notice"+curNot+"'>\
//        <i class=\"fa fa-close close\" onclick='destroy(\"notice"+curNot+"\")'></i>\
//        <h4 class=\"nomargin spdn leftAlText\">"+head+"</h4><hr>\
//        <p>"+mes+"</p><br>\
//        </div>");
//        if($("#impNotCont").hasClass("nclose")){
//            $("#impNotCont").toggleClass("nopen nclose");
//        }
//    },1000);
            
function sortTable(id,colInd,numerically) {
  var table, rows, switching, i, x, y, shouldSwitch;
  table = document.getElementById(id);
  switching = true;
  /* Make a loop that will continue until
  no switching has been done: */
  while (switching) {
    // Start by saying: no switching is done:
    switching = false;
    rows = table.rows;
    /* Loop through all table rows (except the
    first, which contains table headers): */
    for (i = 1; i < (rows.length - 1); i++) {
      // Start by saying there should be no switching:
      shouldSwitch = false;
      /* Get the two elements you want to compare,
      one from current row and one from the next: */
      x = rows[i].getElementsByTagName("TD")[colInd];
      y = rows[i + 1].getElementsByTagName("TD")[colInd];
      // Check if the two rows should switch place:
      if(numerically){
      if (Number(x.innerHTML) > Number(y.innerHTML)) {
        shouldSwitch = true;
        break;
      }
  }else{
      if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
        // If so, mark as a switch and break the loop:
        shouldSwitch = true;
        break;
      }
    }
    }
    if (shouldSwitch) {
      /* If a switch has been marked, make the switch
      and mark that a switch has been done: */
      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
      switching = true;
    }
  }
}

function AIEL() {
    $(".docketRef").on("click",function(){
       popsl('af/dockRec.jsp?d='+this.innerHTML); 
    });
}

function AUIEL(){
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
    acc[i].addEventListener("click", function() {
        /* Toggle between adding and removing the "active" class,
        to highlight the button that controls the panel */
        this.classList.toggle("active");

        /* Toggle between hiding and showing the active panel */
        var panel = this.nextElementSibling;
        if (panel.style.display === "block") {
            panel.style.display = "none";
        } else {
            panel.style.display = "block";
        }
    });
}
}
var fileEdit=0;
function afe(){
    $(".leftPop").on("click",function(){
            popsl(this.getAttribute("src")+".jsp");
    });
    $(".rPop").on("click",function(){
            popsr(this.getAttribute("src")+".jsp");
    });
//    $(".mr")
    $(".fedit").on("click",function(){
        fileEdit++;
        var box=document.createElement("div");
        box.id="fileEdit"+fileEdit;
        box.style.position="fixed";
        document.body.style.overflow="hidden";
        box.style.top="55px";
        box.style.bottom="50px";
        box.style.height="100vh";
        box.style.right="0px";
        box.style.left="0px";
        box.style.zIndex="99999";
        box.innerHTML="<div class='bgcolt8 fullWidWithBGContainer p-5' style='position:fixed;'>\n\
        <div class='d3 left'>"+this.getAttribute("name")+"</div><div class='d3 left'><span><i class='centAlText button fa fa-save bold'  file='"+this.getAttribute("data")+"' id='saveFile"+fileEdit+"' > Save</i></span></div><div class='d3 left'></div>\n\
        \n\<i class='fa fa-close close' id='flclose"+fileEdit+"'></i></div><br>\n\
        <div style='padding-top:25px'><textarea style='min-width:100%;min-height:100%;height:85vh' id='flcontent"+fileEdit+"' editable='true'></textarea></div>";
        $(box).addClass("loginForm panel");
        $(document.body).prepend(box);
//        load
        $.post(this.getAttribute("src"),"f="+this.getAttribute("data"),function(data){
         $("#flcontent"+fileEdit).text(data);
        });
        $("#flclose"+fileEdit).on("click",function(){
            document.body.style.overflow="";
            destroy("fileEdit"+fileEdit);
        });
        $("#saveFile"+fileEdit).on("click",function(){
            sdfr('../write',"f="+escape(this.getAttribute("file"))+"&cont="+escape($("#flcontent"+fileEdit).val()));
        });
        
    });
     $(".uploadTextFile").on("change",function(){
         var selFileUpload = document.getElementById("files").files[0];    
         alert(selFileUpload.value);
        fileEdit++;
        var box=document.createElement("div");
        box.id="fileEdit"+fileEdit;
        box.style.position="fixed";
        document.body.style.overflow="hidden";
        box.style.top="55px";
        box.style.bottom="50px";
        box.style.height="100vh";
        box.style.right="0px";
        box.style.left="0px";
        box.style.zIndex="99999";
        box.innerHTML="<div class='bgcolt8 fullWidWithBGContainer p-5' style='position:fixed;'>\n\
        <div class='d3 left'>"+this.getAttribute("name")+"</div><div class='d3 left'><span><i class='centAlText button fa fa-save bold'  file='"+this.getAttribute("data")+"' id='saveFile"+fileEdit+"' > Save</i></span></div><div class='d3 left'></div>\n\
        \n\<i class='fa fa-close close' id='flclose"+fileEdit+"'></i></div><br>\n\
        <div style='padding-top:25px'><textarea style='min-width:100%;min-height:100%;height:85vh' id='flcontent"+fileEdit+"' editable='true'></textarea></div>";
        $(box).addClass("loginForm panel");
        $(document.body).prepend(box);
//        load
        $.post(this.getAttribute("src"),"f="+this.getAttribute("data"),function(data){
         $("#flcontent"+fileEdit).text(data);
        });
        $("#flclose"+fileEdit).on("click",function(){
            document.body.style.overflow="";
            destroy("fileEdit"+fileEdit);
        });
        $("#saveFile"+fileEdit).on("click",function(){
            sdfr('../write',"f="+escape(this.getAttribute("file"))+"&cont="+escape($("#flcontent"+fileEdit).val()));
        });
        
    });
}
window.onhashchange=function(data){
    if(window.location.hash.substr(1).length>1)
    loadPage(window.location.hash.substr(1));
}

function promptWC(bundle){
//                alert("OM");
                $(document.body).append("<div  class=\"conDial\" id=\"promptDialog\">\n" +
                    "        <center>\n" +
                    "            <div class=\"fullWidWithBGContainer\"  id=\"promptBox\">\n" +
                    "                <div class=\"bgcolef\" style=\"border-radius:5px;max-width: 50%;min-height: 300px;margin-top: 70px;\">\n" +
                    "                    <div class=\"fullWidWithBGContainer\">\n" +
                    "                        <span class=\"fa fa-close close\" onclick=\"destroy('promptDialog')\"></span>\n" +
                    "                        <h3 id=\"promptDialHead\" class=\"bgcolt8 leftAlText nomargin spdn movCurs\">Dialog</h3>\n" +
                    "                        <div id=\"promptDialCont\" class=\"leftAlText spdn\">\n" +
                    "                            <form action=\"#\" onsubmit=\"return false;\" id=\"globalPromptForm\">\n" +
                    "                            <p class=\"greenFont\" id=\"promptInputCont\">\n" +
                    "                            </p>\n" +
                    "                            <span class=\"right lpdn\">\n" +
                    "                                <button class=\"button greenFont\" id=\"promptActBtn\">Proceed</button>\n" +
                    "                                <button  class=\"button redFont\" id=\"promptCancBtn\">Cancel</button>\n" +
                    "                            </span>\n" +
                    "                            </form>\n" +
                    "                        </div>\n" +
                    "                    </div>\n" +
                    "                </div>\n" +
                    "            </div>\n" +
                    "        </center>\n" +
                    "</div>\n" +
                    "");
                $("#promptDialHead").html(bundle.head);
                $("#promptActBtn").text(bundle.action);
//                alert("OM");
                
                var txt="<center>";
                for (var i = 0; i < bundle.text.length; i++) {
                    txt+="<input name='"+bundle.text[i]+"' type='text' placeholder='"+bundle.ph[i]+"' class='textField'/>"
                }
                $("#promptInputCont").html(txt+"</center>");
                $("#promptCancBtn").click(function(){destroy('promptDialog');});
                $("#promptActBtn").click(function(){
                    bundle.task();
                    $("#promptActBtn").click(function(){bundle.task();});
                    return false;
                });
                showMe("promptDialog");
//                alert("end");
            }