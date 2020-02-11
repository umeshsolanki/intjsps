<%-- 
    Document   : GenQRCODE
    Created on : 14 Mar, 2018, 12:36:12 PM
    Author     : UMESH-ADMIN
--%>

<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="com.google.zxing.client.j2se.MatrixToImageWriter"%>
<%@page import="com.google.zxing.common.BitMatrix"%>
<%@page import="com.google.zxing.BarcodeFormat"%>
<%@page import="com.google.zxing.qrcode.QRCodeWriter"%>
<%@page import="com.google.zxing.qrcode.encoder.QRCode"%>
<%@page contentType="image/png" pageEncoding="UTF-8"%>
        <%
            
            String d=request.getParameter("d");
            QRCodeWriter  wr=new QRCodeWriter();
            BitMatrix bm=wr.encode(d, BarcodeFormat.QR_CODE, 300, 300);
            BufferedImage bi=MatrixToImageWriter.toBufferedImage(bm);
            ImageIO.write(bi, "png", response.getOutputStream());
            
        %>