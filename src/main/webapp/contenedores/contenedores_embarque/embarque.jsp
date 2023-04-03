<%-- 
    Document   : embarque
    Created on : 03/03/2020, 07:43:47 AM
    Author     : hvelazquez
--%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    PreparedStatement ps, ps2, ps3;
    ResultSet rs, rs_chofer, rs_camion;
    String fecha_actual = "";
    String hora_inicio = "";
    try 
    {
        ps = connection.prepareStatement(" select convert(varchar,getdate(),103) as fecha , GETDATE()  as hora ");
        rs = ps.executeQuery();

        ps2 = connection.prepareStatement("  select code,name from " + clases.variables.BD2 + ".dbo.[@CHOFERES] with(nolock) order by 2 ");
        rs_chofer = ps2.executeQuery();

        ps3 = connection.prepareStatement("select code,name from " + clases.variables.BD2 + ".dbo.[@CAMIONES] ");
        rs_camion = ps3.executeQuery();

        while (rs.next()) 
        {
            fecha_actual = rs.getString("fecha");
            hora_inicio = rs.getString("hora");
        }
        rs.close();
        String version = contenedores_embarque_contenedor_reporte_embarque;
%>
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" 
     data-target=".bd-example-modal-xx" onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>')" >
    <label ><%=version%></label>  
</div>
</head>


<form method="post"   id="formulario_embarque" name="formulario_embarque">
    <div class="form-group">
        <div class="input-group">
            <input type="text" id="hora_inicio" value="<%=hora_inicio%>" style="display:none" />
            FECHA EMBARQUE:      

            <input  style=" font-weight: bold"class="datepicker" value="<%=fecha_actual%>" type="text" id="calendario_embarque" name="calendario_embarque">              
            <select style=" font-weight: bold" class="form-control" name="cbox_chofer" id="cbox_chofer">
                <option style=" font-weight: bold" value="-" selected="selected" >  CHOFER </option>
                <%
                    while (rs_chofer.next()) {
                %>
                <OPTION VALUE="<%=rs_chofer.getString("code")%>"> <%=rs_chofer.getString("name")%> </OPTION><%
                    }
                    rs_chofer.close();%>
            </select>  
            <span class="input-group-addon">-</span>
            <select class="form-control;display:none" name="cbox_camion" id="cbox_camion">
                <option style=" font-weight: bold" selected="selected"  value="-" >  CAMION </option>
                <%

                    while (rs_camion.next()) {

                %><OPTION VALUE="<%=rs_camion.getString("code")%>"><%=rs_camion.getString("code")%>- <%=rs_camion.getString("name")%> </OPTION><%
                    }

                    %>

            </select>
        </div>
    </div>




    <div class="form-group" >
        <div class="input-group">

            <input type="checkbox"   disabled="disable" style="display:none"  data-toggle="toggle" checked  data-on="Factura reserva SI" data-off="Factura reserva NO" id="chkToggle2" data-onstyle="success" data-offstyle="warning">


            <input type="text"  style="  font-weight: bold" disabled="disable"  placeholder="NUMERO DE FACTURA" name="txt_nro_fact" id="txt_nro_fact" onblur="validar_factura($('#txt_nro_fact').val());" class="form-control"   />

        </div>
    </div>

    <div style="display: none" id="div_embarque_carga">
        <div class="form-group">
            <div class="input-group">
                <input type="number" placeholder="LOTE" name="txt_lote" id="txt_lote" class="form-control" onkeypress="cargar_datos_key();"/>

                <span class="input-group-addon">-</span>
                <input type="button" value="INGRESAR" name="btn_ingresar" id="btn_ingresar" onclick="traer_control_embarque($('#txt_lote').val(), $('#calendario_embarque').val());" class="form-control btn btn-primary"/>
            </div>
        </div>

        <input  type="button" value="REGISTRAR" id="btn_registrar" name="btn_registrar" onclick="  registrar_embarque();" class="form-control btn bg-navy example2" />


        <br>
        <input type="text" placeholder="total_a" name="total_a" id="total_a" class="form-control "  style="display:none"  />
        <input type="text" placeholder="total_b" name="total_b" id="total_b" class="form-control"   style="display:none"/>
        <input type="text" placeholder="total_c" name="total_c" id="total_c" class="form-control"   style="display:none" />
        <input type="text" placeholder="total_d" name="total_d" id="total_d" class="form-control"  style="display:none" />
        <input type="text" placeholder="total_s" name="total_s" id="total_s" class="form-control"   style="display:none"/>
        <input type="text" placeholder="total_j" name="total_j" id="total_j" class="form-control"   style="display:none" />
        <input type="text" placeholder="total_g" name="total_g" id="total_g" class="form-control"   style="display:none"  />
        <!-- CAMPOS PARA OBTENER EL TOTAL PENDIENTES DE CADA TIPO DE HUEVO EN LA FACTURA INGRESADA !-->
        <input type="hidden"    placeholder="total_factura_carros" name="total_factura_carros" id="total_factura_carros" class="form-control"   />
        <!-- SE RECUPERA EL TOTAL EN CARROS DE LA FACTURA !-->
        <input type="text"      placeholder="total_carros_grilla" name="total_carros_grilla" id="total_carros_grilla" class="form-control" style="display:none"   />
        <!-- SE RECUPERA EL TOTAL EN CARROS  DE LA GRILLA !-->
        <input type="text"      placeholder="tipo_grilla" name="tipo_grilla" id="tipo_grilla" class="form-control" style="display:none" />
        <!-- SE RECUPERA LOS TIPOS DE HUEVOS QUE HAY EN LA GRILLA, EJEMPLO: 1,2,3,4 !-->
        <input type="text"      placeholder="resultado" name="resultado" id="resultado" class="form-control"   style="display:none"   />
        
        <a style=" font-weight: bold" >TOTAL CARROS</a>
        <input type="text" style=" display:none"   name="total_cajones" id="total_cajones" value="0"   class="form-control" readonly />
        <input type="text" style=" font-weight: bold"   name="total_carros" id="total_carros" value="0"   class="form-control" readonly />
        <div id="carros_div">

            <a style=" font-weight: bold" > EN CARROS</a>
            <table  id="tabla_carros"   data-row-style="rowStyle"   data-toggle="table" data-click-to-select="true">
                <thead>
                    <tr>
                        <th style=" font-weight: bold">TIPO A</th>
                        <th style=" font-weight: bold">TIPO B</th>
                        <th style=" font-weight: bold">TIPO C</th>
                        <th style=" font-weight: bold">TIPO D</th>
                        <th style=" font-weight: bold">TIPO J</th>
                        <th style=" font-weight: bold">TIPO S</th>
                        <th style=" font-weight: bold">TIPO G</th>
                    </tr>
                </thead>
                <tbody>

                    <tr>
                        <td> <input type="text" style=" font-weight: bold"  name="tipo_ca" id="tipo_ca" value="0"   class="form-control" readonly /></td>
                        <td> <input type="text" style=" font-weight: bold"  name="tipo_cb" id="tipo_cb" value="0" class="form-control" readonly  /></td>
                        <td> <input type="text" style=" font-weight: bold"  name="tipo_cc" id="tipo_cc" value="0"   class="form-control" readonly /></td>
                        <td> <input type="text" style=" font-weight: bold" name="tipo_cd" id="tipo_cd" value="0"  class="form-control"readonly /></td>
                        <td> <input type="text"style=" font-weight: bold"  name="tipo_cj" id="tipo_cj" value="0"  class="form-control" readonly  /></td>
                        <td> <input type="text" style=" font-weight: bold" name="tipo_cs" id="tipo_cs" value="0"  class="form-control" readonly/></td>
                        <td> <input type="text" style=" font-weight: bold" name="tipo_cg" id="tipo_cg" value="0"  class="form-control" readonly /></td>
                    </tr>

                </tbody>
            </table>
        </div>

        <div id="cajones_div" >
            <a style=" font-weight: bold;color:red">EN CAJONES</a>
            <table id="tabla_cajones"   data-row-style="rowStyle"   data-toggle="table" data-click-to-select="true">
                <thead >
                    <tr >
                        <th><a style="color:red ; font-weight: bold" >TIPO A </a></th>
                        <th><a style="color:red ; font-weight: bold" >TIPO B</a></th>
                        <th><a style="color:red ; font-weight: bold" >TIPO C</a></th>
                        <th><a style="color:red ; font-weight: bold" >TIPO D</a></th>
                        <th><a style="color:red ; font-weight: bold" >TIPO J</a></th>
                        <th><a style="color:red ; font-weight: bold" >TIPO S</a></th>
                        <th><a style="color:red ; font-weight: bold" >TIPO G</a></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td > <b><input type="text" style="color:red ; font-weight: bold"  name="tipo_cja" id="tipo_cja" value="0"   class="form-control" readonly /></b></td>
                        <td> <b><input type="text" style="color:red ; font-weight: bold"  name="tipo_cjb" id="tipo_cjb" value="0" class="form-control" readonly  /></b></td>
                        <td> <b><input type="text" style="color:red; font-weight: bold"  name="tipo_cjc" id="tipo_cjc" value="0"   class="form-control" readonly /></b></td>
                        <td> <b><input type="text" style="color:red ; font-weight: bold" name="tipo_cjd" id="tipo_cjd" value="0"  class="form-control"readonly /></b></td>
                        <td> <b><input type="text" style="color:red ; font-weight: bold" name="tipo_cjj" id="tipo_cjj" value="0"  class="form-control" readonly  /></b></td>
                        <td> <b><input type="text" style="color:red ; font-weight: bold"  name="tipo_cjs" id="tipo_cjs" value="0"  class="form-control" readonly/></b></td>
                        <td> <b><input type="text" style="color:red ; font-weight: bold" name="tipo_cjg" id="tipo_cjg" value="0"  class="form-control" readonly /></b></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <table  id="tabla_contador" style="display:none"  data-row-style="rowStyle"   data-toggle="table" data-click-to-select="true" class="dataTable">
            <thead>
                <tr>
                    <th>TIPO A</th>
                    <th>TIPO B</th>
                    <th>TIPO C</th>
                    <th>TIPO D</th>
                    <th>TIPO J</th>
                    <th>TIPO S</th>
                    <th>TIPO G</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td> <b><input type="text"  style=" font-weight: bold"   name="tipo_a" id="tipo_a" value="0"   class="form-control" readonly /></b></td>
                    <td> <b><input type="text" style=" font-weight: bold"    name="tipo_b" id="tipo_b" value="0" class="form-control" readonly  /></b></td>
                    <td><b><input type="text"  style=" font-weight: bold"  name="tipo_c" id="tipo_c" value="0"   class="form-control" readonly /></b></td>
                    <td> <b><input type="text" style=" font-weight: bold"  name="tipo_d" id="tipo_d" value="0"  class="form-control"readonly /></b></td>
                    <td> <b><input type="text" style=" font-weight: bold"   name="tipo_j" id="tipo_j" value="0"  class="form-control" readonly  /></b></td>
                    <td> <b><input type="text"  style=" font-weight: bold" name="tipo_s" id="tipo_s" value="0"  class="form-control" readonly/></b></td>
                    <td><b> <input type="text" style=" font-weight: bold"  name="tipo_g" id="tipo_g" value="0"  class="form-control" readonly /></b></td>
                </tr>
            </tbody>
        </table>

        <div id="div_aviso">
            <div class="alert alert-danger alert-dismissible fade show" role="alert" id="div_aviso_sincro_espera" >
                <strong><center>SINCRONIZANDO LOTES DISPONIBLES, FAVOR ESPERE...</center></strong> 
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </div>
        <div id="div_carros_duplicados"></div>     
        <table id="myTable" class="table table-striped table-bordered"  >
            <thead>
                <tr>
                    <th class="ocultar" >COD LOTE</th>
                    <th>ARTICULO</th>
                    <th class="idsDeclarados">CARRO</th>
                    <th class="ocultar">CODIGO</th>
                    <th>CANTIDAD</th>
                    <th>FECHA PUESTA</th>
                    <th>ACCION</th>
                    <th class="ocultar">ESTADO</th>
                    <th class="ocultar"> IDENTIFICADOR</th>
                    <th  > CONTADOR</th>
                </tr>
            </thead>
            <tbody id="tbody_embarque">

            </tbody>
        </table>                      
    </div>
</form> 


<%    } catch (Exception e) {
    } finally {
        clases.controles.DesconnectarBD();
    }
%>

