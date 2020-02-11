<%-- 
    Document   : new
    Created on : 16 Jan, 2019, 12:31:14 PM
    Author     : UMESH-ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="loginForm" style="background-color: #888" id="newPurchase" ng-controller="newPurchaseController as pc">  
    <span class="close fa fa-close" id="close" onclick="clrLSP()"></span>
    <div class="white popupHead centAlText" id="head"><h2 class="nomargin nopadding centAlText">New Purchase Bill</h2></div><br><br><hr>
        <div class="fullWidWithBGContainer">
        <div class="popupBody scrollable">
        <center>
        <form id="importMaterial" onsubmit="return false;">
            <br>
            <div>
            <div class="inputWrapper">
                <input class="textField" type="date" required="" ng-model="pc.bill.importOn" value="<%=Utils.DbFmt.format(new Date())%>T18:30:00.000Z" />
                <span class="movLabel">Purchase Date</span>
            </div>

            <div class="inputWrapper">
                <input class="textField" type="text" ng-model="pc.bill.billNo" value=""/>
                <span class="movLabel">Bill No</span>
            </div>
            <div class="inputWrapper">
                <select class="textField" required="" ng-model="pc.bill.inBr" ng-init="pc.bill.inBr='0'" >
                    <option value="0">Select Branch</option>
                    <c:forEach items="${branches}" var="br">
                        <option value="${br.brId}">${br.brName}</option>
                    </c:forEach>
                </select>
                
                <!--<span class="movLabel">Branch</span>-->
            </div>
            <div class="inputWrapper">
                <input class="textField" list="purFrom" type="text" required="" ng-model="pc.bill.purFrom" value=""/>
                <span class="movLabel">Vendor</span>
                <datalist id="purFrom">
                    <c:forEach items="${vendors}" var="v">
                        <option value="${v}"/>
                    </c:forEach>
                </datalist>
            </div>
            <div ng-repeat="p in pc.bill.purchased" class="inRow">
                <select class="smTF"  ng-model="p.matId" ng-init="p.matId='0'" update-units>
                    <option value="0">Select Material</option>
                    <option ng-repeat="m in pc.data" value="{{m.matId}}">{{m.matName}}</option>
                </select>
                <div class="inputWrapper">
                <input class="smTF" type="text" ng-model="p.qnt" placeholder="Rate"/>
                <span class="movLabel">Purchase Quantity</span>
                </div>
                <div class="inputWrapper">
                    <input class="smTF" type="text" required ng-model="p.qtyInPPC" value=""/>
                    <span class="movLabel">Inward Quantity</span>
                </div>
                
                <input type="radio" name="tax{{$index}}" ng-model="p.taxType" value="GST"/>GST
                <input type="radio" name="tax{{$index}}" ng-model="p.taxType" value="IGST"/>IGST 
                <div class="inputWrapper">
                <input  class="smTF" type="text" ng-model="p.tax" placeholder="Tax Value"/>
                <span class="movLabel">Tax (%)</span>
                </div>
                <div class="inputWrapper">
                    <input  class="smTF" type="text" ng-model="p.rate" placeholder="Rate"/>
                <span class="movLabel">Rate</span>
                </div>
                <div class="inputWrapper">
                <input  class="smTF" type="text" value="{{p.rate*p.qnt}}" placeholder="Total" ng-disabled="true"/>
                <span class="movLabel"></span>
                </div>
                <button class="button fa fa-trash" ng-click="remove($index)"></button>
            </div>
            </div>
            
        </form>
       </center>  
        </div>
                <div class="popupFooter">
                <table>
                <tr>
                    </td>
                    <td></td>
                    <td><button class="button" ng-click="addMat()">Add Material</button></td>
                    <td><button class="button" ng-click="show()">Save</button></td>
                    <!--{{pc.material}}-->
                </tr>
            </table>
                </div>
        </div>
</div>
<style>
    .popupHead{
        position: absolute;
        left: 0;
        top: 0;
        right:0;
        min-height: 55px;
            
    }
</style>
