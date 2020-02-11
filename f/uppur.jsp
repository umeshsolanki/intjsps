<%-- 
    Document   : uppur
    Created on : 5 Jun, 2018, 7:58:37 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="entities.SaleInfo"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="entities.DistSaleManager"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="entities.InwardManager"%>
<%@page import="entities.Material"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.FinishedProductStock"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="entities.Admins"%>
<%@page import="java.util.List"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.Session"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Admins role=(Admins)session.getAttribute("role");
    DistributorInfo dis=(DistributorInfo)session.getAttribute("dis");
    if(role==null&&dis==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
<%
    return ;
}
String i=request.getParameter("i");
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
InwardManager in=(InwardManager)sess.get(InwardManager.class, new Long(i));
%>
<center>
<!--    <style>
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
    </style>-->
    <span class="close fa fa-close" id="close" onclick="clrLSP();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <span class="white"><h2 class="nopadding nomargin bgcolt8">Update Purchase Record <%=in.getImportId()%></h2></span><hr>
        <form action="FormManager" onsubmit="return false;" method="post" name="loginForm" id='upPurForm' >
            <br>
            <input type="hidden" name="action" id="action" value="UPur"/>
            <input type="hidden" name="i" id="i" value="<%=in.getImportId()%>"/>
            <input type="text" name="mat" id="mat" class="textField" value="<%=in.getMatId().getMatName()%>" disabled required/>
            <div class="inputWrapper">
            <input type="text" name="purQty" class="textField" id="purQty" value="<%=in.getQty()%>" placeholder="Qty in <%=in.getMatId().getImportUnit()%>" required/>
            <span class="movLabel">Purchase Quantity</span>
            </div>
            <div class="inputWrapper">
            <input type="text" name="inQty" class="textField" id="inQty" required placeholder="Qty in <%=in.getMatId().getPpcUnit()%>" value="<%=in.getQtyInPPC()%>"/><br>
            <span class="movLabel">Quantity in </span>
            </div>
            <div class="inputWrapper">
                <input type="text" name="price" class="textField" required id="price" placeholder="Price"  value="<%=in.getPrice()%>"/>
            <span class="movLabel">Value without tax</span>
            </div>
            <div class="inputWrapper">
            <input type="text" name="rate" class="textField" required id="rate" placeholder="Rate" value="<%=in.getPrice()/in.getQty()%>"/>
            <span class="movLabel">Rate</span>
            </div>
            <div class="inputWrapper">
            <input type="text" name="tax" class="textField" required id="tax" placeholder="Tax(%)" value="<%=in.getTaxPer()%>"/>
            <span class="movLabel">Tax Percentage</span>
            </div>
            <div class="inputWrapper">
                <input type="text" name="IGST"  class="textField" required id="IGST" placeholder="IGST" value="<%=in.getIgst()%>"/><br>
            <span class="movLabel">IGST</span>
            </div>
            <div class="inputWrapper">
                <input type="text" name="CGST"  class="textField" id="CGST" required placeholder="CGST " value="<%=in.getCgst()%>"/>
            <span class="movLabel">CGST</span>
            </div>
            <div class="inputWrapper">
                <input type="text" name="SGST"  class="textField" required id="SGST" placeholder="SGST" value="<%=in.getSgst()%>"/>
            <span class="movLabel">SGST</span>
            </div>
            <div class="inputWrapper">
            <input type="text" name="bill" class="textField" required  placeholder="Bill Ref" value="<%=in.getBillNo()%>"/><br>
            <span class="movLabel">Bill No</span>
            </div>
            <div class="inputWrapper">
            <input type="text" name="from" class="textField" required  placeholder="Pur From " value="<%=in.getPurFrom()%>"/>
            <span class="movLabel">Purchased from</span>
            </div><br>
            <div class="inputWrapper">
                <textarea name="remark" class="txtArea" required  placeholder="Remark" ><%=in.getRemark()%></textarea>
            <!--<span class="movLabel">Remark</span>-->
            </div>
            <br><br>
            <button onclick='return subForm("upPurForm","U")' id="editBtn" class="button">Update</button>
            <br><br>
        </form>
    </div>
</center>           
<style>
    .popSMLE{
        box-shadow: 4px 4px 25px black;
    }
</style>
<%
sess.close();
%>
