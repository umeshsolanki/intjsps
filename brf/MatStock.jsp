<%-- 
    Document   : MatStock
    Created on : 16 Dec, 2017, 7:35:12 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="entities.StockManager"%>
<%@page import="java.util.List"%>
<%@page import="entities.Admins.ROLE"%>
<%@page import="entities.Admins"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
              if(role.getRole().matches("(.*"+ROLE.BRM_RMEA+".*)|(.*"+ROLE.BRM_RME+".*)")){
              List<StockManager> prods=sess.createQuery("from StockManager where mat is not null and inBr=:br order by mat.matName").setParameter("br", role.getBranch()).list();
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
    <div class="tFivePer left">
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
            <h2 class="nopadding nomargin">Material's Stock In <%=role.getBranch().getBrName()%> 
                <span>
                    <input type="search" placeholder="Search" id='brMatStkScroller' onkeyup="filterKeys(this.value);"/>
                </span>
            </h2>
                <div style="position: absolute;background-color: #778899;max-width: 350px;max-height: 200px;overflow: auto;" id="matSRes">                
                </div>

        </span>
    <hr> 
    <div class="scrollable">
      <table style="margin:0px" width="100%" cellpadding="5px"  border='1' >
        <thead>
            <tr align="left">
                <!--<th>Date</th>-->
                <th>Material</th>
                <th>In Stock(PPC Unit)</th>
            </tr>
        </thead>
        <tbody>
<%
    for(StockManager in:prods){
%>
            <tr id="matScroll<%=(in.getMat().getMatId())%>" align="left">
                <td><span class="pointer" title="Click to view material stock update history" onclick="loadPageIn('detailCont','brManForms/MaterialConsumedSummary.jsp?i=<%=in.getMat().getMatId()%>')"><%=in.getMat().getMatName()%></span></td>
                <td><%=in.getQty()+" "+in.getMat().getPpcUnit()%></td>
            </tr>
<%}%>
        </tbody>
        </table>
        </div>
         <!--<br><span class="button">View More...</span>-->
         <br><br>
    </div>   
    <div class="sixtyFivePer right boxPcMinHeight" style="">
        <div id='detailCont'></div>
    </div>
    <%}%>
</div>
