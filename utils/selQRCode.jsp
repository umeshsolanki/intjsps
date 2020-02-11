<%-- 
    Document   : GenQRCODE
    Created on : 14 Mar, 2018, 12:36:12 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="com.google.zxing.EncodeHintType"%>
<%@page import="com.google.zxing.oned.Code128Writer"%>
<%@page import="com.google.zxing.pdf417.encoder.BarcodeMatrix"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="com.google.zxing.client.j2se.MatrixToImageWriter"%>
<%@page import="com.google.zxing.common.BitMatrix"%>
<%@page import="com.google.zxing.BarcodeFormat"%>
<%@page import="com.google.zxing.qrcode.QRCodeWriter"%>
<%@page import="com.google.zxing.qrcode.encoder.QRCode"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%            
            String cc=request.getParameter("cc");
            String d=request.getParameter("d");
            QRCodeWriter  wr=new QRCodeWriter();
            BitMatrix bm=null;
            if(cc==null||cc.equals("qr")){
                bm=wr.encode(d, BarcodeFormat.QR_CODE, 300, 300);
            }else{
                bm=new Code128Writer().encode(d, BarcodeFormat.CODE_128, 0, 0);
            }
            BufferedImage bi=MatrixToImageWriter.toBufferedImage(bm);
            ImageIO.write(bi, "png", response.getOutputStream());
            
%>