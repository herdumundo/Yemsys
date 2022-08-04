<%@page import="java.sql.PreparedStatement"%>
<%@page import="clases.fuentedato"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@ page session="true" %>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>  
<%    PreparedStatement pst, pst2;
    ResultSet rs, rs2;

    pst = connection.prepareStatement("SELECT   t0.[id]  ,"
            + " t0.[fecha_nacimiento],"
            + " FORMAT (t0.[fecha_nacimiento], 'dd/MM/yyyy')   as fecha_nacimiento_form,"
            + "t0.[lote] ,t0.[id_raza],t0.[aviario],t0.[cantidad_aves],t0.[edad_produccion_dias],t0.fecha_produccion,t0.fecha_predescarte,"
            + " FORMAT (t0.[fecha_produccion], 'dd/MM/yyyy')   as fecha_produccion_form , "
            + " FORMAT (t0.[fecha_predescarte], 'dd/MM/yyyy')   as  fecha_predescarte_form ,t1.raza_name "
            + ""
            + "FROM [ppr_pry_cab] t0 inner join ppr_razas t1 on t0.id_raza=t1.raza_id order by convert(date,fecha_predescarte )asc");
    rs = pst.executeQuery();

    String version = "Test";
    String desc_version = "Test";
    try {

%>
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>', 'DESCRIPCION:<%=desc_version%>')">
    <label ><%=version%> </label>  
</div>
</head>
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                LOG
            </div>
        </div>
        <center><b>PROYECCION DE PRODUCCION</b></center>
    </div>
</div>  <br>    

<table  id="example" class=' table-bordered compact hover' style='width:100%'>
    <thead>
    <th>Nro.</th>
    <th>Fecha nacimiento</th>
    <th>Lote</th>
    <th>Raza</th>
    <th>Aviario</th>
    <th>Cantidad aves</th>
    <th>Edad produccion (dias)</th>
    <th>Fecha produccion</th>
    <th>Fecha predescarte</th>
    <th></th>
    <th></th>
    <th></th>

</thead>
<tbody>
    <% while (rs.next()) {%>
    <tr>
        <td><%=rs.getString("id")%></td>
        <td><%=rs.getString("fecha_nacimiento_form")%></td>
        <td><%=rs.getString("lote")%></td>
        <td><%=rs.getString("raza_name")%></td>
        <td><%=rs.getString("aviario")%></td>
        <td><%=rs.getString("cantidad_aves")%></td>
        <td><%=rs.getString("edad_produccion_dias")%></td>
        <td><%=rs.getString("fecha_produccion_form")%></td>
        <td><%=rs.getString("fecha_predescarte_form")%></td>
        <td><input type="button" value="Editar" class="bg-navy" onclick="edit_lote_proyeccion_ppr('<%=rs.getString("id")%>', '<%=rs.getString("lote")%>', '<%=rs.getString("aviario")%>', '<%=rs.getString("cantidad_aves")%>', '<%=rs.getString("fecha_nacimiento")%>', '<%=rs.getString("fecha_produccion")%>', '<%=rs.getString("fecha_predescarte")%>')"   > </td>
        <td><input type="button" value="Ajuste" class="bg-warning" onclick="ajuste_lote_proyeccion_ppr('<%=rs.getString("id")%>', '<%=rs.getString("lote")%>', '<%=rs.getString("aviario")%>', '<%=rs.getString("cantidad_aves")%>', '<%=rs.getString("fecha_nacimiento")%>', '<%=rs.getString("fecha_produccion")%>', '<%=rs.getString("fecha_predescarte")%>')"   > </td>
        <td><input type="button" data-toggle="modal" data-target="#exampleModalPreview" value="Visualizar" onclick="grafico_proyeccion_ppr(<%=rs.getString("id")%>, '<%=rs.getString("aviario")%>', '<%=rs.getString("fecha_nacimiento_form")%>', '<%=rs.getString("fecha_produccion_form")%>', '<%=rs.getString("fecha_predescarte_form")%>', '<%=rs.getString("lote")%>', '<%=rs.getString("raza_name")%>')" > </td>


    </tr>
    <%   } %>
</tbody>
</table>





<div class="modal fade" id="modal_upd_user" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-black">
                <h5 class="modal-title" id="exampleModalLabel">Editar Lote</h5>
                <button class="close" type="button"  class="position-relative p-3 bg-navy"  data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body bg-navy"   >  

                <form id="form_upd_user" action="POST"  style=" height: 400px">

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
    </div>
</div>       






<div class="modal fade" id="modal_ajuste" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-black">
                <h5 class="modal-title" id="exampleModalLabel">Ajustes de lote</h5>
                <button class="close" type="button"  class="position-relative p-3 bg-navy"  data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body bg-navy"   >  


                <input hidden="true" class="form-control text-left " type="text" style="width: 100%" disabled="true" id="txt_id_ajuste"  >
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



                </table> 
                <strong><a>Comentario</a></strong> 
                <textarea class="form-control" id="comentario" placeholder="Ingrese comentario" > </textarea>


                <div class="modal-footer align-right">
                    <input  class="btn bg-white"  type="button"  onclick="control_modificar_proyeccion_lote_ajuste_ppr()"  value="Registrar" >
                    <input  class="btn bg-white"  type="button"   data-dismiss="modal"   value="Cancelar" >            
                </div>
            </div>
        </div>
    </div>
</div>   


 


<div class="modal fade right" id="exampleModalPreview" tabindex="-1" role="dialog" aria-labelledby="exampleModalPreviewLabel" aria-hidden="true">
    <div class="modal-dialog-full-width modal-dialog momodel modal-fluid" role="document">
        <div class="modal-content-full-width modal-content ">
            <div class=" modal-header-full-width   modal-header text-center">
                <b>Test</b>  <button type="button" class="close " data-dismiss="modal" aria-label="Close">
                    <span style="font-size: 1.3em;" aria-hidden="true">&times;</span>
                </button>


            </div>
            <div class="modal-body">
                <div class="input-group mb-3">


                    <div id="grafico" style="width:70%; " > 

                        <div id="cargarzoom"  ></div> 

                    </div>
                   <div id="grilla_log"  > 

 
                    </div>
                     


                </div>
                <div class="modal-footer-full-width  modal-footer">
                    <button type="button" class="btn btn-danger btn-md btn-rounded" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>





    <%
        } catch (Exception e) {

        } finally {
            connection.close();
        }
    %>