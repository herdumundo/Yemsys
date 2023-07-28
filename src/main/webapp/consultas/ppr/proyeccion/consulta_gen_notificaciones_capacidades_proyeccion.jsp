<%@page import="java.text.DecimalFormat"%>
<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@include  file="../../../chequearsesion.jsp" %>
<%@include  file="../../../cruds/conexion.jsp" %> 
<%    JSONObject ob = new JSONObject();
     try 
     {
        ResultSet rs_GM;
        Statement st = connection.createStatement(); 
        rs_GM = st.executeQuery("			 "
                + " select "
                + "     mes,nameMes,anho,capacidad,fecha "
                + " from         "
                + " (        "
		+ "     select   " 
		+ "         t1.cantidad_aves as aves,   "
		+ "         t2.capacidad,               "
		+ "         t1.mes,t1.anho ,            "
		+ "         DATENAME(month, concat('1','/',t1.mes,'/',t1.anho))	as nameMes,     "
		+ "         convert(date,( concat('1','/',t1.mes,'/',t1.anho)))	as fecha,       "
		+ "         case when t1.cantidad_aves >=capacidad then 'SI' ELSE 'NO' END AS band  "
		+ "     from "
		+ "         v_mae_ppr_saldo_aves_global    T1 INNER JOIN   ppr_pry_capacidad_predescarte T2 ON t1.mes=t2.id "
                + " )   T3 where band='SI'  "
                + " group by             "
		+ " mes, anho	,nameMes,   capacidad,fecha  order by anho, mes ");
       
 
        String contenido = "   "; 
        
        String cabecera= 
            "<a class=\"nav-link\" data-toggle=\"dropdown\" href=\"#\" aria-expanded=\"false\">  <i class=\"far fa-bell animacion2  \"  style=\"color:red;\" aria-hidden=\"true\"></i> "
            +"  </a>"
            +" <div class=\"dropdown-menu dropdown-menu-lg dropdown-menu-right\" style=\"left: inherit; right: 0px;\" >   "
            +"     <span class=\"dropdown-item dropdown-header bg-red\" style=\" font-weight:bold\" ><a style=\"color:white;\" >Notificaciones capacidad a exceder</a></span>   ";
           
        while (rs_GM.next())  
        {
            contenido = contenido
            + " <div class=\"dropdown-divider\"></div>"
            +"      <a  href=\"javascript:set_fecha_venta_notificacion_ppr('"+rs_GM.getString("fecha")+"');\" class=\"dropdown-item\">"
            +"          <i class=\"fas fa-envelope mr-2\" aria-hidden=\"true\"></i> "+rs_GM.getString("nameMes")+" "+rs_GM.getString("anho") 
            +"      </a> <div class=\"dropdown-divider\"></div>" ;
        } 
        
        
        
       
    
    
        ob.put("notificacion", cabecera + contenido + "</div>");
          
        rs_GM.close();
    } catch (Exception e) 
    {
        ob.put("grilla", e.getMessage());
    } finally {
        connection.close();
        out.print(ob);
    }
%> 

