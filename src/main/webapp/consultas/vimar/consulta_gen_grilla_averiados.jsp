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
        String fecha = request.getParameter("fecha");

        ResultSet rs;
        Statement st = connection.createStatement(); 
        rs = st.executeQuery("select  a.docentry as codigo, a.DocNum, a.DocDate,"
                + " f.slpname, REPLACE(STR(DocTime / 100, 2), SPACE(1), '0') + ':' + REPLACE(STR(DocTime - DocTime/ 100 * 100, 2), SPACE(1), '0') AS hora_transferencia, "
                + " b.WhsName as Origen,"
                + " b.WhsName as Destino, "
                + " a.cardcode,a.cardname, ISNULL(a.cardname, '') + '-' + isnull(a.Comments, '') as cliente,d.WhsName as linea_destino "
                + " from vimar.dbo.owtr a inner join vimar.dbo.OWHS b on a.Filler = b.WhsCode "
                + " inner join vimar.dbo.OWHS d on B.WhsCode = d.WhsCode "
                + " left outer join vimar.dbo.OSLP f on a.SlpCode = f.SlpCode "
                + " where  CONVERT(VARCHAR(10), a.DocDate, 103) = '"+fecha+"'  and B.whscode in('CEN007','AVE001','AVE002')");
         

        cabecera = " <table id='tb_informe_averiados' class='table table-bordered table-striped' style='width:100%'>"
                + "<thead>"
                + "<tr>"
                 + " <th>Generar PDF</th>"
                 + " <th>Responsable</th>"
                 + " <th>Hora transferencia</th>"
                 + " <th>Origen</th>"
                 + " <th>Destino</th>"
                + "</tr>"
             
                + " </thead> "
                + " <tbody >";
        while (rs.next()) 
        {
            grilla_html = grilla_html
                    + "<tr >"
                    +"<td><form action=\"cruds/vimar/control_reporte_averiados.jsp\" target=\"blank\">"
                    + "<input type=\"submit\" value=\"Reporte\" class=\"btn btn-success\"> "
                    + "<input type=\"hidden\" id=\"codigo\" name=\"codigo\" value=\""+rs.getString("codigo")+"\"></form>  </td>"
                    +"<td>"+rs.getString("slpname")+"</td>" 
                    +"<td>"+rs.getString("hora_transferencia")+"</td>" 
                    +"<td>"+rs.getString("Origen")+"</td>" 
                    +"<td>"+rs.getString("Destino")+"</td>" 
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


 