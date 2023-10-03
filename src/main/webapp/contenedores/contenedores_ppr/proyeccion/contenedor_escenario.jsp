<%@page import="java.sql.PreparedStatement"%>
<%@page import="clases.fuentedato"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@ page session="true" %>
<%@include  file="../../../versiones.jsp" %>
<%@include file="../../../cruds/conexion.jsp" %>
<%@include  file="../../../chequearsesion.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%       
    String version = "Test";
    String desc_version = "Test";
    
 PreparedStatement pst, pst2,pst3;
    ResultSet rs, rs2,rs3;

    
    pst2 = connection.prepareStatement("SELECT         id, descripcion, capacidad, estado	"
            + " FROM            ppr_aviarios_capacidades			   where estado=1");
    rs2 = pst2.executeQuery();

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
        <center><b>LISTADO DE ESCENARIOS DE PRODUCCIÓN PRIMARIA</b></center>
    </div>
</div>      

<input type="button" value="Crear nuevo escenario" class="btn btn-danger" onclick="cuadroCreacionEscenario()">


<div id="div_grilla_pry">
    

</div>
 

<div id="div_grilla_pry_det">
    

</div>
<div id="div_grillaLotes">
    

</div>

 <style>
  /* Estilo para la columna "Calculo Mortandad" en el encabezado */
  th.anchoGrilla {
    width: 900px; /* Ajusta el ancho según tus necesidades */
  }

  /* Estilo para las celdas de la columna "Calculo Mortandad" */
  td.calculoanchoGrillamortandad {
    width: 900px/* Ajusta el ancho según tus necesidades */
  }
</style>



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
                                                <input  id="idEscenarioLote"   class="form-control text-left    "  style="width: 100%" type="text"     >

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