<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@page language="java" import="java.sql.*" errorPage="error.jsp" %>
 <%@include  file="../../cruds/conexion.jsp" %> 
<%    
JSONObject responseJSON =   new JSONObject();
String ci_usuario       =   request.getParameter("numeroCedula");
String nombre_usuario   =   request.getParameter("nombreUsuario");
String apellido_usuario =   request.getParameter("apellidoUsuario");
String telefono_usuario =   request.getParameter("telefonoUsuario");
String ciudad_usuario   =   request.getParameter("ciudadUsuario");
String edad_usuario     =   request.getParameter("edadUsuario");

    
    try {
        //ResultSet rs_GM;
        //Statement st = connection.createStatement();
        //rs_GM = st.executeQuery( "select * from test_persona where ci="+ci_usuario+" ");
            
        
        /*String query = "INSERT INTO test_persona "
                    + "(ci, nombre, apellido, telefono, ciudad, edad)"  + 
                    "VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(query); 
            preparedStatement.setString(1, ci_usuario);
            preparedStatement.setString(2, nombre_usuario);
            preparedStatement.setString(3, apellido_usuario);
            preparedStatement.setString(4, telefono_usuario);
            preparedStatement.setString(5, ciudad_usuario);
            preparedStatement.setString(6, edad_usuario);

            int rowsInserted = preparedStatement.executeUpdate();
                if (rowsInserted > 0) {
                    responseJSON.put("tipo", 1);
                    responseJSON.put("msg", "Datos insertados correctamente");  // Mensaje de éxito
                } else {
                    responseJSON.put("tipo", 2);
                    responseJSON.put("msg", "Error al insertar datos");  // Mensaje de error
        

        }
        */  String call = "{call updatePersona(?, ?, ?, ?, ?, ?, ?, ?)}";
            CallableStatement callableStatement = connection.prepareCall(call);
            callableStatement.setString(1, ci_usuario);
            callableStatement.setString(2, nombre_usuario);
            callableStatement.setString(3, apellido_usuario);
            callableStatement.setString(4, telefono_usuario);
            callableStatement.setString(5, ciudad_usuario);
            callableStatement.setString(6, edad_usuario);
            callableStatement.registerOutParameter(7, Types.VARCHAR);
            callableStatement.registerOutParameter(8, Types.INTEGER);

            callableStatement.execute();  // Ejecutamos el procedimiento almacenado

            String mensaje = callableStatement.getString(7);
            int tipo = callableStatement.getInt(8);
                responseJSON.put("tipo", tipo);
                responseJSON.put("msg", mensaje);  // Mensaje de éxito
    } catch (SQLException e) {
                responseJSON.put("tipo", 2);
                responseJSON.put("msg", "Error de SQL: " + e.getMessage());  // Mensaje de error SQL
            }

            out.print(responseJSON);  // Enviamos la respuesta JSON al cliente

        /*while (rs_GM.next()) 
        {
             id=rs_GM.getString("id");
             ci=rs_GM.getString("ci");
             nombre=rs_GM.getString("nombre");
             apellido=rs_GM.getString("apellido");
             telefono=rs_GM.getString("telefono");
             ciudad=rs_GM.getString("ciudad");
             edad=rs_GM.getString("edad");
        }
                rs_GM.close();

     
        ob.put("VariableJsonId", id);
        ob.put("VariableJsonCi", ci);
        ob.put("VariableJsonNombre", nombre);
        ob.put("VariableJsonApellido", apellido);
        ob.put("VariableJsonTelefono", telefono);
        ob.put("VariableJsonCiudad", ciudad);
        ob.put("VariableJsonEdad", edad);


    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
        out.print(ob);
    }*/
%> 

