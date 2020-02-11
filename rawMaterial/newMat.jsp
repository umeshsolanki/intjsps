<%-- 
    Document   : newMat
    Created on : Jan 2, 2018, 3:56:33 PM
    Author     : sunil
--%>

<%@page import="org.hibernate.criterion.Order"%>
<%@page import="entities.Admins"%>
<%@page import="java.util.List"%>
<%@page import="entities.Material"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if(!(session.getAttribute("role") instanceof Admins)){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
<%return; }
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
List<Material> mats=sess.createCriteria(Material.class).addOrder(Order.asc("matName")).list();
%>
<div class="loginForm" style="background-color: #333" class="draggable" id="matDrag">
    <span class="close fa fa-close" id="close" onclick="clrLSP()"></span>
        <div class="fullWidWithBGContainer">
                <span class="white"><h2 class="nomargin nopadding centAlText">Add Material</h2></span><hr>
                <center>
                <form method="post" name="AddMaterial" id='AddMaterial' >
                    <input type="hidden" id='action' name="action" value="addMaterial" /><br>
                    <input type="hidden" id='id' name="id" value="" /><br>
                    <input class="textField" type="text" id="matName"  name="matId" placeholder="*Material"/>
                    <!--<input class="textField" type="text"  name="size" placeholder="*Unit Conversion Factor"/><br>-->
                    <input class="textField" type="text" id="inUnit"  name="inunit" list="inUnitSel" placeholder="Purchase Unit" autocomplete='off'/>
                    <datalist id="inUnitSel" style="display: none;">
                        <option value="">Select Import Unit</option>
                        <option>In</option>
                        <option>MM</option>
                        <option>CM</option>
                        <option>Kg</option>
                        <option>Gm</option>
                        <option>L</option>
                        <option>Nos.</option>
                        <option>Ft</option>
                        <option>Ltr</option>
                        <option>GSM</option>
                        <option>Mtr</option>
                    </datalist>
<!--                    <select class="textField" id="inUnit" name="inunit">
                        <option value="">Select Import Unit</option>
                        <option>In</option>
                        <option>MM</option>
                        <option>CM</option>
                        <option>Kg</option>
                        <option>Gm</option>
                        <option>L</option>
                        <option>Nos.</option>
                        <option>Ft</option>
                        <option>Ltr</option>
                        <option>GSM</option>
                        <option>Mtr</option>
                    </select><br><br>-->
                    <br><br><input class="textField" type="text" id="ppcunit"  name="ppcunit" list="inUnitSel" placeholder="PPC Unit" autocomplete='off'/>
<!--                    <select class="textField" name="ppcunit" id="ppcunit">
                        <option value="">Select PPC Unit</option>
                        <option>In</option>
                        <option>MM</option>
                        <option>CM</option>
                        <option>Kg</option>
                        <option>Gm</option>
                        <option>L</option>
                        <option>Nos.</option>
                        <option>Ft</option>
                        <option>Ltr</option>
                        <option>GSM</option>
                        <option>Mtr</option>
                    </select>-->
                    <input class="textField" type="number" id='minQnt' name="minQnt" placeholder="*Min Quantity In stock (PPC Unit)"/><br><br>
                    <input class="textField" type="text" id="rate"  name="rate" placeholder="Rate per unit(only digits and decimal)"/>
                    <br><br>
                    <button onclick='return subForm("AddMaterial","FormManager");' id='adButton' class="button">Add</button><br><br>
                </form>
                </center>
        </div>
</div>
<%
    sess.close();
%>
                    
        
