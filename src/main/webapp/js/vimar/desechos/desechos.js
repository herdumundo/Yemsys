function irDesechosAveriados (){
    $.ajax({
        type: "POST",
        url: rutaContenedoresDesechosVimar + "contenedor_desechos.jsp",
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
            $("#contenedor_principal").html("");
        },
        success: function (data)
        {
            $("#contenedor_principal").html(data);
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });
}

function cuadroDesechos(id,cantidad,fecha,tipo,linea){
      Swal.fire({
    icon: "warning",
    customClass: 'swal-wide',
    html: `
    <label >`+linea+`: Nro. `+id+` </label> <br>
    <label >Lote: `+fecha+` </label>
       <div class="form-container">
    <div class="form-group">
        
        <input type="number" id="cantidad" placeholder="Ingrese cantidad de gramos" class="form-control">
    </div>

    <div class="form-group">
        <input type="button" class="btn btn-success form-control" value="Registrar" onclick="registrarDesechos(`+id+`,`+cantidad+`,'`+fecha+`','`+tipo+`',$('#cantidad').val())"> 
      </div>
</div>
    `,
    title: tipo + ': ' + cantidad,
    text: 'Tu subtítulo aquí',  // Agrega el subtítulo utilizando la propiedad text
    showCancelButton: false,
    showConfirmButton: false
});

}

function registrarDesechos(id,cantidad,fecha,tipo,gramos){
    console.log(id,cantidad,fecha,tipo,gramos);
    
      $.ajax({
        type: 'POST',
        url: rutaCrudsDesechosVimar + 'crud_desechos.jsp',
        data: ({ id: id, cantidad: cantidad, fecha: fecha, tipo: tipo, gramos: gramos}),
        beforeSend: function (xhr) {
             procesando_swal();
        },
        success: function (data) {
            aviso_generico(data.tipo, data.msg );
            irDesechosAveriados();
        }
    });
    
 }


function irInformeAveriadosDesecho(){
    $.ajax({
        type: "POST",
        url: rutaContenedoresDesechosVimar + "contenedor_informe_desechos.jsp",
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
            $("#contenedor_principal").html("");
        },
        success: function (data)
        {
            $("#contenedor_principal").html(data);
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });
}
