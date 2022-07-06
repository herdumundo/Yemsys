<%-- 
    Document   : grilla_registro_diario_aviarios_mecanizados
    Created on : 27/01/2022, 10:15:33
    Author     : aespinola
--%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../versiones.jsp" %>
 <%  
   PreparedStatement ps;
   ResultSet rs;
    clases.controles.connectarBD();
  
   try {
           
   ps=clases.controles.connect .prepareStatement("select avi.avilot_aviario,avilot_lote,lo.lote_name from ppr_avilote avi left join ppr_lotes lo on avi.avilot_lote=lo.lote_id "
                                                 + "where avilot_ffin is null and lo.lote_activo=1 and avi.avilot_aviario not like 'C1%'");
   rs=ps.executeQuery();
  
   %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

    <label  ><b></b></label> 
    <div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
         onclick="cargar_datos_modal_version('0002-REP-01032022-A', 'VERSION: 0002-REP-01032022-A')">
        <label neme="label_contenido" id="label_contenido">0002-PAN-01032022-A</label>  
    </div>

</head>
<body>   

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
        document.getElementById("idfecham").setAttribute("max", today);

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

        setInputDate("#idfecham");

    </script>



    <div class="card m-4">
        <input type="hidden" value="2" id="udepartamento" name="udepartamento">
        <section class="content" id="contenido">
            <div class="text-center">

                <br>
                <div class="bg-navy">
                    <input type="hidden" id="lote" name="lote">
                    <input type="hidden" id="avi" name="avi">
                    <input type="hidden" id="lote_registro" name="lote_registro">
                    <input type="hidden" id="id_datos" name="id_datos">
                    <input type="hidden" id="edad_dias" name="edad_dias">
                    <h5 class="text-center">Registro Diario - Aviarios Mecanizados</h5>
                    <table id="tabla" name="tabla" class=" tablagrilla compact-cs">

                        <th class="tablagrilla">
                        <center>
                            <select onchange="contador_mortandad_ppr()" style="width:117px;" id="avis" name="avi" class=" tablagrilla form-control cargar2">
                                <%while(rs.next()){%>
                                <option data-lote="<%=rs.getString("avilot_lote")%>" value="<%=rs.getString("avilot_aviario")%>"><%=rs.getString("avilot_aviario")%> - <%=rs.getString("lote_name")%></option>
                                 <%} %>
                            </select>
                        </center></th>
                        <th class="tablagrilla">
                        <center>
                            <input onchange="contador_mortandad_ppr()" type="date" id="idfecham" step="1 name="fechadesde" min="2014-10-01" class="tablagrilla form-control text-center cargar2" required="">
                        </center>
                        </th>
                        <th class="tablagrilla">
                        <center>
                            <div class="input-group-append">
                                <button type="button" id="volver" name="volver" onclick="traer_vista_contador_huevo3_ppr();" class="btn-volver float-right bg-gradient-gray text-center" >Volver</button>
                            </div>
                        </center>
                        </th>
                    </table>
                </div>

                <div class="card-body ocultar" >
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-7">
                            <div>
                                <input type="hidden"  id="lote" name="lote">
                                <input type="hidden"  id="avi" name="avi">
                                <table class="tablagrilla table table-bordered table-striped compact" id="tabla_mor" name="tabla_mor">
                                    <thead>
                                        <tr>
                                            <th class="bg-navy tablagrilla" colspan="29" class="text-center">Detalle de Mortandad</th>
                                        </tr>
                                    </thead>
                                    <tbody class="tablagrilla">
                                        <tr class="tablagrilla">
                                            <td class="tablagrilla" rowspan="7" style="width:40px;background-color:#666;"></td>
                                            <td class="tablagrilla" colspan="4" class="text-center">Columna 1</td>
                                            <td class="tablagrilla" rowspan="7" style="width:40px;background-color:#666;"></td>
                                            <td class="tablagrilla" rowspan="7" style="width:40px;background-color:#666;"></td>
                                            <td class="tablagrilla" colspan="4" class="text-center">Columna 2</td>
                                            <td class="tablagrilla" rowspan="7" style="width:40px;background-color:#666;"></td>
                                            <td class="tablagrilla" rowspan="7" style="width:40px;background-color:#666;"></td>
                                            <td class="tablagrilla" colspan="4" class="text-center">Columna 3</td>
                                            <td class="tablagrilla" rowspan="7" style="width:40px;background-color:#666;"></td>
                                            <td class="tablagrilla" rowspan="7" style="width:40px;background-color:#666;"></td>
                                            <td class="tablagrilla" colspan="4" class="text-center">Columna 4</td>
                                            <td class="tablagrilla" rowspan="7" style="width:40px;background-color:#666;"></td>
                                        </tr>
                                        <tr class="tablagrilla">
                                            <td class="tablagrilla text-center cursor-pointer btn-link">116</td>
                                            <td contenteditable="true"   id="116" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="126" class="tablagrilla text-right textcolor2 cerom" ></td> 
                                            <td class="tablagrilla text-center cursor-pointer btn-link">126</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">216</td>
                                            <td contenteditable="true"   id="216" class="tablagrilla text-right textcolor2 cerom"  ></td>
                                            <td contenteditable="true"   id="226" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">226</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">316</td>
                                            <td contenteditable="true"   id="316" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="326" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">326</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">416</td>
                                            <td contenteditable="true"   id="416" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="426" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">426</td>

                                        </tr>
                                        <tr class="tablagrilla">
                                            <td class="tablagrilla text-center cursor-pointer btn-link">115</td>
                                            <td contenteditable="true"   id="115" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="125" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">125</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">215</td>
                                            <td contenteditable="true" mor_id=""  id="215" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true" mor_id=""  id="225" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">225</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">315</td>
                                            <td contenteditable="true" mor_id=""  id="315" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true" mor_id=""  id="325" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">325</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">415</td>
                                            <td contenteditable="true" mor_id=""  id="415" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true" mor_id=""   id="425" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">425</td>

                                        </tr>
                                        <tr class="tablagrilla">
                                            <td class="tablagrilla text-center cursor-pointer btn-link">114</td>
                                            <td contenteditable="true"   id="114" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="124" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">124</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">214</td>
                                            <td contenteditable="true"   id="214" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="224" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">224</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">314</td>
                                            <td contenteditable="true"  id="314" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"  id="324" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">324</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">414</td>
                                            <td contenteditable="true"   id="414" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="424" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">424</td>

                                        </tr>
                                        <tr class="tablagrilla">
                                            <td class="tablagrilla text-center cursor-pointer btn-link">113</td>
                                            <td contenteditable="true"   id="113" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="123" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">123</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">213</td>
                                            <td contenteditable="true"  id="213" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"  id="223" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">223</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">313</td>
                                            <td contenteditable="true"  id="313" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"  id="323" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">323</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">413</td>
                                            <td contenteditable="true"   id="413" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="423" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">423</td>

                                        </tr>
                                        <tr class="tablagrilla">
                                            <td class="tablagrilla text-center cursor-pointer btn-link">112</td>
                                            <td contenteditable="true"  id="112" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"  id="122" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">122</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">212</td>
                                            <td contenteditable="true"   id="212" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="222" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">222</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">312</td>
                                            <td contenteditable="true"   id="312" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="322" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">322</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">412</td>
                                            <td contenteditable="true"   id="412" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="422" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">422</td>

                                        </tr>
                                        <tr class="tablagrilla">
                                            <td class="tablagrilla text-center cursor-pointer btn-link">111</td>
                                            <td contenteditable="true"   id="111" contenteditable="true" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="121" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">121</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">211</td>
                                            <td contenteditable="true"   id="211" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="221" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">221</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link">311</td>
                                            <td contenteditable="true"   id="311" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="321" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">321</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" (411)">411</td>
                                            <td contenteditable="true"   id="411" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   id="421" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link">421</td>

                                        </tr>
                                    </tbody>
                                    <tfoot>
                                        <tr class="tablagrilla">
                                            <th colspan="29">Mortandad Total: <span id="total-morfilas"><input type="text" class=" form-control-sm cerom tablagrilla textcolor2" contenteditable="false" id="total-morfilas2"></span></th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="col-12 col-md-5">
                            <table class="tablagrilla table table-bordered table-striped compact">
                                <thead>
                                    <tr>
                                        <th colspan="21" class="tablagrilla text-center bg-navy"><h5>RESUMEN</h5></th>
                                    </tr>
                                </thead>
                            </table>
                            <table class="tablagrilla table table-bordered table-striped compact">
                                <thead>
                                <div class="row mt-4">
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Edad</label>
                                            <input  campo="edad" type="text" id="dl_edad" class="form-control form-control-sm text-center" readonly="">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Saldo ant.</label>
                                            <input   campo="saldoant" type="text" id="dl_saldoant" class="form-control form-control-sm text-center" readonly="">

                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">% mortandad</label>
                                            <input   campo="morpor" type="text" id="dl_mortpor" class="form-control form-control-sm text-center" readonly="">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Saldo</label>
                                            <input  type="text" id="dl_saldo" class="form-control form-control-sm text-center campo" readonly="">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Productiv. (%)</label>
                                            <input type="text" id="prodpor" class="form-control form-control-sm text-center" readonly="">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Kg. Balanceados</label>
                                            <input type="text" id="kg_bal" class="form-control form-control-sm text-center" readonly="">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Bal. gr/ave</label>
                                            <input type="text" id="ave_bal" class="form-control form-control-sm text-center" readonly="">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Cons. agua Total</label>
                                            <input type="text" id="cons_agua" class="form-control form-control-sm text-center" readonly="">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Cons. agua/ave</label>
                                            <input type="text" id="cons_agua_t" class="form-control form-control-sm text-center" readonly="">
                                        </div>
                                    </div>    

                                </div>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-12 col-md-4">
                                <table class="tablagrilla table table-bordered table-striped compact">
                                    <thead>
                                        <tr>
                                            <th class="bg-navy tablagrilla text-center" colspan="21">Tipos de Mortandad</th>
                                        </tr>
                                    </thead>
                                </table>
                                <div class="row mt-3">                    
                                    <div class="col-12 col-md-2">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Normal</label>
                                            <input data="true"    type="number" id="dl_muertos_normal" name="dl_muertos_normal" class="form-control form-control-sm text-center avi-input">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-2">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Prolapsos</label>
                                            <input data="true"  type="number" id="dl_muertos_prolapso" name="dl_muertos_prolapso" class="form-control form-control-sm text-center avi-input">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-2">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Livianos</label>
                                            <input data="true"  type="number" id="dl_muertos_livianos" name="dl_muertos_livianos" class="form-control form-control-sm text-center avi-input">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Total muertos</label>
                                            <input type="number" id="total-muertos" name="total-muertos" class="form-control form-control-sm text-center" readonly="">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">No Clasif.</label>
                                            <input type="number" id="mornoclas" name="mornoclas" class="form-control form-control-sm text-center" readonly="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-md-3">
                                <table class="tablagrilla table table-bordered table-striped compact">
                                    <thead>
                                        <tr>
                                            <th class="bg-navy tablagrilla text-center" colspan="21">Consumo de Balanceados</th>
                                        </tr>
                                    </thead>
                                </table>  
                                <div class="row mt-3">
                                    <div class="col-12 col-md-5">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Silo 1</label>
                                            <input data="true" type="number" id="dl_balkg1" name="dl_balkg1"  class="form-control form-control-sm text-center avi-input">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-5">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Silo 2</label>
                                            <input  data="true" type="number" id="dl_balkg2" name="dl_balkg2"  class="form-control form-control-sm text-center avi-input">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-5">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Total Balanceados</label>
                                            <input   type="text" id="baltotal" name="baltotal" class="form-control form-control-sm text-center" readonly="">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-5">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Calcico</label>
                                            <input data="true" type="number" id="dl_calcico" name="dl_calcico" class="form-control form-control-sm text-center avi-input">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-md-4">
                                <table class="tablagrilla table table-bordered table-striped compact">
                                    <thead>
                                        <tr>
                                            <th class="bg-navy tablagrilla text-center" colspan="21" >Registros de Caudalimetros (agua)</th>
                                        </tr>
                                    </thead>
                                </table>  
                                <div class="row mt-3">
                                    <div class="col-12 col-md-6">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Caudal. mañana</label>
                                            <input style="width:140px;"  data="true" type="number" id="dl_caudal" name="dl_caudal" class="form-control form-control-sm text-center avi-input">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Caudal. tarde</label>
                                            <input style="width:140px;"  data="true" type="number" id="dl_caudal2" name="dl_caudal2" class="form-control form-control-sm text-center avi-input">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Lectura Anterior (mañana)</label>
                                            <input style="width:140px;"  type="text" id="dia_ant" name="dia_ant" class="form-control form-control-sm text-center" readonly="">
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="col-12 col-md-3">
                                <table class="tablagrilla table table-bordered table-striped compact">
                                    <thead>
                                        <tr>
                                            <th class="bg-navy tablagrilla text-center" colspan="21">Registro de Temperatura interior</th>
                                        </tr>
                                    </thead>
                                </table>  
                                <div class="row mt-3">
                                    <div class="col-12 col-md-6">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Temp. mín.</label>
                                            <input data="true" type="number" id="dl_tempm2" name="dl_tempm2" class="form-control form-control-sm text-center avi-input">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Temp. máx.</label>
                                            <input data="true" type="number" id="dl_tempm1" name="dl_tempm1" class="form-control form-control-sm text-center avi-input">
                                        </div>
                                    </div>                            
                                </div>
                            </div>
                            <div class="col-12 col-md-2">
                                <table class="tablagrilla table table-bordered table-striped compact">
                                    <thead>
                                        <tr>
                                            <th class="bg-navy tablagrilla text-center" colspan="21" >Producción de Huevos</th>
                                        </tr>
                                    </thead>
                                </table>
                                <div class="row mt-3">
                                    <div class="col-12 col-md-8">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Cant. Huevos</label>
                                            <input disabled="true" data="true" type="number" id="dl_huevos" name="dl_huevos" class="form-control form-control-sm text-center avi-input">
                                        </div>
                                    </div>                    
                                </div>
                            </div>
                            <div class="col-12 col-md-6">
                                <table class="tablagrilla table table-bordered table-striped compact">
                                    <thead>
                                        <tr>
                                            <th class="bg-navy tablagrilla text-center" colspan="21">Transferencias / Ajustes / Ventas</th>
                                        </tr>
                                    </thead>
                                </table>  
                                <div class="row mt-3">
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Transf. Ingreso</label>
                                            <input data="true" type="number" id="dl_transferin" name="dl_transferin" class="form-control form-control-sm text-center avi-input">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Transf. Salida</label>
                                            <input data="true"  type="number" id="dl_transferout" name="dl_transferout" class="form-control form-control-sm text-center avi-input">
                                        </div>
                                    </div> 
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Ajuste</label>
                                            <input data="true" type="number" id="dl_ajuste" name="dl_ajuste" class="form-control form-control-sm text-center avi-input">
                                        </div>
                                    </div>     
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Venta</label>
                                            <input data="true" type="number" id="dl_venta" name="dl_venta" class="form-control form-control-sm text-center avi-input">
                                        </div>
                                    </div>                                
                                </div>
                            </div>
                            <div class="col-12 col-md-6">
                                <table class="tablagrilla table table-bordered table-striped compact">
                                    <thead>
                                        <tr>
                                            <th colspan="21" class="tablagrilla bg-navy text-center">Anotaciones</th>
                                        </tr>
                                    </thead>
                                </table>
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <div class="form-group">
                                            <textarea data="true" id="dl_anota" name="dl_anota" class="avi-input form-control form-control-sm avi-input" rows="3"></textarea>
                                        </div>
                                    </div>                                                      
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </center>
        </section>
        <!-- /.content -->
    </div>
    
</body>
</html>
<%
    
       } catch (Exception e) {
       }
       finally{
        clases.controles.DesconnectarBD();
}
%>