<%-- 
    Document   : conusulta_bal_encolamientoMTP
    Created on : 05-may-2023, 8:07:12
    Author     : jalvarez
--%>
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
    // Llamada al procedimiento almacenado antes de la consulta a la vista
    try {
        String father =  request.getParameter("father");
        CallableStatement cs = connection.prepareCall("{call sp_mae_bal_mtp_encolamiento(?)}");
        cs.setString(1, father);
        cs.execute();
    } catch (SQLException ex) {
        // Manejar la excepción, por ejemplo, mostrar un mensaje de error.
        out.print("Error al ejecutar el procedimiento almacenado: " + ex.getMessage());
    } 
    JSONObject ob = new JSONObject();
    String grilla_html = "";
  
    String cabecera = "";
    ResultSet rs_GM;
        Statement st = connection.createStatement();
     try 
     {
        String father =  request.getParameter("father");

            rs_GM = st.executeQuery("SELECT  * from v_mae_bal_mtp_encolamiento  where cod_formula='"+ father +"' OR COD_FORMULA IS NULL");

        cabecera = " <table id='tb_formulacion' class=' table-bordered compact display' style='width:100%'>"
                + "<thead>"

                + ""
                + "<tr>"
                + " <th  style='color: #fff; background: black;' >CODIGO</th>      "
                + " <th  style='color: #fff; background: black;' >INGREDIENTE</th>      "
                + " <th  style='color: #fff; background: black;' >ESTADO</th>      " 
                + " <th  style='color: #fff; background: black;' >ESTADO PREDETERMINADO</th>      " 
                + " </thead> "
                + " <tbody >";
        while (rs_GM.next()) 
        {
             String estado = rs_GM.getString("estado");
             String estadoPred = rs_GM.getString("estadopredeterminado");
             String colorBoton="bg-danger";
             String valorBoton ="DESBLOQUEAR";
             String colorBotonPred="bg-danger";
             String valorBotonPred ="DESBLOQUEAR";
              
             if (estado.equals("BLOQUEAR")){
                colorBoton="bg-success";
                valorBoton = "BLOQUEAR";
                }
             if (estadoPred.equals("BLOQUEAR")){
                colorBotonPred="bg-success";
                valorBotonPred = "BLOQUEAR";
                }
            grilla_html = grilla_html
                    + "<tr > "
                    + "<td style=\"font-weight:bold\" >   " + rs_GM.getString("ItemCode") + "</td>"
                    + "<td style=\"font-weight:bold\">   " + rs_GM.getString("ItemName") + "</td>"
                    +"<td class='text-center'> "
                        + "<input id=\"BTN"+rs_GM.getString("ItemCode")+"\" type=\"button\" value=\""+valorBoton+"\" class=\""+colorBoton +"\" " 
                        + "onclick=\"activa_desactivar_encolamientoMTP('"+rs_GM.getString("ItemCode")+"',1)\">"
                    + "</td>"
                    +"<td class='text-center'> "
                        + "<input id=\"BTNEP"+rs_GM.getString("ItemCode")+"\" type=\"button\" value=\""+valorBotonPred+"\" class=\""+colorBotonPred +"\" " 
                        + "onclick=\"activa_desactivar_encolamientoMTPEstPre('"+rs_GM.getString("ItemCode")+"',1)\">"
                    + "</td>"
                    + "</tr>";
         }
         
        
        ob.put("grillaEncolamiento",cabecera + grilla_html + "</tbody></table>" );
        
    
        
        rs_GM.close();
    } catch (Exception e) {
        ob.put("grilla", e.toString());  
    } finally {
        connection.close();
        out.print(ob ); 
    }


%>