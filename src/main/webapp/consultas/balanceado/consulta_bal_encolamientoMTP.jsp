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
 
    JSONObject ob = new JSONObject();
    String grilla_html = "";
  
    String cabecera = "";
    ResultSet rs_GM,rs_GM2;
        Statement st = connection.createStatement();
        Statement st2 = connection.createStatement();
     try 
     {
        String father =  request.getParameter("father");

            rs_GM = st.executeQuery("SELECT  * from v_mae_bal_mtp_encolamiento where cod_formula='"+ father +"' ");

        cabecera = " <table id='tb_formulacion' class=' table-bordered compact display' style='width:100%'>"
                + "<thead>"

                + ""
                + "<tr>"
                + " <th  style='color: #fff; background: black;' >CODIGO</th>      "
                + " <th  style='color: #fff; background: black;' >INGREDIENTE</th>      "
                + " <th  style='color: #fff; background: black;' >ESTADO</th>      " 
                + " </thead> "
                + " <tbody >";
        while (rs_GM.next()) 
        {
             String estado = rs_GM.getString("estado");
             String colorBoton="bg-danger";
             String valorBoton ="DESBLOQUEAR";
              if (estado.equals("BLOQUEAR")){
                colorBoton="bg-success";
                valorBoton = "BLOQUEAR";
                }
            grilla_html = grilla_html
                    + "<tr > "
                    + "<td style=\"font-weight:bold\" >   " + rs_GM.getString("ItemCode") + "</td>"
                    + "<td style=\"font-weight:bold\">   " + rs_GM.getString("ItemName") + "</td>"
                    +"<td class='text-center'> "
                        + "<input id=\"BTN"+rs_GM.getString("ItemCode")+"\" type=\"button\" value=\""+valorBoton+"\" class=\""+colorBoton +"\" " 
                        + "onclick=\"activa_desactivar_encolamientoMTP('"+rs_GM.getString("ItemCode")+"',1)\">"
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