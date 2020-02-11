<%-- 
    Document   : mnfd
    Created on : 4 Jan, 2018, 1:56:39 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.ProductionRequest"%>
<%@page import="entities.Manufactured"%>
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
<div  class="loginForm">
    <!--<span></span>-->
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
    ProductionRequest pr=(ProductionRequest)sess.get(ProductionRequest.class, new Long(p));
//    List<Manufactured> prods=sess.createQuery("from Manufactured mc "+((p!=null&&p.matches("\\d+"))?"where pr.reqId="+new Long(p):"")+"").list();

    %>
    <span class="close fa fa-close" id="close" onclick="<%=p!=null?"clrLSP()":"closeMe()"%>"></span>
    <div>
        
        <span class="white"><h2 class="nomargin nopadding centAlText">Manufactured Products</h2></span>
    <hr>
    <div class="fullWidWithBGContainer">
        <center><form class="loginForm" id="trFm" onsubmit="return false;">
                <p>Transfered To Local Store <b><%=pr.getToStock()%></b> To Central Store <b><%=pr.getToSKU()%></b></p>
            <input class="textField" name='action' value="trAfProdtn" type="hidden"/>
            <input class="textField" name='pr' value="<%=pr.getReqId()%>" type="hidden" />
            <input class="textField" name='dt' value="" type="date" />
            <input class="textField" name='csku' value="" type="text" placeholder="To CSKU" />
            <!--<input class="textField" name='lsku' value="" type="text" placeholder="To Local Store"/>-->
            <br>
            <br><button onclick="return subForm('trFm','U');">Proceed</button><br><br>
        </form>
        </center>
    </div>
    <%--<div class="scrollable">
      <table width="100%" border="1px" cellpadding="5" >
        <thead>
            <tr align="center">
                <th>ProducedOn</th>
                <th>Branch</th>
                <th>Product</th>
                <th>Barcode</th>
                <th>Status</th>
                <th>Trace</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody style="max-height: 500px;overflow: auto">
        <%for(Manufactured in:prods){%>
            <tr align="center">
                <td><%=in.getManOn()%></td>
                <td><%=in.getPr().getProducedBy().getBrName()%></td>
                <td><%=in.getpCat().getFPName()%></td>
                <td><%=in.getBar()%></td>
                <td><%=in.getCurPos()%></td>
                <td><%=in.getTrace()%></td>
                <td>
                <%if(!in.isUpdated()){%>
                <select class="smTF" id="str<%=in.getMan()%>">
                    <option hidden="" value="">Keep in</option>
                    <option value="lcl">Local Store</option>
                    <option value="csku">Central Store</option>
                </select>
                <button onclick="sdfr('S','action=SPDCN&m=<%=in.getMan()%>&w='+$('#str<%=in.getMan()%>').val(),false)" class="fa button fa-arrow-circle-right"></button>
                <%}else{%>Stock Updated<%}%>
                </td>
        <%}%>
        </tbody>
        </table>
        </div>--%>
    </div>
        <style>
        .popSMLE{
            box-shadow: 4px 4px 25px black;
        }
        </style>
</div>