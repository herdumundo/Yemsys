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

</script>
<div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
PPR
</div>
</div>
    <center><b>REGISTRO DE DATOS DIARIOS PRE-DESCARTE CONVENCIONALES</b></center>
</div>
   </div>  <br>
<div class="card m-4">
    
    <section class="content" id="contenido">
        <div class="text-center "  >
              <div class="bg-navy">
            <table id="tabla" name="tabla" class=" tablagrilla compact-cs ">
               
                <th class="tablagrilla">
                        <center>
                             <input onchange="carga_grilla_pre_des_convencionales_ppr2()" type="date" id="idfecham" step="1 name="idfecham" min="2014-10-01" class="tablagrilla form-control text-center cargar_u_r_datosdiariosA" required="">
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
            <br>   
            <div id="tabla_datos_diarios_pre_descarte_mecanizados" class="tablagrilla input-group-append ocultar"></div>
        </div>
        </center>
    </section>
    <!-- /.content -->
</div>
