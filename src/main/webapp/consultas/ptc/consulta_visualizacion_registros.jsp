<%@page import="clases.controles"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %> 
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@include  file="../../chequearsesion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
<% 
        String calendario    = request.getParameter("calendario_informe");
        String area = (String) sesionOk.getAttribute("clasificadora");
        String cbox_estado_liberacion =request.getParameter("estado");

        JSONObject ob = new JSONObject();
        ob=new JSONObject();
    try {
        
            controles.VerificarConexion();
            //clases.controles.connectarBD();   
             //Connection cn = clases.controles.connect; 
            fuente.setConexion(clases.controles.connectSesion);
            ResultSet rsCab1= fuente.obtenerDato("  exec    [mae_ptc_select_retenidos_total_cantidad]   @fecha='"+calendario+"',@area='"+area+"'"); 
            ResultSet rsCab2 = fuente.obtenerDato(" exec    [mae_ptc_select_totalCarrosTipos]           @fecha='"+calendario+"',@clasificadora='"+area+"' ");
            ResultSet rsCab3 = fuente.obtenerDato(" exec    [mae_ptc_select_total_cajones]              @clasificadora='"+area+"', @fecha='"+calendario+"' ");

            ResultSet rsdet = fuente.obtenerDato("   exec [mae_ptc_select_registrados_porFecha] @clasificadora='"+area+"', @fecha='"+calendario+"',@estado_liberacion='"+cbox_estado_liberacion+"'");

            String cab1="";
            String cab2="";
            String cab3="";
            String det="";
            String grillaTotal="";
            String cab_det="  <table id='grilla_lotes' class='table table-striped table-bordered' style='width:100%'>"
            + " <thead><tr><th>ACCION</th><th>Fecha clasifi</th><th>Nro. carro</th><th>Origen</th><th>Tipo</th>               <th>Categoria</th>                <th>Fecha puesta </th>        "
            + "        <th>Hora</th>                <th>Responsable clasificación</th>                <th>U.medida</th>                 <th>Cantidad</th>                 <th>Aviario</th>     "
            + "            <th>Empacadora</th>                 <th>T.almacenamiento</th>                  <th>Liberado por</th>                 <th>Comentario</th>                 <th>Estado liberación</th>      "
            + "           <th>Disposicion</th>                 <th>Costeo</th> <th>ID</th>             </tr>      </thead>";
           
            String pie_det="   </table>";
            
             if(rsCab1.next()){
                 cab1="   "
                         + " <div style='background-color:#ffff66;'  > <b>CANTIDAD DE LIBERADOS Y RETENIDOS</b></div>"
                         + "<table style='background-color:#ffff99;' class='table'   data-row-style='rowStyle' data-toggle='table' "
                    + "data-click-to-select='true'> <thead> "
                         + "<tr> <th style='background-color:green'><b>LIBERADOS CARROS</b></th>  "
                    + "<th style='background-color:red'><b>RETENIDOS CARROS</b></th>  "
                         + "<th style='background-color:green'><b>LIBERADOS CAJONES</b></th> "
                    + "<th style='background-color:red'><b>RETENIDOS CAJONES</b></th> </tr>  </thead>    <tbody>"
                    + " <tr>  "
                    + "     <td><b>"+rsCab1.getString(1)+"</b></td> "
                    + "     <td><b>"+rsCab1.getString(2)+"</b></td> "
                    + "     <td><b>"+rsCab1.getString(3)+"</b></td> "
                    + "     <td><b>"+rsCab1.getString(4)+"</b></td> "
                    + "</tr></tbody></table> ";
                  
             }
             int b=0;
              if(rsCab2.next()){
                  cab2=" <br>  "
                         + " <div style='background-color:#ffff66;'  > <b>EN CARRITOS</b></div>"
                         + "<table style='background-color:#ffff99;' class='table'   data-row-style='rowStyle' data-toggle='table' "
                    + "data-click-to-select='true'> "
                        + "<tr>"
                            + "<th style='background-color:green'><b>A</b></th> "
                            + "<th style='background-color:red'><b>A</b></th>  "
                            + "<th style='background-color:green'><b>B</b></th>   "
                            + "<th style='background-color:red'><b>B</b></th>    "
                            + "<th style='background-color:green'><b>C</b></th>   "
                            + "<th style='background-color:red'><b>C</b></th>   "
                            + "<th style='background-color:green'><b>4TA</b></th>  "
                            + "<th style='background-color:red'><b>4TA</b></th>    "
                            + "<th style='background-color:green'><b>S</b></th>   "
                            + "<th style='background-color:red'><b>S</b></th>  "
                            + "<th style='background-color:green'><b>J</b></th>    "
                            + "<th style='background-color:red'><b>J</b></th>  "
                            + "<th style='background-color:green'><b>G</b></th>    "
                            + "<th style='background-color:red'><b>G</b></th> "
                        + "</tr>  "
                        + "</thead>    "
                        + "<tbody>"
                        + " <tr>  "
                        + "     <td><b>"+rsCab2.getString(2)+"</b></td> "
                        + "     <td><b>"+rsCab2.getString(3)+"</b></td> "
                        + "     <td><b>"+rsCab2.getString(4)+"</b></td> "
                        + "     <td><b>"+rsCab2.getString(5)+"</b></td> "
                        + "     <td><b>"+rsCab2.getString(6)+"</b></td> "
                        + "     <td><b>"+rsCab2.getString(7)+"</b></td> "
                        + "     <td><b>"+rsCab2.getString(8)+"</b></td> "
                        + "     <td><b>"+rsCab2.getString(9)+"</b></td> "
                        + "     <td><b>"+rsCab2.getString(10)+"</b></td> "
                        + "     <td><b>"+rsCab2.getString(11)+"</b></td> "
                        + "     <td><b>"+rsCab2.getString(12)+"</b></td> "
                        + "     <td><b>"+rsCab2.getString(13)+"</b></td> "
                        + "     <td><b>"+rsCab2.getString(14)+"</b></td> "
                        + "     <td><b>"+rsCab2.getString(15)+"</b></td> "
                        + " </tr></tbody></table> ";
                  b++;
             }
              
              int c=0;
               if(rsCab3.next()){
                  cab3=" <br>  "
                         + " <div style='background-color:#66ff66;'  > <b>EN CAJONES</b></div>"
                         + "<table style='background-color:#99ff99;' class='table'   data-row-style='rowStyle' data-toggle='table' "
                    + "data-click-to-select='true'> "
                        + "<tr>"
                            + "<th style='background-color:green'><b>A</b></th> "
                            + "<th style='background-color:red'><b>A</b></th>  "
                            + "<th style='background-color:green'><b>B</b></th>   "
                            + "<th style='background-color:red'><b>B</b></th>    "
                            + "<th style='background-color:green'><b>C</b></th>   "
                            + "<th style='background-color:red'><b>C</b></th>   "
                            + "<th style='background-color:green'><b>4TA</b></th>  "
                            + "<th style='background-color:red'><b>4TA</b></th>    "
                            + "<th style='background-color:green'><b>S</b></th>   "
                            + "<th style='background-color:red'><b>S</b></th>  "
                            + "<th style='background-color:green'><b>J</b></th>    "
                            + "<th style='background-color:red'><b>J</b></th>  "
                            + "<th style='background-color:green'><b>G</b></th>    "
                            + "<th style='background-color:red'><b>G</b></th> "
                        + "</tr>  "
                        + "</thead>    "
                        + "<tbody>"
                        + " <tr>  "
                         + "     <td><b>"+rsCab3.getString(2)+"</b></td> "
                        + "     <td><b>"+rsCab3.getString(3)+"</b></td> "
                        + "     <td><b>"+rsCab3.getString(4)+"</b></td> "
                        + "     <td><b>"+rsCab3.getString(5)+"</b></td> "
                        + "     <td><b>"+rsCab3.getString(6)+"</b></td> "
                        + "     <td><b>"+rsCab3.getString(7)+"</b></td> "
                        + "     <td><b>"+rsCab3.getString(8)+"</b></td> "
                        + "     <td><b>"+rsCab3.getString(9)+"</b></td> "
                        + "     <td><b>"+rsCab3.getString(10)+"</b></td> "
                        + "     <td><b>"+rsCab3.getString(11)+"</b></td> "
                        + "     <td><b>"+rsCab3.getString(12)+"</b></td> "
                        + "     <td><b>"+rsCab3.getString(13)+"</b></td> "
                        + "     <td><b>"+rsCab3.getString(14)+"</b></td> "
                        + "     <td><b>"+rsCab3.getString(15)+"</b></td> "
                        + " </tr>"
                          + "</tbody>"
                          + "</table> ";
                  c++;
             }
               
             
 
            rsdet = fuente.obtenerDato("  exec [mae_ptc_select_registrados_porFecha] @clasificadora='"+area+"', @fecha='"+calendario+"',@estado_liberacion='"+cbox_estado_liberacion+"'");
            while(rsdet.next())
            { 
                    det=det+"<tr>   <td><input type='button' value='Editar' class='btn btn-primary otherButton' data-toggle='modal' data-target='#modal_obs'  "
                    + "   ></td>"
                    + "<td><b>"+rsdet.getString("fecha")+"</b>    </td> "
                    + " <td><b>"+rsdet.getString("cod_carrito")+"   </b></td>"
                    + "<td><b>"+rsdet.getString("origen")+"   </b></td>"
                    + "<td><b>"+rsdet.getString("tipo_huevo")+"    </b></td>"
                    + "<td><b>"+rsdet.getString("categoria")+"    </b></td>"
                    + "<td><b>"+rsdet.getString("fecha_puesta")+"    </b></td>"
                    + "<td><b>"+rsdet.getString("hora_clasificacion")+"    </b></td>"
                    + "<td><b>"+rsdet.getString("resp_clasificacion")+"   </b></td>  "
                    + "<td><b>"+rsdet.getString("u_medida")+"   </b></td>  "
                    + "<td><b>"+rsdet.getString("cantidad")+"   </b></td>  "
                    + " <td><b>"+rsdet.getString("aviario")+"  </b></td>  "
                    + "<td><b>"+rsdet.getString("empacadora")+"   </b></td> "
                    + " <td><b>"+rsdet.getString("tipo_almacenamiento")+"  </b></td>  "
                    + "<td><b>"+rsdet.getString("liberado_por")+"  </b></td>  "
                    + "<td><b>"+rsdet.getString("comentario")+"   </b></td>  "
                    + "<td><b>"+rsdet.getString("estado_liberacion")+"  </b> </td> "
                    + "<td><b>"+rsdet.getString("disposicion")+"   </b></td> "
                    + "<td><b>"+rsdet.getString("estado")+"  </b></td> "
                    + "<td><b>"+rsdet.getString("cod_interno")+"  </b></td> "
                    + "</tr>";
            }
            
                
               
               if(c==0){
                  cab3="  <div class='alert alert-danger alert-dismissible fade show' role='alert'>  "
                          + " <strong><center>NO DISPONE DE CAJONES.</center></strong>   "
                          + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>  "
                          + "<span aria-hidden='truecab3'>&times;</span>  </button>  </div>";
               } 
               
                 if(b==0){
                  cab2="  <div class='alert alert-danger alert-dismissible fade show' role='alert'>  "
                          + " <strong><center>NO DISPONE DE CARROS.</center></strong>   "
                          + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>  "
                          + "<span aria-hidden='truecab3'>&times;</span>  </button>  </div>";
               } 
                 grillaTotal=cab_det+det+pie_det;
                String total=cab1+" "+cab2+cab3+"<br>"+grillaTotal;
               // cn.close();
              clases.controles.DesconnectarBDsession();
                ob.put("table", total);
                out.print(ob);
                
        } catch (Exception e) {
        }
         %>
  