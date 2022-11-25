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
        ResultSet rs_GM,rs2,rs3; 
        DecimalFormat formatea = new DecimalFormat("###,###.##");
        Statement st = connection.createStatement();
        Statement st2 = connection.createStatement();
        Statement st3 = connection.createStatement();
        rs_GM = st.executeQuery("			 "
                + " select "
                + "     *,convert(varchar,fecha_entrada,103) as entrada_form,convert(varchar,fecha_salida,103) as salida_form "
                + " from "
                + "     v_mae_ppr_lotes_ventas	"
                + " where "
                + "     fecha='"+fecha+"' ORDER BY fecha_entrada ASC    ");
       
            
        
          rs3 = st3.executeQuery("  select  id,fecha_entrada,aviario   "
                + " from v_mae_ppr_lotes_ventas  where MONTH(fecha)=MONTH('"+fecha+"' ) "
                    + " and year(fecha)=year('"+fecha+"' ) and  fecha>='"+fecha+"' "
                    + "  and cantidad_aves>0 group by id,fecha_entrada,aviario ORDER BY fecha_entrada ASC  ");
        
          rs2 = st2.executeQuery("  "
                  + "   select "
                  + "      DATENAME(month, concat('1','/',mes,'/',anho))  as nameMes, [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31] " 
	 +"             from v_mae_ppr_saldo_aves_global " 
	+"              pivot"
                  + "   (" 
	+"                  sum(cantidad_aves) 	for dia in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31])" 
	+"              )  as t1   where anho=year('"+fecha+"') and "
                + " mes between month(dateadd(month,-1,convert(date,'"+fecha+"'))) and month(dateadd(month,1,convert(date,'"+fecha+"'))) ");
       
        
        
        
        
        String cabecera = "   "
                + "<table  class=' table-bordered compact hover dataTable  ' style='width:100%'>"
                + "<thead>" 
                + " <tr>"
                + " <th  style='color: #fff; background: black;'>Id lote</th>     "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Lote  </th>       "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Saldo Actual  </th>       "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Saldo Anterior  </th>       "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Venta  </th>       "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Mortandad  </th>       "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Dia  </th>       "
                + " <th  style='color: #fff; background: black;' >Entrada</th> "
                + " <th  style='color: #fff; background: black;'>Salida</th> "
                + "</tr>"
                + "</thead> <tbody >";
      
         
        String tr = "   ";
        String tr3 = "   ";
        String tr2 = "   ";
        String mes = "   ";
        
         while (rs3.next()) 
        {
            tr3 = tr3
             + "<tr>"
            +"<td>"+rs3.getString("id")+"</td>" 
            +"<td>"+rs3.getString("fecha_entrada")+"</td>" 
            +"<td>"+rs3.getString("aviario")+"</td>" 
           
            + "</tr>";
        }
         
        while (rs_GM.next()) 
        {
            tr = tr
             + "<tr>"
            +"<td>"+rs_GM.getString("id")+"</td>" 
            +"<td>"+rs_GM.getString("aviario")+"</td>" 
            +"<td>"+formatea.format(rs_GM.getInt("cantidad_aves"))+"</td>" 
            +"<td>"+formatea.format(rs_GM.getInt("saldo_anterior"))+"</td>" 
            +"<td>"+formatea.format(rs_GM.getInt("venta"))+"</td>" 
            +"<td>"+formatea.format(rs_GM.getInt("mortandad_anterior"))+"</td>" 
            +"<td>"+rs_GM.getString("dias")+"</td>" 
            +"<td>"+rs_GM.getString("entrada_form")+"</td>" 
            +"<td>"+rs_GM.getString("salida_form")+"</td>" 
            + "</tr>";
        }
        
        
        while (rs2.next()) 
        {
            tr2 = tr2
            + "<tr>"
            +"<td  style='color: black; background: gray;font-weight:bold' >"+rs2.getString("nameMes")+"</td>";
                for(int i=1;i<=31; )
                { 
                    
                    if(rs2.getInt(String.valueOf(i))>=120000)
                    {
                        tr2=tr2+"<td><span class='badge badge-danger right '>"+formatea.format(rs2.getInt(String.valueOf(i)))+"</span> </td>" ;  
                    }
                    else if(rs2.getInt(String.valueOf(i))>=90000)
                    {
                        tr2=tr2+"<td><span class='badge badge-warning right '>"+formatea.format(rs2.getInt(String.valueOf(i)))+"</span> </td>" ;  
                    }
                    else
                    {
                        tr2=tr2+"<td>"+formatea.format(rs2.getInt(String.valueOf(i)))+"</td>" ;  
                    }
                    i++;
                }  
           
            tr2=tr2+ "</tr>";
            mes=rs2.getString("nameMes");
        }
        
        
        
        
        
           String cabecera3 = "   "
                + "<table  class=' table-bordered   hover dataTable  '  >"
                + "<thead>" 
                + " <tr><tr><th colspan='3'  style='color: #fff; background: #0B1D52;'>Lotes mes "+mes+"</th> </tr>"
                   + " <tr>"
                + " <th  style='color: #fff; background: black;'>Id lote</th>     "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Fecha entrada  </th>       "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Lote  </th>       " 
                + "</tr>"
                + "</thead> <tbody >";
        
        
         String cabecera2 = "   "
                + "<table class=' tabla tabla-con-borde table-striped table-condensed compact hover dataTable  '  >"
                + "<thead>" 
                + " <th  style='color: #fff; background: black;' >Mes</th>     "
                + " <th class='text-center' >1</th>     "
                + " <th class='text-center' >2</th>     "
                + " <th class='text-center' >3</th>     "
                + " <th class='text-center' >4</th>     "
                + " <th class='text-center' >5</th>     "
                + " <th class='text-center' >6</th>     "
                + " <th class='text-center' >7</th>     "
                + " <th class='text-center' >8</th>     "
                + " <th class='text-center' >9</th>     "
                + " <th class='text-center' >10</th>     "
                + " <th class='text-center' >11</th>     "
                + " <th class='text-center' >12</th>     "
                + " <th class='text-center' >13</th>     "
                + " <th class='text-center' >14</th>     "
                + " <th class='text-center' >15</th>     "
                + " <th class='text-center' >16</th>     "
                + " <th class='text-center' >17</th>     "
                + " <th class='text-center' >18</th>     "
                + " <th class='text-center' >19</th>     "
                + " <th class='text-center' >20</th>     "
                + " <th class='text-center' >21</th>     "
                + " <th class='text-center' >22</th>     "
                + " <th class='text-center' >23</th>     "
                + " <th class='text-center' >24</th>     "
                + " <th class='text-center' >25</th>     "
                + " <th class='text-center' >26</th>     "
                + " <th class='text-center' >27</th>     "
                + " <th class='text-center' >28</th>     "
                + " <th class='text-center' >29</th>     "
                + " <th class='text-center' >30</th>     "
                + " <th class='text-center' >31</th>     "
               
                + "</tr>"
                + "</thead> <tbody >";
        
         
    
    
        ob.put("grilla", cabecera + tr + "</tbody></table>");
        ob.put("grilla2", cabecera2 + tr2 + "</tbody></table>");
        ob.put("grilla3", cabecera3 + tr3 + "</tbody></table>");
        
        rs_GM.close();
    } catch (Exception e) 
    {
        ob.put("grilla", e.getMessage());
    } finally {
        connection.close();
        out.print(ob);
    }
%> 

