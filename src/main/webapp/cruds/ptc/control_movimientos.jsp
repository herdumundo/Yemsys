 <%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.Types"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@ page contentType="application/json; charset=utf-8" %>

<%@include  file="../../chequearsesion.jsp" %>
<%
    clases.controles.connectarBD();  
    Connection cn = clases.controles.connect;
    fuente.setConexion(cn);   
    int res_out=4;
    String mensaje= "";
    int resultad_final=1;
    String  seleccionados  = request.getParameter("id_carro");
    String  clasificadora=(String)sesionOk.getAttribute("clasificadora");
    String  usuario=(String)sesionOk.getAttribute("usuario");
    String  nombre_usuario=(String)sesionOk.getAttribute("nombre_usuario");
    String  combo_estado  = request.getParameter("estado_requerido");
    String  disposicion= request.getParameter("disposicion");
    String  estado_liberacion_pnc= request.getParameter("estado_liberacion");
    String  fecha_alimentacion= request.getParameter("fecha_alimentacion");
    String  motivo_retencion =request.getParameter("motivo_retencion");
    String  liberado_por =request.getParameter("responsable");
    String[] elementos = seleccionados.split(",");
    String cod_lote="";
    String cod_interno="";
    String cod_lote_cod_interno="";
    String tipo_costeo="";
    String tipo_mensaje="";
    int disposicion_liberar=0;//EN EL PROCEDIMIENTO ALMACENADO DE LIBERADOS, NECESITO ENVIAR LA DIPOSICION QUE CONTIENE CADA FILA DE LOS RETENIDOS Y RETENIDOS CON REPORTE.
    try {
         
            if (combo_estado.equals("R")||combo_estado.equals("Z"))
            {
                cn.setAutoCommit(false);
                for(int i=0; i<elementos.length; i++)
                {

                    cod_lote_cod_interno=elementos[i];
                    String [] contenido_cod_lote_cod_interno=cod_lote_cod_interno.split("-");
                    cod_lote=contenido_cod_lote_cod_interno[0];
                    cod_interno=contenido_cod_lote_cod_interno[1];
                    tipo_costeo=contenido_cod_lote_cod_interno[2];

                    CallableStatement  callableStatement=null;   
                    callableStatement = cn.prepareCall("{call mae_ptc_movimiento_retenido( ?, ?, ?, ?, ? ,?,?,?,?,?,?)}");
                    callableStatement .setString(1, cod_lote);
                    callableStatement .setString(2, clasificadora);
                    callableStatement .setString(3, combo_estado);
                    callableStatement .setString(4, estado_liberacion_pnc);
                    callableStatement .setString(5, motivo_retencion);
                    callableStatement .setInt(6, Integer.parseInt(disposicion));
                    callableStatement .setString(7, cod_interno);
                    callableStatement .setString(8,nombre_usuario);
                    callableStatement .setString(9,usuario);
                    callableStatement .setString(10,tipo_costeo);

                    callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
                    callableStatement.execute();
                    res_out = callableStatement.getInt("mensaje");
                    resultad_final=resultad_final*res_out;

                }
                if (resultad_final==0)
                {
                    cn.rollback(); 
                    mensaje="HA OCURRIDO UN ERROR. VUELVA A INTENTAR";
                    tipo_mensaje="0";
                }   
                else 
                {
                    cn.commit();
                   // cn.rollback();
                    mensaje="REGISTRADO CON EXITO";
                    tipo_mensaje="1";
                }
            }

            else if (combo_estado.equals("L"))
            {
                cn.setAutoCommit(false);
                for(int i=0; i<elementos.length; i++)
                {
                    cod_lote_cod_interno=elementos[i];
                    String [] contenido_cod_lote_cod_interno=cod_lote_cod_interno.split("-");
                    cod_lote=contenido_cod_lote_cod_interno[0];
                    cod_interno=contenido_cod_lote_cod_interno[1];
                    tipo_costeo=contenido_cod_lote_cod_interno[2];
                    disposicion_liberar= Integer.parseInt(contenido_cod_lote_cod_interno[3]);

                    CallableStatement  callableStatement=null;   
                    callableStatement = cn.prepareCall("{call mae_ptc_movimiento_liberado( ?, ?, ?, ?, ?,?,?,?,?,?,?)}");
                    callableStatement .setString(1, cod_lote);
                    callableStatement .setString(2, clasificadora);
                    callableStatement .setString(3, combo_estado);
                    callableStatement .setString(4, liberado_por);
                    callableStatement .setInt(5, Integer.parseInt(cod_interno) );
                    callableStatement .setString(6,fecha_alimentacion);
                    callableStatement .setString(7,nombre_usuario);
                    callableStatement .setString(8,tipo_costeo);
                    callableStatement .setString(9,usuario);
                    callableStatement .setInt(10,disposicion_liberar);

                    callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
                    callableStatement.execute();
                    res_out = callableStatement.getInt("mensaje");
                    resultad_final=resultad_final*res_out;

                }

                if (resultad_final==0)
                {
                    cn.rollback();
                    mensaje="HA OCURRIDO UN ERROR. VUELVA A INTENTAR";
                    tipo_mensaje="0";
                }   
                else 
                {
                   //  cn.rollback();
                    cn.commit();
                    mensaje="REGISTRADO CON EXITO";
                    tipo_mensaje="1";
                }

            }
        } catch (Exception e) 
            {
                mensaje=e.toString();
                tipo_mensaje="0";
            }
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
        ob.put("tipo_mensaje", tipo_mensaje);
        ob.put("mensaje", mensaje);
        cn.close();
        controles.DesconnectarBD();
        out.print(ob);  
%>   