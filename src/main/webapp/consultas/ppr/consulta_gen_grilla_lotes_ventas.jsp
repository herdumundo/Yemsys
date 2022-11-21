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
        ResultSet rs_GM,rs2; 
        DecimalFormat formatea = new DecimalFormat("###,###.##");
        Statement st = connection.createStatement();
        Statement st2 = connection.createStatement();
        rs_GM = st.executeQuery("			 select *,convert(varchar,fecha_entrada,103) as entrada_form,convert(varchar,fecha_salida,103) as salida_form "
                + "from v_mae_ppr_lotes_ventas	where fecha='"+fecha+"' ORDER BY fecha_entrada ASC");
       
        
          rs2 = st2.executeQuery("  "
                  + "   select "
                  + "      DATENAME(month, concat('1','/',mes,'/',anho))  as nameMes, [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31] " 
	 +"             from v_mae_ppr_saldo_aves_global " 
	+"              pivot"
                  + "   (" 
	+"                  sum(cantidad_aves) 	for dia in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31])" 
	+"              )  as t1   where anho=year('"+fecha+"') and mes=month('"+fecha+"') ");
       
        
        
        
        
        String cabecera = "   "
                + "<table id='tb_preembarque' class=' table-bordered compact hover dataTable  ' style='width:100%'>"
                + "<thead>" 
                + " <tr>"
                + " <th  style='color: #fff; background: black;'>Id lote</th>     "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Lote  </th>       "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Aves  </th>       "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Venta  </th>       "
                + " <th  style='color: #fff; background: black;font-weight:bold' >  Dia  </th>       "
                + " <th  style='color: #fff; background: black;' >Entrada</th> "
                + " <th  style='color: #fff; background: black;'>Salida</th> "
                + "</tr>"
                + "</thead> <tbody >";
        
         
        String tr = "   ";
        String tr2 = "   ";
        String mes = "   ";
        
        while (rs_GM.next()) 
        {
            tr = tr
            + "<tr > "
            + "<tr>"
            +"<td>"+rs_GM.getString("id")+"</td>" 
            +"<td>"+rs_GM.getString("aviario")+"</td>" 
            +"<td>"+formatea.format(rs_GM.getInt("cantidad_aves"))+"</td>" 
            +"<td>"+formatea.format(rs_GM.getInt("venta"))+"</td>" 
            +"<td>"+rs_GM.getString("dias")+"</td>" 
            +"<td>"+rs_GM.getString("entrada_form")+"</td>" 
            +"<td>"+rs_GM.getString("salida_form")+"</td>" 
            + "</tr>";
        }
        
           while (rs2.next()) 
        {
            tr2 = tr2
            + "<tr > "
            + "<tr>"
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("1"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("2"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("3"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("4"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("5"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("6"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("7"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("8"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("9"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("10"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("11"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("12"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("13"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("14"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("15"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("16"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("17"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("18"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("19"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("20"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("21"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("22"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("23"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("24"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("25"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("26"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("27"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("28"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+formatea.format(rs2.getInt("29"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+ formatea.format(rs2.getInt("30"))+"</td>" 
            +"<td  style='color: #fff; background: gray;'>"+ formatea.format(rs2.getInt("31"))+"</td>" 
            
            + "</tr>";
            
            
            mes=rs2.getString("nameMes");
        }
        
        
        
        
         String cabecera2 = "   "
                + "<table class=' table-bordered   dataTable ' style='width:100%'>"
                + "<thead>" 
                + " <tr><tr><th colspan='31'  style='color: #fff; background: navy;'>"+mes+"</th> </tr>"
                + " <th  style='color: #fff; background: black;'>1</th>     "
                + " <th  style='color: #fff; background: black;'>2</th>     "
                + " <th  style='color: #fff; background: black;'>3</th>     "
                + " <th  style='color: #fff; background: black;'>4</th>     "
                + " <th  style='color: #fff; background: black;'>5</th>     "
                + " <th  style='color: #fff; background: black;'>6</th>     "
                + " <th  style='color: #fff; background: black;'>7</th>     "
                + " <th  style='color: #fff; background: black;'>8</th>     "
                + " <th  style='color: #fff; background: black;'>9</th>     "
                + " <th  style='color: #fff; background: black;'>10</th>     "
                + " <th  style='color: #fff; background: black;'>11</th>     "
                + " <th  style='color: #fff; background: black;'>12</th>     "
                + " <th  style='color: #fff; background: black;'>13</th>     "
                + " <th  style='color: #fff; background: black;'>14</th>     "
                + " <th  style='color: #fff; background: black;'>15</th>     "
                + " <th  style='color: #fff; background: black;'>16</th>     "
                + " <th  style='color: #fff; background: black;'>17</th>     "
                + " <th  style='color: #fff; background: black;'>18</th>     "
                + " <th  style='color: #fff; background: black;'>19</th>     "
                + " <th  style='color: #fff; background: black;'>20</th>     "
                + " <th  style='color: #fff; background: black;'>21</th>     "
                + " <th  style='color: #fff; background: black;'>22</th>     "
                + " <th  style='color: #fff; background: black;'>23</th>     "
                + " <th  style='color: #fff; background: black;'>24</th>     "
                + " <th  style='color: #fff; background: black;'>25</th>     "
                + " <th  style='color: #fff; background: black;'>26</th>     "
                + " <th  style='color: #fff; background: black;'>27</th>     "
                + " <th  style='color: #fff; background: black;'>28</th>     "
                + " <th  style='color: #fff; background: black;'>29</th>     "
                + " <th  style='color: #fff; background: black;'>30</th>     "
                + " <th  style='color: #fff; background: black;'>31</th>     "
               
                + "</tr>"
                + "</thead> <tbody >";
        
         
        
        
        
        
        
        
        
    
        ob.put("grilla", cabecera + tr + "</tbody></table>");
        ob.put("grilla2", cabecera2 + tr2 + "</tbody></table>");
        
        rs_GM.close();
    } catch (Exception e) 
    {
        ob.put("grilla", e.getMessage());
    } finally {
        connection.close();
        out.print(ob);
    }
%> 

