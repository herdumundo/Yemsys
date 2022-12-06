<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="clases.fuentedato"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@ page session="true" %>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>  
<%@ page contentType="text/html; charset=UTF-8" %>

<%    
    PreparedStatement pst, pst2,pst3;
    ResultSet rs, rs2,rs3;

    
    pst2 = connection.prepareStatement("SELECT         id, descripcion, capacidad, estado	"
            + " FROM            ppr_aviarios_capacidades			   where estado=1");
    rs2 = pst2.executeQuery();

    pst3 = connection.prepareStatement(" select * from ppr_razas");
    rs3 = pst3.executeQuery();

    String version = "Test";
    String desc_version = "Test";
    DecimalFormat formatea = new DecimalFormat("###,###.##");
    int aves_inicial=0;
    int aves_actual=0;
    int promedio_semana=0;
    try {

%>

<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block " href="#" data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>', 'DESCRIPCION:<%=desc_version%>')">
    <label ><%=version%> </label>  
</div>
</head>
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                ppr
            </div>
        </div>
        <center><b>PROYECCION DE PRODUCCIÓN PRIMARIA</b></center>
    </div>
</div>      

    



    <div id="div_grilla_pry">
        
        
    </div>

    
    
    

 
<div class="modal fade" id="modalLote" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header bg-black">
                <button class="close" type="button"  class="position-relative p-3 bg-navy"  data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>

            <div class="card">
                <div class="card-header p-2">
                    <ul class="nav nav-pills">
                        <li class="nav-item "><a class="nav-link"   href="#ajusLote"    data-toggle="tab">Ajuste lote</a></li>
                        <li class="nav-item"><a class="nav-link"    href="#modLote"     data-toggle="tab">Modificacion lote</a></li>
                        <li class="nav-item"><div id="div_crear_pred"><input type="button" value=crear predescarte""></div></li>
                    </ul>
                </div>
                <div class="card-body">
                    <div class="tab-content"> 

                        <div class="tab-pane" id="modLote">
                            <div class="modal-body bg-navy"   >  

                                <form  id="form_upd_user" action="POST"  style=" height: 400px">

                                    <input hidden="true" class="form-control text-left " type="text" style="width: 100%" disabled="true" id="txt_id"    name="txt_id">
                                    <strong><a>Lote</a></strong> 
                                    <input class="form-control text-left " style="width: 100%" type="text"   id="txt_lote"    name="txt_lote"      readonly="true" >
                                    <strong><a>Aviario</a></strong>
                                    <input class="form-control text-left " style="width: 100%" type="text"   id="txt_aviario"    name="txt_aviario"      readonly="true" >

                                    <strong><a>Cantidad de aves</a></strong>
                                    <input class="form-control text-left " style="width: 100%" type="number"   id="txt_cantidad_aves"    name="txt_cantidad_aves"  >
                                    <strong><a>Fecha de nacimiento</a></strong>
                                    <input class="form-control text-left   " style="width: 100%" type="date"   id="txt_fecha_nacimiento"  onchange="sumar_dias_fechas_ppr($('#txt_fecha_nacimiento').val())"  name="txt_fecha_nacimiento"  >

                                    <strong><a id="label_produccion">Edad a PPR  117 dias  </a></strong>
                                    <input class="form-control text-left    " style="width: 100%" type="date"  onchange="contar_dias_proyeccion_ppr()"  id="txt_fecha_produccion"    name="txt_fecha_produccion"  >
                                    <strong><a id="label_predescarte">Edad a predescarte 594 dias </a></strong>
                                    <input class="form-control text-left   " style="width: 100%" type="date"   id="txt_fecha_predescarte"  onchange="contar_dias_proyeccion_ppr()"   name="txt_fecha_predescarte"  >





                                    <div class="modal-footer align-right">
                                        <input  class="btn bg-white"  type="button"  onclick="control_modificar_proyeccion_lote_ppr()"  id="btn_apd_usuario" value="Modificar" >
                                        <input  class="btn bg-white"  type="button"   data-dismiss="modal"   value="Cancelar" >            
                                    </div>
                                </form>   
                            </div>
                        </div>
                        <!-- COMIENZA EL NUEVO FRAME-->

                        <div class="tab-pane" id="ajusLote"> 
                            <div class="modal-body bg-navy"   >  


                                <input hidden="true"  id="txt_id_ajuste"  >
                                <input hidden="true"  id="txt_fnac_ajuste"  >
                                <table class="table">
                                    <tr> 
                                        <th> <strong><a>Lote</a></strong> 
                                            <input class="form-control text-left " style="width: 100%" type="text"   id="txt_lote_ajuste"      disabled></th>
                                        <th><strong><a>Aviario</a></strong>
                                            <input class="form-control text-left " style="width: 100%" type="text"   id="txt_aviario_ajuste" disabled ></th>
                                    </tr>

                                    <tr>  <th> <strong><a>Fecha de ajuste</a></strong>
                                            <input class="form-control text-left is-invalid  "  style="width: 100%" type="date"   id="txt_fecha_ajuste"  onchange="sumar_dias_semanas_ajuste_ppr()"  name="txt_fecha_nacimiento"  >
                                        </th>
                                        <th> <strong><a>Saldo de aves</a></strong>
                                            <input class="form-control text-left " style="width: 100%" type="number"   id="txt_cantidad_aves_ajuste" disabled   ></th>
                                    </tr>
                                    <tr>
                                        <th>Edad (Dias) <a class="text-red" id="label_dias_ajuste">115</a></th>
                                        <th>Edad (Semanas) <a class="text-red"  id="label_semanas_ajuste" >16</a></th>   
                                    </tr>

                                    <tr> 
                                        <th> <strong><a>Nuevo saldo</a></strong> 
                                            <input class="form-control text-left is-invalid " style="width: 100%" type="number"   id="txt_nuevo_saldo_ajuste"   onchange="diferencia_saldo_ajuste_lote_proyeccion_ppr()"  ></th>
                                        <th><strong><a>Ajuste</a></strong>
                                            <input class="form-control text-left  " style="width: 100%" type="number"   id="txt_cantidad_ajuste" disabled ></th>
                                    </tr>
                                    <tr> 
                                        <th> <strong><a>Edad predescarte (días)</a></strong> 
                                            <input id="txt_edad_dias_pred_ajuste"  name="txt_edad_dias_pred_ajuste" required class="form-control text-left is-invalid " style="width: 100%" type="number"   onchange="cal_fecha_dia_predescarte_ajuste_pry_ppr()"      >
                                        </th>
                                        <th> <strong><a>(Semanas)</a></strong> 
                                            <input id="txt_edad_sems_pred_ajuste"  name="txt_edad_sems_pred_ajuste"  class="form-control text-left   " style="width: 100%" type="text"     readonly   >
                                        </th>
                                        <th><strong><a>Fecha de predescarte</a></strong>
                                            <input  id="txt_fecha_predescarte_ajuste" name="txt_fecha_predescarte_ajuste"  class="form-control text-left  " style="width: 100%" type="date"  readonly ></th>  
                                    </tr>  


                                </table> 
                                <strong><a>Comentario</a></strong> 
                                <textarea class="form-control" id="comentario_ajuste" placeholder="Ingrese comentario" > </textarea>


                                <div class="modal-footer align-right">
                                    <input  class="btn bg-white"  type="button"  onclick="control_modificar_proyeccion_lote_ajuste_ppr()"  value="Registrar" >
                                    <input  class="btn bg-white"  type="button"   data-dismiss="modal"   value="Cancelar" >            
                                </div>
                            </div>
                        </div>
                    </div> 
                </div> 
            </div>
        </div>
    </div>
</div>

 
<div class="modal fade" id="modal_crear_lote" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header bg-black">
                <h5 class="modal-title" id="exampleModalLabel">Registro de lote</h5>
                <button class="close" type="button"  class="position-relative p-3 bg-navy"  data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body bg-navy"   >  

                 
                    <div class="card-body">
                        <div class="tab-content"> 

                                 <div class="modal-body bg-navy"   >  

                                    <form id="form_crear" >
                                        <table class="table">
                                            <tr> 
                                                <th> <strong><a>Lote</a></strong> 
                                                    <input  id="txt_lote_crear" name="txt_lote_crear"  class="form-control text-left  is-invalid " required placeholder="Ingrese lote" style="width: 100%" type="text"     >
                                                </th>
                                                <th>
                                                    <strong><a>Aviario</a></strong>
                                                    <select id="select_aviario_crear" name="select_aviario_crear"  class="form-control  is-invalid " onchange="capacidad_aviario_set_pry()">
                                                        <option value="-">Seleccione aviario</option>    
                                                        <% while (rs2.next()) {%>
                                                        <option data-capacidad="<%=rs2.getString("capacidad")%>" value="<%=rs2.getString("descripcion")%>"><%=rs2.getString("descripcion")%></option>
                                                        <%}%>
                                                    </select>  
                                                </th>
                                                <th> <strong><a>Capacidad</a></strong> 
                                                    <input  name="txt_capacidad_crear" class="form-control text-left "  style="width: 100%" type="text"   id="txt_capacidad_crear" readonly       >
                                                </th>
                                            </tr>

                                            <tr>  
                                                <th> <strong><a>Fecha de nacimiento A</a></strong>
                                                    <input  id="txt_fecha_nacA_crear"  name="txt_fecha_nacA_crear"  required  class="form-control text-left is-invalid  "  style="width: 100%" type="date"    onchange="sumar_dias_fechas_crear_ppr($('#txt_fecha_nacA_crear').val())"    >
                                                </th>
                                                <th> <strong><a>Fecha de nacimiento B</a></strong>
                                                    <input  id="txt_fecha_nacB_crear" name="txt_fecha_nacB_crear"   required  class="form-control text-left is-invalid  "  style="width: 100%" type="date"    >
                                                </th>
                                            </tr>
                                            <tr> 
                                                <th> <strong><a>Cantidad aves</a></strong> 
                                                    <input  id="txt_cant_aves_crear" name="txt_cant_aves_crear"  required class="form-control text-left is-invalid " style="width: 100%" type="number"     ></th>
                                                <th>
                                                    <strong><a>Raza</a></strong>
                                                    <select id="select_raza_crear"  name="select_raza_crear"  class="form-control  is-invalid " >
                                                        <option value="-">Seleccione raza</option>    
                                                        <% while (rs3.next()) {%>
                                                        <option value="<%=rs3.getString("raza_id")%>"><%=rs3.getString("raza_name")%></option>
                                                        <%}%>
                                                    </select>  
                                                </th>

                                                <th> 
                                                    <strong><a>Comentario</a></strong> 
                                                    <textarea id="comentario" name="comentario" class="form-control"  placeholder="Ingrese comentario" > </textarea>
                                                </th>
                                            </tr>

                                            <tr>
                                                <th> <strong><a>Edad produccion (días)</a></strong> 
                                                    <input  id="txt_eddad_dias_prod_crear" name="txt_eddad_dias_prod_crear" required  class="form-control text-left is-invalid " style="width: 100%" type="number"  onchange="cal_fecha_dia_crear_pry_ppr()"   ></th>
                                                <th> <strong><a>(Semanas)</a></strong> 
                                                    <input id="txt_eddad_sems_prod_crear" name="txt_eddad_sems_prod_crear"  class="form-control text-left   " style="width: 100%" type="text"   readonly  onchange="cal_fecha_dia_crear_pry_ppr()"      >
                                                </th> 
                                                <th><strong><a>Fecha de producción</a></strong>
                                                    <input  id="txt_fecha_produccion_crear" name="txt_fecha_produccion_crear" class="form-control text-left  " style="width: 100%" type="date"    readonly >
                                                </th>  
                                            </tr>


                                            <tr> 
                                                <th> <strong><a>Edad predescarte (días)</a></strong> 
                                                    <input id="txt_eddad_dias_pred_crear"  name="txt_eddad_dias_pred_crear" required class="form-control text-left is-invalid " style="width: 100%" type="number"   onchange="cal_fecha_dia_crear_pry_ppr()"      >
                                                </th>
                                                <th> <strong><a>(Semanas)</a></strong> 
                                                    <input id="txt_eddad_sems_pred_crear"  name="txt_eddad_sems_pred_crear"  class="form-control text-left   " style="width: 100%" type="text"     readonly   >
                                                </th>
                                                <th><strong><a>Fecha de predescarte</a></strong>
                                                    <input  id="txt_fecha_predescarte_crear" name="txt_fecha_predescarte_crear"  class="form-control text-left  " style="width: 100%" type="date"  readonly ></th>  
                                            </tr>    


                                        </table> 



                                        <div class="modal-footer align-right">
                                            <input  class="btn bg-white"  type="submit"    value="Registrar" >
                                            <input  class="btn bg-white"  type="button"   data-dismiss="modal"   value="Cancelar" >            
                                        </div>

                                    </form>   
                                </div>
                             <!-- COMIENZA EL NUEVO FRAME-->
                                   

                        </div> 
                    </div> 
                 
                
                
                
                             
            </div>
        </div>
    </div>
</div>   
  
 
<div class="modal fade right" id="exampleModalPreview" tabindex="-1" role="dialog" aria-labelledby="exampleModalPreviewLabel" aria-hidden="true">
    <div class="modal-dialog-full-width modal-dialog momodel modal-fluid" role="document">
        <div class="modal-content-full-width modal-content ">
            
            <div class="modal-body">
                <div class="input-group mb-3">


                    <div id="div_cabecera_graf_lote" style="width:100%; " > 

                         
                    </div>
                    <div class="card card-navy"  style="width:100%; ">   
                        <div class="card-header"> 
                            <h3 class="card-title">Viabilidad de aves</h3> <br> 
                        </div>
                        <canvas id="grafViab" width="1500" height="400"></canvas>   
                        
                         <div class="card-header "> 
                            <h3 class="card-title">Historial ajustes de aves</h3> <br> 
                        </div>
                        <div id="grilla_log" > 
                        </div>
                    </div> 
                     
                    
                    <div class="card card-navy"  style="width:100%; ">   
                        <div class="card-header"> 
                            <h3 class="card-title">Productividad de aves</h3> <br> 
                        </div>
                        <canvas id="grafProd" width="1500" height="400"></canvas> 
                        
                         <div class="card-header "> 
                            <h3 class="card-title">Historial contadores de huevos</h3> <br> 
                        </div>
                        <div id="grilla_log_prod" > 
                        </div>
                    </div> 
                    
                </div>
                <div class="modal-footer-full-width  modal-footer">
                    <button type="button" class="btn btn-danger btn-md btn-rounded" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>
</div>
      
              
                                  
                                <div class="card card-navy" >   
                                    <div class="card-header"> 
                                        <h3 class="card-title">Viabilidad de aves</h3> <br>                        

                                    </div> 
                                    <canvas id="grafico_gral_aves" width="1500" height="400">
                                    </canvas> 

                                </div> 

                                <div class="card card-navy" >   
                                    <div class="card-header"> 
                                        <h3 class="card-title">Semanas de aves</h3> <br>                        

                                    </div> 
                                    <canvas id="grafico_gral_semanas" width="1500" height="400"></canvas>


                                </div>                 

                                   <div class="card card-navy" >   
                                    <div class="card-header"> 
                                        <h3 class="card-title">Productividad de aves</h3> <br>                        

                                    </div> 
                                    <canvas id="grafico_gral_productividad" width="1500" height="400"></canvas>


                                </div> 
                                                    
                                                    <div class="card card-navy">   
                                    <div class="card-header"> 
                                        <h3 class="card-title">Proyección General</h3> <br>                        

                                    </div> 
                                    <div id="chart_div"   ></div>

                                </div>                          
                                

                            
<%
    } catch (Exception e) {

    } 
    finally 
    {
        connection.close();
    }
%> 

<style>
    
.box01{
  width: 100%;
    display: flex;
  align-items: flex-start;
}

.box02{
  width: 15%;
 }

.box03{
  width: 100%;
 }
    
</style>