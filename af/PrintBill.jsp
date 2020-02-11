<%-- 
    Document   : PrintBill
    Created on : 9 Aug, 2017, 10:47:48 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="entities.Bill"%>
<%@page import="entities.DistributionRecord"%>
<%@page import="entities.Admins"%>
<%@page import="entities.Material"%>
<%@page import="entities.ProductionBranch"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="entities.InwardManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.FinishedProduct"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if(!(session.getAttribute("role") instanceof Admins)){
        %>
        <script>
            window.location.replace("?msg=Unauthorized Access, Please Login First");
        </script>
<%
    return ;
}
Session sess=sessionMan.SessionFact.getSessionFact().openSession();
%>
<%
    String iLim=request.getParameter("ini");
    String embed=request.getParameter("embed")==null?"0":request.getParameter("embed");
    Long billId=new Long(request.getParameter("bId"));
    
    int ini=0;
    if(iLim!=null&&iLim.matches("\\d+")){
        ini=Integer.parseInt(iLim);
    }
//    List<DistributionRecord> prods=sess.createCriteria(DistributionRecord.class).addOrder(Order.desc("distId")).
//            setFirstResult(ini).setMaxResults(20).list();
Bill bill=(Bill)sess.get(Bill.class,billId);
ArrayList<DistributionRecord> dists=new ArrayList(bill.getDist());
DistributionRecord dr=dists.get(0);
if(embed.equals("0")){
%>
    <div class="loginForm"  style="background: #dfede1 !important;margin: 15px;padding:0px;">
    <span class="close fa fa-close" onclick="clearViewIn('billCont')"></span>
    <!--<span></span>-->
    <script>
        function printBill() {
            var cont=$("#billCont").html();
    var wind=window.open("PullNDry","Print Bill");
    wind.document.write("<html><head></head><body><center>"+cont+"</center></body></html>");
        wind.print();
    wind.close();
    return true;
}
    </script>
    <style>
        table tr td{
            border-right: 1px solid black;
            border-left: 1px solid black;
            margin: 0px;
            padding: 5px;
        }
        .border{
            border: 1px solid black;
        }
        th{
            border: 1px solid black;
            padding: 5px;
            margin: 0px;
            /*border-top:1px solid black;*/
        }
        @media print{
            body,table{
                margin: 0px;
                padding: 0px;
            }
        table tr td{
            border-right: 1px solid black;
            border-left: 1px solid black;
            margin: 0px;
            padding: 5px;
        }
        th{
            border: 1px solid black;
            padding: 5px;
            margin: 0px;
            /*border-top:1px solid black;*/
        }
        .close{
    color:#fff;
    font-family: sans-serif;
    font-weight: 900;
    cursor: default;
    position: absolute;
    right:0px;
    font-size: 20px;
    top:0px;
    float:right;
    z-index: 9999;
    padding-left: 10px;
    padding-right: 10px;
}
.close:hover{
    border-top-right-radius: 2px;
    background-color: red;
}
.half{
    
    padding:0px;
    margin: 0px;
    max-width: 50%;
    width: 49%;
}
.left{
    float: left;
}
.left::after{
    clear:both;
}
.right{
    float: right;
}
.right::after{
    clear:both;
}
.button{display: none;}
.close{display: none}
tr.border  td{
    border: 1px solid black;
}
        }
    </style>


    <h2 class="white" style='padding: 5px'>Invoice Details</h2><hr>
    <div class="container">
        <div class="half left">
            <p align='left' class="readingGap" style="padding: 5px">
        <b>Pull N Dry Appliances PVT. LTD.</b><br>
        <b>Bengaluru</b>
    </p></div>
        <div class="half right">
    <p align='left' class="readingGap" style="padding: 5px">
        <b>Date- <%=dists.get(0).getSoldOn()%></b><br>
        <b>Customer Name:</b> <%=dists.get(0).getToWhome().getDisId()%><br>
        <b>Customer Mob &nbsp;:</b> <%=dists.get(0).getToWhome().getMob()%><br>
        <b>Transporter No:</b> <%=bill.getTransportNo()%><br>
        <b>Destination &nbsp;&nbsp;:</b> <%=bill.getDestination()%><br>
        <b>LR No. &nbsp;&nbsp;:</b> <%=bill.getLRNo()%><br>
        <b>GST No. &nbsp;:</b> <%=bill.getGstNum()%><br>
        
    </p></div>
    </div>
        
      <table cellpadding="5" cellspacing="0" width="100%"  >
        <thead>
            <tr align="left">
                <th>Sr.No</th>
                <th>Description</th>
                <th>Code</th>
                <th>HSN No</th>
                <th>Qty</th>
                <th>Rate</th>
                <th>Amount</th>
            </tr>
        </thead>
        <tbody id="dataCont">
            
<%
    int qty=0,i=0;
    double amtWithDisc=bill.getAmount()-(bill.getAmount()*bill.getDiscount()/100)+(bill.getAmount()/50);
    for(DistributionRecord in:dists){
        i++;
//        double bal=in.getAmount()-in.getPaidAmount()-in.getDiscount();
//    dists=new ArrayList(in.getDist());
        qty+=in.getQty();
%>

            <tr>
                <td><%=i%></td>
                <td><%=in.getFromStore().getFPId().getProdDesc()%></td>
                <td><%=in.getFromStore().getFPId().getFPId()%></td>
                <td><%=in.getFromStore().getFPId().getHSNNo()%></td>
                <td><%=in.getQty()%></td>
                <td><%=in.getMRP()%></td>
                <td>INR <%=in.getMRP()*in.getQty()%></td>
                
            </tr>
            
<%
    dists=null;}
if(bill.getDiscount()>0){%><tr><td></td><td></td><td></td><td></td><td></td><td>Discount@ <%=bill.getDiscount()%> %</td><td>INR <%=(bill.getAmount()*bill.getDiscount()/100)%> </td></tr><%}%>
<tr><td></td><td></td><td></td><td></td><td></td><td>Packing &amp; Forwarding charges </td><td>INR <%=(bill.getAmount()/50)%> </td></tr>
<tr><td></td><td></td><td></td><td></td><td></td><td></td><td><hr></td></tr>                
<tr><td></td><td></td><td></td><td></td><td></td><td></td><td>INR <%=amtWithDisc%></td></tr>                
<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr> 
<%if(bill.getIgst()>0){%><tr><td></td><td></td><td></td><td></td><td></td><td>IGST @ <%=bill.getIgst()%> %</td><td>TAX <%=(amtWithDisc*bill.getIgst()/100)%> </td></tr><%}%>
<%if(bill.getCgst()>0){%><tr><td></td><td></td><td></td><td></td><td></td><td>CGST @ <%=bill.getCgst()%> %</td><td>TAX <%=(amtWithDisc*bill.getCgst()/100)%> </td></tr><%}%>
<%if(bill.getSgst()>0){%><tr><td></td><td></td><td></td><td></td><td></td><td>SGST @ <%=bill.getSgst()%> %</td><td>TAX <%=(amtWithDisc*bill.getSgst()/100)%> </td></tr><%}%>

<tr ><td class="border">Total</td><td class="border"></td><td class="border"></td><td class="border">
    </td><td class="border"><%=qty%></td><td class="border"></td><td class="border">INR <%=bill.getToPay()%></td></tr>

        </tbody>
    </table>
    
    <div class="container border">
        <div class="half left" >
            <p class="readingGap">
        <br><br><br>
            <center>    Customer Sign.</center>
        
    </p></div>
        <div class="half right">
    <p class="readingGap">
        <br><br><br>
        <center>Authorised Signatory</center>
    </p></div>
    </div>
    <br>
    <button class="button" onclick="printBill();">Print</button>
    <br><br>
    
    </div>
            <%

}else{

%>
<div class="loginForm"  style="background: #dfede1 !important;margin: 15px;padding:0px;">
        <span class="close" onclick="clearViewIn('billCont')">&Cross;</span>
    <!--<span></span>-->
    <script>
        function printBill() {
            var cont=$("#billCont").html();
    var wind=window.open("PullNDry","Print Bill");
    wind.document.write("<html><head></head><body><center>"+cont+"</center></body></html>");
        wind.print();
    wind.close();
    return true;
}
    </script>
    <style>
        table tr td{
            border-right: 1px solid black;
            border-left: 1px solid black;
            margin: 0px;
            padding: 5px;
        }
        .border{
            border: 1px solid black;
        }
        th{
            border: 1px solid black;
            padding: 5px;
            margin: 0px;
            /*border-top:1px solid black;*/
        }
        @media print{
            body,table{
                margin: 0px;
                padding: 0px;
            }
        table tr td{
            border-right: 1px solid black;
            border-left: 1px solid black;
            margin: 0px;
            padding: 5px;
        }
        th{
            border: 1px solid black;
            padding: 5px;
            margin: 0px;
            /*border-top:1px solid black;*/
        }
        .close{
    color:#fff;
    font-family: sans-serif;
    font-weight: 900;
    cursor: default;
    position: absolute;
    right:0px;
    font-size: 20px;
    top:0px;
    float:right;
    z-index: 9999;
    padding-left: 10px;
    padding-right: 10px;
}
.close:hover{
    border-top-right-radius: 2px;
    background-color: red;
}
.half{
    
    padding:0px;
    margin: 0px;
    max-width: 50%;
    width: 49%;
}
.left{
    float: left;
}
.left::after{
    clear:both;
}
.right{
    float: right;
}
.right::after{
    clear:both;
}
.button{display: none;}
.close{display: none}
tr.border  td{
    border: 1px solid black;
}
        }
    </style>


    <h2 class="white" style='padding: 5px'>Invoice Details</h2><hr>
    <div class="container">
        <div class="half left">
            <p align='left' class="readingGap" style="padding: 5px">
        <b>Pull N Dry Appliances PVT. LTD.</b><br>
        <b>Bengaluru</b>
    </p></div>
        <div class="half right">
    <p align='left' class="readingGap" style="padding: 5px">
        <b>Date- <%=dists.get(0).getSoldOn()%></b><br>
        <b>Customer Name:</b> <%=dists.get(0).getToWhome().getDisId()%><br>
        <b>Customer Mob &nbsp;:</b> <%=dists.get(0).getToWhome().getMob()%><br>
        <b>Transporter No:</b> <%=bill.getTransportNo()%><br>
        <b>Destination &nbsp;&nbsp;:</b> <%=bill.getDestination()%><br>
        <b>LR No. &nbsp;&nbsp;:</b> <%=bill.getLRNo()%><br>
        <b>GST No. &nbsp;:</b> <%=bill.getGstNum()%><br>
        
    </p></div>
    </div>
        
      <table cellpadding="5" cellspacing="0" width="100%"  >
        <thead>
            <tr align="left">
                <th>Sr.No</th>
                <th>Description</th>
                <th>Code</th>
                <th>HSN No</th>
                <th>Qty</th>
                <th>Rate</th>
                <th>Amount</th>
            </tr>
        </thead>
        <tbody id="dataCont">
            
<%
    int qty=0,i=0;
    double amtWithDisc=bill.getAmount()-(bill.getAmount()*bill.getDiscount()/100)+(bill.getAmount()/50);
    for(DistributionRecord in:dists){
        i++;
//        double bal=in.getAmount()-in.getPaidAmount()-in.getDiscount();
//    dists=new ArrayList(in.getDist());
        qty+=in.getQty();
%>

            <tr>
                <td><%=i%></td>
                <td><%=in.getFromStore().getFPId().getProdDesc()%></td>
                <td><%=in.getFromStore().getFPId().getFPId()%></td>
                <td><%=in.getFromStore().getFPId().getHSNNo()%></td>
                <td><%=in.getQty()%></td>
                <td><%=in.getMRP()%></td>
                <td>INR <%=in.getMRP()*in.getQty()%></td>
                
            </tr>
            
<%
    dists=null;}
if(bill.getDiscount()>0){%><tr><td></td><td></td><td></td><td></td><td></td><td>Discount@ <%=bill.getDiscount()%> %</td><td>INR <%=(bill.getAmount()*bill.getDiscount()/100)%> </td></tr><%}%>
<tr><td></td><td></td><td></td><td></td><td></td><td>Packing &amp; Forwarding charges </td><td>INR <%=(bill.getAmount()/50)%> </td></tr>
<tr><td></td><td></td><td></td><td></td><td></td><td></td><td><hr></td></tr>                
<tr><td></td><td></td><td></td><td></td><td></td><td></td><td>INR <%=amtWithDisc%></td></tr>                
<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr> 
<%if(bill.getIgst()>0){%><tr><td></td><td></td><td></td><td></td><td></td><td>IGST @ <%=bill.getIgst()%> %</td><td>TAX <%=(amtWithDisc*bill.getIgst()/100)%> </td></tr><%}%>
<%if(bill.getCgst()>0){%><tr><td></td><td></td><td></td><td></td><td></td><td>CGST @ <%=bill.getCgst()%> %</td><td>TAX <%=(amtWithDisc*bill.getCgst()/100)%> </td></tr><%}%>
<%if(bill.getSgst()>0){%><tr><td></td><td></td><td></td><td></td><td></td><td>SGST @ <%=bill.getSgst()%> %</td><td>TAX <%=(amtWithDisc*bill.getSgst()/100)%> </td></tr><%}%>

<tr ><td class="border">Total</td><td class="border"></td><td class="border"></td><td class="border">
    </td><td class="border"><%=qty%></td><td class="border"></td><td class="border">INR <%=bill.getToPay()%></td></tr>

        </tbody>
    </table>
    
    <div class="container border">
        <div class="half left" >
            <p class="readingGap">
        <br><br><br>
            <center>    Customer Sign.</center>
        
    </p></div>
        <div class="half right">
    <p class="readingGap">
        <br><br><br>
        <center>Authorised Signatory</center>
    </p></div>
    </div>
    <br>
    <button class="button" onclick="printBill();">Print</button>
    <br><br>
    </div>
    
            <%
}
   sess.close();
%>
