<%@page import="java.text.DecimalFormat"%>
<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%    JSONObject ob = new JSONObject();
     try {
       
         ResultSet rs ; 
         Statement st = connection.createStatement();
          
        rs = st.executeQuery("			 "
                + " select "
                + "     * "
                + " from "
                + "     ppr_pry_capacidad_predescarte	   ");
        String tr = "   ";
         
         while (rs.next()) 
        {
            tr = tr
            + " <tr>"
            +"      <td>"+rs.getString("id")           +"</td>" 
            +"      <td>"+rs.getString("mes")+"</td>" 
            +"      <td><input class='celda_editable' id=\"cap"+rs.getString("id")+"\" type='number' value='"+rs.getString("capacidad")      +"' onchange=\"crud_grilla_capacidad_pry_predescarte_ppr("+rs.getString("id") +" ,$('#cap"+rs.getString("id")+"').val() )\"></td>" 
            +"  </tr>";
        }
         
         
        
        String cabecera  = "   "
                + "<table  class=' tabla tabla-con-borde table-striped table-condensed compact hover dataTable  '  >"
                + "<thead>"
                + "<tr>" 
                + " <th  style='color: #fff; background: black;'>Id</th>     "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Mes  </th>       "
                + " <th   style='color: #fff; background: black;font-weight:bold' >  Capacidad  </th>       " 
                + "</tr>"
                + "</thead> <tbody >";
         
         
    
    
        ob.put("grilla", cabecera + tr + "</tbody></table>");
         
     } catch (Exception e) 
    {
        ob.put("grilla", e.getMessage());
    } finally {
        connection.close();
        out.print(ob);
    }
%> 

