<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../versiones.jsp" %>


<%     
    String version = contenedores_ptc_informe_kpi_dinamico;
    String descripcion = DESC_contenedores_ptc_informe_kpi_dinamico;
    String pdf          =  pdf_contenedores_ptc_informe_kpi_dinamico;
%> 
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>','<%=descripcion%>','<%=pdf%>',true)">
    <label neme="label_contenido" id="label_contenido"><%=version%></label>  
</div>
</head>
<div>
 
        <div class="col-lg-20 ">
            <div class="position-relative p-3 bg-navy"  >
                <div class="ribbon-wrapper">
                    <div class="ribbon bg-warning">
                        PTC
                    </div>
                </div>
                <center><b>MENU INDICADORES DE PORCENTAJE KPI CYO</b></center>
            </div>  
            </div>  
   
                 <tr>                    
                     <td><div class="btn btn-xs bg-navy" onclick="ir_indicador_global_ptc()"  >Indicadores globales <i class="fa fa-eye"></i></div></td>
                     <td><div class="btn btn-xs bg-danger" onclick="ir_indicador_global_detallados_ptc()" >Indicadores detallados por tipos Subproductos, Reprocesos y PTC <i class="fa fa-eye"></i></div></td>
                </tr>  
               
                
                
            </table>
            
            <div id="contenedor_indicadores">
                
                
            </div>