<%-- 
    Document   : crud_agregar_modulos
    Created on : 14/12/2021, 11:20:03
    Author     : csanchez
--%>

<%@page contentType="application/json; charset=utf-8"%> "%>
<%@include file="../cruds/conexion.jsp" %>
<%@include  file="../chequearsesion.jsp" %>
<%    JSONObject obje = new JSONObject();
    obje = new JSONObject();

     String select_rol;
    String id = "";
    String descri_rol = request.getParameter("descri_rol");
     String descri_modulo = request.getParameter("descri_modulo");
    select_rol = request.getParameter("data.select[c]");
    String[] array_modulo = request.getParameterValues("permisos");
    String mensaje = "";
    String tipo_mensaje = "";
     int i = 0;

    try { 
        CallableStatement call2;
        call2 = connection.prepareCall("exec [stp_mae_yemsys_insert_permisos_estado] @idrol='" + select_rol + "'");
        call2.execute();

         CallableStatement call;
        for (i = 0; i < array_modulo.length;)//mientras que i sea menor que grilla_array 
        {
            id = array_modulo[i];
            call = connection.prepareCall("{call [stp_mae_yemsys_insert_permisos](?,?,?,?)}");
            call.setString(1, select_rol);
            call.setString(2, id);
            call.registerOutParameter(3, java.sql.Types.VARCHAR);
            call.registerOutParameter(4, java.sql.Types.VARCHAR);
            call.execute();
            tipo_mensaje = call.getString(3);
            mensaje = call.getString(4);

            i++;
        }
    } catch (Exception ex) {
    } finally {
        connection.close();
        obje.put("mensaje", mensaje);
        obje.put("tipo_mensaje", tipo_mensaje);
        out.print(obje);
    }
%>

