<%@page import="java.sql.ResultSet"%>
<%@include  file="../../../versiones.jsp" %>
<%@include  file="../../../chequearsesion.jsp" %>
<%@include  file="../../../cruds/conexion.jsp" %>
<%@page import="org.json.JSONObject"%>
<%@ page contentType="application/json; charset=utf-8" %>
<%    
    JSONObject ob = new JSONObject();
    String grilla_html = "";
    String cabecera = "";
     try 
     {
        String fecha = request.getParameter("fecha");

        ResultSet rs;
        Statement st = connection.createStatement(); 
        rs = st.executeQuery("select * from v_vim_desechos_averiados where  CONVERT(VARCHAR(10), fecha, 103) = '"+fecha+"'");
         

        cabecera = " <table id='tb_informe_desechos' class='display'>"
                + "<thead>"
                + "<tr>"
                 + " <th>Doc Num</th>"
                 + " <th>Cantidad</th>"
                 + " <th>Fecha</th>"
                 + " <th>Descripción</th>"
                 + " <th>Comentarios</th>"
                 + " <th>Gramos Ingresados</th>"
                + "</tr>"
             
                + " </thead> "
                + " <tbody >";
        while (rs.next()) 
        {
            grilla_html = grilla_html
                    + "<tr >"
                    +"<td>"+rs.getString("DocNum")+"</td>" 
                    +"<td>"+rs.getString("cantidad")+"</td>" 
                    +"<td>"+rs.getString("fecha")+"</td>" 
                    +"<td>"+rs.getString("Dscription")+"</td>" 
                    +"<td>"+rs.getString("comments")+"</td>" 
                    +"<td>"+rs.getString("gramos_ingresados")+"</td>" 
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


 