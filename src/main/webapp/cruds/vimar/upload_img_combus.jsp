<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="javax.swing.ImageIcon"%>
<%@page import="javafx.scene.transform.Scale"%>
<%@page import="com.lowagie.text.pdf.ByteBuffer"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="clases.controles"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.Statement"%>
<%@page import ="java.sql.Connection"%>
<%@page import ="java.sql.SQLException"%>
<%@page import ="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
 
<%
    // Directorio de destino dentro del proyecto

    // Guardar el archivo en el directorio de destino
     
    try {
        
     ServletFileUpload.isMultipartContent(request);
   /* if (!isMultipartContent) {
        return;
    }*/
     
     } catch (Exception e) {
//        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//        return;
        out.print(e.toString());
    }


%>
