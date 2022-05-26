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
    String id            = request.getParameter("id");
    String usuario       = (String) sesionOk.getAttribute("usuario");
    String area       = (String) sesionOk.getAttribute("area_log");
    String area_form="";
    if(area.equals("A")){
        area_form="CCHA"; 
    }
    else if(area.equals("B")){
        area_form="CCHB"; 
    }
    else if(area.equals("H")){
        area="CCHH"; 
    }
    else if(area.equals("O")){
        area_form="OVO"; 
    }
    else if(area.equals("C")){
        area_form="CYO"; 
    }
      int i=0;
    String grilla_html="";
    String cod_chofer="";
    String cabecera=" <div id='div_grilla'  class='table_wrapper' >"
            + "<div id='container' style='width: 1500px; margin: left;'>"
            + "<div id='first' style=' width: 1000px; float: left; height: 700px;'> "
            + " <table id='tb_preembarque' class='table table-bordered table-hover' style='width:50%'>"
            + "<thead>"
              + " <tr>"
            + "<th rowspan='2'  style='color: #fff; background: gray;'><b>Fecha puesta</b></th>  "
            + " <th rowspan='2' ><b>Tipo</b></th>  "
            + " <th colspan='10' class='text-center' style='color: #fff; background: green;  ' ><b><a id='td_"+area_form+"'>"+area_form+ "</a></b></th>   </tr>"
            
            + " <tr>" 
            + " <th  style='color: #fff; background: black;' >LIB</th>      <th style='color: #fff; background: black;' >Cant</th>"
            + " <th  style='color: #fff; background: green;'>Acep</th>      <th style='color: #fff; background: green;' >Cant</th>"
            + " <th  style='color: #fff; background: green;'>Invo</th>      <th  style='color: #fff; background: green;'>Cant</th>"
           + " <th  style='color: #fff; background: green;'>LDO</th>      <th  style='color: #fff; background: green;'>Cant</th>  "
                        + " <th  style='color: #fff; background: green;'>Pallet</th>      <th  style='color: #fff; background: green;'>Cant</th>"

            + " </tr>"
            + "</thead> <tbody >";
   
     if(area.equals("O")){
         cabecera=" <div id='div_grilla'  class='table_wrapper' >"
            + "<div id='container' style='width: 1500px; margin: left;'>"
            + "<div id='first' style=' width: 1000px; float: left; height: 700px;'>  "
                 + "<table id='tb_preembarque' class='table table-bordered table-hover' style='width:50%'>"
            + "<thead>"
              + " <tr>"
            + "<th rowspan='2'  style='color: #fff; background: gray;'><b>Fecha puesta</b></th>  "
            + " <th rowspan='2' ><b>Tipo</b></th>  "
            + " <th colspan='6' class='text-center' style='color: #fff; background: green;  ' ><b><a id='td_"+area_form+"'>"+area_form+ " </a></b></th>   </tr>"
            
            + " <tr>" 
            + " <th  style='color: #fff; background: black;' >LIB</th>      <th style='color: #fff; background: black;' >Cant</th>"
            + " <th  style='color: #fff; background: green;'>Acep</th>      <th style='color: #fff; background: green;' >Cant</th>"
            + " <th  style='color: #fff; background: green;'>Invo</th>      <th  style='color: #fff; background: green;'>Cant</th>"
           + " <th  style = 'display:none' style='color: #fff; background: green;' >LDO</th>      <th  style = 'display:none' style='color: #fff; background: green;'>Cant</th>  "
            + " <th  style='color: #fff; background: green;'>Pallet</th>      <th  style='color: #fff; background: green;'>Cant</th>"

                 
                 + " </tr>"
            + "</thead> <tbody >";
     }
    
    
    
    try {
            
      
    int cont_fila=0;
    ResultSet rs,rs2,rs3,rs4,rs5;
    
    String cantidades_carros_tipos="";
    String cantidades_tipos="";
    rs5 = fuente.obtenerDato(" select clasificadora,tipo_huevo,sum(cantidad) as cantidad "
               + "  from  mae_log_ptc_det_pedidos where   u_medida='ENTERO' and id_cab ="+id+"  "
               + "  AND ESTADO=2 and clasificadora='"+area_form+"' group by clasificadora,tipo_huevo");
    while(rs5.next())
    {
        if(i==0){
            cantidades_carros_tipos=rs5.getString("tipo_huevo").trim()+"_"+rs5.getString("cantidad").trim() ;
            cantidades_tipos=rs5.getString("tipo_huevo").trim();
            }
            else{
            cantidades_carros_tipos=cantidades_carros_tipos+","+rs5.getString("tipo_huevo").trim()+"_"+rs5.getString("cantidad").trim() ;
            cantidades_tipos=cantidades_tipos+","+rs5.getString("tipo_huevo").trim();
            }
            i++;
    }
    
     rs = fuente.obtenerDato(" exec mae_log_select_pedidos_gen @id="+id+"  ");
       
     
     
     
    if(area.equals("O")){

     
        while(rs.next())
        {
                String edit1="";//contenteditable='true'
                String edit2="";//contenteditable='true'
                String edit3="";//contenteditable='true'
                String edit4="";//contenteditable='true'
                String edit5="";//contenteditable='true'

                 if(rs.getInt("liberados_"+area)>0){

                     if(cantidades_tipos.contains(rs.getString(2))){
                        edit1="contenteditable='true'  style='color: #fff; background: black;' title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("liberadosing_"+area)+"'";  

                     }
                     else {
                    edit1="    title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("liberadosing_"+area)+"'";  

                     }

                } 
                if(rs.getInt("aceptar_"+area)>0){
                      if(cantidades_tipos.contains(rs.getString(2))){
                  edit2="contenteditable='true'  style='color: #fff; background: black;' title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("aceptadosing_"+area)+"'";  

                     }
                     else {
                  edit2="    title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("aceptadosing_"+area)+"'";  

                     }

                }
                if(rs.getInt("invo_"+area)>0){
                       if(cantidades_tipos.contains(rs.getString(2))){
                  edit3="contenteditable='true'  style='color: #fff; background: black;' title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("involucradosing_"+area)+"'";  

                     }
                     else {
                  edit3="   title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("involucradosing_"+area)+"'";  

                     }
                }

                 if(rs.getInt("pallet_"+area)>0){
                   if(cantidades_tipos.contains(rs.getString(2))){
                  edit5="contenteditable='true'  style='color: #fff; background: black;' title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("palleting_"+area)+"'";  

                     }
                     else {
                  edit5="  title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("palleting_"+area)+"'";  

                     }
                }
              grilla_html=grilla_html+
                "<tr   >"
                       + "<td>"+rs.getString(1)+"</td>"
                       + "<td width='35'  class='text-center '> "+rs.getString(2)+" </td>"                                                                                  
                       + "<td  class='text-center'  ><b> "+rs.getString("liberados_"+area)+"    </b></td>   <td "+edit1+"   class='text-center celda_editable single_line'>   "+rs.getString("liberadosing_"+area)+"     </td>"
                       + "<td  class='text-center'  ><b>"+rs.getString("aceptar_"+area)+"       </b></td>   <td "+edit2+"   class='text-center celda_editable single_line'>   "+rs.getString("aceptadosing_"+area)+"     </td>"
                       + "<td class='text-center'   ><b>"+rs.getString("invo_"+area)+"          </b></td>   <td "+edit3+"   class='text-center celda_editable single_line'>   "+rs.getString("involucradosing_"+area)+"     </td>"
                       + "<td class='text-center'  style = 'display:none' ><b>0         </b></td>   <td  style = 'display:none'   class='text-center celda_editable single_line'>  0</td>"
                        + "<td class='text-center'   ><b>"+rs.getString("pallet_"+area)+"       </b></td>   <td "+edit5+"   class='text-center celda_editable single_line'>   "+rs.getString("palleting_"+area)+"     </td>"

                      +   " </tr>";
              cont_fila++; 
            }

    }

      else {
        
     
     while(rs.next())
        {
            String edit1="";//contenteditable='true'
            String edit2="";//contenteditable='true'
            String edit3="";//contenteditable='true'
            String edit4="";//contenteditable='true'
            String edit5="";//contenteditable='true'
 
             if(rs.getInt("liberados_"+area)>0){
                 
                 if(cantidades_tipos.contains(rs.getString(2))){
                    edit1="contenteditable='true'  style='color: #fff; background: black;' title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("liberadosing_"+area)+"'";  

                 }
                 else {
                edit1="    title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("liberadosing_"+area)+"'";  

                 }
               
            } 
            if(rs.getInt("aceptar_"+area)>0){
                  if(cantidades_tipos.contains(rs.getString(2))){
              edit2="contenteditable='true'  style='color: #fff; background: black;' title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("aceptadosing_"+area)+"'";  

                 }
                 else {
              edit2="    title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("aceptadosing_"+area)+"'";  

                 }
                  
            }
            if(rs.getInt("invo_"+area)>0){
                   if(cantidades_tipos.contains(rs.getString(2))){
              edit3="contenteditable='true'  style='color: #fff; background: black;' title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("involucradosing_"+area)+"'";  

                 }
                 else {
              edit3="   title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("involucradosing_"+area)+"'";  

                 }
            }
            if(rs.getInt("lavados_"+area)>0){
               if(cantidades_tipos.contains(rs.getString(2))){
              edit4="contenteditable='true'  style='color: #fff; background: black;' title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("lavadosing_"+area)+"'";  

                 }
                 else {
              edit4="  title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("lavadosing_"+area)+"'";  

                 }
            }
            
            
            
               if(rs.getInt("pallet_"+area)>0){
               if(cantidades_tipos.contains(rs.getString(2))){
              edit5="contenteditable='true'  style='color: #fff; background: black;' title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("palleting_"+area)+"'";  

                 }
                 else {
              edit5="  title='Fecha puesta: "+rs.getString("fecha_puesta")+"\nTipo de huevo: "+rs.getString(2)+"\nCargados:"+rs.getString("palleting_"+area)+"'";  

                 }
            }
               
               
            
          grilla_html=grilla_html+
            "<tr   >"
                   + "<td>"+rs.getString(1)+"</td>"
                   + "<td width='35'  class='text-center '> "+rs.getString(2)+" </td>"                                                                                  
                   + "<td  class='text-center'  ><b> "+rs.getString("liberados_"+area)+"    </b></td>   <td "+edit1+"   class='text-center celda_editable single_line'>   "+rs.getString("liberadosing_"+area)+"     </td>"
                   + "<td  class='text-center'  ><b>"+rs.getString("aceptar_"+area)+"       </b></td>   <td "+edit2+"   class='text-center celda_editable single_line'>   "+rs.getString("aceptadosing_"+area)+"     </td>"
                   + "<td class='text-center'   ><b>"+rs.getString("invo_"+area)+"          </b></td>   <td "+edit3+"   class='text-center celda_editable single_line'>   "+rs.getString("involucradosing_"+area)+"     </td>"
                   + "<td class='text-center'   ><b>"+rs.getString("lavados_"+area)+"       </b></td>   <td "+edit4+"   class='text-center celda_editable single_line'>   "+rs.getString("lavadosing_"+area)+"     </td>"
                   + "<td class='text-center'   ><b>"+rs.getString("pallet_"+area)+"       </b></td>   <td "+edit5+"   class='text-center celda_editable single_line'>   "+rs.getString("palleting_"+area)+"     </td>"
            +   " </tr>";
          cont_fila++; 
        }
         
      }
   
            String cabecera_mixto=" <div id='second' style=' width: 500px;  float: right;  height: 700px;'><table id='tb_preembarque_mixto' class='table table-bordered table-hover' style='width:100%'>"
            + "<thead>"
               + " <tr>"
            + "<th colspan='6'  style='color: #fff; background: gray;'  class='text-center'  ><b>CARROS MIXTOS</b></th>  </tr>"
            + "<tr>"
            + "<th  style='color: #fff; background: black;'>CARRO</th>      "
               + "<th style='color: #fff; background: green;' >AREA</th>"
               + "<th style='color: #fff; background: green;' >PUESTA</th>"
               + "<th style='color: #fff; background: green;' >DETALLE CAJONES</th>"
               + "<th style='color: #fff; background: green;' >ACCION</th>"
             + "</tr>"
            + "</thead> <tbody >";
     String grilla_html2 ="";  
        rs2 = fuente.obtenerDato("  SELECT cod,clasificadora_ACTUAL,convert(varchar,FECHA_PUESTA,103)AS FECHA_PUESTA,  stuff(( select   ','+  [tipo_huevo] + ':'+convert(varchar,[cantidad])   from [v_mae_stock_linea_mixtos] with (nolock) "
                + "                 where cod_carrito =  cod for XML path('') ),1,1,'')as fecha_involucrada "
                + "                 FROM  ( SELECT cod_carrito as cod,clasificadora_ACTUAL ,FECHA_PUESTA FROM v_mae_stock_linea_cajones12 WHERE cod_carrito not in (select cod_carrito from  mae_log_ptc_det_pedidos where estado=1 and u_medida='MIXTO' and id_cab not in("+id+")) ) T where clasificadora_ACTUAL='"+area_form+"' ORDER BY 2,3");
       while(rs2.next())
        {
            grilla_html2=grilla_html2+ "<tr>" + "<td  >"+rs2.getString(1 )+"</td>"+  "<td   >"+rs2.getString(2)+"</td>"+   "<td   >"+rs2.getString(3)+"</td>"+ 
                    "<td class='something' >"+rs2.getString(4)+"</td>"+ " <td><div class='btn btn-dark btn-sm' id='"+rs2.getString(1 )+"'  >SELECCIONE</div>   </td> </tr>";
        }
       String cod_camion="";
       String cantidad_area="";
       String obs="";
          
        rs3 = fuente.obtenerDato(" select id,fecha_registro,camion,sum(cantidad) as cantidad,concat(cantidad_camion,'_',camion) as combo,id_chofer,obs "
                + "from "
			+ " ("
			+ " 	select "
                + "                 id_cab as id, FORMAT(b.fecha_registro, 'dd/MM/yyyy HH:mm') as fecha_registro,code as camion,1 as cantidad, "
                        + "         carro, b.cantidad as cantidad_camion,b.id_chofer, b.obs"
			+ "     from "
                + "                 mae_log_ptc_det_mixtos_pedidos a "
			+ "         inner join mae_log_pct_cab_pedidos b on a.id_cab=b.id"
			+ "         inner join maehara.dbo.[@CAMIONES] c on b.id_camion=c.Code collate database_default "
			+ "     where "
                + "                 a.estado=2 and a.clasificadora='"+area_form+"' "
			+ "     group by "
                        + "         a.id_cab,b.fecha_registro,code,name ,carro,b.cantidad,b.id_chofer,b.obs"
			+ "     union all"
			+ "     select "
                        + "         distinct a.id,FORMAT (a.fecha_registro, 'dd/MM/yyyy HH:mm') as fecha_registro,code as camion  ,"
			+ "         sum(c.cantidad) as cantidad, 0 as carro , a.cantidad as cantidad_camion ,a.id_chofer,a.obs "
                        + "     from "
                        + "         mae_log_pct_cab_pedidos a    "
			+ "         inner join maehara.dbo.[@CAMIONES] b     on a.id_camion=b.Code collate database_default     and a.estado IN (2)     "
			+ "         inner join mae_log_ptc_det_pedidos c on a.id=c.id_cab and c.estado<>4 and c.clasificadora='"+area_form+"' "
			+ "         and a.id in ( select distinct id_cab from mae_log_ptc_det_pedidos where estado=2 and clasificadora='"+area_form+"') "
                        + "     group by a.id,a.fecha_registro,code,name,a.cantidad ,a.id_chofer,a.obs"
                                + ") t  WHERE ID= "+id+" "
            + " group by  id,fecha_registro,camion,cantidad_camion,id_chofer,obs ");
         
           while(rs3.next())
        {
            cod_camion=rs3.getString("combo");
            cantidad_area=rs3.getString("cantidad");
            cod_chofer=rs3.getString("id_chofer");
            obs=rs3.getString("obs");

        }
           
       String carros_mixtos="";
     
       rs4 = fuente.obtenerDato(" select cod_carrito from  mae_log_ptc_det_pedidos where estado=2 and u_medida='MIXTO' and id_cab   in("+id+" )");
        i=0;
       while(rs4.next())
        {
            if(i==0){
            carros_mixtos=rs4.getString("cod_carrito") ;
            }
            else{
            carros_mixtos=carros_mixtos+","+rs4.getString("cod_carrito") ;
            }
            i++;
        }

        clases.controles.DesconnectarBD();
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
 
        ob.put("grilla",cabecera+grilla_html+"</tbody></table></div>");
        ob.put("grilla_mixto",cabecera_mixto+grilla_html2+"</tbody></table></div></div></div></div>");
        ob.put("cod_camion",cod_camion);
        ob.put("cantidad_area",cantidad_area);
        ob.put("validacion_cantidades",cantidades_carros_tipos.trim());
        ob.put("validacion_tipos",cantidades_tipos.trim());
        ob.put("carros_mixtos",carros_mixtos);
        ob.put("id_pedido",id);
        ob.put("area",area_form);
        ob.put("cod_chofer",cod_chofer);
        ob.put("obs",obs);
        
        
        
        out.print(ob);
          } catch (Exception e) {
              String error=e.getMessage();
        }
%>