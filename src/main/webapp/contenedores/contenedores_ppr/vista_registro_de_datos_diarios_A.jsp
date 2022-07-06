<%-- 
    Document   : vista_registro_de_datos_diarios_A
    Created on : 21/02/2022, 13:51:26
    Author     : csanchez
--%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>
 <%  
   PreparedStatement ps;
   ResultSet rs;
   
   try {
           
   ps=connection .prepareStatement("select lote_id,lote_name from ppr_lotes where lote_aviario is null and lote_id > 297");
   rs=ps.executeQuery();
  
   %>
<style>

    .textcolor   {
        color: #ffffff;
    }


</style>     
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xl" >
    <label neme="label_contenido" id="label_contenido"></label>  0008-Rep-01032022-A
</div>
</head>
<script>
    var today = new Date();
            var dd = today.getDate(1);
            var mm = today.getMonth(1) + 1;
            var yyyy = today.getFullYear();
            if (dd < 10) {
                dd = '0' + dd
            }
            if (mm < 10) {
                mm = '0' + mm
            }

            today = yyyy + '-' + mm + '-' + dd;
            document.getElementById("idfechad").setAttribute("max", today);
            document.getElementById("fecha_desac").setAttribute("max", today);
            document.getElementById("fecha_actic").setAttribute("max", today);
            function setInputDate(_id) {
                var _dat = document.querySelector(_id);
                var hoy = new Date(),
                        d = hoy.getDate(),
                        m = hoy.getMonth() + 1,
                        y = hoy.getFullYear(),
                        data;

                if (d < 10) {
                    d = "0" + d;
                }
                ;
                if (m < 10) {
                    m = "0" + m;
                }
                ;

                data = y + "-" + m + "-" + d;
                console.log(data);
                _dat.value = data;
            }
            ;

            setInputDate("#idfechad");
            setInputDate("#fecha_desac");
            setInputDate("#fecha_actic");
</script>

<div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
PPR
</div>
</div>
    <center><b>REGISTRO DE DATOS DIARIOS</b></center>
</div>
   </div>  <br>
<div class="card m-4">
    
    <section class="content" id="contenido">
        <div class="text-center">
            <table id="tabla" name="tabla" class=" tablagrilla compact-cs">
                <th class="tablagrilla">
                <center>
                    <label class="tablagrilla">Fecha</label>
                </center>
                <center>
                    <input onchange="carga_grilla_registro_datos_diarios_A_ppr()" type="date" id="idfechad" step="1 name="idfechad" min="2014-10-01" class="tablagrilla form-control text-center cargar_u_r_datosdiariosA" required="">
                </center>
                </th>

            </table>
            
            <div id="tabla_datos_diarios" class=" tablagrilla input-group-append ocultar"></div>
            <div id="tabla_datos_diariosb" class=" tablagrilla input-group-append ocultar"></div>
            <div id="tabla_datos_diarios_descarte" class=" tablagrilla input-group-append ocultar"></div>
            <div id="tabla_datos_diarios_h" class=" tablagrilla input-group-append ocultar"></div>
            <div id="tabla_datos_diarios_pre_descarte" class=" tablagrilla input-group-append ocultar"></div>
            <div id="div_total_pre_descarte" class=" tablagrilla input-group-append ocultar"></div>
          
        </div>
        </center>
    </section>
      <div class="modal fade" id="desactivar_lote_aviario" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form id="ppr-necro-form" name="ppr-necro-form" autocomplete="off" class="form form-horizontal">
                <div class="modal-header bg-navy">
                    <h class="modal-title">Desactivar lote/aviario</h>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                           <div class="row mt-3">
                                    <div class="col-12 col-md-5">
                                        <div class="form-group">
                                            <H6> <label class="form-control-placeholder">Fecha</label></H6>
                                            <input  type="date" id="fecha_desac" step="1 name="fecha_desac" min="2014-10-01" class="tablagrilla form-control text-center cargar_u_r_datosdiariosA" required="">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-5">
                                        <div class="form-group">
                                            <H6><label class="form-control-placeholder">Fecha ultimo registro</label></H6>
                                            <input  disabled="true" type="date" id="fecha_ultimo" step="1 name="fecha_ultimo" min="2014-10-01" class="tablagrilla form-control text-center cargar_u_r_datosdiariosA" required="">
                                            <input  hidden="true" id="lote_desac"  name="lote_desac"  type="text"/>
                                            <input  hidden="true" id="aviario_desac" name="aviario_desac"   type="text"/>
                                        </div>
                                    </div> 
                            </div> 
                       
                    </div>
                    
                </div>
                <div class="modal-footer">
                    <button type="button" onclick="desactivar_lote_ppr()" class="bg-navy">Desactivar</button>
                    <button type="button" class="bg-navy" data-dismiss="modal">Cancelar</button>
                </div>
            </form>
        </div>
    </div>
</div>
    <!-- /.content -->
      <div class="modal fade" id="agregar_lote_aviario" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form id="ppr-necro-form" name="ppr-necro-form" autocomplete="off" class="form form-horizontal">
                <div class="modal-header bg-navy">
                    <center><h class="modal-title  "> ACTIVAR AVIARIO<input readonly class="text-white bg-navy" id="aviario_lote"></center>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                        <span aria-hidden="true">×</span>  
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                          <div class="row mt-3">
                                    <div class="col-12 col-md-5">
                                        <div class="form-group">
                                            <H6> <label class="form-control-placeholder">FECHA</label></H6>
                                            <input  type="date" id="fecha_actic" step="1 name="fecha_actic" min="2014-10-01" class="tablagrilla form-control text-center cargar_u_r_datosdiariosA" required="">
                                        </div>
                                    </div>
                                        <div class="col-12 col-md-5">
                                        <div class="form-group">
                                            <H6><label class="form-control-placeholder">LOTE DISPONIBLE</label></H6>
                                            <select class="form-control" id="lote" name="lote" >
                                            <%while(rs.next()){%>
                                        <option value="<%=rs.getString("lote_id")%>"><%=rs.getString("lote_name")%></option>
                                        <%} %>
                                         </select>
                                            <input  hidden="true" id="aviario_sac" name="aviario_desac"   type="text"/>
                                        </div>
                                    </div> 
                                 <div class="col-12 col-md-5">
                                        <div class="form-group">
                                            <H6><label class="form-control-placeholder">SALDO INICIAL AVES</label></H6>
                                            <input   type="text" id="saldo_inicial" step="1 name="saldo_inicial" min="2014-10-01" class="tablagrilla form-control text-center cargar_u_r_datosdiariosA" required="">
                                        </div>
                                </div> 
                            </div> 
                        </div>
                    
                </div>
                <div class="modal-footer">
                    <button type="button" onclick="activar_lote_ppr()" class="bg-navy">Registrar</button>
                    <button type="button" class="bg-navy" data-dismiss="modal">Cancelar</button>
                </div>
            </form>
        </div>
    </div>
</div>
</div>
<%
    
       } catch (Exception e) {
       }
       finally{
         connection.close();
}
%>