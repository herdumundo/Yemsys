<%-- 
    Document   : grilla_registro_diario_aviarios_mecanizados
    Created on : 27/01/2022, 10:15:33
    Author     : aespinola
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                    <h5 class="text-center">Contadores de Huevos</h5>
                    <table id="tabla" name="tabla" class=" tablagrilla compact-cs">

                        <th class="tablagrilla">
                        <center>
                            <select onchange="contador_registro_huevos_ppr()" style="width:70px;" id="avis" name="avi" class=" tablagrilla form-control cargar2">
                                <option data-lote="287" value="A2">A2   </option>
                                <option data-lote="291" value="A3">A3   </option>
                                <option data-lote="294" value="A4">A4   </option>
                                <option data-lote="292" value="A5">A5   </option>
                                <option data-lote="280" value="A6">A6   </option>
                                <option data-lote="274" value="A7">A7   </option>
                                <option data-lote="279" value="A8">A8   </option>
                                <option data-lote="273" value="A9">A9   </option>
                                <option data-lote="289" value="A10">A10 </option>
                                <option data-lote="284" value="A11">A11 </option>
                                <option data-lote="290" value="A12">A12 </option>
                                <option data-lote="288" value="B2">B2   </option>
                                <option data-lote="285" value="B3">B3   </option>
                                <option data-lote="283" value="B4">B4   </option>
                                <option data-lote="278" value="B5">B5   </option>
                                <option data-lote="281" value="B6">B6   </option>
                                <option data-lote="272" value="B7">B7   </option>
                                <option data-lote="275" value="B8">B8   </option>
                                <option data-lote="282" value="B10">B10 </option>
                                <option data-lote="286" value="B11">B11 </option>
                                <option data-lote="273" value="H3">H3   </option>
                                <option data-lote="274" value="H3B">H3B </option>
                                <option data-lote="277" value="H1">H1   </option>
                                <option data-lote="276" value="H2">H2   </option>
                            </select>
                        </center></th>
                        <th class="tablagrilla">
                        <center>
                            <input onchange="contador_registro_huevos_ppr()" type="date" id="idfecham" step="1 name="fechadesde" min="2014-10-01" class="tablagrilla form-control text-center cargar2" required="">
                        </center>
                        </th>
                     
                    </table>
                </div>
                 <th class="tablagrilla">
                 <center>
                <div class="card-body ocultar ">
              
                        
                        <div class="col-xs-12 col-sm-12 col-md-10">
                            <div>
                                <input type="hidden"  id="lote" name="lote">
                                <input type="hidden"  id="avi" name="avi">
                                <table class="tablagrilla table table-bordered table-striped compact" id="tabla_mor" name="tabla_mor">
                                
                                    <tbody class="tablagrilla">
                                        <tr class="tablagrilla">
                                            <td class="tablagrilla text-center" rowspan="7" style="width:10px;background-color:#666;"></td>
                                            <td class="tablagrilla text-center" colspan="4" >Columna 1</td>
                                            <td class="tablagrilla text-center" rowspan="7" style="width:10px;background-color:#666;"></td>
                                            <td class="tablagrilla text-center" colspan="4" >Columna 2</td>
                                            <td class="tablagrilla text-center" rowspan="7" style="width:10px;background-color:#666;"></td>
                                            <td class="tablagrilla text-center" colspan="4" >Columna 3</td>
                                            <td class="tablagrilla text-center" rowspan="7" style="width:10px;background-color:#666;"></td>
                                            <td class="tablagrilla text-center" colspan="4" >Columna 4</td>
                                            <td class="tablagrilla text-center" rowspan="7" style="width:10px;background-color:#666;"></td>
                                        </tr>
                                        <tr class="tablagrilla">
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">116</td>
                                            <td contenteditable="true"   style="width:50px;" id="116" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="126" class="tablagrilla text-right textcolor2 cerom" ></td> 
                                            <td class="tablagrilla text-center cursor-pointer btn-link">126</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">216</td>
                                            <td contenteditable="true"   style="width:50px;" id="216" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="226" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">226</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">316</td>
                                            <td contenteditable="true"   style="width:50px;" id="316" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="326" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">326</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">416</td>
                                            <td contenteditable="true"   style="width:50px;" id="416" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="426" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">426</td>

                                        </tr>
                                        <tr class="tablagrilla">
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">115</td>
                                            <td contenteditable="true"   style="width:50px;" id="115" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="125" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">125</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">215</td>
                                            <td contenteditable="true" mor_id=""  style="width:50px;" id="215" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true" mor_id=""  style="width:50px;" id="225" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">225</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">315</td>
                                            <td contenteditable="true" mor_id="" style="width:50px;" id="315" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true" mor_id="" style="width:50px;" id="325" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">325</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">415</td>
                                            <td contenteditable="true"  style="width:50px;" id="415" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"  style="width:50px;" id="425" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">425</td>

                                        </tr>
                                        <tr class="tablagrilla">
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">114</td>
                                            <td contenteditable="true"    style="width:50px;" id="114" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"    style="width:50px;" id="124" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">124</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">214</td>
                                            <td contenteditable="true"   style="width:50px;" id="214" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="224" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">224</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">314</td>
                                            <td contenteditable="true"   style="width:50px;" id="314" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="324" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">324</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">414</td>
                                            <td contenteditable="true"    style="width:50px;" id="414" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"    style="width:50px;" id="424" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">424</td>

                                        </tr>
                                        <tr class="tablagrilla">
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">113</td>
                                            <td contenteditable="true"    style="width:50px;" id="113" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"    style="width:50px;" id="123" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">123</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">213</td>
                                            <td contenteditable="true"   style="width:50px;" id="213" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="223" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">223</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">313</td>
                                            <td contenteditable="true"   style="width:50px;" id="313" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="323" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">323</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">413</td>
                                            <td contenteditable="true"   style="width:50px;" id="413" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="423" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">423</td>

                                        </tr>
                                        <tr class="tablagrilla">
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">112</td>
                                            <td contenteditable="true"  style="width:50px;" id="112" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"  style="width:50px;" id="122" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">122</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">212</td>
                                            <td contenteditable="true"   style="width:50px;" id="212" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="222" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">222</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">312</td>
                                            <td contenteditable="true"   style="width:50px;" id="312" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="322" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">322</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">412</td>
                                            <td contenteditable="true"   style="width:50px;" id="412" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="422" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">422</td>

                                        </tr>
                                        <tr class="tablagrilla">
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">111</td>
                                            <td contenteditable="true"   style="width:50px;" id="111" contenteditable="true" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="121" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">121</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">211</td>
                                            <td contenteditable="true"   style="width:50px;" id="211" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="221" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">221</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">311</td>
                                            <td contenteditable="true"   style="width:50px;" id="311" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="321" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">321</td>

                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">411</td>
                                            <td contenteditable="true"   style="width:50px;" id="411" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td contenteditable="true"   style="width:50px;" id="421" class="tablagrilla text-right textcolor2 cerom" ></td>
                                            <td class="tablagrilla text-center cursor-pointer btn-link" style="width:20px;;">421</td>

                                        </tr>
                                    </tbody>
                                </table> 
                                  
                                 
                                         <table class="tablagrilla table table-bordered table-striped compact">
                               
                                        </table>
                            <table class="tablagrilla table table-bordered table-striped compact ">
                                <thead>
                                <div class="row mt-2">
                                    
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Huevos</label>
                                            <input   campo="saldoant" type="text" id="total_filas" class="form-control form-control-sm text-center" readonly="">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Poductividad(%)</label>
                                            <input  campo="edad" type="text" id="productividad" class="form-control form-control-sm text-center" readonly="">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Productividad Padrón(%)</label>
                                            <input   campo="morpor" type="text" id="poduc_pad" class="form-control form-control-sm text-center" readonly="">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Dif. Prod. Padrón(%)</label>
                                            <input  type="text" id="diferencia" class="form-control form-control-sm text-center campo" readonly="">
                                        </div>
                                    </div>
                                   
                                    <div class="col-12 col-md-3">
                                        <div class="form-group">
                                            <label class="form-control-placeholder">Edad días(sem)</label>
                                            <input type="text" id="edad" class="form-control form-control-sm text-center" readonly="">
                                        </div>
                                    </div>
                                   
                                   
                                </table>
                             
                            </div>
                        </div>
                   
                        
                        </div>
                    </center></th>
                       
                        
</body>
</html>
