<%-- 
    Document   : apiForm
    Created on : 4 Oct, 2019, 12:48:29 PM
    Author     : ee211143
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">    
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://naaniretail.com/materialize/css/materialize.min.css">
        <link rel="stylesheet" href="https://naaniretail.com/css/via.css">
        <script type="text/javascript" src="https://naaniretail.com/js/jquery-3.1.0.min.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://naaniretail.com/materialize/js/materialize.min.js"></script>
    
    </head>
    <body>
        <div class="row">
        <form class="col s12" id="productForm" onsubmit="return false" method="POST">
               
            <div class="input-field col s12 m3">
                <input id="proName" type="text" name="entity" class="validate" value="">
                <label for="proName">Entity</label>
            </div>
            <div class="input-field col s12 m3">
                <input id="cat" type="text" name="dao" autocomplete="off" value="Dao" class="validate" data-target="autocomplete-options-fb8a101f-9460-214d-c236-48f39d4885e4"><ul id="autocomplete-options-fb8a101f-9460-214d-c236-48f39d4885e4" class="autocomplete-content dropdown-content" tabindex="0"></ul>
                <label for="cat">Dao</label>
            </div>
            <div class="input-field col s12 m3">
                <input id="cat" type="text" name="service" autocomplete="off" value="Service" class="validate" data-target="autocomplete-options-fb8a101f-9460-214d-c236-48f39d4885e4"><ul id="autocomplete-options-fb8a101f-9460-214d-c236-48f39d4885e4" class="autocomplete-content dropdown-content" tabindex="0"></ul>
                <label for="cat">service</label>
            </div>
            <div class="input-field col s12 m3">
                <input id="parcat" type="text" name="controller" autocomplete="off" value="Controller" class="validate" data-target="autocomplete-options-1856c6e2-bd74-5649-6c25-8fec0df1ed61"><ul id="autocomplete-options-1856c6e2-bd74-5649-6c25-8fec0df1ed61" class="autocomplete-content dropdown-content" tabindex="0"></ul>
                <label for="parcat">Controller</label>
            </div>
            <div class="input-field col s12 m3">
                <input id="proName" type="text" name="pkg" class="validate" value="">
                <label for="proName">BasePackage</label>
            </div>
            <div class="input-field col s12 m3">
                <input id="proName" type="text" name="dest" class="validate" value="/home/ee211143/NetBeansProjects/SaskenApi/src/main/java/">
                <label for="proName">Destination</label>
            </div>
            <span class="btn waves-effect waves-green offset-m8 col m2 s12 saveProduct">Save</span>  
        </form>
        </div>
    </body>
    <script>
        M.updateTextFields();
        M.textareaAutoResize($('#desc'));
   
    $(".saveProduct").on("click",function(){
        var arr=$("#productForm").serializeArray();
        var method=$("#productForm").attr("method")
        var product={};
        for(var f in arr){
            var key=arr[f].name;
            if(key.indexOf(".")>-1){
                var keys=key.split(".");
//                if(product[keys[0]] != undefined){
//                    var subObj={};
//                    subObj[keys[1]]=arr[f].value;
//                    product[keys[0]].push(subObj);
//                }else{
                    var subObj={};
                    subObj[keys[1]]=arr[f].value;
                    product[keys[0]].push(subObj);
//                }
            }else{
                var v=arr[f].value;
                product[key]=v;
            }
          }
          $.ajax({url: '/SaskenApi/api/create',type :method ,contentType: 'application/json; charset=utf-8',data : JSON.stringify(product),
                success : function(result) {
                    console.log(result)
                    try{
                        M.toast({html:result})
                    }catch(e){
                        console.log(e)
                    }
//                                alert(result)
                },
                error: function(xhr, resp, text) {
                    M.toast({html:text})
                    console.log(xhr, resp, text);
                }
                })
          console.log(JSON.stringify(product))
//        var product={"name":productForm.proName.value,};
    });
            </script>
</html>
