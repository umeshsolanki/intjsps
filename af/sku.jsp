<%-- 
    Document   : RMBelowDL
    Created on : 6 Nov, 2017, 3:56:07 PM
    Author     : UMESH-ADMIN
--%>
<%@page import="entities.SKU"%>
<%@page import="entities.Admins"%>
<%@page import="java.util.List"%>
<%@page import="entities.StockManager"%>
<%@page import="org.hibernate.Session"%>
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
%>


<div class="loginForm border" style="max-width: 100%;">
    <span class="close" id="close" onclick="closeMe();">X</span>
    <div class="fullWidWithBGContainer">

<div class="tFivePer left boxPcMinHeight">
    <!--<marquee>-->
    <h2 class="nomargin nopadding white">Centralized SKU for Distribution</h2>
    <!--</marquee>-->
    <hr>
    <div class="scrollable">
    <table border="1" width="100%" style='margin: 0px;padding: 0px;' cellpadding="5">
    <thead align='left'>
                <tr>
                    <th>Product</th>
                    <th>Total</th>
                    <!--<th>Branches-Included</th>-->
                    <!--<th>Sold</th>-->
                    <!--<th>Action</th>-->
                </tr>
                </thead>
          <tbody>         
    <%
        List<SKU> prods=sess.createCriteria(SKU.class).list();
        for(SKU fp:prods){
    %>
                    <tr >
                    <td  title="click to trace complete product detail"
                        onclick="loadPageIn('skuList','af/SKUListener.jsp?i=<%=fp.getFPId().getFPId()%>',false);"
                        class="navLink"><%=fp.getFPId().getFPName()%>
                    </td>
                    <td><%=UT.df.format(fp.getQnt())%></td>
                    </tr>
                    <%}%>
    
          <%--
    List<FinishedProduct> prods=sess.createCriteria(FinishedProduct.class).list();
    for(FinishedProduct fp:prods){
    List<Object[]> allProdCount=sess.createQuery("Select sum(Qnt),count(producedBy) from FinishedProductStock"
                    + " fps where FPId=:prod and Qnt>0").setParameter("prod", fp).list();
            if(!allProdCount.isEmpty())
                for(Object[] sm:allProdCount){
                if(sm[0]==null)
                continue;
%>
                    <tr>
                        <td onclick='loadPage("Res/pro/<%=fp.getFPId()%>");' class="navLink"><%=fp.getFPName()%></td>
                        <td><%=sm[0]%></td>
                        <td><%=sm[1]%></td>
                    </tr>
                    <%}}--%>
          </tbody>
    </table>
</div>
</div>
          <div class="sixtyFivePer right" id="skuList">
              
          </div>
</div>
</div>
<%sess.close();%>