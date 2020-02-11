<%-- 
    Document   : index
    Created on : 17 Jul, 2017, 12:51:28 PM
    Author     : UMESH-ADMIN
--%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="header.jsp"/>
<div class="white">
    <center>  <br><br>
        <h1>Welcome To VIA ERP</h1>
        <p>It's first time setup WIZARD, Please provide Company information for ERP activation</p><br><br>
        <form onsubmit="return false;" id="compForm">
                <input type="hidden" name="action" value="setup"/>
                <input class="textField" type="text"  name="cn" placeholder="Company Name" />
                <input class="textField" type="text" value="" name="loc" placeholder="Company Location" />
                <input class="textField" type="text" value="" name="ct" placeholder="City" />
                <input class="textField" type="text" value="" name="stt" placeholder="State" /><br>
                <input class="textField" type="text" value="" name="pin" placeholder="PIN Code" />
                <input class="textField" type="text" value="" name="tn" placeholder="TIN No" />
                <input class="textField" type="text" value="" name="web" placeholder="Website(optional)" />
                <input class="textField" type="email" name="mail" minlength="6" placeholder="Email"/><br>
                <input class="textField" type="text" value="" name="tel" placeholder="Tel No" />
                <input class="textField" type="text" value="" name="tf" placeholder="Mobile No" />
                <input class="textField" type="text" value="" name="gn" placeholder="GST No(optional)" />
                <input class="textField" type="text"  name="aId" placeholder="Global Admin"/><br>
                <input class="textField" type="password" name="pass" minlength="4" placeholder="password"/>
                
                <br><button onclick="subForm('compForm','FormManager');" class="button">Proceed</button>
        </form>
    </center>
</div>
<%
    return;
}%>
    <div class="fullWidWithBGContainer tileCont" id="mainSel" onclick="hideSideBar()">
        <center>
            <jsp:include page="adminIndex.jsp" flush="true"/>
            <jsp:include page="distIndex.jsp" />
        </center>
    </div>
    <div class="fullWidWithBGContainer" id="subPageContainer"></div>
    <a onclick="refresh();" placeholder="Reload"><span class="rightDownButton"  id="reloadBtn"><center><span class="fa fa-repeat "></span></center></span></a>
    <script>
    dragElement(document.getElementById('reloadBtn'));
</script>

<script>
//    var lastAct=0;
//    notify("Did you know??","${req} requisitions are pending","loadPage('af/requisition.jsp?approved=false')");
</script>
<div class="hidden invisible" id="noticeSync" style="width:0px;height: 0px;position: absolute;right:0;top:50%;">
    
</div>