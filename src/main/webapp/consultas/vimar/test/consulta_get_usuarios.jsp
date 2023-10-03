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
JSONObject ob = new JSONObject();
String ci_usuario = request.getParameter("numeroCedula");

String id="";
String ci="";
String nombre="";
String apellido="";
String telefono="";
String ciudad="";
String edad="";

    try {
     //   String father = request.getParameter("father");
        ResultSet rs_GM;
        Statement st = connection.createStatement();
        rs_GM = st.executeQuery( "select * from test_persona where ci="+ci_usuario+" ");

        while (rs_GM.next()) 
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
    }
%> 

