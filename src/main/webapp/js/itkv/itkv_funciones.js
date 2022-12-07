function ir_consumo_combustible_itkv()
{
    window.location.hash = "SCFBAL";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_itkv + "contenedor_consumo_combustible.jsp",
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
                 $('.selectpicker').selectpicker({ size: '10'
            });   
             $('#ubicacion').val('UB-00000').prop('selected', true);            
            $('#ubicacion').selectpicker('refresh');

            $('#rubro').val('UPR-001').prop('selected', true);            
            $('#rubro').selectpicker('refresh');

            $('#actividad').val('GAN').prop('selected', true);            
            $('#actividad').selectpicker('refresh');


            $("#form_add_consumo").on("submit", function (e) {
                e.preventDefault(), 
                        registrar_salida1_itkv(); 
                e.stopPropagation();
            }) 
            cerrar_load();
    
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });

}




function registrar_salida1_itkv() {
    
    
    
  var  responsable      = $("#retirado_por").val();
  var  id_activo        = $("#activo").find(':selected').attr('value');  
  var  desc_activo      = $("#activo").find(':selected').attr('desc');   
  var  id_ubicacion   = $("#ubicacion").find(':selected').attr('value');  
  var  desc_ubicacion = $("#ubicacion").find(':selected').attr('desc'); 
  var  id_rubro       = $("#rubro").find(':selected').attr('value');   
  var  desc_rubro     = $("#rubro").find(':selected').attr('desc');   
  var  id_actividad   = $("#actividad").find(':selected').attr('value');   
  var  desc_actividad =  $("#actividad").find(':selected').attr('desc');    
  var  km_ho          = $("#km_ho").val();
  var  id_boca        = $("#boca").find(':selected').attr('value');     
  var  desc_boca      = $("#boca").find(':selected').attr('desc');     
  var  lt_inicio      = $("#lt_inicio").val();
  var  lt_fin         = $("#lt_fin").val();
  var  lt_total       = $("#lt_total").val();
    
    
  
    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA GENERAR EL DOCUMENTO?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: ruta_cruds_itkv + "crud_registrar_salida_combustible.jsp",
                data: { 
                
                responsable:responsable,
                id_activo:id_activo,
                desc_activo:desc_activo,
                id_ubicacion:id_ubicacion,
                desc_ubicacion:desc_ubicacion,
                id_rubro:id_rubro,
                desc_rubro:desc_rubro,
                id_actividad:id_actividad,
                desc_actividad:desc_actividad,
                km_ho:km_ho,
                id_boca:id_boca,
                desc_boca:desc_boca,
                lt_inicio:lt_inicio,
                lt_fin:lt_fin,
                lt_total:lt_total,
                
                
                
                },
                beforeSend: function () {
                    Swal.fire({
                        title: "PROCESANDO!",
                        html: "<strong>ESPERE</strong>...",
                        showCancelButton: false,
                        showConfirmButton: false,
                        allowOutsideClick: !1,
                        onBeforeOpen: () => {
                            Swal.showLoading(),
                                    (timerInterval = setInterval(() => {
                                        Swal.getContent().querySelector("strong").textContent = Swal.getTimerLeft();
                                    }, 1e3));
                        },
                    });
                },
                success: function (res)
                {
                    if (res.tipo_respuesta ==1) {
                        swal.fire({
                            type: 'success',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });
 
                        ir_consumo_combustible_itkv();
                    } else {
                        swal.fire({
                            type: 'error',
                            html: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                    }
                }
            });
        }
    }); 
}

function calcular_litros_itkv(){
    var  lt_inicio      = $("#lt_inicio").val();
    var  lt_fin         = $("#lt_fin").val();
     
    
    $("#lt_total").val(parseInt(lt_fin)-parseInt(lt_inicio));
}
function ir_reporte_consumo_combustible_itkv()
{
    window.location.hash = "IRCCI";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_itkv + "contenedor_consumo_combustible_reporte.jsp",
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            cargar_estilo_calendario_global('dd/mm/yyyy',true);
             
            
            cerrar_load();
    
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });

}

function ir_grilla_consumo_combustible_itkv()
{
     $.ajax({
        type: "POST",
        url: ruta_consultas_itkv + "consulta_gen_grilla_impresion_combustible.jsp",
        data:({fecha:$("#fecha").val()}),
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#div_grilla").html("");
            $("#div_grilla").html(data.tabla);
            
           // activar_datatable("#grilla");
            cerrar_load();
    
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });

}