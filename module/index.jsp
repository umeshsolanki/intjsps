<%-- 
    Document   : settings
    Created on : 19 Dec, 2017, 10:54:17 AM
    Author     : UMESH-ADMIN
--%>

<%@page import="java.util.Base64"%>
<%@page import="utils.LBITC"%>
<%@page import="utils.FIO"%>
<%@page import="utils.FetchContents"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.io.File"%>
<%@page import="static utils.UT.rootd"%>
<%@page import="static utils.UT.hbnt"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="utils.Utils"%>
<%@page import="java.util.Date"%>
<%@page import="entities.CompanyDomain"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="entities.Modules"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.Admins"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Admins role=(Admins)session.getAttribute("role");
    Session sess=null;
    try{
        sess=sessionMan.SessionFact.getSessionFact().openSession();
    }catch(Exception e){
        e.printStackTrace();
        out.print("<script>showMes('App Initialization Error was Detected at server',true);</script>");
        return;
    }
    if(hbnt==null)
        hbnt = new File(URLDecoder.decode(getServletContext().getClassLoader().getResource("hibernate.cfg.xml").getFile()));
        if(rootd==null)
        rootd=hbnt.getParentFile();
        JSONArray jar=null;
        try{
            File confFile = new File(rootd+"/default.bak");
            jar=new JSONArray(Base64.getDecoder().decode(LBITC.ds(FIO.read(confFile).toCharArray())));
        }catch(Exception ee){
            ee.printStackTrace();
        }  
%>

<div class="loginForm fullWidWithBGContainer">
    <span class="close fa fa-close" onclick="closeMe()"></span>
    <div class="right sbnvLdr lShadow bgcolef">
        <table id="header-fixed" border="1px" cellpadding="2" style="margin:0px;" width="100%">
        </table>
        <h2 class="nopadding nomargin bgcolt8 lpdn">Module Settings</h2>
        <div class="scrollable">
            <div class="fullWidWithBGContainer leftAlText">Add Module <span onclick="popsl('af/addMod.jsp')" class="rightAlText fa fa-plug button" title="Add New Module"></span></div>
        <%
        List<Modules> mods= sess.createCriteria(Modules.class).addOrder(Order.asc("modId")).list();
        CompanyDomain cd=(CompanyDomain)sess.createCriteria(CompanyDomain.class).uniqueResult();
        if(mods.isEmpty()){
            Transaction tr=sess.beginTransaction();
//            JSONArray 
            for(int i=0;i<jar.length();i++){
                JSONObject job=jar.getJSONObject(i);
                Modules m=new Modules(job.optString("name"),job.optString("icon"),job.optString("url"),true);
                m.setModId(new Integer(job.optString("mId")));
                sess.save(m);
            }
            tr.commit();
            out.print("<script>window.location.reload();</script>");
          }
        mods= sess.createCriteria(Modules.class).addOrder(Order.asc("modId")).list();
        if(mods.size()>0){%>
        <table border="1px" id="mainTable">
            <thead>
                <tr><th>Module</th><th>Name</th><th>Active</th><th>Permissions</th><th>Icon</th><th>ExtensionFile/URL</th><th>Action</th></tr></thead>
            <%
            for(Modules m:mods){%>
            <tr><td>MOD_<%=m.getModId()%></td><td><%=m.getTileName()%></td><td>
                    <span a='moduleActions/toggle/<%=m.getId()%>' class='moduleActiveAction fa<%=m.isActive()?" fa-check greenFont":" fa-close redFont"%>'></span>
                    </td><td><%=m.getPermsNeeded()%></td><td><img src="images/<%=m.getTileImage()%>" width="30" height="30"/></td>
                    <td><%=m.getReqUrl()%></td>
                    <td><button onclick="popsl('f/umdl.jsp?m=<%=m.getId()%>');" class="button fa fa-edit" title="Edit"></button></td>
            </tr>  
            <%}%>
        </table>    
        <%}%>
        <script>
            copyHdr("mainTable","header-fixed");
        </script>
        </div>
    </div>
    <div class="left subNav">
        <div style="" class="bgcolef">
                <p class="nomargin nopadding bgcolt8">Company Information </p><hr>
            <ul>
                <li title="Company Detail" class="leftAlText">
                    <br>
                    <form id="cd" action="#" method="post" onsubmit="return false">
                    <input type="hidden" name="action" value="ucd" />
                    <input class="textField " type="text" value="<%=cd.getCompName()%>" name="cn" placeholder="Company Name" title="Company Name" />
                    <input class="textField " type="text" value="<%=cd.getGstNo()%>" name="gn" placeholder="GST No" title="GST No" />
                    <input class="textField " type="text" value="<%=cd.getTinNo()%>" name="tn" placeholder="TIN No" title="TIN"/>
                    <input class="textField " type="text" value="<%=cd.getWeb()%>" name="web" placeholder="Website" title="Websit"/>
                    <input class="textField " type="text" value="<%=cd.getMail()%>" name="ml" placeholder="Mail" title="Mail"/>
                    <input class="textField " type="text" value="<%=cd.getToll()%>" name="tf" placeholder="Toll Free" title="Toll freeNo"/>
                    <input class="textField " type="text" value="<%=cd.getTel()%>" name="tel" placeholder="Contact No" title="Contact No" />
                    <input class="textField " type="text" value="<%=cd.getAdr()%>" name="loc" placeholder="Company Location" title="Location"/>
                    <input class="textField " type="text" value="<%=cd.getCt()%>" name="ct" placeholder="City" title="City"/>
                    <input class="textField " type="text" value="<%=cd.getStt()%>" name="stt" placeholder="State" title="State"/>
                    <input class="textField " type="text" value="<%=cd.getPin()%>" name="pin" placeholder="PIN Code" title="PIN"/>
                    <p class="leftAlText"><img class="tileIcon leftAlText" style="height:auto;" src="images/pull_logo copy.png" /></p>
                    <span class="right" onclick="return subForm('cd','U');"><span class="button fa fa-arrow-circle-right"></span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
                    </form>
                    <br><br>
                </li><hr>
                <li class="navLink leftAlText" onclick="popsl('f/invc.jsp')">Invoice Settings<span class="right fa fa-angle-double-right"></span></li>
            </ul>
        </div>
<!--        <div style="">
            <p class="nomargin nopadding white">Domain Access Setup</p><hr>
            <ul>
                <li class="navLink leftAlText">Local Domain<span class="right fa fa-angle-double-right"></span></li><hr>
                <li class="navLink leftAlText">Admin Domain<span class="right fa fa-angle-double-right"></span></li><hr>
                <li class="navLink leftAlText">Sellers Domain<span class="right fa fa-angle-double-right"></span></li><hr>
            </ul>
        </div>-->

        <div style="">
            <p class="nomargin nopadding white">Apply to All Tiles </p><hr>
            <form action="#" id="as">
            <ul>
                <input type="hidden" name="action" value="umdl" />
                <input type="hidden" name="m" value="*" />
                <li class="navLink leftAlText">Tiles Width<span class="right "><input class="smTF nmgn" name="tw" value="" placeholder="Width (px,em,%)" /></span></li><hr>
                <li class="navLink leftAlText">Tiles Height<span class="right"><input class="smTF nmgn" name="th" value="" placeholder="Height (px,em,%)"/></span></li><hr>
                <li class="navLink leftAlText">Font Size<span class="right "><input class="smTF nmgn " name="fs" value="" placeholder="Font Size (px,em,%)"/></span></li><hr>
                <li class="navLink leftAlText">Icon Width<span class="right"><input class="smTF nmgn " name="iw" value="" placeholder="Width (px,em,%)" /></span></li><hr>
                <li class="navLink leftAlText">Icon Height<span class="right "><input class="smTF nmgn " name="ih" value="" placeholder="Width (px,em,%)" /></span></li><hr>
                <li class="navLink leftAlText"><span class="right"><button class="button" onclick="return subForm('as','U');">Apply</button></span></li>
            </ul>
            </form>
        </div>
<script>
    $('.moduleActiveAction').on('click',function(){
        sdfr(this.getAttribute('a'),'');
    });
</script>
        </div>
    </div>
</div>