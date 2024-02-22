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
        String id = request.getParameter("id");

        ResultSet rs;
        Statement st = connection.createStatement(); 
        rs = st.executeQuery(" SELECT  [id] ,[idCab],[itemCode],[lote],[cantidad],[conteo], (conteo-cantidad )as   diferencia     "
        + "   ,[deposito]      ,[idUsuario]      ,[contado]  FROM [GrupoMaehara].[dbo].[vim_recuento_inventario_det] WHERE idCab="+id+" ");
         

        cabecera = " <table id='tb_grilla_det' class='table table-bordered table-striped' style='width:100%'>"
                + "<thead>"
                + "<tr>"
                 + " <th>ItemCode</th>"
                 + " <th>Lote</th>"
                 + " <th>Conteo</th>"
                 + " <th>SAP</th>"
                 + " <th>Diferencia fin</th>"
                 + " <th>Deposito</th>"
                 + " <th>Contado</th>"
                + "</tr>"
             
                + " </thead> "
                + " <tbody >";
        while (rs.next()) 
        {
            String colorBadge="danger";
            String flecha="down";
            if(rs.getInt("diferencia")>0 && rs.getString("contado").equals("SI")){
                colorBadge="success";
                flecha="up";           
            }
             else if(rs.getInt("diferencia")==0 && rs.getString("contado").equals("SI")){
                colorBadge="primary";
                flecha="right";           
            }
            else if(rs.getString("contado").equals("NO")){
                colorBadge="secondary";
                }
             grilla_html = grilla_html
                    + "<tr >"
                     +"<td>"+rs.getString("itemCode")+"</td>" 
                    +"<td>"+rs.getString("lote")+"</td>" 
                    +"<td>"+rs.getString("conteo")+"</td>" 
                    +"<td>"+rs.getString("cantidad")+"</td>" 
                    
                    +"<td><h5><span class='badge badge-"+colorBadge+" right'> <i class='nav-icon fas fa-arrow-circle-"+flecha+" text-black' aria-hidden='true'>&nbsp&nbsp"+rs.getString("diferencia")+"</i></span></h5> </td> "
                    
                    +"<td>"+rs.getString("deposito")+"</td>" 
                    +"<td>"+rs.getString("contado")+"</td>" 
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


