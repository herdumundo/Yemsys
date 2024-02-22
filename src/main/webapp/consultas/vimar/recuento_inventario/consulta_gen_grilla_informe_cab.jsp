<%@page import="java.text.DecimalFormat"%>
<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../../chequearsesion.jsp" %>
<%@include  file="../../../cruds/conexion.jsp" %> 
<%    
    JSONObject ob = new JSONObject();
    String grilla_html = "";
    String cabecera = "";
     try 
     {
        String fecha = request.getParameter("fecha");

        ResultSet rs;
        Statement st = connection.createStatement(); 
        rs = st.executeQuery(" 	select T1.id,FORMAT(T1.HORAINICIO, 'HH:mm') AS horaInicio, FORMAT(t1.horaFin, 'HH:mm') AS horaFin,t2.nombre "
        + " from vim_recuento_inventario_cab  T1 inner join USUARIOS T2 ON T1.idUsuario=T2.cod_usuario   where convert(date,t1.horaInicio)='"+fecha+"'");
         

        cabecera = " <table id='tb_grilla_cab' class='table table-bordered table-striped' style='width:100%'>"
                + "<thead>"
                + "<tr>"
                 + " <th></th>"
                 + " <th>Nro</th>"
                 + " <th>Hora de inicio</th>"
                 + " <th>Hora fin</th>"
                 + " <th>Usuario</th>"
                 
                + "</tr>"
             
                + " </thead> "
                + " <tbody >";
        while (rs.next()) 
        {
            grilla_html = grilla_html
                    + "<tr >"
                    +"<td> <input type=\"button\" value=\"Visualizar\" class=\"form-control btn btn-success\" onclick=\"generarInformeRecuentoInventarioVimarDetalle("+rs.getString("id")+")\">   </td>"
                    +"<td>"+rs.getString("id")+"</td>" 
                    +"<td>"+rs.getString("horaInicio")+"</td>" 
                    +"<td>"+rs.getString("horaFin")+"</td>" 
                    +"<td>"+rs.getString("nombre")+"</td>" 
                    + "</tr>";            
        } 
         
         ob.put("grilla",cabecera + grilla_html + "</tbody></table>"    );
         
        rs.close();
    } catch (Exception e) {
        ob.put("grilla", e.toString());  
    } finally {
        connection.close();
        out.print(ob ); 
    }
%>


 