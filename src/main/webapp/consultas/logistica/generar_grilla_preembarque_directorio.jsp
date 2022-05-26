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
         
    ResultSet rs,rs2,rs3,rs5;
    String grilla_html="";
     
    
     String cabecera="   "
           
            
             + "<table id='tb_preembarque' class='display compact '  >"
            + "<thead>"
            + " <tr >"
                + " <th rowspan='1'     style='color: #fff;' class='bg-dark' > </th>  "
                + " <th rowspan='1'     style='color: #fff;font-weight:bold'  class='bg-warning'><a  id='th_clasificadora'>    </a></th>  "
                + " <th colspan='10' class='text-center bg-dark '    id='th_ccha' style='color: #fff;  '     ><b>    <a id='td_ccha'>CCHA CARROS CAJONES   </a></b></th>   "
                + " <th colspan='10' class='text-center bg-navy'    id='th_cchb'  style='color: #fff; '      ><b>    <a id='td_cchb'>CCHB CARROS CAJONES   </a></b></th>   "
                + " <th colspan='10' class='text-center  bg-dark'    id='th_cchh' style='color: #fff;  '     ><b>    <a id='td_cchh'>CCHH CARROS CAJONES  </a></b></th>   "
                + " <th colspan='8' class='text-center bg-navy'      id='th_ovo'  style='color: #fff;      ><b>    <a id='td_ovo'>LAVADOS CARROS CAJONES </a></b></th>   "
                + " <th colspan='10' class='text-center  bg-dark'    id='th_cyo'  style='color: #fff; '     ><b>    <a id='td_cyo'>CYO CARROS CAJONES     </a></b></th>   "
            + "</tr>"
            
            + " <tr>" 
                + " <th       style='color: #fff; ' class='bg-dark'  > Fecha puesta  </th>     "
                + " <th     style='color: #fff; ;font-weight:bold' class='bg-red'>  Tipo  </th>       "
                + " <th  style='color: #fff; ' class='bg-dark' >Stock   </th>        <th  style='color: #fff; ' class='bg-dark'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-dark'>Aceptado   </th>        <th  style='color: #fff; ' class='bg-dark'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-dark'>Involucrado   </th>        <th  style='color: #fff; ' class='bg-dark'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-dark'>LDO    </th>        <th  style='color: #fff; ' class='bg-dark'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-dark'>Pallet    </th>        <th  style='color: #fff; ' class='bg-dark'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-navy' >Stock   </th>        <th  style='color: #fff; ' class='bg-navy'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-navy'>Aceptado   </th>        <th  style='color: #fff; ' class='bg-navy'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-navy'>Involucrado   </th>        <th  style='color: #fff; ' class='bg-navy'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-navy'>LDO    </th>        <th  style='color: #fff; ' class='bg-navy'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-navy'>Pallet    </th>        <th  style='color: #fff; ' class='bg-navy'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-dark'>Stock    </th>        <th  style='color: #fff; ' class='bg-dark'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-dark'>Aceptado   </th>        <th  style='color: #fff; ' class='bg-dark'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-dark'>Involucrado   </th>        <th  style='color: #fff; ' class='bg-dark'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-dark'>LDO    </th>        <th  style='color: #fff; ' class='bg-dark'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-dark'>Pallet    </th>        <th  style='color: #fff; ' class='bg-dark'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-navy'>Stock    </th>        <th  style='color: #fff; ' class='bg-navy'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-navy'>Aceptado   </th>        <th  style='color: #fff; ' class='bg-navy'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-navy'>Involucrado   </th>        <th  style='color: #fff; ' class='bg-navy'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-navy'>Pallet    </th>        <th  style='color: #fff; ' class='bg-navy'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-dark'>Stock    </th>        <th  style='color: #fff; ' class='bg-dark'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-dark'>Aceptado   </th>        <th  style='color: #fff; ' class='bg-dark'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-dark'>Involucrado   </th>        <th  style='color: #fff; ' class='bg-dark'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-dark'>LDO    </th>        <th  style='color: #fff; ' class='bg-dark'>Res</th>"
                + " <th  style='color: #fff; ' class='bg-dark'>Pallet    </th>        <th  style='color: #fff; ' class='bg-dark'>Res</th>"
            + "</tr>"
            + "</thead> <tbody >";
       rs = fuente.obtenerDato("exec [mae_log_select_reserva_directorio]  ");
    
      while(rs.next())
        {
            grilla_html=grilla_html+rs.getString("tr");
         }
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
        

              String cabecera_mixto="<div id='second'  style='width:50%'  '> "
                      + " <table id='tb_preembarque_mixto'  class='display compact '   >"
            + "<thead>"
               + " <tr>"
            + "<th colspan='6'  style='color: #fff;  '  class='text-center  bg-dark'  ><b>CARROS MIXTOS CAJONES</b></th>  </tr>"
            + "<tr>"
            + "<th  style='color: #fff;'class='bg-navy'>CARRO</th>      "
               + "<th style='color: #fff;' class='bg-navy' >AREA</th>"
               + "<th style='color: #fff; ' class='bg-navy' >PUESTA</th>"
               + "<th style='color: #fff; ' class='bg-navy' >DETALLE CAJONES</th>"
               + "<th style='color: #fff; ' class='bg-navy' >ESTADO</th>"
             + "</tr>"
            + "</thead> <tbody > ";
              
                      
        String grilla_html2 ="";  
         rs2 = fuente.obtenerDato("   select * from v_mae_log_mixtos_directorio order by   fecha_puesta asc,cod_carrito");
        String cod_carrito="";
        String cajones_unidos="";
        String fp_unido="";
        String td_estado="";
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
                td_estado=rs2.getString("estado");
           }
           else if(cod_carrito.equals(""))
            {
                cod_carrito=fp_unido;
                fp_unido=fp_unido;
                area_unido=area_unido;
                cajones_unidos=cajones_unidos;
                td_estado=rs2.getString("estado");
            }
            else if(cod_carrito.equals(rs2.getString("cod_carrito")))
            {
                 cajones_unidos=cajones_unidos+","+rs2.getString("tipo_huevo")+":"+rs2.getString("cantidad_caj");
                td_estado=rs2.getString("estado");
            }
            else
            {
                grilla_html2=grilla_html2+ 
                "<tr>" + 
                "<td style='font-weight:bold' >"+cod_carrito+"</td>"+  
                "<td style='font-weight:bold'  >"+area_unido+"</td>"+   
                "<td style='font-weight:bold'  >"+fp_unido+"</td>"+ 
                "<td style='font-weight:bold' class='something' >"+cajones_unidos+"</td>"+ " "
                +td_estado
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
                      +   td_estado
                + "</tr>";
        }
        
           
       String titulo_estado="";
       String tipo_huevo_cantidad="";
        
        
    String Cab="  ";
        String color_estrella="";
        String icono="";
        
        
           f=0;
        
         ResultSet rs4 = fuente.obtenerDato("select * from v_mae_log_reserva_directorio_mensaje order by estado ");
    String mensaje_div="";
    String estado="";
      while(rs4.next())
        {
            //mensaje_div=mensaje_div+rs4.getString("ESTADO_tr");
             if(f==0){
                estado=rs4.getString("estado");
                titulo_estado=rs4.getString("estado_desc");
                tipo_huevo_cantidad=tipo_huevo_cantidad+"<p class='text-sm'>"+rs4.getString("titulo_desc")+"</p>"; 
                icono=rs4.getString("icono");
                      color_estrella=rs4.getString("color_estrella");

            }
              else if(estado.equals(""))
            {
                estado=rs4.getString("estado");
                titulo_estado=rs4.getString("estado_desc");
                tipo_huevo_cantidad=tipo_huevo_cantidad+"<p class='text-sm'>"+rs4.getString("titulo_desc")+"</p>"; 
                icono=rs4.getString("icono");
                      color_estrella=rs4.getString("color_estrella");
            }
            else if(estado.equals(rs4.getString("estado")))
             { 
                estado=rs4.getString("estado");
                 titulo_estado=rs4.getString("estado_desc");
                tipo_huevo_cantidad=tipo_huevo_cantidad+"<p class='text-sm'>"+rs4.getString("titulo_desc")+"</p>"; 
                      color_estrella=rs4.getString("color_estrella");
                icono=rs4.getString("icono");
                   }
             else 
            { 
            Cab=Cab+"    <div class='media'>           <div class='media-body'>            "
            + "     <h3 class='dropdown-item-title'>"+titulo_estado+" <span class='float-right text-sm text-"+color_estrella+"'><i class='fas fa-star'></i></span>  </h3>          "
            + tipo_huevo_cantidad    
            + "     <p class='text-sm text-muted'><i class='"+icono+" mr-1'>        "
            + "     </i> </p>  </div>  </div> <div class='dropdown-divider'></div>";
            titulo_estado="";
            tipo_huevo_cantidad="";
            icono="";
            titulo_estado=rs4.getString("estado_desc");
            tipo_huevo_cantidad=tipo_huevo_cantidad+"<p class='text-sm'>"+rs4.getString("titulo_desc")+"</p>"; 
            color_estrella=rs4.getString("color_estrella");
            icono=rs4.getString("icono");
                estado=rs4.getString("estado");
            }
            f++;
         }
        
         if(f>0){ //LA ULTIMA FILA YA NO TRAE, ENTONCES CONSULTO SI EXISTIO ENTONCES TRAE.
              Cab=Cab+"    <div class='media'>           <div class='media-body'>            "
            + "     <h3 class='dropdown-item-title'>"+titulo_estado+" <span class='float-right text-sm text-"+color_estrella+"'><i class='fas fa-star'></i></span>  </h3>          "
            + tipo_huevo_cantidad    
            + "     <p class='text-sm text-muted'><i class='"+icono+" mr-1'>        "
            + "     </i> </p>  </div>  </div> <div class='dropdown-divider'></div>";
        }
        
        int cantidad_mensaje=0;
                 ResultSet rs6 = fuente.obtenerDato("select count(*) as contador from v_mae_log_reserva_directorio_mensaje  ");
            while(rs6.next())
                  {
                  cantidad_mensaje=rs6.getInt("contador");
              }
        ob.put("grilla",cabecera+grilla_html+"</tbody></table>");
        ob.put("grilla_mixto",cabecera_mixto+grilla_html2+"</tbody></table></div></div></div></div>");
        ob.put("mensaje_div",Cab);
        ob.put("cantidad_mensaje",cantidad_mensaje);
        
        
        out.print(ob); 
     } catch (Exception e) {
     String men=e.toString();
     }
finally{
        clases.controles.DesconnectarBD();
 }
     %> 