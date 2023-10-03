<%@page import="java.text.DecimalFormat"%>
<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 

<%
   JSONObject responseJSON = new JSONObject();
   String tr_html = "";
   
    try{
        ResultSet rs;
        Statement st = connection.createStatement();
        rs = st.executeQuery("select * from vim_motivos");
        
        while (rs.next()){
            tr_html = tr_html
                    +"<tr class=\"odd\" id=\"ROW"+rs.getString("id")+"\">"
                    +"<td >"+rs.getString("id")+"</td>" 
                    +"<td >"+rs.getString("descripcion")+"</td>" 
                    +"<td >"+rs.getString("id_estado")+"</td>" 
                    +"<td >"+rs.getString("tipo")+"</td>"
                    +"<td ><div class=\"text-center\">"
                            + "<div class=\"btn bg-navy\" "
                            + "type=\"button\" value=\"Editar\" "
                            + "onclick=\"edit_motivo_modal("+rs.getString("id")+",'"+rs.getString("descripcion")+"',"+rs.getString("id_estado")+","+rs.getString("tipo")+")\">"
                                + "<i class=\"fas fa-edit\"></i></div></td>" /*agregar botón para editar valor*/
                    +"<td><button class=\"btn bg-danger\" onclick=\"deleteMotivo("+rs.getString("id")+")\" title=\"Eliminar motivo \"><i class=\"fa fa-trash-o\" aria-hidden=\"true\"></i></button></td>" /*agregar botón para eliminar grilla*/

                    + "</tr>";
        }
        responseJSON.put("grilla", tr_html);
        
        rs.close();
        
    }catch (SQLException e){
        responseJSON.put("grilla",e.toString());
    }finally{
        connection.close();
        out.print(responseJSON);    
    }

%>

 