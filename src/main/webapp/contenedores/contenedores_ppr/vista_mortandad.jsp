<%-- 
    Document   : reporte_grilla_mortandad
    Created on : 07/01/2022, 08:10:55
    Author     : csanchez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="card m-4">
            <input type="hidden" id="avi" name="avis">
            <section class="content" id="contenido"><div class="text-center">
                    <div class="card-header">
                        <h4 class="text-center">CONTADOR DE MUERTES</h4>
                    </div>
                        <div class="card-header">
                        <form  id="filtro-form" class="form-inline" autocomplete="off">
                              <br><table class="table-responsive">
                                  
                                        <thead class="table-responsive" >
                                            
                                            <tr><th ><label  class="col-form-label">AVIARIO:</label></th>
                                            <th><select id="avi_m" name="avi" class="form-control">
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
                                            </select></th>
                                        <th><label>FECHA</label></th>
                                        <th><input type="date" id="idfecha_m" name="fecha" class="form-control text-center"></th>
                                        <th><input type="button" id="buscar" name="buscar" onclick="contador_mortandad_ppr()" class="form-control text-center" value="Buscar"></th>
                                        <th><input type="button" id="limpiar" name="limpiar" onclick="limpiar_ppr()" class="form-control text-center" value="Buscar"></th>
                                        
                                        </tr></thead>
                                    </table>
                            </form>
                    </div>
                </div>
                
                    <div class="box box-default">
                        <div class="card-header" id="datos">
                            <center>
                                <form  id="formceldas" class="form-inline" autocomplete="off">
                            <table class="tabla table-condensed table-responsive tabla-con-borde listLargeTable mx-auto">
                                <thead class="text-center">
                                    <tr class="text-center">
                                        <th></th>
                                        <th>Columna 1</th>
                                        <th>Columna 1</th>
                                        <th></th>
                                        <th></th>
                                        <th>Columna 2</th>
                                        <th>Columna 2</th>
                                        <th></th>
                                        <th></th>
                                        <th>Columna 3</th>
                                        <th>Columna 3</th>
                                        <th></th>
                                        <th></th>
                                        <th>Columna 4</th>
                                        <th>Columna 4</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>

                                        <th>116</th>

                                        <td id="celda116" class="celda_editable single_line text-center" contenteditable="false" data-lote="287" data-fila="116" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda126" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="126" data-aviario="A2" data-orig=""></td>                    
                                        <th>126</th>                    

                                        <th>216</th>

                                        <td id="celda216" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="216" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda226" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="226" data-aviario="A2" data-orig=""></td>                    
                                        <th>226</th>                    

                                        <th>316</th>

                                        <td id="celda316" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="316" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda326" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="326" data-aviario="A2" data-orig=""></td>                    
                                        <th>326</th>                    

                                        <th>416</th>

                                        <td id="celda416" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="416" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda426" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="426" data-aviario="A2" data-orig=""></td>                    
                                        <th>426</th>                    
                                    </tr>
                                    <tr>

                                        <th>115</th>

                                        <td id="celda115" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="115" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda125" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="125" data-aviario="A2" data-orig=""></td>                    
                                        <th>125</th>                    

                                        <th>215</th>

                                        <td id="celda215" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="215" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda225" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="225" data-aviario="A2" data-orig=""></td>                    
                                        <th>225</th>                    

                                        <th>315</th>

                                        <td id="celda315" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="315" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda325" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="325" data-aviario="A2" data-orig=""></td>                    
                                        <th>325</th>                    

                                        <th>415</th>

                                        <td id="celda415" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="415" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda425" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="425" data-aviario="A2" data-orig=""></td>                    
                                        <th>425</th>                    
                                    </tr>
                                    <tr>

                                        <th>114</th>

                                        <td id="celda114" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="114" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda124" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="124" data-aviario="A2" data-orig=""></td>                    
                                        <th>124</th>                    

                                        <th>214</th>

                                        <td id="celda214" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="214" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda224" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="224" data-aviario="A2" data-orig=""></td>                    
                                        <th>224</th>                    

                                        <th>314</th>

                                        <td id="celda314" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="314" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda324" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="324" data-aviario="A2" data-orig=""></td>                    
                                        <th>324</th>                    

                                        <th>414</th>

                                        <td id="celda414" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="414" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda424" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="424" data-aviario="A2" data-orig=""></td>                    
                                        <th>424</th>                    
                                    </tr>
                                    <tr>

                                        <th>113</th>

                                        <td id="celda113" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="113" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda123" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="123" data-aviario="A2" data-orig=""></td>                    
                                        <th>123</th>                    

                                        <th>213</th>

                                        <td id="celda213" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="213" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda223" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="223" data-aviario="A2" data-orig=""></td>                    
                                        <th>223</th>                    

                                        <th>313</th>

                                        <td id="celda313" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="313" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda323" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="323" data-aviario="A2" data-orig=""></td>                    
                                        <th>323</th>                    

                                        <th>413</th>

                                        <td id="celda413" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="413" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda423" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="423" data-aviario="A2" data-orig=""></td>                    
                                        <th>423</th>                    
                                    </tr>
                                    <tr>

                                        <th>112</th>

                                        <td id="celda112" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="112" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda122" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="122" data-aviario="A2" data-orig=""></td>                    
                                        <th>122</th>                    

                                        <th>212</th>

                                        <td id="celda212" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="212" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda222" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="222" data-aviario="A2" data-orig=""></td>                    
                                        <th>222</th>                    

                                        <th>312</th>

                                        <td id="celda312" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="312" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda322" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="322" data-aviario="A2" data-orig=""></td>                    
                                        <th>322</th>                    

                                        <th>412</th>

                                        <td id="celda412" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="412" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda422" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="422" data-aviario="A2" data-orig=""></td>                    
                                        <th>422</th>                    
                                    </tr>
                                    <tr>

                                        <th>111</th>

                                        <td id="celda111" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="111" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda121" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="121" data-aviario="A2" data-orig=""></td>                    
                                        <th>121</th>                    

                                        <th>211</th>

                                        <td id="celda211" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="211" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda221" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="221" data-aviario="A2" data-orig=""></td>                    
                                        <th>221</th>                    

                                        <th>311</th>

                                        <td id="celda311" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="311" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda321" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="321" data-aviario="A2" data-orig=""></td>                    
                                        <th>321</th>                    

                                        <th>411</th>

                                        <td id="celda411" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="411" data-aviario="A2" data-orig=""></td>                    

                                        <td id="celda421" class="celda_editable single_line text-center" contenteditable="false" data-fecha="06/01/2022" data-avi="A2" data-lote="287" data-fila="421" data-aviario="A2" data-orig=""></td>                    
                                        <th>421</th>                    
                                    </tr>
                                </tbody>
                            </table>
                            </form>
                                </center>
                            <div class="card-header">
                                <div class="text-center">
                                   
                                    <div class="text-center">
                                            <label>Muertes</label>
                                            <input type="text" id="muertes" name="huevos" class="form-control text-center border-huevos bg-huevos-light" disabled="">
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
            <!-- /.content -->
        </div>
    </body>
</html>
