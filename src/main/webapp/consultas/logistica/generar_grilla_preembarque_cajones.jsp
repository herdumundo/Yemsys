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
     //rs3 = fuente.obtenerDato("  select min(convert(date,fecha_puesta)) as fecha_puesta ,tipo_huevo from  v_mae_preembarque  with(nolock)  group by tipo_huevo  ");
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
            + "<tr><th>TIPO</th><th>PEDIDO</th><th>CARGADOS</th><th>RESTANTES</th><th>FECHA PUESTA VIEJA</th><th>DISPONIBLE</th><tbody >"
            + "<tr  "+style_a+"><td>A</td><td><input type='number' value='0' style='font-weight: bold; color: black;' class='txt_cargas' id='txt_tipo_a'   ></td>   <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_ac'        ></td>      <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_af'        ></td>                       <td><input type='text' style='font-weight: bold; color: black;' value='"+fp_a+"' readonly     ></td><td><input type='text' style='font-weight: bold; color: black;' value='"+cant_a+"' readonly     ></td>   </tr>"
            + "<tr  "+style_b+"><td>B</td><td><input type='number' value='0' style='font-weight: bold; color: black;' class='txt_cargas' id='txt_tipo_b'    ></td>  <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_bc'        ></td>      <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_bf'        ></td>            <td><input type='text' style='font-weight: bold; color: black;' value='"+fp_b+"' readonly     ></td> <td><input type='text' style='font-weight: bold; color: black;' value='"+cant_b+"' readonly     ></td>   </tr>"
            + "<tr  "+style_c+"><td>C</td><td><input type='number' value='0' style='font-weight: bold; color: black;' class='txt_cargas' id='txt_tipo_c'    ></td>  <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_cc'        ></td>      <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_cf'        ></td>              <td><input type='text' style='font-weight: bold; color: black;' value='"+fp_c+"' readonly     ></td> <td><input type='text' style='font-weight: bold; color: black;' value='"+cant_c+"' readonly   ></td>   </tr>"
            + "<tr  "+style_d+"><td>D</td><td><input type='number' value='0' style='font-weight: bold; color: black;' class='txt_cargas' id='txt_tipo_d'    ></td>  <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_dc'        ></td>      <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_df'        ></td>             <td><input type='text' style='font-weight: bold; color: black;' value='"+fp_d+"' readonly     ></td><td><input type='text' style='font-weight: bold; color: black;' value='"+cant_d+"' readonly     ></td>   </tr>"
            + "<tr  "+style_s+"><td>S</td><td><input type='number' value='0' style='font-weight: bold; color: black;' class='txt_cargas' id='txt_tipo_s'    ></td>  <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_sc'        ></td>      <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_sf'        ></td>             <td><input type='text' style='font-weight: bold; color: black;' value='"+fp_s+"' readonly     ></td> <td><input type='text' style='font-weight: bold; color: black;' value='"+cant_s+"' readonly     ></td>   </tr>"
            + "<tr  "+style_j+"><td>J</td><td><input type='number' value='0' style='font-weight: bold; color: black;' class='txt_cargas' id='txt_tipo_j'   ></td>   <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_jc'        ></td>      <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_jf'        ></td>             <td><input type='text' style='font-weight: bold; color: black;' value='"+fp_j+"' readonly     ></td>  <td><input type='text' style='font-weight: bold; color: black;' value='"+cant_j+"' readonly     ></td>   </tr>"
          
            + "<tr><td>MIXTO</td><td><input type='number' value='0' style='font-weight: bold; color: black;' class='txt_cargas' id='txt_tipo_mixto'   ></td>        <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_mixtoc'    ></td>      <td><input type='text'  style='font-weight: bold; color: black;'    value='0'   readonly    id='txt_tipo_mixtof'    ></td>   </tr>"
            + "</tbody > </tr></thead>"
            + "</table> </div>"
            + " <div id='div_grilla' style=' margin: left; height: 700px;'  >"
           
            
            + "<div id='container'   margin: left;'>"
            + ""
            + ""
            + "<div id='first' style='  float: left; '> "
            
            
          //  + "<table id='tb_preembarque' class='stripe row-border order-column' style='width:100%'>"
            + "<table id='tb_preembarque' class='stripe order-column dataTable no-footer ' style='width:50%'>"
            + "<thead>"
            + " <tr >"
                + " <th rowspan='1'     style='color: #fff; background:     black;' ><b> </b></th>  "
                + " <th rowspan='1'     style='color: #fff; background:     brown;font-weight:bold'  ><b></b></th>  "
                + " <th colspan='10' class='text-center'    id='th_ccha' style='color: #fff; background: black;'     ><b>    <a id='td_ccha'>CCHA TOTAL CARGADOS:0   </a></b></th>   "
                + " <th colspan='10' class='text-center'    id='th_cchb'  style='color: #fff; background: green;'     ><b>    <a id='td_cchb'>CCHB TOTAL CARGADOS:0   </a></b></th>   "
                + " <th colspan='10' class='text-center'    id='th_cchh' style='color: #fff; background: black;'     ><b>    <a id='td_cchh'>CCHH TOTAL CARGADOS:0   </a></b></th>   "
                + " <th colspan='8' class='text-center'     id='th_ovo'  style='color: #fff; background: green;'     ><b>    <a id='td_ovo'>LAVADOS TOTAL CARGADOS:0 </a></b></th>   "
                + " <th colspan='10' class='text-center'    id='th_cyo'  style='color: #fff; background: black;'     ><b>    <a id='td_cyo'>CYO TOTAL CARGADOS:0     </a></b></th>   "
            + "</tr>"
            
            + " <tr>" 
                + " <th       style='color: #fff; background:     black;'   > Fecha puesta  </th>     "
                + " <th    style='color: #fff; background:     brown;font-weight:bold' >  Tipo  </th>       "
                + " <th  style='color: #fff; background: black;' >LIB   </th>      <th  style='color: #fff; background: black;'>Cant</th>"
                + " <th  style='color: #fff; background: black;'>Acep   </th>      <th  style='color: #fff; background: black;'>Cant</th>"
                + " <th  style='color: #fff; background: black;'>Invo   </th>      <th  style='color: #fff; background: black;'>Cant</th>"
                + " <th  style='color: #fff; background: black;'>LDO    </th>      <th  style='color: #fff; background: black;'>Cant</th>"
                + " <th  style='color: #fff; background: black;'>Pal    </th>      <th  style='color: #fff; background: black;'>Cant</th>"
                + " <th  style='color: #fff; background: green;' >LIB   </th>      <th  style='color: #fff; background: green;'>Cant</th>"
                + " <th  style='color: #fff; background: green;'>Acep   </th>      <th  style='color: #fff; background: green;'>Cant</th>"
                + " <th  style='color: #fff; background: green;'>Invo   </th>      <th  style='color: #fff; background: green;'>Cant</th>"
                + " <th  style='color: #fff; background: green;'>LDO    </th>      <th  style='color: #fff; background: green;'>Cant</th>"
                + " <th  style='color: #fff; background: green;'>Pal    </th>      <th  style='color: #fff; background: green;'>Cant</th>"
                + " <th  style='color: #fff; background: black;'>LIB    </th>      <th  style='color: #fff; background: black;'>Cant</th>"
                + " <th  style='color: #fff; background: black;'>Acep   </th>      <th  style='color: #fff; background: black;'>Cant</th>"
                + " <th  style='color: #fff; background: black;'>Invo   </th>      <th  style='color: #fff; background: black;'>Cant</th>"
                + " <th  style='color: #fff; background: black;'>LDO    </th>      <th  style='color: #fff; background: black;'>Cant</th>"
                + " <th  style='color: #fff; background: black;'>Pal    </th>      <th  style='color: #fff; background: black;'>Cant</th>"
                + " <th  style='color: #fff; background: green;'>LIB    </th>      <th  style='color: #fff; background: green;'>Cant</th>"
                + " <th  style='color: #fff; background: green;'>Acep   </th>      <th  style='color: #fff; background: green;'>Cant</th>"
                + " <th  style='color: #fff; background: green;'>Invo   </th>      <th  style='color: #fff; background: green;'>Cant</th>"
                + " <th  style='color: #fff; background: green;'>Pal    </th>      <th  style='color: #fff; background: green;'>Cant</th>"
                + " <th  style='color: #fff; background: black;'>LIB    </th>      <th  style='color: #fff; background: black;'>Cant</th>"
                + " <th  style='color: #fff; background: black;'>Acep   </th>      <th  style='color: #fff; background: black;'>Cant</th>"
                + " <th  style='color: #fff; background: black;'>Invo   </th>      <th  style='color: #fff; background: black;'>Cant</th>"
                + " <th  style='color: #fff; background: black;'>LDO    </th>      <th  style='color: #fff; background: black;'>Cant</th>"
                + " <th  style='color: #fff; background: black;'>Pal    </th>      <th  style='color: #fff; background: black;'>Cant</th>"
            + "</tr>"
            + "</thead> <tbody >";
    int cont_fila=0;
    int cont_id=0;
     rs = fuente.obtenerDato(" SELECT * FROM ( select *,convert(varchar,fecha_puesta,103)as fecha_format from  v_mae_log_stock_pedidos_maehara_2  with(nolock) ) T WHERE tipo_huevo NOT IN ('-')   order by 1,2  ");
     //  rs = fuente.obtenerDato(" select *,convert(varchar,fecha_puesta,103)as fecha_format from mae_log_ptc_reporte_carros;");
       
      
      while(rs.next())
        {
            String ocultar="style='background: white; color:white'";
             if (cont_fila%2==0) {
                    ocultar="style='background: #dbdbbe; color:#dbdbbe'";
                } 
            
            String editLIBERADOSCCHA=ocultar;//contenteditable='true'
            String editACEPTARCCHA=ocultar;//contenteditable='true'
            String editINVOCCHA=ocultar;//contenteditable='true'
            String editLAVADOSCCHA=ocultar;//contenteditable='true'
            String editPALLETCCHA=ocultar;//contenteditable='true'
           
            String editLIBERADOSCCHB=ocultar;//contenteditable='true'
            String editACEPTARCCHB=ocultar;//contenteditable='true'
            String editINVOCCHB=ocultar;//contenteditable='true'
            String editLAVADOSCCHB=ocultar;//contenteditable='true'
            String editPALLETCCHB=ocultar;//contenteditable='true'
     
            String editLIBERADOSCCHH=ocultar;//contenteditable='true'
            String editACEPTARCCHH=ocultar;//contenteditable='true'
            String editINVOCCHH=ocultar;//contenteditable='true'
            String editLAVADOSCCHH=ocultar;//contenteditable='true'
            String editPALLETCCHH=ocultar;//contenteditable='true'
            
            String editLIBERADOSCCHO=ocultar;//contenteditable='true'
            String editACEPTARCCHO=ocultar;//contenteditable='true'
            String editINVOCCHO=ocultar;//contenteditable='true'
            String editLAVADOSCCHO=ocultar;//contenteditable='true'
            String editPALLETCCHO=ocultar;//contenteditable='true'
            
            String editLIBERADOSCYO=ocultar;//contenteditable='true'
            String editACEPTARCYO=ocultar;//contenteditable='true'
            String editINVOCYO=ocultar;//contenteditable='true'
            String editLAVADOSCYO=ocultar;//contenteditable='true'
            String editPALLETCYO=ocultar;//contenteditable='true'
            
            
            String AeditLIBERADOSCCHA=ocultar;//contenteditable='true'
            String AeditACEPTARCCHA=ocultar;//contenteditable='true'
            String AeditINVOCCHA=ocultar;//contenteditable='true'
            String AeditLAVADOSCCHA=ocultar;//contenteditable='true'
            String AeditPALLETCCHA=ocultar;//contenteditable='true'
           
            String AeditLIBERADOSCCHB=ocultar;//contenteditable='true'
            String AeditACEPTARCCHB=ocultar;//contenteditable='true'
            String AeditINVOCCHB=ocultar;//contenteditable='true'
            String AeditLAVADOSCCHB=ocultar;//contenteditable='true'
            String AeditPALLETCCHB=ocultar;//contenteditable='true'
     
            String AeditLIBERADOSCCHH=ocultar;//contenteditable='true'
            String AeditACEPTARCCHH=ocultar;//contenteditable='true'
            String AeditINVOCCHH=ocultar;//contenteditable='true'
            String AeditLAVADOSCCHH=ocultar;//contenteditable='true'
            String AeditPALLETCCHH=ocultar;//contenteditable='true'
            
            String AeditLIBERADOSCCHO=ocultar;//contenteditable='true'
            String AeditACEPTARCCHO=ocultar;//contenteditable='true'
            String AeditINVOCCHO=ocultar;//contenteditable='true'
            String AeditLAVADOSCCHO=ocultar;//contenteditable='true'
            String AeditPALLETCCHO=ocultar;//contenteditable='true'
            
            String AeditLIBERADOSCYO=ocultar;//contenteditable='true'
            String AeditACEPTARCYO=ocultar;//contenteditable='true'
            String AeditINVOCYO=ocultar;//contenteditable='true'
            String AeditLAVADOSCYO=ocultar;//contenteditable='true'
            String AeditPALLETCYO=ocultar;//contenteditable='true'
            
            
                   
               
                String fecha_form=rs.getString("fecha_format").replaceAll("/", "");
                grilla_html=grilla_html+
            "<tr class='item-model-number'  >"
                   + "<td style='color: #fff; background: black;font-weight:bold'>"+rs.getString("fecha_format" )+"</td>"
                   + "<td  style='color: #fff; background:  brown;font-weight:bold'   > "+rs.getString(2)+" </td>" ;                                                                        
                    
                    cont_id++;
                    
                    String id_td=String.valueOf(cont_id);
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("LIBERADOSCCHA")>0){
                        id_td="ID";
                        editLIBERADOSCCHA="contenteditable='true'  style='color: #fff; background: black;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nLiberados'";  
                        AeditLIBERADOSCCHA="style='font-weight:bold'";
                    }
                    
                    
                    grilla_html=grilla_html+ "<td "+AeditLIBERADOSCCHA+" class='text-center "+ "LIB_"+id_td+"_"+fecha_form+"_CCHA_"+rs.getString(2)+"'  >"+rs.getInt("LIBERADOSCCHA")*12+"    </td>   <td "+editLIBERADOSCCHA+"      class='text-center celda_editable single_line'  >   0 </td>";
                    
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("ACEPTARCCHA")>0){
                        id_td="ID";
                        editACEPTARCCHA="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nAceptados tal cual'";  
                        AeditACEPTARCCHA="style='font-weight:bold'";    
                    }
                    grilla_html=grilla_html + "<td   "+AeditACEPTARCCHA+"  class='text-center "+ "ACEP_"+id_td+"_"+fecha_form+"_CCHA_"+rs.getString(2)+"' >     "+rs.getInt("ACEPTARCCHA")*12+"    </td>     <td "+editACEPTARCCHA+"       class='text-center celda_editable single_line'  >   0   </td>";
                    
                    cont_id++; 
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("INVOCCHA")>0){
                        id_td="ID";
                        editINVOCCHA="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nFechas involucradas'";  
                    AeditINVOCCHA="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html + "<td  "+AeditINVOCCHA+"   class='text-center "+ "INVO_"+id_td+"_"+fecha_form+"_CCHA_"+rs.getString(2)+"' >     "+rs.getInt("INVOCCHA")*12+" </td>        <td "+editINVOCCHA+"       class='text-center celda_editable single_line'  >   0   </td>";
                    
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("LAVADOSCCHA")>0){
                        id_td="ID";
                        editLAVADOSCCHA="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nLavados'";  
                    AeditLAVADOSCCHA="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html  + "<td "+AeditLAVADOSCCHA+"    class='text-center "+ "LDO_"+id_td+"_"+fecha_form+"_CCHA_"+rs.getString(2)+"'  >    "+rs.getInt("LAVADOSCCHA")*12+" </td>        <td "+editLAVADOSCCHA+"       class='text-center celda_editable single_line'  >   0   </td>";
                    
                    
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("PALLETCCHA")>0){
                        id_td="ID";
                        editPALLETCCHA="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nPallet'";  
                    AeditPALLETCCHA="style='font-weight:bold'";
                    }
                    
                    grilla_html=grilla_html  + "<td "+AeditPALLETCCHA+"     class='text-center "+ "PAL_"+id_td+"_"+fecha_form+"_CCHA_"+rs.getString(2)+"'  >    "+rs.getInt("PALLETCCHA")*12+" </td>        <td "+editPALLETCCHA+"       class='text-center celda_editable single_line'  >   0   </td>";
                   
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("LIBERADOSCCHB")>0){
                        id_td="ID";
                        editLIBERADOSCCHB="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nLiberados'";  
                    AeditLIBERADOSCCHB="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html  + "<td  "+AeditLIBERADOSCCHB+" class='text-center column_verde "+ "LIB_"+id_td+"_"+fecha_form+"_CCHB_"+rs.getString(2)+"'  > "+rs.getInt("LIBERADOSCCHB")*12+" </td>        <td "+editLIBERADOSCCHB+"       class='text-center celda_editable single_line column_verde'  >   0   </td>";
                   
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("ACEPTARCCHB")>0){
                        id_td="ID";
                        editACEPTARCCHB="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nAceptados tal cual'";  
                   AeditACEPTARCCHB ="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html  + "<td "+AeditACEPTARCCHB+"   class='text-center column_verde "+ "ACEP_"+id_td+"_"+fecha_form+"_CCHB_"+rs.getString(2)+"' >    "+rs.getInt("ACEPTARCCHB")*12+" </td>        <td "+editACEPTARCCHB+"       class='text-center celda_editable single_line column_verde'  >   0   </td>";
                   
                    cont_id++; 
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("INVOCCHB")>0){
                        id_td="ID";
                        editINVOCCHB="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nFechas involucradas'";  
                   AeditINVOCCHB="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html + "<td  "+AeditINVOCCHB+"   class='text-center column_verde "+ "INVO_"+id_td+"_"+fecha_form+"_CCHB_"+rs.getString(2)+"' >     "+rs.getInt("INVOCCHB")*12+" </td>        <td "+editINVOCCHB+"       class='text-center celda_editable single_line column_verde'  >   0   </td>";
                    cont_id++; 
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("LAVADOSCCHB")>0){
                        id_td="ID";
                        editLAVADOSCCHB="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nLavados'";  
                        AeditLAVADOSCCHB="style='font-weight:bold'";
                    }
                  
                    grilla_html=grilla_html  + "<td "+AeditLAVADOSCCHB+"  class='text-center column_verde "+ "LDO_"+id_td+"_"+fecha_form+"_CCHB_"+rs.getString(2)+"'  >    "+rs.getInt("LAVADOSCCHB")*12+" </td>       <td "+editLAVADOSCCHB+"       class='text-center celda_editable single_line column_verde'  >   0   </td>";
                    
                    cont_id++; 
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("PALLETCCHB")>0){
                        id_td="ID";
                        editPALLETCCHB="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nPallet'";  
                    AeditPALLETCCHB="style='font-weight:bold'";
                    }
                    
                    grilla_html=grilla_html  + "<td "+AeditPALLETCCHB+"  class='text-center column_verde "+ "PAL_"+id_td+"_"+fecha_form+"_CCHB_"+rs.getString(2)+"'  >    "+rs.getInt("PALLETCCHB")*12+" </td>        <td "+editPALLETCCHB+"       class='text-center celda_editable single_line column_verde'  >   0   </td>";
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("LIBERADOSCCHH")>0){
                        id_td="ID";
                        editLIBERADOSCCHH="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nLiberados'";  
                    AeditLIBERADOSCCHH="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html  + "<td "+AeditLIBERADOSCCHH+"  class='text-center "+ "LIB_"+id_td+"_"+fecha_form+"_CCHH_"+rs.getString(2)+"'  >    "+rs.getInt("LIBERADOSCCHH")*12+" </td>       <td "+editLIBERADOSCCHH+"       class='text-center celda_editable single_line'  >   0   </td>";
                    
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("ACEPTARCCHH")>0){
                        id_td="ID";
                        editACEPTARCCHH="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nAceptados tal cual'";  
                   AeditACEPTARCCHH="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html   + "<td  "+AeditACEPTARCCHH+"  class='text-center "+ "ACEP_"+id_td+"_"+fecha_form+"_CCHH_"+rs.getString(2)+"' >   "+rs.getInt("ACEPTARCCHH")*12+" </td>       <td "+editACEPTARCCHH+"      class='text-center celda_editable single_line'  >   0   </td>";
                   
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("INVOCCHH")>0){
                        id_td="ID";
                        editINVOCCHH="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nFechas involucradas'";  
                        AeditINVOCCHH="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html   + "<td "+AeditINVOCCHH+"  class='text-center  "+ "INVO_"+id_td+"_"+fecha_form+"_CCHH_"+rs.getString(2)+"' >    "+rs.getInt("INVOCCHH")*12+" </td>       <td "+editINVOCCHH+"      class='text-center celda_editable single_line'  >   0   </td>";
                    
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("LAVADOSCCHH")>0){
                        id_td="ID";
                        editLAVADOSCCHH="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nLavados'";  
                   AeditLAVADOSCCHH="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html   + "<td  "+AeditLAVADOSCCHH+" class='text-center "+ "LDO_"+id_td+"_"+fecha_form+"_CCHH_"+rs.getString(2)+"'  >    "+rs.getInt("LAVADOSCCHH")*12+" </td>       <td "+editLAVADOSCCHH+"      class='text-center celda_editable single_line'  >   0   </td>";
                    
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("PALLETCCHH")>0){
                        id_td="ID";
                        editPALLETCCHH="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nPallet'";  
                        AeditPALLETCCHH="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html  + "<td "+AeditPALLETCCHH+"  class='text-center "+ "PAL_"+id_td+"_"+fecha_form+"_CCHH_"+rs.getString(2)+"'  >    "+rs.getInt("PALLETCCHH")*12+" </td>        <td "+editPALLETCCHH+"       class='text-center celda_editable single_line'  >   0   </td>";
                    
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("LIBERADOSCCHO")>0){
                        id_td="ID";
                        editLIBERADOSCCHO="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nLiberados'";  
                    AeditLIBERADOSCCHO="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html    + "<td "+AeditLIBERADOSCCHO+"  class='text-center column_verde "+ "LIB_"+id_td+"_"+fecha_form+"_OVO_"+rs.getString(2)+"'  >    "+rs.getInt("LIBERADOSCCHO")*12+" </td>       <td "+editLIBERADOSCCHO+"      class='text-center celda_editable single_line column_verde'  >   0   </td>";
                    
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("ACEPTARCCHO")>0){
                        id_td="ID";
                        editACEPTARCCHO="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nAceptados tal cual'";  
                        AeditACEPTARCCHO ="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html   + "<td  "+AeditACEPTARCCHO+"  class='text-center column_verde "+ "ACEP_"+id_td+"_"+fecha_form+"_OVO_"+rs.getString(2)+"' >    "+rs.getInt("ACEPTARCCHO")*12+" </td>       <td "+editACEPTARCCHO+"      class='text-center celda_editable single_line column_verde'  >   0   </td>";
                    
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("INVOCCHO")>0){
                        id_td="ID";
                        editINVOCCHO="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nFechas involucradas'";  
                    AeditINVOCCHO="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html   + "<td "+AeditINVOCCHO+"  class='text-center column_verde "+ "INVO_"+id_td+"_"+fecha_form+"_OVO_"+rs.getString(2)+"'  >   "+rs.getInt("INVOCCHO")*12+" </td>       <td "+editINVOCCHO+"      class='text-center celda_editable single_line column_verde'  >   0   </td> ";
                    
                     cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("PALLETCCHO")>0){
                        id_td="ID";
                        editPALLETCCHO="contenteditable='true' style='color: #fff; background: green;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nPallet'";  
                   AeditPALLETCCHO="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html  + "<td "+AeditPALLETCCHO+"  class='text-center column_verde "+ "PAL_"+id_td+"_"+fecha_form+"_OVO_"+rs.getString(2)+"'  >    "+rs.getInt("PALLETCCHO")*12+" </td>        <td "+editPALLETCCHO+"       class='text-center celda_editable single_line column_verde'  >   0   </td>";
                    
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("LIBERADOSCYO")>0){
                        id_td="ID";
                        editLIBERADOSCYO="contenteditable='true' style='color: #fff; background: black;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nLiberados'";  
                   AeditLIBERADOSCYO ="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html  + "<td "+AeditLIBERADOSCYO+"  class='text-center "+ "LIB_"+id_td+"_"+fecha_form+"_CYO_"+rs.getString(2)+"'  >    "+rs.getInt("LIBERADOSCYO")*12+" </td>       <td "+editLIBERADOSCYO+"       class='text-center celda_editable single_line'  >   0   </td>";
                    
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("ACEPTARCYO")>0){
                        id_td="ID";
                        editACEPTARCYO="contenteditable='true' style='color: #fff; background: black;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nAceptados tal cual'";  
                  AeditACEPTARCYO ="style='font-weight:bold'";
                    }
                    
                    grilla_html=grilla_html   + "<td "+AeditACEPTARCYO+"   class='text-center "+ "ACEP_"+id_td+"_"+fecha_form+"_CYO_"+rs.getString(2)+"' >   "+rs.getInt("ACEPTARCYO")*12+" </td>       <td "+editACEPTARCYO+"      class='text-center celda_editable single_line'  >   0   </td>";
                   
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("INVOCYO")>0){
                        id_td="ID";
                        editINVOCYO="contenteditable='true' style='color: #fff; background: black;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nFechas involucradas'";  
                   AeditINVOCYO ="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html   + "<td "+AeditINVOCYO+"  class='text-center  "+ "INVO_"+id_td+"_"+fecha_form+"_CYO_"+rs.getString(2)+"' >    "+rs.getInt("INVOCYO")*12+" </td>       <td "+editINVOCYO+"      class='text-center celda_editable single_line'  >   0   </td>";
                    
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("LAVADOSCYO")>0){
                        id_td="ID";
                        editLAVADOSCYO="contenteditable='true' style='color: #fff; background: black;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nLavados'";  
                   AeditLAVADOSCYO ="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html   + "<td  "+AeditLAVADOSCYO+"  class='text-center "+ "LDO_"+id_td+"_"+fecha_form+"_CYO_"+rs.getString(2)+"'  >    "+rs.getInt("LAVADOSCYO")*12+" </td>       <td "+editLAVADOSCYO+"      class='text-center celda_editable single_line'  >   0   </td>";
                    
                    cont_id++;
                    id_td=String.valueOf(cont_id);
                    if(rs.getInt("PALLETCYO")>0){
                        id_td="ID";
                        editPALLETCYO="contenteditable='true' style='color: #fff; background: black;' title='Fecha puesta: "+rs.getString("fecha_format")+"\nTipo de huevo: "+rs.getString(2)+"\nPallet'";  
                        AeditPALLETCYO ="style='font-weight:bold'";
                    }
                    grilla_html=grilla_html  + "<td "+AeditPALLETCYO+"  class='text-center  "+ "PAL_"+id_td+"_"+fecha_form+"_CYO_"+rs.getString(2)+"'  >    "+rs.getInt("PALLETCYO")*12+" </td>        <td "+editPALLETCYO+"       class='text-center celda_editable single_line'  >   0   </td>";
                    grilla_html=grilla_html  + " </tr>";
          cont_fila++; 
        }
       
              String cabecera_mixto="<div id='second' style=' float: left;  '> "
                      + " <table id='tb_preembarque_mixto' class='stripe order-column dataTable no-footer' style='width:70%'>"
            + "<thead>"
               + " <tr>"
            + "<th colspan='6'  style='color: #fff; background: black;'  class='text-center'  ><b>CARROS MIXTOS</b></th>  </tr>"
            + "<tr>"
            + "<th  style='color: #fff; background: black;'>CARRO</th>      "
               + "<th style='color: #fff; background: green;' >AREA</th>"
               + "<th style='color: #fff; background: green;' >PUESTA</th>"
               + "<th style='color: #fff; background: green;' >DETALLE CAJONES</th>"
              + "</tr>"
            + "</thead> <tbody > ";
     String grilla_html2 ="";  
         rs2 = fuente.obtenerDato("select cod_carrito,cantidad_caj,clasificadora_actual,convert(varchar,fecha_puesta,103) as fecha_puesta,tipo_huevo "
                 + "from v_mae_log_stock_pedidos_maehara_cajones"
                 + " where   cod_carrito not in (select cod_carrito from  mae_log_ptc_det_pedidos with(nolock) where estado in (1,2) and u_medida='MIXTO') order by 1,4");
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
                "<td style='font-weight:bold'  >"+cod_carrito+"</td>"+  
                "<td style='font-weight:bold'  >"+area_unido+"</td>"+   
                "<td style='font-weight:bold'  >"+fp_unido+"</td>"+ 
                "<td style='font-weight:bold' class='something' >"+cajones_unidos+"</td>"+ " "
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
                "<td style='font-weight:bold'  >"+cod_carrito+"</td>"+  
                "<td style='font-weight:bold'  >"+area_unido+"</td>"+   
                "<td style='font-weight:bold'  >"+fp_unido+"</td>"+ 
                "<td style='font-weight:bold' class='something' >"+cajones_unidos+"</td>"+ " "
                + "</tr>";
        }
       
        
        clases.controles.DesconnectarBD();
         JSONObject ob = new JSONObject();
        ob=new JSONObject();
 
        ob.put("grilla",cabecera+grilla_html+"</tbody></table></div>");
        ob.put("grilla_mixto",cabecera_mixto+grilla_html2+"</tbody></table></div></div></div></div>");
        out.print(ob);  %> 