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
        String fecha = request.getParameter("fecha");
        ResultSet rs_GM;
    DecimalFormat formatea = new DecimalFormat("###,###.##");
        Statement st = connection.createStatement();
        rs_GM = st.executeQuery("			 select *,convert(varchar,fecha_entrada,103) as entrada_form,convert(varchar,fecha_salida,103) as salida_form "
                + "from v_mae_ppr_lotes_ventas	where fecha='"+fecha+"' ORDER BY fecha_entrada ASC");
        
        String cabecera = "   "
                + "<table id='tb_preembarque' class=' table-bordered compact hover dataTable  ' style='width:100%'>"
                + "<thead>" 
                + " <tr>"
                + " <th  style='color: #fff; background: black;'>Id lote</th>     "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Lote  </th>       "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Aves  </th>       "
                + " <th  style='color: #fff; background: black;' >Entrada</th> "
                + " <th  style='color: #fff; background: black;'>Salida</th> "
                + "</tr>"
                + "</thead> <tbody >";
        
        String tr = "   ";
        
        while (rs_GM.next()) 
        {
            tr = tr
            + "<tr > "
            + "<tr>"
            +"<td>"+rs_GM.getString("id")+"</td>" 
            +"<td>"+rs_GM.getString("aviario")+"</td>" 
            +"<td>"+formatea.format(rs_GM.getInt("cantidad_aves"))+"</td>" 
            +"<td>"+rs_GM.getString("entrada_form")+"</td>" 
            +"<td>"+rs_GM.getString("salida_form")+"</td>" 
            + "</tr>";
        }
    
        ob.put("grilla", cabecera + tr + "</tbody></table>");
        
        rs_GM.close();
    } catch (Exception e) 
    {
        ob.put("grilla", e.getMessage());
    } finally {
        connection.close();
        out.print(ob);
    }
%> 

