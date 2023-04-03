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
    DecimalFormat formatea = new DecimalFormat("###,###.##");
    DecimalFormat formatea2 = new DecimalFormat("###.###");
    JSONObject ob = new JSONObject();
    String grilla_html = "";
    String cabecera = "";
     try 
     {
        
        ResultSet rs_GM;
        Statement st = connection.createStatement();
        String cod_formula  = request.getParameter("cod_formula");
         rs_GM = st.executeQuery(""
                 + " exec mae_bal_nutrientes @cod_formula='"+cod_formula+"'  ");
                 
                 
        cabecera = " <table id='grillaNutriente' class=' table-bordered compact display' style='width:100%'>"
                + "<thead>"

                + ""
                + "<tr>"
                + " <th  style='color: #fff; background: black;' >CODIGO</th>      "
                + " <th  style='color: #fff; background: black;' >VITAMINA</th>      "
                + " <th  style='color: #fff; background: black;' >ACTUAL</th>      "
                + " <th  style='color: #fff; background: black;' >NUEVO</th>      "
                 +"</tr>"      
                + " </thead> "
                + " <tbody >";
        while (rs_GM.next()) 
        {
            grilla_html = grilla_html
                    + "<tr > "
                  
                   + "<td style=\"font-weight:bold\" >   " + rs_GM.getString("id_nutriente") + "</td>"
                   + "<td style=\"font-weight:bold\">   " + rs_GM.getString("desc_nutriente") + "</td>"
                   + "<td style=\"font-weight:bold\" >" + rs_GM.getString("nuevo") + "</td>"
                   + "<td style=\"font-weight:bold\" class='single_line' contenteditable=\"true\"> 0</td>"
                   
                    + "</tr>";
            
           
        }
         
        ob.put("grilla",cabecera + grilla_html + "</tbody></table>" );
        
        
        rs_GM.close();
    } catch (Exception e) {
        ob.put("grilla", e.toString());  
    } finally {
        connection.close();
        out.print(ob ); 
    }


%>


 