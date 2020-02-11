<%-- 
    Document   : brIndex
    Created on : 21 Nov, 2017, 10:17:13 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="utils.UT"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="entities.StockManager"%>
<%@page import="java.util.List"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="entities.Admins"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="loginForm" style="margin: 0px;padding: 0px;">
    <span class="close" id="close" onclick="closeMe()">&Cross;</span>
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
              if(role.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_BR_ALLSTOCKV+".*)")){
              List<StockManager> prods=sess.createQuery("from StockManager where mat is not null order by mat.matName").list();
          %>
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
<div class="fullWidWithBGContainer">
    
    <div class="tFivePer border left">
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
            <h3 class="nopadding nomargin">Material's Stock
                <span>
                    <input type="search" placeholder="Search" id='brMatStkScroller' onkeyup="filterKeys(this.value);"/>
                </span>
            </h3>
            <div class="scrollable" style="position: absolute;background-color: #778899;max-width: 350px;max-height: 200px;overflow: auto;" id="matSRes">                
            </div>
        </span>
    <hr>
    <div class="scrollable">
      <table style="margin:0px" width="100%" cellpading="5px"  border='1' >
        <thead>
            <tr align="left">
                <th>Material</th>
                <th>Branch</th>
                <th>In Stock</th>
            </tr>
        </thead>
        <tbody>
<%
    for(StockManager in:prods){
%>
            <tr class="pointer" id="matScroll<%=(in.getMat().getMatId())%>" align="left">
                <td title="Click to view material stock update history" onclick="loadPageIn('detailCont','brManForms/MaterialConsumedSummary.jsp?i=<%=in.getMat().getMatId()%>&b=<%=in.getInBr().getBrId()%>')">
                    <span ><%=in.getMat().getMatName()%></span></td>
                <td><%=in.getInBr().getBrName()%></td>
                <td><%=UT.df.format(in.getQty())+" "+in.getMat().getPpcUnit()%></td>
            </tr>
<%}%>
        </tbody>
        </table>
        </div>
         <!--<br><span class="button">View More...</span>-->
         <br><br>
    </div>   
    <div class="sixtyFivePer right scrollable" >
        <div id='detailCont'></div>
    </div>
    <%}if(role.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_BR_ALLSTOCKV+".*)")){%>
    <div class="fullWidWithBGContainer">
        <div class="tFivePer border boxPcMinHeight left" style="">
        
            <span class="white"><h2 class="nomargin nopadding">Product's Stock</h2></span><hr>
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
            List<StockManager> finProds=sess.createCriteria(StockManager.class).add(Restrictions.isNull("mat"))
                    .addOrder(Order.asc("mat")).list();
            for(StockManager fp:finProds){
            %>
            <tr>
                <td><span class="navLink" title="Click for details" onclick="loadPageIn('prodRecord','brManForms/ProductConsumedSummary.jsp?i=<%=fp.getSemiProd().getFPId()%>',false)"><%=fp.getSemiProd().getFPName()%></span></td>
                <td><%=UT.df.format(fp.getQty())%></td>
            </tr>
            <%}%>
        </tbody>
    </table>
    </form>
        </div>
        <div class="sixtyFivePer right " id="prodRecord">    
            
        </div>
    </div>
<%}%>
</div>
</div>
