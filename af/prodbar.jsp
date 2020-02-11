<%-- 
    Document   : prodbar
    Created on : 2 Jan, 2018, 3:02:40 PM
    Author     : UMESH-ADMIN
--%>
<%@page import="java.io.OutputStream"%>
<%@page import="com.google.zxing.client.j2se.MatrixToImageWriter"%>
<%@page import="com.google.zxing.common.BitMatrix"%>
<%@page import="com.google.zxing.MultiFormatWriter"%>
<%@page import="com.google.zxing.BarcodeFormat"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="entities.Admins"%>
<%@page import="entities.MaterialConsumed"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.StockManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.List"%>
<%@page contentType="image/jpg" pageEncoding="UTF-8"%>
<%
            MultiFormatWriter wr=new MultiFormatWriter();
            BitMatrix bar=wr.encode("Hello", BarcodeFormat.CODE_128, 150, 50);
            MatrixToImageWriter.writeToStream(bar, "jpg", (OutputStream)response.getOutputStream());
        %>
<%--<div  class="loginForm">
    <span></span>
    <style>
        table tr th{
            border-bottom: 1px solid #000;
        }
    </style>
<%
    
    String p=request.getParameter("p");
    Admins role=(Admins)session.getAttribute("role");
    if(role==null){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
        <%
    return ;
}
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    String iLim=request.getParameter("ini");
    int ini=0;
    if(iLim!=null&&iLim.matches("\\d+")){
        ini=Integer.parseInt(iLim);
    }
    ProductionRequest prods=(ProductionRequest)sess.createQuery("from ProductionRequest "+((p!=null&&p.matches("\\d+"))?"where reqId="+new Long(p):"")+"").uniqueResult();
    %>
    <span class="close fa fa-close" id="close" onclick="<%=p!=null?"clrLSP()":"closeMe()"%>"></span>
    <div>
        <span class="white"><h2 class="nomargin nopadding centAlText">Production Bar codes</h2></span>
    <hr>
    <%
//        for(int i=0;i<prods.getQnt();i++){
    %>
        <%
            MultiFormatWriter wr=new MultiFormatWriter();
            BitMatrix bar=wr.encode("Hello", BarcodeFormat.CODE_128, 150, 50);
            MatrixToImageWriter.writeToStream(bar, "jpg", (OutputStream)response.getOutputStream());
        %>
        <%//}%> 
    </div>
        <style>
        .popSMLE{
            box-shadow: 4px 4px 25px black;
        }
        </style>
</div>--%>