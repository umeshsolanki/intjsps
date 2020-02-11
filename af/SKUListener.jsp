<%-- 
    Document   : MaterialConsumption
    Created on : 28 Jul, 2017, 10:36:18 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="utils.UT"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="utils.Utils"%>
<%@page import="entities.SKUChangeListener"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="entities.InwardManager"%>
<%@page import="entities.MaterialStockListener"%>
<%@page import="entities.PPControl"%>
<%@page import="entities.Admins"%>
<%@page import="entities.MaterialConsumed"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.StockManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div  class="loginForm " style="margin: 0px;border-radius: 0px;">
    <%
        String f=request.getParameter("f");
    %>
    <span class="fa fa-close close" id="close" onclick="<%=Utils.isEmpty(f)?"clrLSP()":"clrLLP()"%>"></span>
    
    <style>
        table tr th{
            border-bottom: 1px solid #000;
        }
    </style>
    <%
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
    String mat=request.getParameter("i");
    int ini=0;
    if(iLim!=null&&iLim.matches("\\d+")){
        ini=Integer.parseInt(iLim);
    }
try{
    List<SKUChangeListener> prods=null;
    if(Utils.isEmpty(f))
    prods=sess.createQuery("from SKUChangeListener where prod.FPId=:pId order by onDate asc").setParameter("pId", Long.parseLong(mat)).list();
    else
    prods=sess.createQuery("from SKUChangeListener order by onDate asc").list();
    if(prods.isEmpty()){
           out.print("<h1 color:red>Product trace is not found</h1>");
    }else{
        out.print("<h2 class='centAlText nopadding nomargin ylFnt'>" +(Utils.isEmpty(f)?prods.get(0).getProd().getFPName():"")+"</h2> <hr>");
    
    %>
    <div class="fullWidWithBGContainer">
      <table style="margin:0px" width="100%" cellpadding="5" border="1px">
        <thead>
            <tr align="left">
                <th>Docket</th>
                <th title="Date of delivery">DOD</th>
                <%if(!Utils.isEmpty(f)){%><th>Product</th><%}%>
                <th>Opening</th>
                <th>Qnt</th>
                <th>Closing</th>
                <th>Remark</th>
            </tr>
        </thead>
        <tbody style="max-height: 500px;overflow: auto">
            <%if(!Utils.isEmpty(f)){
              for(SKUChangeListener in:prods){    
                DistOrderManager d=in.getOdrMan();
            %>
               <tr >
                   <td onclick="popsl('af/dockRec.jsp?d=<%=d!=null?d.getDocketNo():""%>')"><%=d!=null?d.getDocketNo():""%></td>
                <td><%=in.getOnDate()%></td>
                <td><%=in.getProd().getFPName()%></td>
                <td><%=UT.df.format(in.getOpeningStock())%></td>
                <td><%=UT.df.format(in.getClosingStock())%></td>
                <td><%=UT.df.format(in.getClosingStock())%></td>
                <td><%=in.getRemark()%></td>
            </tr>
                <%}%>  
            <%}else{

                double op=0,cl=0;
                for(SKUChangeListener in:prods){
                double qnt=in.getClosingStock()-in.getOpeningStock();
                DistOrderManager d=in.getOdrMan();
                op=cl;
                cl=cl+qnt;
    %>            
            <tr >
                <td onclick="popsl('af/dockRec.jsp?d=<%=d!=null?d.getDocketNo():""%>')"><%=d!=null?d.getDocketNo():""%></td>
                <td><%=in.getOnDate()%></td>
                <td><%=op%></td>
                <td class="<%=qnt>=0?"greenFont":"redFont"%>"><%=qnt>=0?UT.df.format(qnt):UT.df.format(-qnt)%></td>
                <td><%=UT.df.format(cl)%></td>
                <td><%=in.getRemark()%></td>
            </tr>
                <%}%>
        </tbody>
        </table>
         <br>
         <!--<span class="button">View More...</span><br><br>-->
    </div>
        <%}}}catch(Exception ee){ee.printStackTrace();%>
                <%="<h1 class='redFont'>&nbsp;Few Linked entries are not found/Error occured</h1>"%>
                <%}%>
</div>
<style>
    .popSMLE{
        box-shadow: 4px 4px 25px black;
    }
</style>