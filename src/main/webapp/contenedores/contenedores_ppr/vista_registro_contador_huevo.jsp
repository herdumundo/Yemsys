<%-- 
    Document   : vista_registro_contador_huevo
    Created on : 26-ene-2022, 13:37:16
    Author     : aespinola
--%>
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
            document.getElementById("fecha").setAttribute("max", today);
           

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

        
            setInputDate("#fecha");

        </script>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <div class="card m-4">
            <input type="hidden" value="2" id="udepartamento" name="udepartamento">
            <section class="content" id="contenido">
                <div class="text-center">
                    <div class="bg-navy">
                        <h4 class="text-center">Contador de Huevos</h4>
                    </div>
                                        <table id="tabla" name="tabla" class=" tablagrilla compact-cs">
                                        <th>
                                        <center>
                                            <label class="">Aviario</label>
                                        </center>
                                        <center>
                                            <select onchange="consulta_contador_huevo_ppr(),traer_grilla_contador_huevo_ppr()" style="width:100px" id="avi" name="avi" class="form-control">
                                                <option class="text-center" ></option>
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
                                        <th>
                                        <center>
                                            <label>Fecha</label>
                                        </center>
                                        <center>
                                            <input   type="date" id="fecha" name="fecha" class="form-control text-center"
                                                     onchange="consulta_contador_huevo_ppr(),traer_grilla_contador_huevo_ppr()" >
                                        </center></th>
                                        
                                            <br>
                                       
                                          
                                    </table>
                       
                    <div id="grilla_contador_huevo"> </div>
                        
        </div>
    </center>
</section>
<!-- /.content -->
</div>