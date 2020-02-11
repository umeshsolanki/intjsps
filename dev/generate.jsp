<%-- 
    Document   : generate
    Created on : 12 Jun, 2018, 3:53:46 PM
    Author     : UMESH-ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String fields=request.getParameter("fields");
    String ent=request.getParameter("eent");
    String isnewEnt=request.getParameter("newEnt");
    int fieldCount=Integer.parseInt(fields);
    StringBuilder entity=new StringBuilder("");
    StringBuilder save=new StringBuilder("");
    StringBuilder upd=new StringBuilder("");
    StringBuilder formui=new StringBuilder("");
    StringBuilder uiman=new StringBuilder("");
    
    for(int i=0;i<fieldCount;i++){
        
    }
    
%>

<%!
    private String genHTMLField(String ph,boolean movable,String type,String name){
        String wrapper;
        if(movable){        
             wrapper="<div class=\"inputWrapper\">\n"+
            "            <input type=\""+type+"\" name=\""+name+"\" class=\"textField\" value=\"\" placeholder=\""+ph+"\" required/>\n" +
            "            <span class=\"movLabel\">"+ph+"</span>\n" +
            "            </div>";
        }else{
            wrapper="<input type=\""+type+"\" name=\""+name+"\" class=\"textField\" value=\"\" placeholder=\""+ph+"\" required/>";
        }
        return wrapper;
    }
%>