<%@page import="utils.UT"%>
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
        if(!UT.ia(role, "20")){
            out.print("<script>showMes('Requested resource denied to response because of limited access rights');");
            return;
        }
        sess.refresh(role);
        Date nw=new Date();
        Date[] curr=Utils.gCMon(nw);
        String m=request.getParameter("m"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),br=request.getParameter("br"),
                apv=request.getParameter("approved"),v=request.getParameter("v");
        
        boolean na=!UT.ie(apv)&&apv.equals("false");
        
        List<Material> mat=sess.createCriteria(Material.class).addOrder(Order.desc("matName")).list();
        Criteria c=sess.createCriteria(InwardManager.class).addOrder(Order.desc("importOn"));
        if(!UT.ie(v)){
            c.add(Restrictions.eq("purFrom", v));
        }
        if(na){
            c.add(Restrictions.eq("approved", false));
        }else{
        if(iD!=null&&iD.matches(".{10}")&&fD!=null&&fD.matches(".{10}")){
            curr[0]=Utils.DbFmt.parse(iD);
            curr[1]=Utils.DbFmt.parse(fD);
            if(role.getLimitDays()>0&&curr[0].getTime()<(nw.getTime()-role.getLimitDays()*86400000)){
                out.print("<script>showMes('You don&apos;t have access to see records before "+role.getLimitDays()+" days');</script>");
                c.add(Restrictions.eq("importOn",new Date(new Date().getTime()-role.getLimitDays()*86400000)));
            }else{
                c.add(Restrictions.between("importOn", curr[0], curr[1]));
            }
        }else if(iD!=null&&iD.matches(".{10}")){
            if(role.getLimitDays()>0&&curr[0].getTime()<(nw.getTime()-role.getLimitDays()*86400000)){
                c.add(Restrictions.eq("importOn",new Date(new Date().getTime()-role.getLimitDays()*86400000)));
            }else{
                c.add(Restrictions.eq("importOn", Utils.DbFmt.parse(iD)));
            }
        }else{
               c.add(Restrictions.between("importOn", curr[0],curr[1]));
        }
        }
        if(role.getBranch()!=null){
            c.add(Restrictions.eq("inBr.brId",role.getBranch().getBrId()));
        }else if((br!=null&&br.matches("\\d+"))){
            c.add(Restrictions.eq("inBr.brId",new Long(br)));
        }
        if(m!=null&&m.matches("\\d+")){
            c.add(Restrictions.eq("matId.matId",new Long(m)));
        }
//            setFirstResult(ini).setMaxResults(20).
        String pendBal="select sum(price-paid) from InwardManager ";
        String paidBal="select sum(paid) from InwardManager ";
        String taxColl="select sum(igst),sum(cgst),sum(sgst) from InwardManager";
        List<InwardManager> prods=c.list();
        double tPur=0,tIn=0;
%>    
<div class="loginForm" style="max-width: 100%;" ng-controller="purCtrl">
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        <div class="d3 left">   
            <p class="white pointer <%=role.getRole().matches("(.*Global.*)|(.*\\(C20\\).*)")?"":"invisible"%>" ng-click="popsl('api/purchases/form')" >
            <span class="button white"><i class="fa fa-plus-circle"></i> Purchase Record</span></p>
        </div>
        <div class="d3 left leftAlText ">
            <p class="greenFont"><%=iD!=null?"from "+iD:"from "+Utils.HRFmt.format(curr[0])%></p>
        </div>
        <div class="d3 left leftAlText">
            <p class="redFont"><%=iD!=null?"to "+fD:"to "+Utils.HRFmt.format(curr[1])%></p>
        </div>
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left rShadow" id="subNav" style="">
                <i class="fa btn fa-arrow-circle-left fa-2x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
<!--            <span class="white"><h2 class="nomargin nopadding">Finance Record</h2></span><hr>-->
<div style="">
    <h4 class="nomargin p-15 white bgcolt8">Month: <%=Utils.getWMon.format(new Date())%> </h4><hr>
    <ul>
        <li title="Filters" class="bgcolef">
            <br>
            <form id="purFil" name="purFil">
                <%if(role.getBranch()==null){%>
                <select title="For branch" class="textField" name="br"><option value="">Select Production Branch</option>
                <%
                    List<ProductionBranch> b=sess.createCriteria(ProductionBranch.class).list();
                for(ProductionBranch brr:b){
                %>
                <option value="<%=brr.getBrId()%>"><%=brr.getBrName()%></option>
                <%}%>
            </select><br>
            <%}else{%>
            <input type="hidden" value="<%=role.getBranch().getBrId()%>" name="br"/>
            <%}%>
            <select class="textField" name="m" >
                <option value="">Select Material</option>
                    <%
                    for(Material mm:mat){
                    %>
                    <option value="<%=mm.getMatId()%>"><%=mm.getMatName()%></option>
                    <%
                    }
                    %>
            </select><br>
            <select class="textField" name="v" >
                <option value="">Select Vendor</option>
                    <%
                    List<String> vendor=sess.createQuery("select distinct(purFrom) from InwardManager").list();
                    for(String mm:vendor){
                    %>
                    <option value="<%=mm%>"><%=mm%></option>
                    <%
                    }
                    %>
            </select><br>
            <input title="Start date" value="<%=UT.ie(iD)?Utils.DbFmt.format(curr[0]):iD%>" class="textField" type="date" name="iD"/><br>
            <input class="textField" value="<%=UT.ie(fD)?Utils.DbFmt.format(curr[1]):fD%>" title="End Date" type="date" name="fD"/><br><br>
            <span class="right" onclick="loadPg('purchases/index.jsp?'+gfd('purFil'));"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
            </form>
            <br><br>
        </li>
    </ul>
</div>
<%
if(role.isA()){
%>
<div style="">
    <h4 class="nomargin p-15 white bgcolt8">Useful Links</h4><hr>
    <ul class="bgcolef">
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','af/rmvendors.jsp')"
            >View RM Vendors<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','ql/billwisermPurchase.jsp')"
            >Show All Bills<span class="right fa fa-angle-double-right"></span></li><hr>
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','ql/rmPendBills.jsp')"
            >Pending bills<span class="right">&#8377;<i id="rmBalAmt"><%=UT.df.format(UT.eQ(sess,pendBal, false))%></i></span></li><hr>
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','ql/vendorWisePurchase.jsp')"
            >Vendor wise<span class="right">&#8377;<i id="rmBalAmt"><%=UT.df.format(UT.eQ(sess,pendBal, false))%></i></span></li><hr>
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','ql/rmpaidBills.jsp')"
            >Total Paid<span class="right">&#8377; <i id="rmPaidAmt"><%=UT.df.format(UT.eQ(sess,paidBal, false))%></i></span></li><hr>
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','ql/igstBills.jsp?i=i')"
            >IGST Paid<span class="right">&#8377; <i id="rmPaidAmt"><% Object[] tc=(Object[])UT.eQ(sess,taxColl, false);%><%=UT.df.format(tc[0])%></i></span></li><hr>
        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','ql/igstBills.jsp?i=c')"
            >CGST+SGST Paid<span class="right">&#8377; <i id="rmPaidAmt"><%=UT.df.format(tc[1])+" + "+UT.df.format(tc[2])%></i></span></li><hr>
<!--        <li class="navLink leftAlText" onclick="loadPageIn('linkLoader','ql/igstBills.jsp?i=s')"
            >SGST Paid<span class="right">&#8377; <i id="rmPaidAmt"><%=tc[2]%></i></span></li><hr>-->
    </ul>
</div>
<%}%>
    <br>
    </div>
        <div class="right sbnvLdr lShadow" id="linkLoader"><hr>
    <center>
    <table id="header-fixed" border="1px" cellpadding="2px" width="100%">
    </table>
    <div class="scrollable" >
    <form id="importMaterial" onsubmit="return false;">
    <table style="margin:0px" width="100%" border='1px' id="mainTable" cellpadding="2px" >
    <thead>
        <tr align="center">
            <th>SNo</th>
            <th>Date</th>
            <th>Branch</th>
            <th>Material</th>
            <th>Opening</th>
            <th>Purchase</th>
            <th>Inward</th>
            <th>Closing</th>
            <th>Vendor</th>
            <th>BillNo</th>
            <%if(role.getRole().matches("(.*Global.*)|(.*V3.*)")){%>
            <th title="W/O TAX">Amount</th>
            <th>Paid</th>
            <th>Bal</th>
            <th>Tax</th>
            <%}%>
            <th>Action</th>
        </tr>
    </thead>
    <tbody id="dataCont">
<%
    int srNo=0;
    double tAmt=0,tBal=0,tTax=0,tPaid=0;
    for(InwardManager in:prods){
        srNo++;
        tAmt+=in.getPrice();
        tBal+=in.getPrice()-in.getPaid();
        tPaid+=in.getPaid();
        tTax+=in.getTaxVal();
        tPur+=in.getQty();
        tIn+=in.getQtyInPPC();
%>
<tr id="IE<%=(in.getImportId())%>" align="center" <%if(in.getTick()!=null){
            out.print("style='color:red;' title='wrong entry ticket generated for this entry'");
                }%>>
                <td><%=(srNo)%></td>            
                <td><%=in.getImportOn()%></td>
                <td><%=in.getInBr().getBrName()%></td>
                <td><%=in.getMatId().getMatName()%></td>
                <td><%=UT.df.format(in.getInStockBFRTr())+" "+in.getMatId().getPpcUnit()%></td>
                <td><%=UT.df.format(in.getQty())+" "+in.getMatId().getImportUnit()%></td>
                <td><%=UT.df.format(in.getQtyInPPC())+" "+in.getMatId().getPpcUnit()%></td>
                <td><%=UT.df.format(in.getInStockBFRTr()+in.getQtyInPPC())+" "+in.getMatId().getPpcUnit()%></td>
                <td><%=(UT.ie(in.getPurFrom())||in.getPurFrom().length()<15)?in.getPurFrom():in.getPurFrom().substring(0,15)+"<i title='"+in.getPurFrom()+"'>..</i>"%></td>
                <td><%=(in.getBillNo())%></td>
                <%if(role.getRole().matches("(.*Global.*)|(.*V3.*)")){%>
                <td><i title="Total">&#8377;<%=(UT.df.format(in.getPrice()))%></i></td>
                <td>&#8377;<%=(UT.df.format(in.getPaid()))%></td>
                <td>&#8377;<i class="<%=(in.getPrice()-in.getPaid())>0?"redFont":"greenFont"%>" title="Pending"><%=(UT.df.format(in.getPrice()-in.getPaid()))%></i></td>
                <td>&#8377;<%=UT.df.format(in.getTaxVal())%></td>
                <%}%>
                <td align="left">
                    <%if(role.getRole().matches("(.*Global.*)|(.*\\(A20\\).*)|(.*"+ROLE.ADM_BR_RME+".*)")){%>
                    <%if(!in.isApproved()){%>
                    <button title="Click Approve Entry" id="ape<%=in.getImportId()%>" class="redFont button fa fa-check-circle" 
                            onclick="sendDataWithCallback('a','action=apIE&IE=<%=in.getImportId()%>',false,function(){
                        this.innerText='Approved';
                    })"></button>
                    <%}}%>
                    <%if(role.getRole().matches("(.*Global.*)|(.*\\(U20\\).*)")){%>
                    <button class="fa fa-edit" onclick="popsl('f/uppur.jsp?i=<%=in.getImportId()%>')"></button>
                    <%}%>
                    <%if(role.getRole().matches("(.*Global.*)|(.*\\(D20\\).*)")){%>
                    <button class="fa fa-trash button" title="Delete This Entry"
                            onclick="showDial('action=del&i=<%=(in.getImportId())%>&mod=BRP&r=IE<%=(in.getImportId())%>','del','Confirm delete'
                            ,'You can\'t undo the changes<br>It\'ll revert stock if entry was approved<br>');"></button>
                    <%}%>
                    <%if(in.getPrice()-in.getPaid()>0&&role.getRole().matches("(.*Global.*)|((.*\\(V20\\).*)(.*\\(C3\\).*))")){%>
                    <button class="tooltip fa fa-credit-card button" title="Click to pay" onclick='popsr("af/imp.jsp?i=<%=in.getImportId()%>")'>
                        <span class="tooltiptext">Click this button to make the entry for payment to the Merchant</span>
                    </button>
                    <%}%>
                </td>
            </tr>
    <%}%>
        <tr>
            <td><b>Total</b></td><td></td><td></td><td></td><td></td><td><b><%=UT.df.format(tPur)%></b></td><td><b><%=UT.df.format(tIn)%></b></td><td></td><td></td><td></td><td><b>&#8377;<%=UT.df.format(tAmt)%></b></td>
            <td><b>&#8377;<%=UT.df.format(tPaid)%></b></td><td><b>&#8377;<%=UT.df.format(tBal)%></b></td>
            <td><b>&#8377;<%=UT.df.format(tTax)%></b></td><td><b class="redFont">Bal: &#8377;<%=UT.df.format(tBal)%></b></td>
        </tr>
        </tbody>
        </table>
        </form>
        </div>
        </center>
        </div>
        </div>
        <script>
        var $fixedHeader=$("#header-fixed").append($("#mainTable > thead").clone(false));
        $("#header-fixed th").each(function(index){
    var index2 = index;
    $(this).width(function(index2){
        var eee= $("#mainTable th").eq(index).width();
//        $("#mainTable th").eq(index).html("-");
//        alert(eee);
        return eee;
    });
});
        <%=UT.ie(v)?"":"purFil.v.value='"+v+"';"%>
        <%=UT.ie(m)?"":"purFil.m.value='"+m+"';"%>
        <%=UT.ie(br)?"":"purFil.br.value='"+br+"';"%>
        </script>
</div>
<%
sess.close();
%>