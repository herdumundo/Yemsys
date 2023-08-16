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
        String      fecha   = request.getParameter("fecha");
        Statement   st      = connection.createStatement();
        Statement   st2     = connection.createStatement();
        Statement   st3     = connection.createStatement();
        Statement   st4     = connection.createStatement();
        ResultSet   rs_GM,rs2,rs3,rs4; 
        DecimalFormat formatea = new DecimalFormat("###,###.##");
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
        
        rs2 = st2.executeQuery("   select  t2.capacidad, T1.*	"
                + " from v_mae_ppr_saldo_aves_global2 T1 INNER JOIN   ppr_pry_capacidad_predescarte T2 ON t1.mes=t2.id 	"
        + "    where   fecha between dateadd(MONTH,-1, convert(date,concat('01/', format(convert(date,'"+fecha+"'),'MM/yyyy'))  ))  and  dateadd(MONTH,1, convert(date,concat('01/', format(convert(date,'"+fecha+"'),'MM/yyyy'))  )) order by anho,mes ");
       
        rs4 = st4.executeQuery("  select venta,mesname,anho from ( "
                              +"  SELECT count(venta)as cant,venta, month(fecha)as mes, DATENAME(month,fecha)as mesname, year(fecha) as anho"
                                + " FROM ppr_pry_det_carga    group by venta	,DATENAME(month,fecha),year(fecha)	,month(fecha) "
                              +"  ) t where 	cant>2	 and venta>0 order by anho,mes   ");
       
        String cabecera4 = "   "
                + "<table id='tabla_log'  class='tabla tabla-con-borde table-striped table-condensed compact hover dataTable '>"
                + "<thead>" 
                + " <tr><tr><th colspan='3'  style='color: #fff; background: #0B1D52;'>Historial de cambios de ventas</th> </tr>"
                 + " <tr>"
                + " <th  style='color: #fff; background: black;font-weight:bold'>   Venta         </th>   "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Mes            </th>   "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Año    </th>   "
                 + "</tr>"
                + "</thead> <tbody >";
      
        String cabecera = "   "
                + "<table  class='tabla tabla-con-borde table-striped table-condensed compact hover dataTable '>"
                + "<thead>" 
                + " <tr>"
                + " <th  style='color: #fff; background: black;font-weight:bold'>                   Id lote         </th>   "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Lote            </th>   "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Saldo Actual    </th>   "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Saldo Anterior  </th>   "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Venta           </th>   "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Mortandad       </th>   "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Dia             </th>   "
                + " <th  style='color: #fff; background: black;' >                  Entrada         </th>   "
                + " <th  style='color: #fff; background: black;'>                   Salida          </th>   "
                + " <th  style='color: #fff; background: black;'>                   Proyección fecha de salida </th>   "
                + " <th  style='color: #fff; background: black;'>                   Dispersión de salidas(Días) </th>   "
                + "</tr>"
                + "</thead> <tbody >";
      
         
        String tr   = " ";
        String tr3  = " ";
        String tr2  = " ";
        String tr4  = " ";
        String mes  = " ";
        
         while (rs3.next()) 
        {
            tr3 = tr3
            + " <tr>"
            +"      <td>"+rs3.getString("id")           +"</td>" 
            +"      <td>"+rs3.getString("fecha_entrada")+"</td>" 
            +"      <td>"+rs3.getString("aviario")      +"</td>" 
            +"  </tr>";
        }
         
        while (rs_GM.next()) 
        {
            tr = tr
            +"  <tr>"
            +"      <td>"+rs_GM.getString("id")                                 +"</td>" 
            +"      <td>"+rs_GM.getString("aviario")                            +"</td>" 
            +"      <td>"+formatea.format(rs_GM.getInt("cantidad_aves"))        +"</td>" 
            +"      <td>"+formatea.format(rs_GM.getInt("saldo_anterior"))       +"</td>" 
            +"      <td>"+formatea.format(rs_GM.getInt("venta"))                +"</td>" 
            +"      <td>"+formatea.format(rs_GM.getInt("mortandad_anterior"))   +"</td>" 
            +"      <td>"+rs_GM.getString("dias")                               +"</td>" 
            +"      <td>"+rs_GM.getString("entrada_form")                       +"</td>" 
            +"      <td>"+rs_GM.getString("salida_form")                        +"</td>" 
            +"      <td>"+rs_GM.getString("fechaSalidaPryFormat")                        +"</td>" 
            +"      <td>"+rs_GM.getString("diferenciaDias")                        +"</td>" 
            +"  </tr>";
        }
        String row="";
        int cont=1; 
        while (rs2.next()) 
        {   
            String tdCapacidad ="<td  style='color: white; ' > <h6><span class='badge badge-dark right '>"+formatea.format(rs2.getInt("capacidad"))+"</span></h6> </td>";
            
            row="<td  style='color: white; ' > <h6><span class='badge badge-dark right '>"+rs2.getString("nameMes") +"</span></h6> </td>"+tdCapacidad;
            if(cont==2)
            {
                row="<td  style='color: black; ' > <h6><span class='badge badge-success right '>"+rs2.getString("nameMes")+ "</span></h6> </td>"+tdCapacidad;
                 mes=rs2.getString("nameMes");
            }
            tr2 = tr2
            + "<tr>"
            +row;
                for(int i=1;i<=31; )
                { 
                    
                    if(rs2.getInt(String.valueOf(i))>=rs2.getInt("capacidad"))
                    {
                        tr2=tr2+"<td><span class='badge badge-danger right '  title='Disponibilidad: "+formatea.format((rs2.getInt("capacidad")-rs2.getInt(String.valueOf(i))))+"'>"+formatea.format(rs2.getInt(String.valueOf(i)))+"</span> </td>" ;  
                    }
                    else if(rs2.getInt(String.valueOf(i))>=(rs2.getInt("capacidad")-5000))
                    {
                        tr2=tr2+"<td><span class='badge badge-warning right ' title='Disponibilidad: "+formatea.format((rs2.getInt("capacidad")-rs2.getInt(String.valueOf(i))))+"'>"+formatea.format(rs2.getInt(String.valueOf(i)))+"</span> </td>" ;  
                    }
                    else
                    {
                        tr2=tr2+"<td>"+formatea.format(rs2.getInt(String.valueOf(i)))+"</td>" ;  
                    }
                    i++;
                }  
           
            tr2=tr2+ "</tr>";
           
            cont++;
        }
        while (rs4.next()) 
        {
            tr4 = tr4
            + " <tr>"
            +"      <td>"+formatea.format(rs4.getInt("venta"))           +"</td>" 
            +"      <td>"+rs4.getString("mesname")+"</td>" 
            +"      <td>"+rs4.getString("anho")      +"</td>" 
            +"  </tr>";
        }
        
        String cabecera3 = "   "
                + "<table  class=' tabla tabla-con-borde table-striped table-condensed compact hover dataTable  '  >"
                + "<thead>" 
                + " <tr><tr><th colspan='3'  style='color: #fff; background: #0B1D52;'>Lotes mes "+mes+"</th> </tr>"
                   + " <tr>"
                + " <th  style='color: #fff; background: black;'>Id lote</th>     "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Fecha entrada  </th>       "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Lote  </th>       " 
                + "</tr>"
                + "</thead> <tbody >";
        
         String cabecera2 = "   "
                + "<table id='tabla_meses'  class=' tabla tabla-con-borde table-striped table-condensed compact hover dataTable  '  >"
                + "<thead>" 
                + " <th  style='color: #fff; background: black;' >Mes</th>     "
                + " <th  style='color: #fff; background: red;' >Capacidad</th>     "
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
        ob.put("grilla4", cabecera4 + tr4 + "</tbody></table>");
        
        rs_GM.close();
    } catch (Exception e) 
    {
        ob.put("grilla", e.getMessage());
    } finally {
        connection.close();
        out.print(ob);
    }
%> 