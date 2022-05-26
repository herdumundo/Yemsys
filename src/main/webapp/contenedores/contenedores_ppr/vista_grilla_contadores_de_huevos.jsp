<%-- 
    Document   : reporte_huevos
    Created on : 06/01/2022, 07:17:00
    Author     : csanchez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    document.getElementById("idfechadesde").setAttribute("max", today);
    document.getElementById("idfechahasta").setAttribute("max", today);

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

    setInputDate("#idfechadesde");
    setInputDate("#idfechahasta");
 <% 
     String version=clases.versiones.contenedores_ppr_vista_grilla_contadores_de_huevos;
 %> 
</script>
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')">
    <label neme="label_contenido" id="label_contenido"><%=version%></label>  
</div>
</head>

<div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
PPR
</div>
</div>
    <center><b>RESUMEN DE CONTADORES DE HUEVOS POR AVIARIO</b></center>
</div>
   </div>  <br>

<div class="card m-4">
    <input type="hidden" value="2" id="udepartamento" name="udepartamento">
    <section class="content" id="contenido">
        <div class="text-center">
            
            <table id="tabla" name="tabla" class=" tablagrilla compact-cs">
                <th class="tablagrilla">
                <center>
                    <label class="tablagrilla">Aviario</label>
                </center>
                <center>
                    <select style="width:120px" id="avi" name="avi" class=" tablagrilla form-control">
                        <option class="text-center" value="A2">A2</option>
                        <option class="text-center" value="A3">A3</option>
                        <option class="text-center" value="A4">A4</option>
                        <option class="text-center" value="A5">A5</option>
                        <option class="text-center" value="A6">A6</option>
                        <option class="text-center" value="A7">A7</option>
                        <option class="text-center" value="A8">A8</option>
                        <option class="text-center" value="A9">A9</option>
                        <option class="text-center" value="A10">A10</option>
                        <option class="text-center" value="A11">A11</option>
                        <option class="text-center" value="A12">A12</option>
                        <option class="text-center" value="B2">B2</option>
                        <option class="text-center" value="B3">B3</option>
                        <option class="text-center" value="B4">B4</option>
                        <option class="text-center" value="B5">B5</option>
                        <option class="text-center" value="B6">B6</option>
                        <option class="text-center" value="B7">B7</option>
                        <option class="text-center" value="B8">B8</option>
                        <option class="text-center" value="B9">B9</option>
                        <option class="text-center" value="B10">B10</option>
                        <option class="text-center" value="B11">B11</option>
                    </select>
                </center></th>
                <th class="tablagrilla">
                <center>
                    <label class="tablagrilla">Fecha desde</label>
                </center>
                <center>
                    <input type="date" id="idfechadesde" step="1 name="fechadesde" min="2014-10-01" class="tablagrilla form-control text-center" required="">
                </center></th>
                <th class="tablagrilla">
                <center>
                    <label class="tablagrilla">Fecha hasta</label>
                </center>
                <center>
                    <input type="date" id="idfechahasta" step="1 name="fechahasta" class="tablagrilla form-control text-center" required="">
                </center>
                </th>

                <th class="tablagrilla">
                <center>
                    <div style="color: #ffffff"><label class="">brueb</label></div>
                </center>
                <center>
                    <div class="input-group-append">
                        <button type="button" id="buscar" name="buscar" onclick="contador_huevos_ppr(), llamar_grafico_detalles_ppr(), max_min_ppr()" class="bg-navy form-control text-center cargar" ><i class="fa fa-search"></i></button>

                    </div>
                </center></th>
            </table>
            <br>
            <div id="tablahuevos" class="box box-default ocultar ">
                <div class="card-header" id="datos">
                    <form  id="filtro-form" class="form" autocomplete="off">

                        <table style="width:100%" id="tablagrilla" class=" tablagrilla table table-bordered compact">
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
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(116), llamar_grafico_detalles_fila_ppr(116)">116</td>
                                    <td id="celda116" class="tablagrilla text-right textcolor cero"></td>
                                    <td id="celda126" class="tablagrilla text-right textcolor cero"></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(126), llamar_grafico_detalles_fila_ppr(126)">126</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(216), llamar_grafico_detalles_fila_ppr(216)">216</td>
                                    <td id="celda216" class="tablagrilla text-right textcolor cero"  ></td>
                                    <td id="celda226" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(226), llamar_grafico_detalles_fila_ppr(226)">226</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(316), llamar_grafico_detalles_fila_ppr(316)">316</td>
                                    <td id="celda316" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda326" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(326), llamar_grafico_detalles_fila_ppr(326)">326</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(416), llamar_grafico_detalles_fila_ppr(416)">416</td>
                                    <td id="celda416" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda426" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(426), llamar_grafico_detalles_fila_ppr(426)">426</td>

                                </tr>
                                <tr class="tablagrilla">
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(115), llamar_grafico_detalles_fila_ppr(115)">115</td>
                                    <td id="celda115" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda125" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(125), llamar_grafico_detalles_fila_ppr(125)">125</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(215), llamar_grafico_detalles_fila_ppr(215)">215</td>
                                    <td id="celda215" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda225" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(225), llamar_grafico_detalles_fila_ppr(225)">225</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(315), llamar_grafico_detalles_fila_ppr(315)">315</td>
                                    <td id="celda315" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda325" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(325), llamar_grafico_detalles_fila_ppr(325)">325</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(415), llamar_grafico_detalles_fila_ppr(415)">415</td>
                                    <td id="celda415" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda425" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(425), llamar_grafico_detalles_fila_ppr(425)">425</td>

                                </tr>
                                <tr class="tablagrilla">
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(114), llamar_grafico_detalles_fila_ppr(114)">114</td>
                                    <td id="celda114" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda124" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(124), llamar_grafico_detalles_fila_ppr(124)">124</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(214), llamar_grafico_detalles_fila_ppr(214)">214</td>
                                    <td id="celda214" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda224" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(224), llamar_grafico_detalles_fila_ppr(224)">224</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(314), llamar_grafico_detalles_fila_ppr(314)">314</td>
                                    <td id="celda314" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda324" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(324), llamar_grafico_detalles_fila_ppr(324)">324</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(414), llamar_grafico_detalles_fila_ppr(414">414</td>
                                    <td id="celda414" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda424" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(424), llamar_grafico_detalles_fila_ppr(424)">424</td>

                                </tr>
                                <tr class="tablagrilla">
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(113), llamar_grafico_detalles_fila_ppr(113)">113</td>
                                    <td id="celda113" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda123" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(123), llamar_grafico_detalles_fila_ppr(123);">123</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(213), llamar_grafico_detalles_fila_ppr(213)">213</td>
                                    <td id="celda213" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda223" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(223), llamar_grafico_detalles_fila_ppr(223)">223</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(313), llamar_grafico_detalles_fila_ppr(313)">313</td>
                                    <td id="celda313" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda323" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(323), llamar_grafico_detalles_fila_ppr(323)">323</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(413), llamar_grafico_detalles_fila_ppr(413)">413</td>
                                    <td id="celda413" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda423" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(423), llamar_grafico_detalles_fila_ppr(423)">423</td>

                                </tr>
                                <tr class="tablagrilla">
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(112), llamar_grafico_detalles_fila_ppr(112)">112</td>
                                    <td id="celda112" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda122" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(122), llamar_grafico_detalles_fila_ppr(122)">122</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(212), llamar_grafico_detalles_fila_ppr(212)">212</td>
                                    <td id="celda212" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda222" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(222), llamar_grafico_detalles_fila_ppr(222)">222</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(312), llamar_grafico_detalles_fila_ppr(312)">312</td>
                                    <td id="celda312" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda322" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(322), llamar_grafico_detalles_fila_ppr(322)">322</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(412), llamar_grafico_detalles_fila_ppr(412)">412</td>
                                    <td id="celda412" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda422" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(422), llamar_grafico_detalles_fila_ppr(422)">422</td>

                                </tr>
                                <tr class="tablagrilla">
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(111), llamar_grafico_detalles_fila_ppr(111)">111</td>
                                    <td id="celda111" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda121" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(121), llamar_grafico_detalles_fila_ppr(121)">121</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(211), llamar_grafico_detalles_fila_ppr(211)">211</td>
                                    <td id="celda211" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda221" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(221), llamar_grafico_detalles_fila_ppr(221)">221</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(311), llamar_grafico_detalles_fila_ppr(311)">311</td>
                                    <td id="celda311" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda321" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(321), llamar_grafico_detalles_fila_ppr(321)">321</td>

                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(411), llamar_grafico_detalles_fila_ppr(411)">411</td>
                                    <td id="celda411" class="tablagrilla text-right textcolor cero" ></td>
                                    <td id="celda421" class="tablagrilla text-right textcolor cero" ></td>
                                    <td class="tablagrilla text-center cursor-pointer btn-link" onclick="resumen_detalle_huevos_ppr(421), llamar_grafico_detalles_fila_ppr(421)">421</td>

                                </tr>
                            </tbody>
                        </table>
                        <div class="card-header text-center">
                            <img src="img/leyenda.png"alt=""/>      
                        </div>
                    </form>
                    <br>
                    <div>
                        <div class="text-center">

                            <div class="text-center">
                                <center>
                                    <table>

                                        <th class="tablagrilla">
                                        <center>
                                            <label>Total</label>
                                            <input type="text" value="0" id="huevos" name="huevos" class="form-control compact-cs text-center border-huevos bg-huevos-light" disabled="">
                                        </center>
                                        </th>

                                        <th class="tablagrilla">
                                        <center>
                                            <label>Promedio</label>
                                            <input type="text" value="0" id="promedio" name="promedio" class="form-control compact-cs text-center border-huevos bg-huevos-light" disabled="">
                                        </center>
                                        </th>

                                        <th class="tablagrilla">
                                        <center>
                                            <label>Máximo</label>
                                            <input type="text" value="0" id="maximo" name="maximo" class="form-control compact-cs text-center border-huevos bg-huevos-light" disabled="">
                                        </center>
                                        </th>

                                        <th class="tablagrilla">
                                        <center>
                                            <label>Mínimo</label>
                                            <input type="text" value="0" id="minimo2" name="minimo" class="form-control compact-cs text-center border-huevos bg-huevos-light" disabled="">
                                        </center>
                                        </th>

                                    </table>
                                </center>
                            </div>

                            <%--
                            <div class="form-group ml-4">
                                <label class="has-float-label">
                                    <input type="text" value="0,0%" id="henday" name="henday" class="form-control text-center border-huevos bg-huevos-light" disabled="">
                                    <span>Productividad (%)</span>
                                </label>
                            </div>
                            <br>
                            <div class="form-group mt-4">
                                <label class="has-float-label">
                                    <input type="text" value="94,3%" id="phenday" name="phenday" class="form-control text-center border-blue bg-blue-light" disabled="">
                                    <span>Productividad Padrón (%)</span>
                                </label>
                                <input type="hidden" value="94.3" id="phen" name="phen">
                            </div>
                            <div class="form-group mt-4 ml-4">
                                <label class="has-float-label">
                                    <input type="text" value="-94,3%" id="diff" name="diff" class="form-control text-center custom-is-invalid" disabled="">                
                                    <span>Dif. Prod. Padrón (%)</span>
                                </label>
                            </div>
                            <br>
                            <div class="form-group mt-4">
                                <label class="has-float-label">
                                    <input type="text" value="259 días (37 sems.)" id="edad" name="edad" class="form-control text-center" disabled="">
                                    <span>Edad días (sem)</span>
                                </label>
                            --%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </center>
    </section>

          <div >
                <div  id="idresumen_det">
                </div>
                <div  id="idresumen_huevos">
                </div>
            </div>




</div>

