<%-- 
    Document   : generar_grilla_preembarque
    Created on : 16-sep-2021, 8:37:03
    Author     : hvelazquez
--%>
<%@page import="org.json.JSONArray"%>
<%@page import="clases.controles"%>
<%@page import="clases.fuentedato"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8" %>
<%     
    clases.controles.connectarBD();
    fuente.setConexion(clases.controles.connect);
 try {
         
    ResultSet rs,rs2,rs3;
    String grilla_html="";
    String fp_a="N/A";
    String fp_b="N/A";
    String fp_c="N/A";
    String fp_d="N/A";
    String fp_s="N/A";
    String fp_j="N/A";
    String cant_a="0";
    String cant_b="0";
    String cant_c="0";
    String cant_d="0";
    String cant_s="0";
    String cant_j="0";
    String style_a="style='display:none'";
    String style_b="style='display:none'";
    String style_c="style='display:none'";
    String style_d="style='display:none'";
    String style_s="style='display:none'";
    String style_j="style='display:none'";
    //  rs3 = fuente.obtenerDato("  select min(convert(date,fecha_puesta)) as fecha_puesta ,tipo_huevo ,SUM(cantidad) AS cantidad from [v_mae_log_stock_1] as cantidad  with(nolock)  group by tipo_huevo  ");
     rs3 = fuente.obtenerDato("  select min(convert(date,fecha_puesta)) as fecha_puesta ,tipo_huevo ,SUM(cantidad) AS cantidad from [v_mae_log_stock_pedidos_maehara] as cantidad  with(nolock)  group by tipo_huevo  ");
    
    // mae_log_ptc_reporte_carros_total_min
     while(rs3.next())
        {
            if(rs3.getString("tipo_huevo").equals("A")){
              fp_a=  rs3.getString("fecha_puesta");
              style_a="";
              cant_a= rs3.getString("cantidad");
            }
            else if(rs3.getString("tipo_huevo").equals("B")){
              fp_b=  rs3.getString("fecha_puesta");
              cant_b= rs3.getString("cantidad");
              style_b="";
            }
             else if(rs3.getString("tipo_huevo").equals("C")){
              fp_c=  rs3.getString("fecha_puesta");
              cant_c= rs3.getString("cantidad");
              style_c="";
            }
             else if(rs3.getString("tipo_huevo").equals("D")){
              fp_d=  rs3.getString("fecha_puesta");
              cant_d= rs3.getString("cantidad");
              style_d="";
            }
             else if(rs3.getString("tipo_huevo").equals("S")){
              fp_s=  rs3.getString("fecha_puesta");
              cant_s= rs3.getString("cantidad");
              style_s="";
            }
             else if(rs3.getString("tipo_huevo").equals("J")){
              fp_j=  rs3.getString("fecha_puesta");
              cant_j= rs3.getString("cantidad");
              style_j="";
            }
        }
    
    String cabecera="   "
            + "<div id='div_2'>"
            + "<table>"
            + " <thead>"
            + "<tr><th>TIPO</th><th>PEDIDO</th><th>CARGADOS</th><th>RESTANTES</th><th>FECHA PUESTA VIEJA</th><th>DISPONIBLE</th><th>CARGADOS</th><th>INGRESAR CARGA PEDIDO</th><tbody >"
            + "<tr  "+style_a+"><td>A</td><td><input type='number' value='0' style='font-weight: bold; color: black;' class='txt_cargas' cantidad='0' tipo_huevo='A' id='1' onblur='insert_cabecera_totales_log(1,1)'  ></td>   <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_ac'        ></td>      <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_af'        ></td>                       <td><input type='text' style='font-weight: bold; color: black;' value='"+fp_a+"' readonly     ></td><td><input type='text' style='font-weight: bold; color: black;' value='"+cant_a+"' readonly     ></td>     <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_At'    ></td>  <td><input type='text'  style='font-weight: bold; color: black;'    value='0' id='11' cantidad='0' tipo_huevo='A'  onblur='insert_totales_carga_pedido_log(11)'    ></td>      </tr>"
            + "<tr  "+style_b+"><td>B</td><td><input type='number' value='0' style='font-weight: bold; color: black;' class='txt_cargas' cantidad='0' tipo_huevo='B' id='2'  onblur='insert_cabecera_totales_log(2,1)'   ></td>  <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_bc'        ></td>      <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_bf'        ></td>            <td><input type='text' style='font-weight: bold; color: black;' value='"+fp_b+"' readonly     ></td> <td><input type='text' style='font-weight: bold; color: black;' value='"+cant_b+"' readonly     ></td>              <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_Bt'    ></td>  <td><input type='text'  style='font-weight: bold; color: black;'    value='0' id='22' cantidad='0' tipo_huevo='B'   onblur='insert_totales_carga_pedido_log(22)'   ></td>      </tr>      "
            + "<tr  "+style_c+"><td>C</td><td><input type='number' value='0' style='font-weight: bold; color: black;' class='txt_cargas' cantidad='0' tipo_huevo='C' id='3'   onblur='insert_cabecera_totales_log(3,1)'  ></td>  <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_cc'        ></td>      <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_cf'        ></td>              <td><input type='text' style='font-weight: bold; color: black;' value='"+fp_c+"' readonly     ></td> <td><input type='text' style='font-weight: bold; color: black;' value='"+cant_c+"' readonly   ></td>              <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_Ct'    ></td>  <td><input type='text'  style='font-weight: bold; color: black;'    value='0' id='33' cantidad='0'  tipo_huevo='C'  onblur='insert_totales_carga_pedido_log(33)'   ></td>      </tr>      "
            + "<tr  "+style_d+"><td>D</td><td><input type='number' value='0' style='font-weight: bold; color: black;' class='txt_cargas' cantidad='0' tipo_huevo='D' id='4'   onblur='insert_cabecera_totales_log(4,1)'  ></td>  <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_dc'        ></td>      <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_df'        ></td>             <td><input type='text' style='font-weight: bold; color: black;' value='"+fp_d+"' readonly     ></td><td><input type='text' style='font-weight: bold; color: black;' value='"+cant_d+"' readonly     ></td>              <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_Dt'    ></td>  <td><input type='text'  style='font-weight: bold; color: black;'    value='0' id='44' cantidad='0'   tipo_huevo='D'  onblur='insert_totales_carga_pedido_log(44)'  ></td>      </tr>      "
            + "<tr  "+style_s+"><td>S</td><td><input type='number' value='0' style='font-weight: bold; color: black;' class='txt_cargas' cantidad='0' tipo_huevo='S' id='5'    onblur='insert_cabecera_totales_log(5,1)' ></td>  <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_sc'        ></td>      <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_sf'        ></td>             <td><input type='text' style='font-weight: bold; color: black;' value='"+fp_s+"' readonly     ></td> <td><input type='text' style='font-weight: bold; color: black;' value='"+cant_s+"' readonly     ></td>             <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_St'    ></td>  <td><input type='text'  style='font-weight: bold; color: black;'    value='0' id='55'  cantidad='0'  tipo_huevo='S'  onblur='insert_totales_carga_pedido_log(55)' ></td>      </tr>     "
            + "<tr  "+style_j+"><td>J</td><td><input type='number' value='0' style='font-weight: bold; color: black;' class='txt_cargas' cantidad='0' tipo_huevo='J' id='6'   onblur='insert_cabecera_totales_log(6,1)' ></td>   <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_jc'        ></td>      <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_jf'        ></td>             <td><input type='text' style='font-weight: bold; color: black;' value='"+fp_j+"' readonly     ></td>  <td><input type='text' style='font-weight: bold; color: black;' value='"+cant_j+"' readonly     ></td>            <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_Jt'    ></td>  <td><input type='text'  style='font-weight: bold; color: black;'    value='0' id='66'  cantidad='0'  tipo_huevo='J'  onblur='insert_totales_carga_pedido_log(66)'  ></td>      </tr>"
            + "<tr><td>MIXTO</td><td><input type='number' value='0' style='font-weight: bold; color: black;' class='txt_cargas' id='7' cantidad='0' tipo_huevo='M'  onblur='insert_cabecera_totales_log(7,1)' ></td>        <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_mixtoc'    ></td>      <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_mixtof'    ></td> <td> </td>   <td> </td>                                                                                                                                                                                                                  <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_Mt'    > <td><input type='text'  style='font-weight: bold; color: black;'          value='0' id='77'  cantidad='0'  tipo_huevo='M'  onblur='insert_totales_carga_pedido_log(77)'  ></td>   </tr>"
            + "</tbody > </tr></thead>"
            + "</table> </div>"
            + " <div id='div_grilla'   >"
           
            
            + "<div id='container'  style='width:100%'  >"
            + ""
            + ""
            + "<div id='first'style='width:100%'  > "
            
            
          //  + "<table id='tb_preembarque' class='stripe row-border order-column' style='width:100%'>"
            + "<table id='tb_preembarque' class=' compact   ' style='width:100%'>"
            + "<thead>"
            + " <tr >"
                + " <th rowspan='1'     style='color: #fff; background:     black;' ><b> </b></th>  "
                + " <th rowspan='1'     style='color: #fff; background:     brown;font-weight:bold'  ><b></b></th>  "
                + " <th colspan='15' class='text-center'    id='th_ccha' style='color: #fff; background: black;'     ><b>    <a id='td_ccha'>CCHA TOTAL CARGADOS:0   </a></b></th>   "
                + " <th colspan='15' class='text-center'    id='th_cchb'  style='color: #fff; background: green;'     ><b>    <a id='td_cchb'>CCHB TOTAL CARGADOS:0   </a></b></th>   "
                + " <th colspan='15' class='text-center'    id='th_cchh' style='color: #fff; background: black;'     ><b>    <a id='td_cchh'>CCHH TOTAL CARGADOS:0   </a></b></th>   "
                + " <th colspan='12' class='text-center'     id='th_ovo'  style='color: #fff; background: green;'     ><b>    <a id='td_ovo'>LAVADOS TOTAL CARGADOS:0 </a></b></th>   "
                + " <th colspan='15' class='text-center'    id='th_cyo'  style='color: #fff; background: black;'     ><b>    <a id='td_cyo'>CYO TOTAL CARGADOS:0     </a></b></th>   "
            + "</tr>"
            
            + " <tr>" 
                + " <th       style='color: #fff; background:     black;'   > Fecha puesta  </th>     "
                + " <th     style='color: #fff; background:     brown;font-weight:bold' >  Tipo  </th>       "
                + " <th  style='color: #fff; background: black;' >LIB   </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Acep   </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Invo   </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>LDO    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Pal    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: green;' >LIB   </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>Acep   </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>Invo   </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>LDO    </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>Pal    </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>LIB    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Acep   </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Invo   </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>LDO    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Pal    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>LIB    </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>Acep   </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>Invo   </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>Pal    </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>LIB    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Acep   </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Invo   </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>LDO    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Pal    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
            + "</tr>"
            + "</thead> <tbody >";
      rs = fuente.obtenerDato(" exec mae_log_stock_pedidos_maehara_3 @tipo=1 ,@id_pedido=0");
     
      while(rs.next())
        {
            grilla_html=grilla_html+rs.getString("tr");
         }
       
      
      
      
              String cabecera_mixto="<div id='second'  style='width:50%'  '> "
                      + " <table id='tb_preembarque_mixto' class='display compact' style='width:100%'>"
            + "<thead>"
               + " <tr>"
            + "<th colspan='6'  style='color: #fff; background: black;'  class='text-center'  ><b>CARROS MIXTOS</b></th>  </tr>"
            + "<tr>"
            + "<th  style='color: #fff; background: black;'>CARRO</th>      "
               + "<th style='color: #fff; background: green;' >AREA</th>"
               + "<th style='color: #fff; background: green;' >PUESTA</th>"
               + "<th style='color: #fff; background: green;' >DETALLE CAJONES</th>"
               + "<th style='color: #fff; background: green;' >ACCION</th>"
             + "</tr>"
            + "</thead> <tbody > ";
              
              
              
              
     String grilla_html2 ="";  
         rs2 = fuente.obtenerDato("select cod_carrito,cantidad_caj,clasificadora_actual,convert(varchar,fecha_puesta,103) as fecha_puesta,tipo_huevo "
                 + "from v_mae_log_stock_pedidos_maehara_cajones"
                 + " where   cod_carrito not in (select cod_carrito from  mae_log_ptc_det_pedidos2 with(nolock) where estado in (1,2) and u_medida='MIXTO') order by 1,4");
        String cod_carrito="";
        String cajones_unidos="";
        String fp_unido="";
        String area_unido="";
        String cod_carro_bd="";
        String tipo_huevo_bd="";
        int f=0;
        while(rs2.next())
        {
           cod_carro_bd=rs2.getString("cod_carrito");
           tipo_huevo_bd=rs2.getString("tipo_huevo");
           
           if(f==0){
              cod_carrito=rs2.getString("cod_carrito");
                fp_unido=rs2.getString("fecha_puesta");
                area_unido=rs2.getString("clasificadora_actual");
                cajones_unidos=cajones_unidos+rs2.getString("tipo_huevo")+":"+rs2.getString("cantidad_caj"); 
           }
           else if(cod_carrito.equals(""))
            {
                cod_carrito=fp_unido;
                fp_unido=fp_unido;
                area_unido=area_unido;
                cajones_unidos=cajones_unidos;
            }
            else if(cod_carrito.equals(rs2.getString("cod_carrito")))
            {
                 cajones_unidos=cajones_unidos+","+rs2.getString("tipo_huevo")+":"+rs2.getString("cantidad_caj");
            }
            else
            {
                grilla_html2=grilla_html2+ 
                "<tr>" + 
                "<td style='font-weight:bold' >"+cod_carrito+"</td>"+  
                "<td style='font-weight:bold'  >"+area_unido+"</td>"+   
                "<td style='font-weight:bold'  >"+fp_unido+"</td>"+ 
                "<td style='font-weight:bold' class='something' >"+cajones_unidos+"</td>"+ " "
                + "<td><div style='font-weight:bold' class='btn btn-dark btn-sm' deseleccionar='true' tipo_huevo='-' categoria='FCO' fecha_puesta='"+fp_unido+"' cod_carrito='"+cod_carrito+"' area='"+area_unido+"'  id='"+cod_carrito+"' onclick='seleccionar_mixtos( "+cod_carrito+" )'>SELECCIONE</div>   </td> "
                + "</tr>";
                cod_carrito="";
                cajones_unidos="";
                fp_unido="";
                area_unido="";
                
                cod_carrito=rs2.getString("cod_carrito");
                fp_unido=rs2.getString("fecha_puesta");
                area_unido=rs2.getString("clasificadora_actual");
                cajones_unidos=cajones_unidos+rs2.getString("tipo_huevo")+":"+rs2.getString("cantidad_caj");
                
            }
            f++; 
        }
        
        if(f>0){ //LA ULTIMA FILA YA NO TRAE, ENTONCES CONSULTO SI EXISTIO ENTONCES TRAE.
             grilla_html2=grilla_html2+ 
                "<tr>" + 
                "<td style='font-weight:bold' >"+cod_carrito+"</td>"+  
                "<td style='font-weight:bold'  >"+area_unido+"</td>"+   
                "<td style='font-weight:bold'  >"+fp_unido+"</td>"+ 
                "<td style='font-weight:bold' class='something' >"+cajones_unidos+"</td>"+ " "
                + "<td><div style='font-weight:bold' fecha_puesta='"+fp_unido+"' tipo_huevo='-' deseleccionar='true' categoria='FCO' cod_carrito='"+cod_carrito+"' area='"+area_unido+"'   class='btn btn-dark btn-sm' id='"+cod_carrito+"' onclick='seleccionar_mixtos( "+cod_carrito+" )'>SELECCIONE</div>   </td> "
                + "</tr>";
        }
        
        rs2 = fuente.obtenerDato("      select id_camion from mae_log_preembarque_reserva where estado=1   group by id_camion ");
          JSONArray ob3 = new JSONArray();
        ob3=new JSONArray();
        while(rs2.next())
        {        
            ob3.put(rs2.getString("id_camion"));
        }
        
        
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
 
        ob.put("grilla",cabecera+grilla_html+"</tbody></table></div>");
        ob.put("grilla_mixto",cabecera_mixto+grilla_html2+"</tbody></table></div></div></div></div>");
        ob.put("select",ob3);
        out.print(ob); 
     } catch (Exception e) {
     }
finally{
        clases.controles.DesconnectarBD();
 }
     %> 