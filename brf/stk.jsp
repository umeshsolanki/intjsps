<%-- 
    Document   : stk
    Created on : 7 Jan, 2018, 11:58:25 AM
    Author     : UMESH-ADMIN
--%>
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
//        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
        sess.refresh(role);
        Date nw=new Date();
        Date[] curr=Utils.gCMon(nw);
        
        String qry="from StockManager sm where inBr=:b";
        String pqry="from StockManager sm where inBr=:b";
//        List<StockManager> prods=sess.createQuery("from StockManager where mat is not null order by mat.matName").list();
        String m=request.getParameter("r"),iD=request.getParameter("iD"),p=request.getParameter("p")
//                ,br=request.getParameter("br")
                ;
//        Criteria c=sess.createCriteria(StockManager.class,"sm");
        if(Utils.isEmpty(p)){
            pqry+=" and sm.mat is null";
        }else if(p.equals("**P")){
            pqry+=" and sm.mat is null";
//            c.add(Restrictions.isNotNull("sm.mat"));
        }else if(p.equals("**PDL")){
//            qry+="where mat is null";
//            c.add(Restrictions.eqProperty("mat", "mat.minQnt"));
        }else if(p.matches("\\d+")){
            pqry+=" and sm.semiProd.FPId="+p;
//            c.add(Restrictions.eq("sm.mat.matId", new Long(p)));
        }
        if(Utils.isEmpty(m)){
            qry+= " and sm.mat is not null ";
        }else if(m!=null&&m.equals("**M")){
            qry+= " and sm.mat is not null ";
        }else if(m!=null&&m.equals("**MDL")){
            qry+=" and sm.Qty<sm.mat.minQnt and sm.mat is not null";
//            c.add(Restrictions.eqProperty("mat", "mat.minQnt"));
        }else if(m.matches("\\d+")){
            qry+=" where sm.mat.matId="+m+" ";
//            c.add(Restrictions.eq("sm.mat.matId", new Long(m)));
        }
//        else if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
//            c.add(Restrictions.between("orderDate", Utils.DbFmt.parse(iD), Utils.DbFmt.parse(fD)));
//        }else{
//               c.add(Restrictions.between("orderDate", curr[0],curr[1]));
//        }
//        if(br!=null&&br.matches("\\d+")){
//            qry+=" and sm.inBr.brId="+br;
//            pqry+=" and sm.inBr.brId="+br;
//            c.add(Restrictions.eq("inBr.brId",new Long(br)));
//        }
//        if(m!=null&&m.matches("00R-.+")){
//            c.add(Restrictions.eq("refBy",m.replaceFirst("00R-", "")));
//        }
//            setFirstResult(ini).setMaxResults(20).
        Query q=sess.createQuery(qry).setParameter("b", role.getBranch());
        Query pq=sess.createQuery(pqry).setParameter("b", role.getBranch());
        List<StockManager> prods=q.list();
        

//        Transaction tr = sess.beginTransaction();
        
//        List<Object[]> todays = sess.createQuery("select sum(credit),sum(debit) from DistFinance where dist=:d and txnDate=CURDATE()").setParameter("d", dist).list();
//        double tCr=0,tDr=0;
//        if(!todays.isEmpty()){
//            Object[] tt=todays.get(0);
//            tCr=new Double((tt[0]!=null)?""+tt[0]:"0");
//            tDr=new Double((tt[1]!=null)?""+tt[1]:"0");
//        }
        
        double mCr=0,mDr=0;
//        todays = sess.createQuery("select sum(credit),sum(debit) from DistFinance where dist=:d and ( txnDate between :iDt and :fDt )")
//        .setParameter("iDt", curr[0])
//        .setParameter("fDt", curr[1])
//        .setParameter("d", dist).list();
//        if(!todays.isEmpty()){
//            Object[] tt=todays.get(0);
//            mCr=new Double((tt[0]!=null)?""+tt[0]:"0");
//            mDr=new Double((tt[1]!=null)?""+tt[1]:"0");
//        }
        double OCr=0; 
//        todays = sess.createQuery("select sum(credit) from DistFinance where dist=:d and docketNo like '2%' and ( txnDate between :iDt and :fDt )")
//        .setParameter("iDt", curr[0])
//        .setParameter("fDt", curr[1])
//        .setParameter("d", dist).list();
//        if(!todays.isEmpty()){
//            Object tt=todays.get(0);
//            OCr=new Double((tt!=null)?""+tt:"0");
//        }
        double CCr=0; 
//        todays = sess.createQuery("select sum(credit) from DistFinance where dist=:d and docketNo like '3%' and ( txnDate between :iDt and :fDt )")
//        .setParameter("iDt", curr[0])
//        .setParameter("fDt", curr[1])
//        .setParameter("d", dist).list();
//        if(!todays.isEmpty()){
//            Object tt=todays.get(0);
//            CCr=new Double((tt!=null)?""+tt:"0");
//        }
        double 
//                tBal=0,
                tTP=0,tPaid=0; 
//        todays = sess.createQuery("select sum(toPay-disc),sum(paid+instCharge) from"
//        + " DistSaleManager where dist=:d and docketNo like '2%' and ( dt between :iDt and :fDt )")
//        .setParameter("iDt", curr[0])
//        .setParameter("fDt", curr[1])
//        .setParameter("d", dist).list();
//        if(!todays.isEmpty()){
//            Object[] tt=todays.get(0);
////            tBal=new Double((tt[0]!=null)?""+tt[0]:"0");
//            tTP=new Double((tt[0]!=null)?""+tt[0]:"0");
//            tPaid=new Double((tt[1]!=null)?""+tt[1]:"0");
//        }
        double tCBal=0,tCTP=0,tCPaid=0; 
//        todays = sess.createQuery("select sum(bal),sum(toPay),sum(paid+instCharge) from"
//        + " DistSaleManager where dist=:d and docketNo like '3%' and ( dt between :iDt and :fDt )")
//        .setParameter("iDt", curr[0])
//        .setParameter("fDt", curr[1])
//        .setParameter("d", dist).list();
//        if(!todays.isEmpty()){
//            Object[] tt=todays.get(0);
//            tCBal=new Double((tt[0]!=null)?""+tt[0]:"0");
//            tCTP=new Double((tt[1]!=null)?""+tt[1]:"0");
//            tCPaid=new Double((tt[2]!=null)?""+tt[2]:"0");
//        }
        double tRBal=0,tRTP=0,tRPaid=0; 
//        todays = sess.createQuery("select sum(totalpayment-paid-discount),sum(totalPayment),sum(paid) from"
//        + " DistOrderManager where distributor=:d and ( orderDate between :iDt and :fDt )")
//        .setParameter("iDt", curr[0])
//        .setParameter("fDt", curr[1])
//        .setParameter("d", dist).list();
//        if(!todays.isEmpty()){
//            Object[] tt=todays.get(0);
//            tRBal=new Double((tt[0]!=null)?""+tt[0]:"0");
//            tRTP=new Double((tt[1]!=null)?""+tt[1]:"0");
//            tRPaid=new Double((tt[2]!=null)?""+tt[2]:"0");
//        }
//        List<DistFinance> list = sess.createCriteria(DistFinance.class).add(Restrictions.eq("dist", dist)).addOrder(Order.desc("txnDate")).list();
//        Transaction tr = sess.beginTransaction();
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
    <div class="fullWidWithBGContainer">
        <div class="d3 left">   
            <p class="white pointer" onclick="popsl('brf/ustk.jsp')">
            <span class="button white"><i class="fa fa-plus-circle"></i> Update Stock</span></p>
        </div>
        <div class="d3 left leftAlText ">
            <p class="white pointer" onclick="popsl('brf/OpeningStock.jsp')">
            <span class="button white"><i class="fa fa-plus-circle"></i> Products Opening</span></p>
        </div>
        <div class="d3 left leftAlText">
            <p class="white pointer" onclick="popsl('brf/MaterialOpening.jsp')">
            <span class="button white"><i class="fa fa-plus-circle"></i> Material Opening</span>
            </p>
        </div>
    </div>
    <div class="fullWidWithBGContainer">
        <div class="subNav left" style="">
<!--            <span class="white"><h2 class="nomargin nopadding">Finance Record</h2></span><hr>-->
<div style="margin: 1px;padding: 1px;border: 1px white solid;">
    <p class="nomargin nopadding white">Month: <%=Utils.getWMon.format(new Date())%> </p><hr>
    <ul>
        <li title="Filters">
            <br>
            <form id="purFil" name="purFil">
                <select title="For branch" class="textField" name="r">
                <option value="">Select Raw Material</option>
                <option value="**M">All Materials Stock</option>
                <option value="**MDL">Materials below deadline</option>
                <%
                List<Material> mts=sess.createCriteria(Material.class).list();
                for(Material brr:mts){
                %>
                <option value="<%=brr.getMatId()%>"><%=brr.getMatName()%></option>
                <%}%>
            </select><br>
            <select class="textField" name="p" >
                <option value="">Select Product</option>
                    <option value="**P">All Products Stock</option>
                    <option value="**PDL">Products below deadline</option>
                    <%
                    List<FinishedProduct> fp=sess.createCriteria(FinishedProduct.class).add(Restrictions.eq("deleted", false)).list();
                    for(FinishedProduct mm:fp){
                    %>
                    <option value="<%=mm.getFPId()%>"><%=mm.getFPName()%></option>
                    <%
                    }
                    %>
                    </select><br>
            <%--<select class="textField" name="br" >
                <option value="">Select Branch</option>
                    <%
                    List<ProductionBranch> bn=sess.createCriteria(ProductionBranch.class)
//                            .add(Restrictions.eq("deleted", false))
                            .list();
                    for(ProductionBranch mm:bn){
                    %>
                    <option value="<%=mm.getBrId()%>"><%=mm.getBrName()%></option>
                    <%
                    }
                    %>
            </select><br>--%><br>
            
            <!--<span class="button right fa fa-arrow-circle-right"></span><i class="right"></i>-->
            <!--<input title="Start date" class="textField" type="date" name="iD"/><br>-->
            <!--<input class="textField" title="End Date" type="date" name="fD"/><br><br>-->
            <span class="right" onclick="loadPg('brf/stk.jsp?'+gfd('purFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
    </ul>
</div>
<div style="margin-top: 10px;padding: 1px;border: 1px white solid;">
    <p class="nomargin nopadding white">Month:Nov </p><hr>
    <ul>
        <li class="navLink leftAlText">Collection <span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Expenditures<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Recd from Complaints<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Recd from Orders<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Paid for Purchase<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Receivable Pending<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText">Payable Pending<span class="right fa fa-angle-double-right"></span></li>
    </ul>
</div>
        <br>
        </div>
        <div class="right sbnvLdr">
              <span class="white"><h2 class="nomargin nopadding">Stock </h2></span><hr>
            <div class="scrollable" >
                <div class="fullWidWithBGContainer">
                    <div class="half left">
        <script>
            function filterKeys(filter) {
//                        alert(JSON.stringify(window.event.keyCode));
            if(filter.toString().length>1){
                $("#matSRes").html("");
                $("#matSRes").css("display","block");
                var patt=new RegExp(".*"+filter+".*","i");
for(var i=0;i<mats.length;i++){
    var mat=mats[i];
//                var patt=new RegExp(".*"+filter+".*","i");
//                alert(mat.name);
    if(patt.test(mat.name)){
        $("#matSRes").append("<div onclick='scrollToMat("+mat.id+");' style='cursor:default;padding:5px;'>"+mat.name+"</div>");

    }
    }

}else{
            $("#matSRes").html("");
                $("#matSRes").css("display","none");
        }
        }

            function scrollToMat(matId) {
//                            alert(mats);

                var matScroll=document.getElementById("matScroll"+matId);
                if(matScroll!=null){
                matScroll.scrollIntoView();
                $(matScroll).css("transition","background 1s");
                var preE=matScroll.innerHTML;
                matScroll.firstElementChild.className='yellow';
                setTimeout(function(){matScroll.firstElementChild.className='normal';},4000);
                window.scroll(0,0);
            }
            else{
                showMes('Material Not found in stock!!',true,true);
            }
            $("#matSRes").html('');
            $("#brMatStkScroller").val('');
        }
        </script>
        <span class="white">
            <h3 class="nopadding nomargin">Raw Material Stock
                <span>
                    <input type="search" placeholder="Search" id='brMatStkScroller' onkeyup="filterKeys(this.value);"/>
                </span>
            </h3>
            <div class="scrollable" style="position: absolute;background-color: #778899;max-width: 350px;max-height: 200px;overflow: auto;" id="matSRes">                
            </div>
        </span>
    <hr>
      <table style="margin:0px" width="100%" cellpadding="5px"  border='1' >
        <thead>
            <tr align="left">
                <th>Material</th>
                <th>Branch</th>
                <th>Qty</th>
            </tr>
        </thead>
        <tbody>
<%
    for(StockManager in:prods){
%>
            <tr class="pointer" id="matScroll<%=(in.getMat().getMatId())%>" align="left">
                <td title="Click to view material stock update history" onclick="popsr('brf/MaterialConsumedSummary.jsp?i=<%=in.getMat().getMatId()%>&b=<%=in.getInBr().getBrId()%>')">
                    <span class="greenFont"><%=in.getMat().getMatName()%></span></td>
                <td><%=in.getInBr().getBrName()%></td>
                <td><%=in.getQty()+" "+in.getMat().getPpcUnit()%></td>
            </tr>
<%}%>
        </tbody>
        </table>
        </div>
    <div class="half right" style="">
        
            <span class="white"><h3 class="nomargin nopadding">Product Stock</h3></span><hr>
    <form id="initProduction">
        <script>
            function updateDev(idVal) {
                $('.msg').html("<center><img src='images/loader.svg' width=100 height=100 /></center>");    
                $.post("FormManager","strId="+idVal+"&action=updProdtn&fin="+$("#"+idVal).val(),function(dat){
                    if(dat.includes("success")){
                        showMes(dat,false);
                    }else{
                        showMes(dat,true);
                    }
                });
            }
        </script>
    <table style="margin:0px" width="100%" cellpadding="5px" border='1px' >
        <thead>
            <tr align="left">
                <th>Product</th>
                <th>Branch</th>
                <th>Quantity</th>
            </tr>
        </thead>
        <tbody id="MoreCont">
            <%
            prods=pq.list();
            for(StockManager ps:prods){
            %>
            <tr>
                <td><span class="greenFont" title="Click for details" onclick="popsr('brf/ProductConsumedSummary.jsp?i=<%=ps.getSemiProd().getFPId()%>&b=<%=ps.getInBr().getBrId()%>',false)"><%=ps.getSemiProd().getFPName()%></span></td>
                <td><%=ps.getInBr().getBrName()%></td>
                <td><%=ps.getQty()%></td>
            </tr>
            <%}%>
        </tbody>
    </table>
    </form>
        </div>
      </div>
        </div></div>
</div>
</div>
<%
sess.close();
%>