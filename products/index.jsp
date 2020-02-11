<%-- 
    Document   : DisFinance
    Created on : Oct 12, 2017, 10:20:53 PM
    Author     : sunil
--%>

<%@page import="utils.UT"%>
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
        if(!UT.ia(role, "8")){
        out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
//        out.print("permission available");
            return;
        }
//        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
        sess.refresh(role);
              
//        Transaction tr = sess.beginTransaction();
        Date nw=new Date();
//        List<Object[]> todays = sess.createQuery("select sum(credit),sum(debit) from DistFinance where dist=:d and txnDate=CURDATE()").setParameter("d", dist).list();
//        double tCr=0,tDr=0;
//        if(!todays.isEmpty()){
//            Object[] tt=todays.get(0);
//            tCr=new Double((tt[0]!=null)?""+tt[0]:"0");
//            tDr=new Double((tt[1]!=null)?""+tt[1]:"0");
//        }
        Date[] curr=Utils.gCMon(new Date());
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
     function toggleSemi(proId,ele) {
                    showMes("<center><img src='images/loader.svg' width=100 height=100 /></center><br>Please wait...",true);
                    $.get("PPCManager?act=tSemi&prod="+proId,function(resp){
                        if(resp.includes("success")){
                            showMes(resp,false);
                            if(ele.innerHTML=="Yes"){
                                ele.innerHTML="No";
                            }else{
                                ele.innerHTML="Yes";
                            }
                        }else{
                            showMes(resp,true);
                        }
                    });
//                    alert(proId);
//                        $("div").remove("#ppc"+ppcId);
                    }

</script>
<div class="loginForm" style="max-width: 100%;">
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\(C8\\).*)")?"":"invisible"%>" onclick="popsl('af/afp.jsp')"><span class="button white"><i class="fa fa-plus-circle"></i> Add New Product</span></p>
        </div>
        <div class="d3 left leftAlText ">
            <p>&nbsp;</p>
        </div>
        <div class="d3 left leftAlText">
            <p >&nbsp;</p>
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left rShadow" style="">
        <i class="fa btn fa-arrow-circle-left fa-2x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
        <div style="">
            <h4 class="nomargin nopadding bgcolt8 white">Month: <%=Utils.getWMon.format(new Date())%> </h4><hr>
            <ul class="bgcolef"></ul>
        </div>
        <br>
        </div>
        <div class="right sbnvLdr lShadow" >
              <!--<span class="white"><h2 class="nomargin nopadding">Products</h2></span>-->
              <hr>
              <table id="header-fixed" border="1px" cellpadding="2" style="margin:0px;" width="100%">
            </table>
        <center>
            <div class="scrollable">
                <table style="margin:0px" id="mainTable" width="100%" border='1px' cellpadding="2" >
                    <thead>
                        <tr>
                            <th>SNo</th>
                            <th>Code</th>
                            <th>Desc</th>
                            <th>MRP</th>
                            <th>HSN</th>
                            <th>Tax</th>
                            <th>BarCode</th>
                            <th>IsSemi</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="matCont">
                        <%
                            List<FinishedProduct> fp=sess.createCriteria(FinishedProduct.class)
                                .add(Restrictions.eq("deleted", false)).addOrder(Order.asc("FPName")).list();
                            int i=0;
                            for(FinishedProduct p:fp){
                                i++;
                        %>
                            <tr id="row<%=p.getFPId()%>"> 
                                <td><span class="pointer"><%=i%></span></td>
                                <td><span class="pointer"><%=p.getFPName()%></span></td>
                                <td><%=p.getProdDesc()%></td>
                                <td><%=p.getMRP()%></td>
                                <td><%=p.getHSNNo()%></td>
                                <td><%=p.getTax()%></td>
                                <td><%=p.getBarCode()%></td>
                                <td onclick='toggleSemi(<%=p.getFPId()%>,this)'title="click to toggle product type"><span class="fa fa-check-circle <%=p.isSemiFinished()?"greenFont":"redFont"%>"></span></td>
                                <td>
                                    <%if(role.getRole().matches("(.*Global.*)|(.*\\(U8\\).*)")){%>
                                    <span class='fa fa-edit button' onclick="popsl('af/afp.jsp?p=<%=p.getFPId()%>');"></span>
                                    <%}if(role.getRole().matches("(.*Global.*)|(.*\\(D8\\).*)")){%>
                                    <span class='fa fa-trash button' onclick="showDial('action=dProd&pId=<%=p.getFPId()%>','del','Sure Delete: <b class=\'redFont\'><%=p.getFPName().replaceAll("'", "&apos;").replaceAll("\"", "&quot;")%></b>','You can\'t undo this action');"></span>
                                    <%}%>
                                </td>
                            </tr>
                        <%}%>
                    </tbody>
                </table>
                    <script>
                        copyHdr("mainTable","header-fixed");    
                    </script>
            </div>
          </div>
        </div>
</div>
<%
sess.close();
%>
