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
     JSONObject ob = new JSONObject();
    String grilla_html = "";
    String cabecera = "";
     try 
     {
        String desde =  request.getParameter("desde");
        String hasta =  request.getParameter("hasta");
        ResultSet rs;
        Statement st = connection.createStatement();
        float cantidad =0; 
         rs = st.executeQuery("  select *,b.descripcion as desc_estado,"
                + " case when  toneladas_proyectada='' then 'INDEFINIDO' ELSE   toneladas_proyectada end as toneladas_desc"
                + " from mae_bal_mtp_cab_solicitud a inner join mae_bal_estados b on a.estado=b.id  where CONVERT(DATE,FECHA_REGISTRO) BETWEEN CONVERT(DATE,'"+desde+"')  AND  CONVERT(DATE,'"+hasta+"')   ");
         
         

        cabecera = " <table id='tb_formulacion' class=' table-bordered compact' style='width:100%'>"
                + "<thead>"
                + "<tr>"
                 + "   <th>Nro.</th>"
                   + " <th>Fecha de registro</th>"
                   + " <th>Solicitud modificacion</th>"
                   + " <th>Formula</th>"
                   + " <th>Recomendado por</th>"
                   + " <th>Motivo</th>"
                   + " <th>Usuario</th>"
                   + " <th>Toneladas</th>"
                   + " <th>Estado</th>"
                   + " <th>Verificación</th>"
                   + " <th> </th>"
                   + " <th> </th>"
                + "</tr>"
             
                + " </thead> "
                + " <tbody >";
        while (rs.next()) 
        {
            grilla_html = grilla_html
                    + "<tr > "
                    + "<tr>"
                    +"<td class='colorear' id='"+rs.getString("id")+"'>"+rs.getString("id")+"</td>" 
                    +"<td>"+rs.getString("fecha_registro")+"</td>" 
                    +"<td>"+rs.getString("fecha_modificacion")+"</td>" 
                    +"<td>"+rs.getString("formula")+"</td>" 
                    +"<td>"+rs.getString("recomendado")+"</td>" 
                    +"<td>"+rs.getString("motivo")+"</td>" 
                    +"<td>"+rs.getString("usuario")+"</td>" 
                    +"<td>"+rs.getString("toneladas_desc")+"</td>" 
                    +"<td>"+rs.getString("desc_estado")+"</td>" 
                    +"<td>"+rs.getString("revision")+"</td>" 
                    +"<td>"
                    + "<form action=\"cruds/balanceado/control_reporte_pedidos_bal.jsp\" target=\"blank\"><input type=\"submit\" value=\"Reporte\" class=\"bg-warning\"> <input type=\"hidden\" id=\"id\" name=\"id\" value=\""+rs.getString("id")+"\"></form>  </td>"               
                     + "<td><input type=\"button\" value=\"Detalle\" class=\"bg-navy\" onclick=\"modal_detalle_formulacion_bal("+rs.getString("id")+",'"+rs.getString("cod_formula")+"','"+rs.getString("formula")+"')\"></td>"
                    + "</tr>";
                    
                    
                     
          
        } 
         
         ob.put("grilla",cabecera + grilla_html + "</tbody></table>" );
         
        rs.close();
    } catch (Exception e) {
        ob.put("grilla", e.toString());  
    } finally {
        connection.close();
        out.print(ob ); 
    }


%>


 