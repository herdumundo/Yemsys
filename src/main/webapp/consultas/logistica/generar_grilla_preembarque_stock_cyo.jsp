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
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%     
    clases.controles.connectarBD();
    fuente.setConexion(clases.controles.connect);
    String area       = (String) sesionOk.getAttribute("area_log");
      
    JSONObject ob = new JSONObject();
    String area_form="";
    if(area.equals("A")){
        area_form="CCHA"; 
    }
    else if(area.equals("B")){
        area_form="CCHB"; 
    }
    else if(area.equals("H")){
        area_form="CCHH"; 
    }
    else if(area.equals("O")){
        area_form="LAVADOS"; 
    }
    else if(area.equals("C")){
        area_form="CYO"; 
    }
        String grilla_html="";
        String cabecera= 
            "<table id='tb_preembarque' class='display compact hover cell-border stripe' style='width:50%'>"
            + "<thead>"
            + " <tr>"
            + "  "
            + " "
            + " <th colspan='12'  style='color: #fff;'   class='bg-navy text-center'   ><b><a id='td_"+area_form+"'>"+area_form+ "</a></b></th>   </tr>"
            + " <tr>" 
            + "<th   style='color: #fff; ' class='bg-navy'><b>Fecha puesta</b></th>"
                + " <th  style='color: #fff; ' class='bg-navy' ><b>Tipo</b></th>  "
                + "<th  style='color: #fff; ' class='bg-navy' >LIB</th>       "
            + " <th  style='color: #fff; ' class='bg-navy'>Acep</th>     "
            + " <th  style='color: #fff; ' class='bg-navy'>Invo</th>      "
            + " <th  style='color: #fff; ' class='bg-navy'>LDO</th>        "
            + " <th  style='color: #fff; ' class='bg-navy'>Pallet</th>    "
            + " </tr>"
            + "</thead> <tbody >";
   
     if(area.equals("O"))
     {
         cabecera= 
            "<table id='tb_preembarque' class='display compact hover cell-border stripe' style='width:50%'>"
            + "<thead>"
            + " <tr>"
            + "  "
            + " "
            + " <th colspan='12'  style='color: #fff;'   class='bg-navy text-center'   ><b><a id='td_"+area_form+"'>"+area_form+ "</a></b></th>   </tr>"
            + " <tr>" 
            + "<th   style='color: #fff; ' class='bg-navy'><b>Fecha puesta</b></th>"
                + " <th  style='color: #fff; ' class='bg-navy' ><b>Tipo</b></th>  "
                + "<th  style='color: #fff; ' class='bg-navy' >LIB</th>       "
            + " <th  style='color: #fff; ' class='bg-navy'>Acep</th>     "
            + " <th  style='color: #fff; ' class='bg-navy'>Invo</th>      "
             + " <th  style='color: #fff; ' class='bg-navy'>Pallet</th>    "
            + " </tr>"
            + "</thead> <tbody >";
     }
    try 
    {
        
        ResultSet rs,rs2,rs3;
        
        rs2 = fuente.obtenerDato(" exec mae_log_stock_pedidos_maehara_3 @tipo=3 ,@id_pedido=0");
        while(rs2.next())
        {
         }
              
        rs = fuente.obtenerDato(" exec mae_log_select_stock_cyo  @area='"+area_form+"'");
     
        while(rs.next())
        {
            grilla_html=grilla_html+rs.getString("tr");
        }
         

        
        
           String cabecera_mixto="  "
                      + " <table id='tb_preembarque_mixto' class='display compact' style='width:100%'>"
            + "<thead>"
               + " <tr>"
            + "<th colspan='6'  style='color: #fff; '  class='text-center bg-navy'  ><b>CARROS MIXTOS</b></th>  </tr>"
            + "<tr>"
            + "<th  style='color: #fff;' class='bg-navy'>CARRO</th>      "
               + "<th style='color: #fff; ' class='bg-navy' >AREA</th>"
               + "<th style='color: #fff; ' class='bg-navy' >PUESTA</th>"
               + "<th style='color: #fff; ' class='bg-navy' >DETALLE CAJONES</th>"
              + "</tr>"
            + "</thead> <tbody > ";
              
              
              
              
     String grilla_html2 ="";  
    ResultSet     rs5 = fuente.obtenerDato("select cod_carrito,cantidad_caj,clasificadora_actual,convert(varchar,fecha_puesta,103) as fecha_puesta,tipo_huevo "
                 + "from v_mae_log_stock_pedidos_maehara_cajones"
                 + " where clasificadora_actual='"+area_form+"'     order by 1,4");
        String cod_carrito="";
        String cajones_unidos="";
        String fp_unido="";
        String area_unido="";
        String cod_carro_bd="";
        String tipo_huevo_bd="";
        int f=0;
        while(rs5.next())
        {
           cod_carro_bd=rs5.getString("cod_carrito");
           tipo_huevo_bd=rs5.getString("tipo_huevo");
           
           if(f==0){
              cod_carrito=rs5.getString("cod_carrito");
                fp_unido=rs5.getString("fecha_puesta");
                area_unido=rs5.getString("clasificadora_actual");
                cajones_unidos=cajones_unidos+rs5.getString("tipo_huevo")+":"+rs5.getString("cantidad_caj"); 
           }
           else if(cod_carrito.equals(""))
            {
                cod_carrito=fp_unido;
                fp_unido=fp_unido;
                area_unido=area_unido;
                cajones_unidos=cajones_unidos;
            }
            else if(cod_carrito.equals(rs5.getString("cod_carrito")))
            {
                 cajones_unidos=cajones_unidos+","+rs5.getString("tipo_huevo")+":"+rs5.getString("cantidad_caj");
            }
            else
            {
                grilla_html2=grilla_html2+ 
                "<tr>" + 
                "<td style='font-weight:bold' >"+cod_carrito+"</td>"+  
                "<td style='font-weight:bold'  >"+area_unido+"</td>"+   
                "<td style='font-weight:bold'  >"+fp_unido+"</td>"+ 
                "<td style='font-weight:bold' class='something' >"+cajones_unidos+"</td>"+ " "
                 + "</tr>";
                cod_carrito="";
                cajones_unidos="";
                fp_unido="";
                area_unido="";
                
                cod_carrito=rs5.getString("cod_carrito");
                fp_unido=rs5.getString("fecha_puesta");
                area_unido=rs5.getString("clasificadora_actual");
                cajones_unidos=cajones_unidos+rs5.getString("tipo_huevo")+":"+rs5.getString("cantidad_caj");
                
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
                 + "</tr>";
        }
       
        ob=new JSONObject();
        ob.put("grilla",cabecera+grilla_html+"</tbody></table>");
        ob.put("grilla_mixto",cabecera_mixto+grilla_html2+"</tbody></table> ");
    } catch (Exception e) 
    {
        String error=e.getMessage();
    }
    finally 
    {
        clases.controles.DesconnectarBD();
        out.print(ob);
    }
%>