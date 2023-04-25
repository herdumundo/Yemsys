<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 

<%    String version = contenedores_bal_solicitudad_cambio_formula;
        String version_desc = desc_contenedores_bal_solicitudad_cambio_formula;
        String pdf = pdf_bal_solicitudad_cambio_formula;

    
    PreparedStatement ps, ps2;
    ResultSet rs, rs2;
    try {
        ps = connection.prepareStatement(" SELECT  * FROM maehara.dbo.OITM  with (nolock) WHERE  ItmsGrpCod='106' AND OnHand>0");
        rs = ps.executeQuery();
        ps2 = connection.prepareStatement("select * from aviarios ");
        rs2 = ps2.executeQuery();
%>

<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>', '<%=version_desc%>','<%=pdf%>',true)">
    <label ><%=version%></label> 
</div>
</head><!-- comment -->
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy "  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                BAL
            </div>
        </div>
        <center><b>SOLICITUD DE CAMBIO DE FORMULA</b></center>
    </div>
</div> 

<form   method="post"  id="formulario" >
    <table class="table">

        <tbody>
            <tr>

                <td width="10%"><label>Cambio realizable a partir de la fecha</label>
                    <input type="text" required="required" id="fecha_solicitud" class="form-control datepicker" placeholder="Ingrese fecha"></td>
                <td width="10%">

                    <label>Toneladas</label>
                    <input type="checkbox"  data-toggle="toggle"    data-on="INDEFINIDO SI"    data-off="INDEFINIDO NO"   id="chkToggle2"  data-onstyle="success" data-offstyle="warning"  class="checkbox">
                    <div id="div_ton" >  
                        <input type="number" id="toneladas" required="required" class="form-control is-invalid" placeholder="Ingrese">
                    </div>
                </td>
                <td width="30%"><label>Recomendado por</label><input type="text" id="recomendado" class="form-control is-invalid" required placeholder="Ingrese"></td>
            </tr>

            <tr>
                <td width="10%"><label>Cabecera</label>
                    <input type="checkbox"  data-toggle="toggle"    data-on="CLONAR SI"    data-off="CLONAR NO"   id="chkToggle_1"  data-onstyle="success" data-offstyle="warning"  class="checkbox">
                    <div id="div_cab" style="display: none" >
                        <input type="text"  id="Clonar_Cabecera" onchange="clonar_cabecera_pedido_bal()" class="form-control is-invalid" placeholder="Ingrese Nro de Pedido">
                    </div>

                       
                 </td>
                  <br><br>
                 <td width="10%"><label>Seleccione Aviario</label>
                     <select class="selectpicker" name="aviario" id="aviario"  multiple data-live-search="true"  data-actions-box="true"  required placeholder="Ingrese aviarios"> 
                        
                        <%
                            while (rs2.next()) {%>
                        <option class="text-center"  value="<%=rs2.getString("descripcion")%>"><%=rs2.getString("descripcion")%></option> <%
                     }%>   
                    <%--
                        </select><input type="button" value="test" onclick="test_val()">   </td>
                        --%>
                    

            </tr>
            <tr>
                <td><label>Motivo</label><input type="text" id="motivo" class="form-control is-invalid" required  placeholder="Ingrese motivo"></td>
                <td><label>Impacto comercial</label>
                    <input type="checkbox"  data-toggle="toggle"    data-on="SI"    data-off="NO"   id="chkToggleImpacto"   data-onstyle="success" data-offstyle="warning"  class="checkbox">
                    <div id="div_impacto" style="display: none">  
                        <input type="text"  id="impacto" class="form-control is-invalid" placeholder="Describir"  >
                    </div>
                </td>
                <td  ><label>Resultado esperado</label><input type="text" id="resultado_esperado" class="form-control is-invalid" required placeholder="Resultado esperado"></td>


            </tr>
            <tr>
                <td><label>Observacion</label>
                    <textarea id="observacion"class="form-control" rows="3"></textarea></td>

                <td><label>Indicadores de evaluación</label><input type="text" id="indicadores" class="form-control is-invalid" required placeholder="Ingrese indicador de evaluación"></td>
                <td ><label>Plazo de evaluación</label>
                    <input type="text"  id="plazo_evaluacion" class="form-control datepicker"  placeholder="Ingrese plazo de evaluación">
                </td>
                <td ><label>Caracter urgente</label><br>

                    <input type="checkbox"  data-toggle="toggle" urgente="NO"   data-on="SI"    data-off="NO"   id="checkUrgente"  data-onstyle="success" data-offstyle="warning"  class="checkbox">
                </td>

            </tr>
            <tr>
                <td width="30%"><label>FORMULA</label>
                    <select class="form-control" id="select_formula" name="select_formula" onchange="ir_grilla_formulacion_bal()">
                        <option class="text-center celda_editable" value="-">SELECCIONE FORMULA</option> 
                        <%
                            while (rs.next()) {%>
                        <option class="text-center"  descripcion="<%=rs.getString("itemName")%>" value="<%=rs.getString("itemCode")%>"><%=rs.getString("itemName")%></option> <%
                     }%>   
                    </select>     </td>
                <td width="50%"><label>MATERIA PRIMA</label>
                    <select class="form-control" id="select_mtp" name="select_mtp"  >

                    </select>
                </td>
                <td width="20%"> <label>-</label><input class=" form-control btn bg-red" type="button"  id="btn_solicitar" value="Agregar materia prima" onclick="add_filas_sol_bal();">
                </td> 
            </tr>    
                 </tbody>
    </table>




    <br>

                    <div class="card card-dark " >
                        <div class="card-header">
                            <strong><a>INSUMOS DE FORMULACIÓN </a></strong>
                        </div>

                        <strong><a>Total</a></strong>
                        <label  id="total_insumos" ></label>
                        <strong><a>Faltantes</a></strong>
                        <label  id="total_insumos_faltantes" ></label>

                        <div id="div_grilla">
                        
                        </div>
                        <div id="div_nutrientes"></div> 
                    
                    </div>


                    <div class="modal-footer align-right ">
                        <input class="btn bg-navy" type="submit"   id="btn_solicitar" value="SOLICITAR">
                    </div>

                    </form>

                    <%
                        } catch (Exception e) {

                        } finally {
                            connection.close();
                        }%>