<%-- 
    Document   : formBuilder
    Created on : 4 Oct, 2019, 2:59:21 PM
    Author     : ee211143
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Form builder</title>
    </head>
    <body>
        <div class="row">
        <div class="input-field col s12 m6">
              <select class="validate zones" value="${z.parentZone.id}">
                  <option value="null">Select Field</option>
                  <c:forEach var="f" items="${fields}">
                      <option>${f.name}</option>
                  </c:forEach>
              </select>
        </div>
        <div class="input-field col s12 m6">
            <select class="validate zones" id="">
                <option value="null">Select Type</option>
                <option value="text">Text</option>
                <option value="date">Date</option>
                <option value="select">Select</option>
                <option value="auto">Autofill</option>
            </select>
        </div>
        <div class="input-field col s12 m6">
            <input id="hint" name="hint"  type="text" class="validate">
            <label for="hint">Hint</label>
        </div>
        <div class="col s6 offset-s2"><span class="btn">Add</span></div>
        </div>
        <form action="/api/create-entity-form/">
            <div class="input-field col s12 m6">
                <input id="entity" name="entity"  type="text" value="${entity}" class="validate">
                <label for="entity">Entity</label>
            </div>
            
        </form>
    </body>
</html>
