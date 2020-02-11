<%-- 
    Document   : index
    Created on : 17 Jul, 2017, 12:51:28 PM
    Author     : UMESH-ADMIN
--%>
<%@page import="entities.SKU"%>
<%@page import="entities.DistributorInfo"%>
<%@page import="entities.FinanceRequest"%>
<%@page import="entities.FinanceRequest"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Bill"%>
<%@page import="entities.DistributionRecord"%>
<%@page import="entities.CompanyDomain"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.ProductionRequest"%>
<%@page import="entities.MaterialStockListener"%>
<%@page import="utils.MainModifier"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="entities.FinishedProductStock"%>
<%@page import="entities.StockManager"%>
<%@page import="entities.Admins"%>
<%@page import="entities.PPControl"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<%
Session sess=null;
try{
    
sess=sessionMan.SessionFact.getSessionFact().openSession();
}catch(Exception e){
    e.printStackTrace();
out.print("<script>showMes('App Initialization Error was Detected at server',true);</script>");
return;
}

Admins role=(Admins)session.getAttribute("role");
DistributorInfo dis=(DistributorInfo)session.getAttribute("dis");
boolean isErp=true;
if(session.getAttribute("Target").equals("Web")){
    isErp=false;
}
    List<CompanyDomain> comp=sess.createCriteria(CompanyDomain.class).list();
    if(comp.size()<1){
%>

<div class="white">
    <center>  <h1>Welcome To Industry Management System</h1>
    <p>It's first time setup WIZARD, Please provide company information</p>
    
    <br><br>
    <form onsubmit="return false;" id="compForm">
            <input type="hidden" name="action" value="setup"/>
            <input class="textField" type="text"  name="aId" placeholder="Global Admin Id"/>
            <input class="textField" type="text" name="nm" minlength="2" placeholder="Company Name"/><br>
            <input class="textField" type="password" name="pass" minlength="4" placeholder="password"/>
            <input class="textField" type="text" name="addr" placeholder="City"/><br>
            <input class="textField" type="email" name="mail" minlength="6" placeholder="Email" required/>
            <br><button onclick="subForm('compForm','FormManager');" class="button">Proceed</button>
    </form>
        </center>
</div>
<%
        return ;
    }
if(role==null){
    if(session.getAttribute("dis")==null){


%>
    <div class="container" onclick="hideSideBar()">
          <div class='fullWidWithBGContainer'>
             <div class='container background'>
                 <center><h1 style='font-size:38px;line-height: 42px;
                             color: #fff;'class="white">The Ultimate systems for drying your clothes</h1> 
                             <span class="justify" style="color: #fff;">
                                 The ultra modern space saver and compact clothes hanger to dry clothes inside/outside home, dry your clothes without electricity
                            </span><br><br>
                        <%if(!isErp){%>
                            <h1 style="color: #fff;font-family: georgia; ">Our Products</h1>
                        <div>
                           <div class="button" style="display: inline-block;color: #fff;background-color: #ff9933">Wall Mounter</div>
                           <div class="button" style="display: inline-block;color: #fff;background-color: #4499cb">Ironing Board</div>
                           <div class="button" style="display: inline-block;color: #fff;background-color: #7788cb">Horizontal Clothes Line</div>
                           <div class="button" style="display: inline-block;color: #fff;background-color: #bb88cb">Tusker Ladder</div>
                           <div class="button" style="display: inline-block;color: #fff;background-color: #ff9999">Adjustable ACR</div>
                        </div><br><br>
                        <%}%>
                 </center>
             </div>
          </div>
        
    <div class='container white'>
        <div class='fullWidWithBGContainer'>
             <center>
                 <div class="form">
    <%if(!isErp){%>
    <h1 style="color: #fff;font-family: georgia; ">View More Products</h1>
    
                     <!--                    <form action="NewClientRequest" method="post">
                        <input class="textField" name="nm" placeholder="Enter Name*"/>
                         <input class="textField" name="mail" placeholder="Enter Mail*"/><br>
                         <input class="textField" name="mob" placeholder="Enter Mobile*"/>
                         <input class="textField" name="comp" placeholder="Enter Company Name"/><br>
                         <select name='proBudget' class="textField">
                             <option>Estimated Budget</option>
                             <option>&lt; ₹ 10000</option>
                             <option> ₹ 10000 - 20000</option>
                             <option> ₹ 20000 - 40000</option>
                             <option>&gt; ₹ 40000</option>
                         </select>
                         <select name='proType' class="textField">
                             <option>Project Category*</option>
                             <option>Website</option>
                             <option>Android App</option>
                             <option>Desktop Application</option>
                             <option>Management System</option>
                             <option>Other</option>
                         </select><br>
                        </select>
                         <textarea placeholder="Poject Details*" name="mes" class="txtArea"></textarea>
                         <br><input type="submit" class="button" style="display: inline-block;color: #fff;background-color: #4499cb" value="Send"/>-->
    <%}%>           
<!--</form>-->                 
                 </div>
                 
<!--            <div class="white" >
                <div class="half left readingGap">
                    <h1 class="even" style="color: #fff;font-family: georgia;line-height: 42px  ">Website Development</h1>
                    <p>
                       We have been delivering the highest quality of web solutions.
                    </p>
                </div>-->
<!--                <div class="half right readingGap">
                   <h1 style="color: #fff;font-family: georgia;line-height: 42px " class="even"> Android App Development</h1>
                   <p class="even justify">Android – a fastest growing operating system of smart phone devices has been popular with its each update. Its versatile, user friendly applications & flexibility has made it more favorite. Our expert team having updated knowledge of latest android release invents profitable android apps.
Vrinda Soft is renowned Android app development company offering professional android app development services. Our Professional team of android app Developers perform deep research and analysis to meet your requirements and expectations. Accessing wide range of tools and technologies we create customized applications which are powerful and scalable for any android devices. We are providing android application development service globally.</p>-->
            </center>
         </div>
    </div><br><br><br><br><br><br><br><br>
</div>
         
<!--<div class='fullWidWithBGContainer'>
             <div class='container' style="min-height: 395px">
                <div class="left half">
                     <img class="layer" src="images/sunil.png" width="100%" height="400" alt="C++ programming language"/>
                     <img class="layer" src="images/cheque.JPG" width="100%" height="400" alt="android training"/>               
                </div>
                <div class="right half">
                    <img class="layer1" src="images/certificate.JPG" height="400" width="100%" alt="Java programming language"/>
                    <img class="layer1" src="images/memento.JPG" width="100%" height="400" alt="Android app development"/>
                </div>
            </div>
</div>-->
<div class='container white' onclick="hideSideBar()">
    <div class='fullWidWithBGContainer'>
        <a name="aboutUs"></a>
        <center><h1 style="color:#fff;font-size: 24px"><font color='#2244ff'>About Pull 'n' Dry Appliances Pvt. Ltd.</font></h1>
            
            <div class="readingGap">
            <h1 class="even" style="color: #fff;font-family: georgia;line-height: 42px; font-size: 19px">                     
                C-Line Industries is an ISO 9001:2008 Company manufacturing clothing line equipments using the latest space saving technologies.
                Designed and developed by engineering entrepreneur two decades ago.
                State of the art Engineering company having InHouse facility of machinery, frabication, powder coating and assembling.
                We have thousands of satisfied customers and we are continuosly innovating to upgrade the available products and introduce new products to suit changing customer needs.
            </h1>
            </div>
        </center><br><br><br><br>
     </div> 
</div>
  
<div class="fullWidWithBGContainer" onclick="hideSideBar()" style="background-color: #4499cb" >
    <a name='contactUs'></a>
    <center><h1 style="color:#fff">Contact Us</h1></center>
    <div class="container autoFitLayout">
        <div class="cardContainer" >
                <div class="cardView">
                <p  style='padding:5px;font-size: 18px;font-family: georgia;line-height: 32px;' > 
                    <b>Customer Care:</b><br>
                    +91 - 9743833355,
                    +91 - 9743833377<br><br>
                    <b>#22, #23, Kyalasanahalli, Kothanur post, Bangalore - 560 077.</b><br>
                </p>
            </div>
        </div>
        <div class="cardContainer" >
                <div class="cardView">
                <p  style='padding:5px;font-size: 18px;font-family: georgia;line-height: 32px;' > 
                    <b>Bangalore Location:</b><br>+91 - 98442 03492,+91 - 97438 33377
                    <br><b>Regd Office: </b>
                    <br>#18, Carmel Complex, Geddalahalli, Bangalore - 560 077.<br>
                    080 - 3244 1357, 
                    080 - 3244 1358
                </p>
            </div>
        </div>
        <div class="cardContainer" >
                <div class="cardView">
                <p  style='padding:5px;font-size: 18px;font-family: georgia;line-height: 32px;' > 
                    <b>Mysore Location<br>
                        Jyothi Enterprises, Mysore</b><br>
                    +91 - 98456 85122
                    +91 - 98446 83436<br>
                    Email : customercare@pullandry.com</p>
            </div>
        </div>
        <div class="cardContainer" >
                <div class="cardView">
                <p  style='padding:5px;font-size: 18px;font-family: georgia;line-height: 32px;' > 
                    <b>Chennai Location</b><br>
                    +91 - 096000 47487
                    +91 - 098848 53679<br>
                    Email : esveedevices@pullandry.com
                </p>
            </div>
        </div>
        <div class="cardContainer" >
                <div class="cardView">
                <p  style='padding:5px;font-size: 18px;font-family: georgia;line-height: 32px;' > 
                    <b>Cochin Home Needs, Cochin</b>
                    <br>+91 - 98474 13377<br>
                        0484 - 2336855
                </p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
<%
    }
}
else if(!role.isBranchModule()){
%>
    
<div class="fullWidWithBGContainer" id="mainSel" onclick="hideSideBar()">
<center>
            <%
            if(role.getRole().matches("(.*Global.*)?(.*Stock.*)?")){
            if(sess!=null){
                List<StockManager> stockWarning=sess.createQuery("from StockManager s where s.Qty<s.mat.minQnt order by mat.matName").list();
            %>
            
            <div class="half left lightBlue border" style="min-height: 400px;">
                <marquee><b  style='padding: 5px;color:#882244;'>RM below deadline</b></marquee><hr>
                <div class="scrollable">
            <table  border="0" width="100%" style='margin: 0px;padding: 0px;' cellspacing="2" cellpadding="5">

<thead align='left'>
                <tr>
                    <th>Material</th>
                    <th>Quantity</th>
                    <th>Branch-Id</th>
                </tr>
</thead>
        <tbody>
        <%
            for(StockManager sm:stockWarning){
        %>
                    <tr>
                        <td><%=sm.getMat().getMatName()%></td>
                        <td style='color:red;'><%=sm.getQty()+" "+sm.getMat().getPpcUnit()%></td>
                        <td><%=sm.getInBr().getBrName()%></td>
                    </tr>
        <%
            }
        %>
                </tbody>
                </table>
                </div>
                </div>
<%}
if(role.getRole().matches("(.*Global.*)|(.*Distribution.*)|(.*Stock.*)")){
%>
               
<div class="half border right lightBlue boxPcMinHeight" style="min-height: 400px;">
    <marquee><b style="padding: 5px;">Centralized SKU for Distribution</b></marquee><hr>
    <div class="scrollable">
    <table border="0" width="100%" style='margin: 0px;padding: 0px;' cellspacing="2" cellpadding="5">
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
                        onclick="loadPage('adminForms/SKUListener.jsp?i=<%=fp.getFPId().getFPId()%>',false);"
                        class="navLink"><%=fp.getFPId().getFPName()%>
                    </td>
                    <td><%=fp.getQnt()%></td>
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
</div>
        <%
        }if(role.getRole().matches("(.*Global.*)?(.*Distribution.*)?(.*Finance.*)?")){
        %>
        
        <div class="half border left boxPcMinHeight" style="background: #8fc3c7;">
    <center><b>Sales Report</b></center><hr>
        <table border="0" width="100%" cellspacing="2" cellpadding="5">

          <thead align='left'>
              <tr>
                  <th>Date</th>
                  <th>Sold To</th>
                  <!--<th>Sold</th>-->
                  <th>Amount</th>
                  <th>Paid</th>
              </tr>
          </thead>
          <tbody>         
          <%
              try{
            List<Bill> dist=sess.createCriteria(Bill.class).addOrder(Order.desc("billId")).list();
        //    for(FinishedProduct fp:prods){
        //    List<DistributionRecord> allProdCount=sess.createQuery("Select sum(Qnt),count(producedBy) from FinishedProductStock"
        //                    + " fps where FPId=:prod and Qnt>0").setParameter("prod", fp).list();
//                    if(!allProdCount.isEmpty())
            for(Bill sm:dist){        
                DistributionRecord dr=new ArrayList<DistributionRecord>(sm.getDist()).get(0);
%>
                    <tr>
                        <td class="navLink" onclick="loadPage('Res/pB/<%=sm.getBillId()%>')"><%=dr.getSoldOn().toLocaleString()%></td>
                        <td><%=dr.getToWhome().getDisId()+", "+dr.getToWhome().getType()%></td>
                        <td>INR <%=sm.getToPay()%></td>
                        <td><%=sm.getPaidAmount()%></td>
                    </tr>
                    <%}
}catch (Exception ex) {
        out.print("Error in Bill History:366");
    }%>
          </tbody>
    </table>
          </div>
          
          <div class="half boxPcMinHeight border right" style="background: #efefef;">
              <center><b>Finance</b></center><hr>
                  <table width="100%" cellpadding='5'>        
      <thead>
            <tr align='left'><th>Date</th><th>Credit</th><th>Debit</th><th>Outcome</th></tr>
      </thead>
              <%        List<Object[]> fin=sess.createQuery("select sum(credit),sum(debit),txnDate from FinanceRequest finId group by txnDate order by txnDate desc").list();
                for(Object[] req:fin){
              %>
                 <tr>
                     <td><%=req[2]%></td>
                     <td title="click to view all credits of the day" style='cursor: default;color:green' onclick="loadPage('adminForms/LoadFinance.jsp?i=0&d=<%=req[2]%>')"><%=req[0]%></td>
                <td style='cursor: default;color:red' title="click to view all debits of the day" onclick="loadPage('adminForms/LoadFinance.jsp?i=1&d=<%=req[2]%>')"><%=req[1]%></td>
                <td><%=((Double)req[0]-(Double)req[1])%></td>
                 </tr>
    <%}%>
          </table>
      </div>
   
    <%}%>
          </center>
          </div>
    <%}%>       
    <center><div class="container animateFast" id="subPageContainer"></div></center>
    
<%
}
else if(role.isBranchModule()){
%>
    <center>
    
          <%
              if(role.getRole().matches("(.*InwardEntry.*)|(.*InwardModify.*)")){
              List<StockManager> prods=sess.createCriteria(StockManager.class).add(Restrictions.isNotNull("mat")).addOrder(Order.asc("mat")).add(Restrictions.eq("inBr", role.getBranch())).list();
          %>
            <div class="fullWidWithBGContainer">
                <div class="half left boxPcMinHeight" style="background-color: #888888;">
                    <span class="white"><h3>Material's Stock In <%=role.getBranch().getBrName()%></h3></span>
    <hr>
      <table style="margin:0px" width="100%" cellspacing="5" style="max-height: 500px;overflow: auto" >
        <thead>
            <tr align="left">
                <!--<th>Date</th>-->
                <th>Material</th>
                <th>In Stock(PPC Unit)</th>
            </tr>
        </thead>
        <tbody>
<%for(StockManager in:prods){
%>
            <tr>
                <td><span class="navLink" title="Click to view material stock update history" onclick="loadPageIn('detailCont','brManForms/MaterialConsumedSummary.jsp?i=<%=in.getMat().getMatId()%>')"><%=in.getMat().getMatName()%></span></td>
                <td><%=in.getQty()+" "+in.getMat().getPpcUnit()%></td>
<%}%>
        </tbody>
        </table>
         <!--<br><span class="button">View More...</span>-->
         <br><br>
                </div>
           
                <div class="half right boxPcMinHeight" style="background-color: #8fc3c7;">
                    <div id='detailCont'>        
                    
                    </div>
                </div>
            </div>
    <%}if(role.getRole().matches("(.*ProductionEntry.*)|(.*ProductionModify.*)")){%>
    <div class="fullWidWithBGContainer">
        <div class="half boxPcMinHeight left" style="background-color: #ff8888;">
        
        <span class="white"><h2>Product's Stock in <%=role.getBranch().getBrName()%></h2></span><hr><br>
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
    <table style="margin:0px" width="100%" cellspacing="5" >
        <thead>
            <tr align="left">
                <th>Product</th>
                <th>Quantity</th>
            </tr>
        </thead>
        <tbody id="MoreCont" style="max-height: 500px;overflow: auto">
            <%
            List<StockManager> finProds=sess.createCriteria(StockManager.class).add(Restrictions.isNull("mat")).addOrder(Order.asc("mat")).add(Restrictions.eq("inBr", role.getBranch())).list();
            for(StockManager fp:finProds){
            %>
            <tr>
                <td><span class="navLink" title="Click for details" onclick="loadPageIn('prodRecord','brManForms/ProductConsumedSummary.jsp?i=<%=fp.getSemiProd().getFPId()%>',false)"><%=fp.getSemiProd().getFPName()%></span></td>
                <td><%=fp.getQty()%></td>
            </tr>
            <%}%>
        </tbody>
    </table>
    </form>
        </div>
        <div class="half boxPcMinHeight right " style="background: #efefef;" id="prodRecord">    
        </div>
    </div>
        <%}%>
        <div style="padding: 3px;" class="fullWidWithBGContainer" id="subPageContainer"></div>
    </center>
</body>
</html>
<%
    }
    if(sess!=null)
sess.close();
%>