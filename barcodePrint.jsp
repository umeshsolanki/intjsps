<%-- 
    Document   : barcodePrint
    Created on : 20 Feb, 2018, 12:41:12 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="entities.Manufactured"%>
<%@page import="java.util.List"%>
<%@page import="entities.Admins"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <script src="js/jquery-3.1.0.min.js" type="text/javascript" ></script>
    </head>
    <style>
        @media all{
            body{
                height: 11.69in;
                width: 8.27in;
                /*border: 0.001in solid red;*/
            }
            .barCodeRow{
                margin-left: 0.1in;
                width: 100%;
            }
            .barcode{
                /*o*/
                /*width: 1.811024in;*/
                
                /*border: 0.001in solid black;*/
                width: 1.811024in;
                background-color: #efefef;
                height: .35in;
                /*line-height: 0.4260in;*/
                overflow: hidden;
                margin-left: .1in;
                margin-right: 0.1in;
                margin-top: 0.105in;
                display: inline-block;
                border-radius: 5px;
            }
            .bImg{
                width: 100%;
                /*margin-top: 0.04in;*/
                margin: 0px;
                padding: 0px;
                height: 0.2in;
            }
            .bText{
                /*margin-top:*/ 
                overflow: hidden;
                font-size: 10px;
            }
            p,html,table,td,th,tr,body,div,img{
                margin:0px;
                padding:0px;
            }
            .marTop{
            margin-top: 0.72in;
        }
        }
        @media print{
            .noprint{
                display: none;
            }
        }
    </style>
    <body>
        <div class="noprint">
            <!--<input--> 
        </div>
        <div class="marTop">
            
        </div>
    <!--<center>-->
        <%
    Session sess=sessionMan.SessionFact.getSessionFact().openSession();
    Admins role=(Admins)session.getAttribute("role");
    String p=request.getParameter("p"),iD=request.getParameter("iD"),fD=request.getParameter("fD"),br=request.getParameter("br");
    List<Manufactured> mans =sess.createQuery("from Manufactured where pr.reqId=:pr").setParameter("pr", new Long(p)).list();
    %>
        <%
              int PC=0,tP=mans.size(),cP=0;
                    boolean Quad=false,cD=false;
                    for(Manufactured m:mans){
//                        if(info.getCategories().contains("PULLNDRY")){
                            PC++;
                            cP++;
                            if(PC==1){
                                Quad=true;
                            }else{
                             Quad=false;   
                            }
                            if(PC==4||cP==tP){
                                cD=true;
                                PC=0;
                            }else{
                             cD=false;   
                            }
                        if(Quad){
        %>
        <div class="barCodeRow"><%}%>
            <div class="barcode">
                <center>
                <img  src="<%=m.getBar()%>.jpg" class="bImg" />
                <p class="bText">MRP: &#8377;<%=((int)m.getpCat().getMRP())%>/-<%=m.getBar()+ m.getpCat().getFPName()%></p></center>
            </div>
            <%if(cD){%>
        </div>
        <%}}%>
    <!--</center>-->
    </body>
</html>