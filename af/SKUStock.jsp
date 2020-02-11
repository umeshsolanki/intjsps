<%@page import="entities.SKUChangeListener"%>
<%@page import="utils.UT"%>
<%@page import="entities.SKU"%>
<%@page import="org.hibernate.type.TypeResolver"%>
<%@page import="entities.StockManager"%>
<%@page import="entities.DistOrderManager"%>
<%@page import="java.util.Iterator"%>
<%@page import="entities.SaleInfo"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entities.DistSaleManager"%>
<%@page import="org.hibernate.Query"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="entities.InwardManager"%>
<%@page import="entities.Material"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.DistFinance"%>
<%@page import="entities.Admins"%>
<%@page import="entities.FinanceRequest"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
        Session sess=sessionMan.SessionFact.getSessionFact().openSession();
        Admins role=(Admins)session.getAttribute("role");
        if(!UT.ia(role, "10")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
        return;
        }
        sess.refresh(role);
        Date nw=new Date();
        Date[] curr=Utils.gCMon(nw);
        Criteria skucl=sess.createCriteria(SKUChangeListener.class).addOrder(Order.desc("onDate"));
        String m=request.getParameter("r"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),p=request.getParameter("p"),br=request.getParameter("br");
        String script="";
        if(p!=null&&p.matches("\\d+")){
           skucl.add(Restrictions.eq("prod.FPId", new Long(p)));
           script+="$(\"select[name='p']\").val(\""+p+"\");";
        }
        if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
            curr[0]=Utils.DbFmt.parse(iD);
            curr[1]=Utils.DbFmt.parse(fD);
            skucl.add(Restrictions.between("onDate", curr[0],curr[1]));
        }else{
            skucl.add(Restrictions.between("onDate", curr[0],curr[1]));
        }
        if(br!=null&&br.matches("\\d+")){
           skucl.add(Restrictions.eq("br.brId", new Long(br)));
            script+="\n$(\"select[name='br']\").val(\""+br+"\");";
        }
%>    
<div class="loginForm" style="max-width: 100%;">
    <style>
        .yellow{
            background-color: yellow !important;
            transition: all 1s;
            color: #449955;
        }
        .normal{
                  background-color: transparent;
                  transition: all 1s;
              }
    </style>
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">   
            <p class="white pointer" onclick="popsl('f/ucstk.jsp')">
                <span class="button white"><i class="fa fa-plus-circle"></i> Update Stock</span></p>
        </div>
        <div class="d3 left leftAlText ">
            <p class="greenFont">&nbsp;</p>
        </div>
        <div class="d3 left leftAlText">
            <p class="redFont">&nbsp;</p>
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left rShadow" style="">
            <i class="fa btn fa-arrow-circle-left fa-2x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<!--            <span class="white"><h2 class="nomargin nopadding">Finance Record</h2></span><hr>-->
<div style="" class="bgcolef">
    <p class="nomargin p-15 white bgcolt8  bold">Month: <%=Utils.getWMon.format(new Date())%> </p><hr>
    <ul>
        <li title="Filters" >
            <br>
            <form id="prodFil" name="prodFil">
                <select title="For branch" class="textField" name="br"><option>Select Production Branch</option>
                <%
                    List<ProductionBranch> b=sess.createCriteria(ProductionBranch.class).list();
                for(ProductionBranch brr:b){
                %>
                <option value="<%=brr.getBrId()%>"><%=brr.getBrName()%></option>
                <%}%>
            </select><br>
            <select class="textField" name="p">
                <option>Select Product</option>
                <%
                List<FinishedProduct> fpa= sess.createCriteria(FinishedProduct.class).add(Restrictions.eq("deleted", false)).addOrder(Order.asc("FPName")).list();
                for(FinishedProduct f:fpa){
                %>
                <option value="<%=f.getFPId()%>"><%=f.getFPName()%></option>
                <%
                    }
                    %>
            </select><br>
            <script>
                <%=script%>
            </script>
            <!--<span class="button right fa fa-arrow-circle-right"></span><i class="right"></i>-->
            <input title="Start date" class="textField" type="date" name="iD" value="<%=Utils.DbFmt.format(curr[0])%>"/><br>
            <input class="textField" title="End Date" type="date" name="fD" value="<%=Utils.DbFmt.format(curr[1])%>"/><br><br>
            <span class="right" onclick="loadPg('af/SKUStock.jsp?'+gfd('prodFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
        <!--<hr>
        <li class="navLink leftAlText blkFnt" onclick="popLL('af/SKUListener.jsp?f=all')">Show all activities<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText blkFnt">Received from production <span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText blkFnt">Sold through Requisition<span class="right fa fa-angle-double-right"></span></li>-->
    </ul>
</div>
        <br>
        </div>
        <div class="right sbnvLdr lShadow">
    <hr>
    <div class="left halfnc">
    
    <table id="header-fixed" border="1px" cellpadding="2" style="margin:0px;" width="100%">
    </table>
    <div class="scrollable" >
        <table id="mainTable" border="1" width="100%" style='margin: 0px;padding: 0px;' cellpadding="0">
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
        List<SKUChangeListener> skuclRes=skucl.list();
        List<SKU> prods=sess.createCriteria(SKU.class).list();
        for(SKU fpp:prods){
    %>
                    <tr >
                    <td  title="click to trace complete product detail"
                         onclick="popsl('af/SKUListener.jsp?i=<%=fpp.getFPId().getFPId()%>',false);"><span class="navLink greenFont"><%=fpp.getFPId().getFPName()%></span>
                    </td>
                    <td><%=UT.df.format(fpp.getQnt())%></td>
                    </tr>
    <%}%>
          </tbody>
    </table>
    </div>
    </div>
          <div class="left halfnc" id="skuListner">
              <div class="scrollable">
      <table style="margin:0px" width="100%" cellpadding="5" border="1px">
        <thead>
            <tr align="left">
                <th>Docket</th>
                <th>Date</th>
                <th>Product</th>
                <th>Qnt</th>
                <th>Remark</th>
            </tr>
        </thead>
        <tbody style="max-height: 500px;overflow: auto">
            <%
                for(SKUChangeListener in:skuclRes){
                    DistOrderManager d=in.getOdrMan();
                    double qnt=in.getClosingStock()-in.getOpeningStock();
            %>
               <tr >
                <td onclick="popsl('af/dockRec.jsp?d=<%=d!=null?d.getDocketNo():""%>')"><%=d!=null?d.getDocketNo():""%></td>
                <td><%=in.getOnDate()%></td>
                <td><%=in.getProd().getFPName()%></td>
                <td class="<%=qnt>=0?"greenFont":"redFont"%>"><%=qnt>=0?UT.df.format(qnt):UT.df.format(-qnt)%></td>
                <td><%=in.getRemark()%></td>
            </tr>
                <%}%>  
        </tbody>
        </table>
        </div>
    </div>
          </div>
          <!--<script>$('#skuListner').load('af/SKUListener.jsp?f=all');</script>-->
        <script>
            copyHdr("mainTable","header-fixed");
        </script>
        </div>
      </div>
        </div></div>
</div>
</div>
<%
sess.close();
%>