<%-- 
    Document   : feedbackform.jsp
    Created on : 1 Jun, 2018, 11:17:42 AM
    Author     : umesh
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="theme-color" content="#448833"/>
        <!--<meta name="google-site-verification" content="8PKYU8B96CVPnZRPSo3k_-3vs1JUYBL1b5EjXYewLVw" />-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--        <link rel="stylesheet" type="text/css" href="file:///android_asset/css/PullNDry.css"/>
        <script src="file:///android_asset/js/jquery-3.1.0.min.js" ></script>
        <script src="file:///android_asset/js/pullNdry.js" ></script>
        <script src="file:///android_asset/js/Chart.js" ></script>
        <script src="file:///android_asset/js/angular.min.js" ></script>
        <script src="file:///android_asset/js/angular.anim.min.js" ></script>
        <link href="file:///android_asset/font-awesome-4.7.0/css/font-awesome.css" rel="stylesheet">-->
        <link rel="stylesheet" type="text/css" href="css/PullNDry.css"/>
        <script src="js/jquery-3.1.0.min.js" ></script>
        <script src="js/pullNdry.js" ></script>
        <script src="js/Chart.js" ></script>
        <script src="js/angular.min.js" ></script>
        <script src="js/angular.anim.min.js" ></script>
        <link href="font-awesome-4.7.0/css/font-awesome.css" rel="stylesheet">
    </head>
    <body>
        <div style="display: none;" id="mobHead">
        <link rel="stylesheet" type="text/css" href="file:///android_asset/css/PullNDry.css"/>
        <script src="file:///android_asset/js/jquery-3.1.0.min.js" ></script>
        <script src="file:///android_asset/js/pullNdry.js" ></script>
        <script src="file:///android_asset/js/Chart.js" ></script>
        <script src="file:///android_asset/js/angular.min.js" ></script>
        <script src="file:///android_asset/js/angular.anim.min.js" ></script>
        <link href="file:///android_asset/font-awesome-4.7.0/css/font-awesome.css" rel="stylesheet">
        </div>
    <div class="loginForm">
    <center>
        <div class="msg"></div>
        <!--<span class="white"><h2>Feedback Form</h2></span><hr>-->
        <!--<br>-->
        <form action="" method="post" name="loginForm" id='ratingFM'>
            <style>
                span[class^="rate"]{
                    font-size: 3em;
                    color:green;
                    /*background-color: red;*/
                }
            </style>
            <input type="hidden"  name="action" value="rating"/><br>
            <input type="hidden" id="rating"  name="rating" value="5"/>
            <input type="hidden" id="u" name="u" value=""/>
            <input type="hidden" id="dev" name="dev" value=""/>
            <div>
                <span class="rate1 fa fa-star checked"></span><span class="rate2 fa fa-star checked"></span><span class="rate3 fa fa-star checked"></span><span class="rate4 fa fa-star"></span><span class="rate5 fa fa-star"></span>
            </div><br>
            <input class="textField" type="text"  name="doc" placeholder="Docket No"/><br><br>
            <select class="textField" name="mes">
                <option value="">Select Feedback</option>
                <option>Poor</option>
                <option>Need Improvement</option>
                <option>Good</option>
                <option>Excellent</option>
            </select><br><br>
            <textarea class="txtArea" name="amt" placeholder="Kindly enter amount paid and Give your suggestion"></textarea>
            <!--<br><br>-->
            <p class="rightAlText"><button onclick="return subForm('ratingFM','FormManager');" class="button ">Go</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
            <!--<br><br>-->
        </form>
        <script>
            $(".rate1").on("click",function(){
               $(".rate1").css("color","green");
               $(".rate2").css("color","black");
               $(".rate3").css("color","black");
               $(".rate4").css("color","black");
               $(".rate5").css("color","black");
               $("#rating").val("1");
            });
            $(".rate2").on("click",function(){
               $(".rate1").css("color","green");
               $(".rate2").css("color","green");
               $(".rate3").css("color","black");
               $(".rate4").css("color","black");
               $(".rate5").css("color","black");
               $("#rating").val("2");
            });
            $(".rate3").on("click",function(){
               $(".rate1").css("color","green");
               $(".rate2").css("color","green");
               $(".rate3").css("color","green");
               $(".rate4").css("color","black");
               $(".rate5").css("color","black");
               $("#rating").val("3");
            });
            $(".rate4").on("click",function(){
               $(".rate1").css("color","green");
               $(".rate2").css("color","green");
               $(".rate3").css("color","green");
               $(".rate4").css("color","green");
               $(".rate5").css("color","black");
               $("#rating").val("4");
            });
            $(".rate5").on("click",function(){
               $(".rate1").css("color","green");
               $(".rate2").css("color","green");
               $(".rate3").css("color","green");
               $(".rate4").css("color","green");
               $(".rate5").css("color","green");
               $("#rating").val("5");
            });
            var suid='';var spass='';
            try{
                var obj=JSON.parse(js.readFile('reg.info'));
                spass=obj['pass'];
                suid=obj['uid'];
                $("#u").val(suid);
            }catch(e){}
            try{
            $("#dev").val(js.getIMEI());
        }catch(e){}    
            js.writeToFile("home.html","<html><head>"+$("#mobHead").html()+"</head><body>"+document.body.innerHTML+"</body></html>",false);        
//            js.Alert(document.documentElement.innerHTML);
//            js.loadPageInHome('http://viatusk.com?u='+escape(suid)+'&p=');
        </script>
       </center>
</div>
    </body>
    
</html>
