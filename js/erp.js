var popup=angular.module("popup",[]);
var erp=angular.module("erp",[]);
erp.controller("erpCtrl",function($compile,$http,$scope,$rootScope){
$rootScope.loadPage=function(x){
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
            var el =$('#contentLoader').html();
            var compiled = $compile(el)($scope);
            angular.element(document.getElementById("contentLoader")).html(compiled);
        }});
        maximizeMe('contentLoader');
        $rootScope.curPage=x;
        window.history.pushState({}, null, "#"+x);
}; 
});
//var pm=angular.module("purchaseModule",[]);
erp.controller("purCtrl",function($scope,$http,$compile){
$scope.popsl=function(pg){
     $('#leftPop').html("<img src='images/loader.svg' width=100 height=100 />");    
     $("#leftPop").load(pg,function( response, status, xhr ) {
        if ( status == "error" ) {
                    showMes("Sorry!! Failed to Respond");
                    $('#leftPop').html("");
        //            $( "#error" ).html( msg + xhr.status + " " + xhr.statusText );
                }else if(status =="success"){
                    $("#leftPop").addClass("shadow");
                    afe();
                    var el =$('#leftPop').html();
                    var compiled = $compile(el)($scope);
                    angular.element(document.getElementById("leftPop")).html(compiled);
                }});
}
}); 
erp.controller('newPurchaseController',function($scope,$http,$rootScope){
    var self=this;
//    self.curPage=null;
    self.bill={importOn:new Date(),purFrom:'',inBr:0,billNo:0,purchased:[]};
    self.data=[];

    $scope.digit=function(s){        
        console.log(s)
        var v=s.attr("value");
        if(v.indexOf(".")>-1){
            var decChar=v.split(".")[1].length;
            if(decChar>0){
               s.setAttribute("step","0."+("0").repeat(decChar-1)+1);
            }
        }else{
            s.removeAttribute("step");
        }
    };
    $scope.addMat=function(){
        self.bill.purchased.push({matId:0,rate:0,taxType:"",tax:0,qtyInPPC:0,qnt:0});
        return false;
    };
        
    $scope.remove=function(index){
            self.bill.purchased.splice(index,1);
            return false;
        };
    $scope.show=function(){
        $http.post('api/purchases/',self.bill,{headers:{
           'Content-Type': 'application/json'
        }}).then(function(resp){
            showMes(resp.data);
        if($rootScope.curPage!=null&&$rootScope.curPage.length>1)
            $rootScope.loadPage($rootScope.curPage);
        else
            document.location.replace("");
        clrLSP();
        clrLLP();
        clrLRP();
        clrRSP();
         },function myError(response) {
        showMes(response.statusText);
    });
    };
    $http.get("api/materials").then(function(response){
            self.data = response.data;
        },function myError(response) {
            $scope.myWelcome = response.statusText;
    });
    });
erp.directive('updateUnits', function() {
//    console.log(data)
  return {
    link:  function link(scope, element,attrs,ngCtrl) {
       var e=element[0]; 
      element.bind('change', function() {
          var ppcunit="",importUnit=""
            var appElement = document.getElementById('newPurchase');
            var contScope = angular.element(appElement).scope();
//            var controllerScope = appScope.$$childHead;
//            console.log(contScope.pc.data);

        for (var m in contScope.pc.data){
            if(contScope.pc.data[m].matId==e.value){
                ppcunit=contScope.pc.data[m].ppcUnit
                importUnit=contScope.pc.data[m].importUnit
            }
          }
          e.parentNode.children[1].children[1].innerHTML="Purchased Qty("+importUnit+")"
          e.parentNode.children[2].children[1].innerHTML="Inward Qty("+ppcunit+")"

      });
    }
  }
});
//erp.directive('digit', function () {
//    return {
//        require: 'ngModel',
//        link: function (scope, elem, attrs, ctrl) {
//            console.log(elem);
//            var v=elem;
//            console.log(v);
//            if(v.indexOf(".")>-1){
//                var decChar=v.split(".")[1].length;
//                if(decChar>0){
//                   elem.setAttribute("step","0."+("0").repeat(decChar-1)+1);
//                }
//            }else{
//                elem.removeAttribute("step");
//            }
//        }
//    };
//});