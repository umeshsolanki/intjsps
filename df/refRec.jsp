<%-- 
    Document   : DisFinance
    Created on : Oct 12, 2017, 10:20:53 PM
    Author     : sunil
--%>

<%@page import="java.util.Iterator"%>
<%@page import="entities.SaleInfo"%>
<%@page import="java.util.Collection"%>
<%@page import="entities.DistSaleManager"%>
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
        DistributorInfo dist=(DistributorInfo)session.getAttribute("dis");
        DistributorInfo LU=(DistributorInfo)session.getAttribute("LU");
        sess.refresh(dist);
        String r=request.getParameter("r");
              
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

</script>
<div class="loginForm" style="max-width: 100%;">
    <span class="close" id="close" onclick="clrLSP();">x</span>
    <div class="fullWidWithBGContainer bgcolef">
        <span class="white"><h2 class="nomargin nopadding bgcolt8 centAlText">'<%=r%>' Referrer Record</h2></span><hr>
    <center>
        <table border='1px' cellpadding='2'>
            <tr>
                <!--<th>Date</th>-->
                <th>ExeDate</th><th>Cust</th><th>Mob</th><th>Add</th>
                <th>DocketNo</th>
                <th>Commission</th><th>Code</th><th>Qty</th><th>Value</th><th>ServCh</th>
                <th>Total</th><th>Recd</th><th>Bal</th></tr>
            <%
            List<DistSaleManager> fd=sess.createCriteria(DistSaleManager.class).add(Restrictions.eq("refBy", r)).add(Restrictions.eq("dist", dist)).list();
            for(DistSaleManager f:fd){
            Iterator<SaleInfo> col=f.getSaleRecord().iterator();
            if(!col.hasNext()){
            %>
            <%--tr>
                <!--<td><%=f.getDt()%></td>-->
                <td><%=f.getExeDate()%></td>
                <td><%=f.getDocketNo()%></td>
                <td <%=f.isCmClr()?" title=\"Click to mark as Paid to referrer\"":" onclick=\"sendDataForResp('FormManager','action=TUP&mod=PCOM&i="+f.getSMId()+"',false)\""%>><span class="<%=f.getDisc()>0?"fa fa-check-circle":"" %> <%=f.isCmClr()?"greenFont":"redFont" %>"> </span> &#8377; <%=f.getDisc()%></td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td><%=f.getScExp()%></td>
                <!--<td><%=f.getInstCharge()%></td>-->
                <td><%=f.getToPay()+f.getScExp()%></td>
                <td><%=f.getBal()+f.getScExp()-f.getInstCharge()%></td></tr--%>
                
            <%
            continue;
            }
            SaleInfo s=col.hasNext()?col.next():new SaleInfo();
            %>
            <tr>
                <!--<td><%=f.getDt()%></td>-->
                <td><%=f.getExeDate()%></td>
                <td><%=f.getCust().getName()%></td>
                <td><%=f.getCust().getMob()%></td>
                <td><%=f.getCust().getAddress()%></td>
                <td><%=f.getDocketNo()%></td>
                <td <%=f.isCmClr()?" title=\"Click to mark as Paid to referrer\"":" onclick=\"sendDataForResp('FormManager','action=TUP&mod=PCOM&i="+f.getSMId()+"',false)\""%>><span class="<%=f.getDisc()>0?"fa fa-check-circle":"" %> <%=f.isCmClr()?"greenFont":"redFont" %>"></span> &#8377; <%=f.getDisc()%></td>
                <td><%=s.getProd().getFPName()%></td>
                <td><%=s.getQnt()%></td>
                <td><%=s.getSoldAt()%></td>
                <td><%=f.getScExp()%></td>
                <!--<td><%=f.getInstCharge()%></td>-->
                <td><%=f.getToPay()+f.getScExp()%></td>
                <td><%=f.getToPay()-f.getBal()+f.getInstCharge()%></td>
                <td><%=f.getBal()+f.getScExp()-f.getInstCharge()%></td></tr>
                <%
                while(col.hasNext()){
                s=col.next();
                %>
            <tr><td>-</td><td>-</td><td>-</td><td>-</td><td><%=s.getProd().getFPName()%></td><td><%=s.getQnt()%></td>
                <td><%=s.getSoldAt()%></td>
                <td>-</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td>
            </tr>
                <%}%>
            <%}%>
        </table>    
        <br><br>
    </center>           
</div>
</div>
            <style>
                            .popSMLE{
                                box-shadow: 4px 4px 25px black;
                            }
                        </style>
<%
sess.close();
%>
