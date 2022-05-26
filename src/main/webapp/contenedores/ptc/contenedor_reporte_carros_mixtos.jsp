 
<div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
PTC
</div>
</div>
    <center><b>REPORTES DE CARROS MIXTOS</b></center>
</div>
   </div>  <br>           

<form id="formulario_reporte_reproceso" action="cruds/ptc/control_reporte_carros_mixto.jsp" name="formulario_reporte_reproceso" action="" target="_blank">

    <div class="form-check">
        <br>
        <input type="checkbox" class="form-check-input" id="check_numero"  >
        <label class="form-check-label" for="check_numero">FILTRO POR NUMERO</label>
    </div>
    <script>
        $(document).ready(function () {
            $("#check_numero").change(function () {
                if ($(this).prop('checked')) {
                    $("#numero").show();
                } else {
                    $("#numero").hide();
                    $("#numero").val('0');
                }
            });
        });
    </script>	
    <br> 
    <select class="form-control" name="cbox_estado" id="cbox_estado" required="true" > 
        <OPTION value=""  selected disabled>SELECCIONAR ESTADO DE LIBERACION</OPTION>
        <OPTION   VALUE="L">LIBERADO</OPTION>
        <OPTION   VALUE="R">RETENIDO</OPTION>
    </select>
    <div class="input-append">  
        <br>
        <input type="number"  value="0" id="numero" name="numero" placeholder="INGRESAR NUMERO" class="form-control" style="display: none">

    </div> 
    <br> 
    <input   class="btn btn-success form-control" type="submit"   value="Generar reporte"> 
</form>  