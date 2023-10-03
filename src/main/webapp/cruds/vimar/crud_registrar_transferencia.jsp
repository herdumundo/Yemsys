<%@page import="org.apache.http.client.config.RequestConfig"%>
<%@page import="org.apache.http.util.EntityUtils"%>
<%@page import="org.apache.http.HttpEntity"%>
<%@page import="org.apache.http.client.methods.HttpGet"%> 
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@page import="org.apache.http.impl.client.HttpClients"%>
<%@page import="org.apache.http.entity.StringEntity"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../chequearsesion.jsp" %>
<%@page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%
    // Se crea un objeto JSONObject para almacenar la respuesta que se envía al cliente.
    JSONObject responseJSON = new JSONObject();
    String idDocRecuperado  = "";
    String mensaje          = "";
    int code                = 0;
    int NuevoId             = 0;
    String id_usu           = (String) sesionOk.getAttribute("id_usuario");

    try {
        // Se deshabilita la autoconfirmación de transacciones en la conexión a la base de datos para permitir 
        // la gestión manual de transacciones.
        connection.setAutoCommit(false);
        
        // Se crea un objeto CallableStatement y se prepara la llamada al procedimiento almacenado 
        // stp_vim_confirmacion_transferencia con tres parámetros de salida. Luego, se registran los 
        // parámetros de salida y se ejecuta el procedimiento almacenado para cambiar el estado de "P" a "A".
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call stp_vim_confirmacion_transferencia(?, ?, ?, ?, ?, ?)}");
        callableStatement.setInt(1, 0);
        callableStatement.setInt(2, 0);
        callableStatement.setString(3, id_usu);
        callableStatement.registerOutParameter(4, Types.VARCHAR);
        callableStatement.registerOutParameter(5, Types.INTEGER);
        callableStatement.registerOutParameter(6, Types.INTEGER);

        callableStatement.execute();
        
  
        mensaje = callableStatement.getString(4);
        code = callableStatement.getInt(5);
        NuevoId = callableStatement.getInt(6);
        
        // Se realiza una solicitud HTTP a la API externa.
        String apiUrl = "http://192.168.6.162/ws/A0_prod_transferencia.aspx?idDoc=" + NuevoId;
        HttpClient httpClient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet(apiUrl);
        HttpResponse httpResponse = httpClient.execute(httpGet);
        
        // Si la respuesta de la API es exitosa (200) y el código de respuesta indica éxito (0),
        // se realiza el commit y se procede a cambiar el estado de "A" a "C".
        if (httpResponse.getStatusLine().getStatusCode() == 200 ) 
        {
            // Procesar la respuesta de la API
            HttpEntity httpEntity = httpResponse.getEntity();
            // Convertir la respuesta en una cadena JSON
            String jsonResponse = EntityUtils.toString(httpEntity);
            // Crear un objeto JSONObject a partir de la cadena JSON
            JSONObject responseJsonObj = new JSONObject(jsonResponse);
            idDocRecuperado = responseJsonObj.getString("idDoc");
            mensaje = responseJsonObj.getString("msg");
            code = responseJsonObj.getInt("code");
            
            if(code==0)
            {
                connection.commit();//CONFIRMA TRANSACCION DEL PRIMER LLAMADO AL PROCEDIMIENTO ALMACENADO
                //Y EJECUTA EL SIGUIENTE PROCEDIMIENTO ALMACENADO PARA CAMBIAR EL ESTADO A "C"
                  // Cambiar el estado de "A" a "C" en un nuevo procedimiento almacenado
                
                connection.setAutoCommit(false);
                CallableStatement callableStatementC = null;
                callableStatementC = connection.prepareCall("{call stp_vim_confirmacion_transferencia(?, ?, ?, ?, ?, ?)}");
                callableStatementC.setInt(1,1); // @tipo_entrada = 1 para cambiar a estado "C"
                callableStatementC.setInt(2, NuevoId); // @id_viejo = NuevoId
                callableStatementC.setString(3, id_usu);
                callableStatementC.registerOutParameter(4, Types.VARCHAR);
                callableStatementC.registerOutParameter(5, Types.INTEGER);
                callableStatementC.registerOutParameter(6, Types.INTEGER);
                callableStatementC.execute();          
                code = callableStatementC.getInt(5);
                connection.commit();

            }
            else
            {
                connection.rollback();
            }
         } 
        else 
        {
            connection.rollback();
            mensaje = "Error en la respuesta de la API.";
        }
    } catch (SQLException e) {
        code = 1;
        mensaje = "Error de SQL: " + e.getMessage(); 
        connection.rollback(); // Realiza un rollback en caso de excepción
    } finally {
        responseJSON.put("tipo", code);
        responseJSON.put("nuevoId", NuevoId);
        responseJSON.put("msg", mensaje + " id " + NuevoId);
 
        connection.close();
        out.print(responseJSON);
    }
%>