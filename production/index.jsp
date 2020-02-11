
<%@page import="entities.MaterialStockListener"%>
<%@page import="servlets.FM"%>
<%@page import="entities.Barcode"%>
<%@page import="utils.UT"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="entities.ProductionBranch"%>
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
        if(!UT.ia(role, "18")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');</script>");
//        out.print("permission available");
            return;
        }
        Date nw=new Date();
        Date[] curr=Utils.gCMon(nw);
        String m=request.getParameter("p"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),br=request.getParameter("br"),
               apv=request.getParameter("approved");
        boolean na=!UT.ie(apv)&&apv.equals("false");
//        List<ProductionRequest> ppp=sess.createCriteria(ProductionRequest.class).list();
//        Transaction tr=sess.beginTransaction();
//        for(ProductionRequest p:ppp){
//            FM.addFPStock(sess, p.getProducedOn(), p.getProducedBy(), p.getDeveloped(), MaterialStockListener.Type.Produced, p, p.getProduct(), "Manufactured ");
//        }
//        tr.commit();
        Criteria c=sess.createCriteria(ProductionRequest.class).add(Restrictions.eq("opening",false)).addOrder(Order.desc("reqId"));
//        System.out.println(""+role.getLimitDays());
        if(na){
            c.add(Restrictions.eq("approved", false));
        }else{
        if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
            curr[0]=Utils.DbFmt.parse(iD);
            curr[1]=Utils.DbFmt.parse(fD);
            if(role.getLimitDays()>0){
                if(curr[0].getTime()<(nw.getTime()-role.getLimitDays()*86400000)){
                    out.print("<script>showMes('You don&apos;t have access to see records before "+role.getLimitDays()+" days');</script>");
                    c.add(Restrictions.between("producedOn",new Date(new Date().getTime()-role.getLimitDays()*86400000) ,curr[1]));
                }else{
                    c.add(Restrictions.between("producedOn", curr[0],curr[1]));
                }
            }else{
                c.add(Restrictions.between("producedOn", curr[0],curr[1]));
            }
        }else if(iD!=null&&iD.matches(".{10}")){
                curr[0]=Utils.DbFmt.parse(iD);
                curr[1]=Utils.DbFmt.parse(fD);
                if(curr[0].getTime()<(nw.getTime()-role.getLimitDays()*86400000)){
                    c.add(Restrictions.eq("producedOn",new Date(new Date().getTime()-role.getLimitDays()*86400000)));
                }else{
                    c.add(Restrictions.eq("producedOn", Utils.DbFmt.parse(iD)));
                }
        }else{
               c.add(Restrictions.between("producedOn", curr[0],curr[1]));
        }
        }
        if(role.getBranch()!=null){
            c.add(Restrictions.eq("producedBy.brId",role.getBranch().getBrId()));
        }else if((br!=null&&br.matches("\\d+"))){
            c.add(Restrictions.eq("producedBy.brId",new Long(br)));
        }
        if(!Utils.isEmpty(m)&&m.matches("\\d+")){
            c.add(Restrictions.eq("product.FPId",new Long(m)));
        }
        List<ProductionRequest> finProds=c.list();
        List<FinishedProduct> fpa= sess.createCriteria(FinishedProduct.class).add(Restrictions.eq("deleted", false)).addOrder(Order.asc("FPName")).list();
        sess.refresh(role);
        double mCr=0,mDr=0;
        double OCr=0; 
        double CCr=0; 
        double tTP=0,tPaid=0; 
        double tCBal=0,tCTP=0,tCPaid=0; 
        double tRBal=0,tRTP=0,tRPaid=0; 
%>
<script>
    var payMethod="";
function setPayMethod(val){
    payMethod=val;
    if(val==="Select Payment Method"){
        $("#payId").attr("disabled","disabled");
        $("#payId").val("");
        $("#bkNm").attr("disabled","disabled");
        $("#bkNm").val("");
        $("#amt").attr("disabled","disabled");
        $("#amt").val("");
    }else if(val==="Cash"){
        $("#amt").removeAttr("disabled");
        $("#amt").attr("placeholder","Amount*");
        $("#payId").attr("disabled","disabled");
        $("#payId").val("");
        $("#bkNm").attr("disabled","disabled");
        $("#bkNm").val("");
    }
    else if(val==="DD"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","DD No.*");
        $("#amt").removeAttr("Disabled");
        $("#amt").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");   
    }
    else if(val==="NEFT"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Transaction-Id*");
        $("#amt").removeAttr("Disabled");
        $("#amt").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    else if(val==="RTGS"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Transaction-Id*");
        $("#amt").removeAttr("Disabled");
        $("#amt").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    else if(val==="Cheque"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Cheque No.*");
        $("#amt").removeAttr("Disabled");
        $("#amt").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    else if(val==="Online"){
        $("#payId").removeAttr("Disabled");
        $("#payId").attr("Placeholder","Transaction-Id*");
        $("#amt").removeAttr("Disabled");
        $("#amt").attr("Placeholder","Amount*");
        $("#bkNm").removeAttr("Disabled");
        $("#bkNm").attr("Placeholder","Bank Name*");
        
    }
    }
            
            function buildJSON(){
                        var distJson=[];
                        for(var i=0;i<distJson.length;i++){ 
//                            var credit=new Number($("#payType"+distJson[i]).val());
//                            var debit=new Number($("#payType"+distJson[i]).val());
                            var amnt=new Number($("#amt"+distJson[i]).val());
                            
                            if(isNaN(amnt)){
                                showMes("Enter valid amount",true);
                                return ;
                            }
                        
                    }
    var req={payType:$("#payType").val(),payMethod:$("#payMethod").val(),payId:$("#payId").val(),amount:$("#amt").val(),
        bank:$("#bkNm").val(),summ:$("#summary").val(),action:$("#action").val()};
//    showMes(JSON.stringify(req));
    sendDataForResp("FormManager",JSON.stringify(req),true);
    }
            function updateDev(proReqId) {
                $('.msg').html("<center><img src='images/loader.svg' width=100 height=100 /></center>");    
                var reqD="strId="+proReqId+"&action=updProdtn&finS="+$("#stk"+proReqId).val()+"&fin="+$("#"+proReqId).val();
                showMes(reqD);
                $.post("FormManager",reqD,
                function(dat){
                    if(dat.includes("success")){
                        showMes(dat,false);
                    }else{
                        showMes(dat,true);
                }
            });
}
</script>
<div class="loginForm" style="max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\(C18\\).*)")?"":"invisible"%>" onclick="popsl('af/newprodrec.jsp')">
                <span class="button white"><i class="fa fa-plus-circle"></i> Start Production</span></p>
        </div>
        <div class="d3 left leftAlText ">
            <p class="greenFont"><%=iD!=null?"from "+iD:"from "+Utils.HRFmt.format(curr[0])%></p>
        </div>
        <div class="d3 left leftAlText">
            <p class="redFont"><%=iD!=null?"to "+fD:"to "+Utils.HRFmt.format(curr[1])%></p>
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="left subNav rShadow" style="">
            <i class="fa btn fa-arrow-circle-left fa-2x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<!--            <span class="white"><h2 class="nomargin nopadding">Finance Record</h2></span><hr>-->
<div style="">
    <h4 class="nomargin p-15 white bgcolt8">Month: <%=Utils.getWMon.format(new Date())%> </h4><hr>
    <ul>
        <li title="Filters" class="bgcolef">
            <br>
            <form id="prodFil" name="prodFil">
                <%if(role.getBranch()==null){%>
            <select title="For branch" class="textField" name="br"><option>Select Branch</option>
            <%          
                    List<ProductionBranch> b=sess.createCriteria(ProductionBranch.class).list();
                    for(ProductionBranch brr:b){
                    %>
            <option value="<%=brr.getBrId()%>"><%=brr.getBrName()%></option>
            <%}%>
            </select><br>
            <%}else{%>
            <input type="hidden" value="<%=role.getBranch().getBrId()%>" name="b"/>
            <%}%>
            <select class="textField" name="p">
                    <option >Select Product</option>
                    <%
                    for(FinishedProduct f:fpa){
                    %>
                    <option value="<%=f.getFPId()%>"><%=f.getFPName()%></option>
                    <%}%>
            </select><br>
            <!--<span class="button right fa fa-arrow-circle-right"></span><i class="right"></i>-->
            <input title="Start date" value="<%=UT.ie(iD)?Utils.DbFmt.format(curr[0]):iD%>" class="textField" type="date" name="iD"/><br>
            <input class="textField" value="<%=UT.ie(fD)?Utils.DbFmt.format(curr[1]):fD%>" title="End Date" type="date" name="fD"/><br><br>
            <span class="right" onclick="loadPg('production/index.jsp?'+gfd('prodFil'))"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
    </ul>
</div>
            <%
            if(role.isA()){
            %>
    <div style="" id="barCont">
    <p class="nomargin p-15 white bgcolt8  bold">Quick Links</p><hr>
    <ul class="bgcolef">
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','ql/prodwiseProduction.jsp?'+gfd('prodFil'))">Product wise Report<span class="right "></span></li><hr>
        <li class="navLink leftAlText" onclick="window.open('ResourseManager/xls/?'+gfd('prodFil'))">Download Excel Report<span class="right "></span></li>
<!--        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','ql/usedinProdReport.jsp')">Used in production<span class="right "></span></li><hr>
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','ql/prodwiseProduction.jsp')">Sent to SKU<span class="right "></span></li><hr>
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','ql/prodwiseProduction.jsp')">Other<span class="right"></span></li>-->
    </ul>
    </div>         
<%}
//        Barcode b = (Barcode)sess.createCriteria(Barcode.class).uniqueResult();    
    %>
<%--        <div style="" id="barCont">
            <p class="nomargin p-15 white bgcolt8  bold">Customize Barcode Size</p><hr>
            <form id="barCust" onsubmit='return false' name="barCust" action="U" method="post">
                <ul class="bgcolef">
                <input type="hidden" name="action" id="action" value="barFormat" />
                <input type="hidden" name="bar" value="*" />
                <li class="navLink leftAlText">Barcode CSS<span class="right ">
                        <input class="smTF nmgn" name="bcss" id="bcss" value="<%=b!=null?b.getBw():""%>" placeholder="Width (px,em,%)" /></span></li><hr>
                <li class="navLink leftAlText">Division CSS<span class="right ">
                <input class="smTF nmgn" name="dcss" id="dcss" value="<%=b!=null?b.getDw():""%>" placeholder="Width (px,em,%)" /></span></li><hr>
                <li class="navLink leftAlText">Text Css<span class="right ">
                <input class="smTF nmgn" name="hcss" id="hcss" value="<%=b!=null?b.getHfs():""%>" placeholder="Width (px,em,%)" /></span></li><hr>
                <li class="navLink leftAlText"><span class="right">
                        <button class="button" onclick="return subForm('barCust','U');" >Apply</button></span></li>
            </ul>
            </form>
        </div>--%>
        <br>
        </div>
        <div class="right sbnvLdr lShadow " id="linkLoader">
              <!--<span class="white"><h2 class="nomargin nopadding">Production</h2></span>-->
              <hr>
              <table id="header-fixed" border="1px" cellpadding="2" style="margin:0px;" width="100%">
            </table>
        <center>
            <div class="scrollable" >
                <form id="initProduction" onsubmit="return false;">
        <script>
            function updateDev(proReqId) {
                $('.msg').html("<center><img src='images/loader.svg' width=100 height=100 /></center>");    
                $.post("FormManager","pr="+proReqId+"&action=trAFPR&lsku="+$("#lsku"+proReqId).val()+"&csku="+$("#csku"+proReqId).val(),
                function(dat){
                    if(dat.includes("success")){
                        showMes(dat,false);
                    }else{
                        showMes(dat,true);
                }
            });
    }
        </script>
        <table id="mainTable" border="1px" width="100%" cellpadding="2" >
        <thead>
            <tr>
                <th >SNo</th>
                <th >Product</th>
                <th >Date</th>
                <th >Branch</th>
                <th >Qty</th>
                <th >Produced</th>
                <!--<th>Transfer-->
                <!--</th><th>CSKU-->
                    <!--</th>-->
                <th >Under Production</th>
                <!--<th>Distributed</th>-->
                <th >Action</th>
            </tr>
        </thead>
        <tbody id="MoreCont" style="max-height: 500px;overflow: auto">
            <%
            for(ProductionRequest fp:finProds){
            %>
            <tr id="PR<%=fp.getReqId()%>">
                    <td><%=fp.getReqId()%></td>
                        <td onclick="popsl('f/BRConsumption.jsp?p=<%=fp.getReqId()%>')"> <span  class="greenFont navLink"><%=fp.getProduct().getFPName()%></span></td>
                        <td><%=fp.getProducedOn()%></td>
                        <td><%=fp.getProducedBy().getBrName()%></td>
                        <td><%=fp.getQnt()%></td>
                        <td>
                            <%if(!fp.getProduct().isSemiFinished()){%>
                            <span  onclick="popsl('af/mnfd.jsp?p=<%=fp.getReqId()%>')" title="View Manufactured Products Status" 
                                   class="fa button fa-eye <%=role.getRole().matches("(.*Global.*)|(.*\\((V|U)18\\).*)")?"":"invisible"%>">&nbsp;</span>
                            <%}%><%=fp.getDeveloped()%>
                        </td>
<!--                        <td>
                            <input id="lsku<%=fp.getReqId()%>" class="smTF" placeholder="To LSKU" /> 
                        </td><td>
                        <input class="smTF" id="csku<%=fp.getReqId()%>" placeholder="To CSKU" /> 
                        <button class="fa fa-save" title="Save" onclick="updateDev('<%=fp.getReqId()%>')"></button>
                        
                        </td>-->
                        <td class="redFont">
                            <%int bal=fp.getQnt()-fp.getDeveloped();%>
                            <span class="fa <%=bal>0?"fa-spinner fa-spin":""%>"></span> <%=bal%>
                        </td>
        <td>
        <%
        if(fp.isApproved()){
        if(bal>0){
            if(role.getRole().matches("(.*Global.*)|(.*\\(U18\\).*)")){
        %>
            <input id='fins<%=fp.getReqId()%>' type="number" placeholder="Manufactured" title="Manufactured out of balance" class="smTF"/>
            <input id='da<%=fp.getReqId()%>' style='min-width: 130px;' type="date" value="<%=Utils.DbFmt.format(new Date())%>" title="Manufactured on" class="smTF"/>
            <button title="Update manufactured" onclick='sdfr("FormManager","strId="+<%=fp.getReqId()%>+"&action=updProdtn&dt="+$("#da<%=fp.getReqId()%>").val()+"&fins="+$("#fins<%=fp.getReqId()%>").val(),false);' class="button fa fa-arrow-circle-right"></button>
            <%}}
            if(role.getRole().matches("(.*Global.*)|(.*\\((V|U)18\\).*)"))
            %>
            <button onclick="popsl('f/BRConsumption.jsp?p=<%=fp.getReqId()%>')" title="View Conumed Material" class="button fa fa-eye"></button>
            <%if(!fp.getProduct().isSemiFinished()){%>           
            <a target="_blank" href="barcodePrint.jsp?p=<%=fp.getReqId()%>" title="Print Barcode" class="fa fa-barcode button">
            <!--<button  title="Generate Batch Barcodes" onclick="popsl('af/pbars.jsp?p=<%=fp.getReqId()%>')" class="button fa fa-barcode"></button>-->
            </a>
            <%}%>
            <%
            }else if(role.getRole().matches("(.*Global.*)|(.*"+ROLE.ADM_BR_EA+".*)|(.*\\(A18\\).*)")){
            %>
                <button title="Approve" onclick="sendDataWithCallback('a','action=apPR&pr=<%=fp.getReqId()%>',false);this.innerHTML='Approved';" class="button fa fa-thumbs-up redFont"></button>
            <%}%>
        <%if(role.getRole().matches("(.*Global.*)|(.*\\(D18\\).*)")){%>
    <button class="fa fa-trash button" title="Delete This Entry" 
            onclick='showDial("action=del&r=PR<%=(fp.getReqId())%>&mod=BRPN&i=<%=(fp.getReqId())%>","del","Do you really want to delete??","It will revert stock changes")'></button>
            <%}%>
        </td>
        </tr>
        <%}%>
                    </tbody>
                </table>
                    <script>
                        copyHdr("mainTable","header-fixed");
                    </script>
                </form>
            </div>
          </div>
</div>
</div>
<%
sess.close();
%>
