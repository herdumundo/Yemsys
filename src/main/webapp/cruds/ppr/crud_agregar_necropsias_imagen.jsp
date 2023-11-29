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
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />

<%

    controles.VerificarConexion();

    fuente.setConexion(clases.controles.connectSesion);
    JSONObject obje = new JSONObject();
    obje = new JSONObject();

   // String imagen = "";
    String ave_nro_imagen;
    String avr_nro = request.getParameter("ave_nro");
    avr_nro = avr_nro;
    String nec_id;
    String file_name = null;
    String fecha_desde = request.getParameter("nec_id");
  /*  String fecha_hasta = request.getParameter("ave_nro_imagen");
    String fecha_hastas = request.getParameter("file");
    String[] array_categoria = request.getParameterValues("file");*/
   // fecha_desde = fecha_desde;

    String mensaje = "";
    String tipo_registro = "";

   // String contentType = request.getContentType();

    boolean isMultipartContent = ServletFileUpload.isMultipartContent(request);
    if (!isMultipartContent) {
        return;
    }
    FileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);
    try {

        List< FileItem> fields = upload.parseRequest(request);

        Iterator< FileItem> it = fields.iterator();

        if (!it.hasNext()) {
            return;
        }

        while (it.hasNext()) {

            FileItem fileItem = it.next();
            FileItem id_necro = it.next();
            FileItem ave_nro = it.next();
            ave_nro_imagen = ave_nro.getFieldName();
            nec_id = id_necro.getFieldName();

            boolean isFormField = fileItem.isFormField();

            if (fileItem.getFieldName().equals("file")) {
                file_name = fileItem.getString();

            }

            if (isFormField) {

            } else {

                if (fileItem.getSize() > 0) {
                    String nombre = fileItem.getName();
                    clases.controles.connectSesion.setAutoCommit(false);
                    CallableStatement call;

                    call = clases.controles.connectSesion.prepareCall("{call [stp_mae_ppr_insert_necropsias_imagen] (?,?,?,?,?,?)}");
                    // values(@necro_id,@ave,@nombre_imagen,@type);
                    call.setString(1, nec_id);
                    call.setString(2, ave_nro_imagen);
                    call.setString(3, "ppr-" + nec_id + "-" + ave_nro_imagen + "-" + nombre);
                    call.setString(4, "jpg");
                    call.registerOutParameter(5, java.sql.Types.VARCHAR);
                    call.registerOutParameter(6, java.sql.Types.VARCHAR);
                    call.execute();
                    //ppr-nec-4-1-IMG_20171109_132742_1664x1248.jpg
                    tipo_registro = call.getString(5);
                    mensaje = call.getString(6);
                    //C:\Users\aespinola\Documents\NetBeansProjects\Yemsys
                    //        File reportfile = new File(application.getRealPath("reportes/cabecera_lotes.jasper"));

                 //   fileItem.write(new File("necropsias_imagen//" + "ppr-" + nec_id + "-" + ave_nro_imagen + "-" + nombre));
                    fileItem.write(new File( application.getRealPath("necropsias_imagen/"+ "ppr-" + nec_id + "-" + ave_nro_imagen + "-" + nombre)));
                   
                    
                    if (tipo_registro == "1") {
                        clases.controles.connectSesion.rollback();

                    } else {
                        //clases.controles.connectSesion.rollback(); 
                        clases.controles.connectSesion.commit();

                    }
                }

            }

        }

    } catch (Exception ex) {

    } finally {

        obje.put("mensaje", mensaje);
        obje.put("tipo_registro", tipo_registro);
        out.print(obje);
        clases.controles.connectSesion.close();
    }


%>


