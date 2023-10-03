<%-- 
    Document   : contenedor_transferencia_vimar
    Created on : 16-ago-2023, 8:53:36
    Author     : hvelazquez
--%>

<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 



<head>   
<label  ><b></b></label> 

</head>
<body>
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                VIM
            </div>
        </div>
        <center><b>INFORME TRANSFERENCIA VIMAR</b></center>
    </div>
</div>


            <h5 class="text-xl-center p-1"><b>Ingrese nuevo motivo</b></h5>
            <input class="form-control" id="motivo_txt" type="text" name="registro" placeholder="Escriba el motivo">
            <button class="form-control bg-gradient-cyan" onclick="registrarMotivo()" name="registro">Registrar motivo</button>        

        <table id="tb_registros" class="table">
            <thead>
            <th class="bg-navy sorting">Id</th>
            <th class="bg-navy sorting">Motivo</th>
            <th class="bg-navy sorting">Estado</th>
            <th class="bg-navy sorting">Tipo</th>
            <th class="bg-navy sorting">Editar</th>
            <th class="bg-navy sorting">Eliminar</th>
            </thead>
            <tbody id="tbody_motivos">
                
            </tbody>
</body>


<div class="modal fade" id="modal_motivo" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-black">
                <h5 class="modal-title" id="exampleModalLabel">EDITAR MOTIVO</h5>
                <button class="close" type="button"  class="position-relative p-3 bg-navy"  data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body bg-navy"   >  
                <form id="form_upd_motivo" action="POST"  style=" height: 25px">
                    <!--<input hidden="true" class="form-control text-left " type="text" style="width: 100%" disabled="true" id="txt_id"    name="txt_id">-->
                    
                    <strong><a>ID</a></strong> 
                    <input class="form-control text-left " style="width: 100%" type="text"   id="id_txt"    name="id_txt"  required >
                    <strong><a>MOTIVO</a></strong> 
                    <input class="form-control text-left " style="width: 100%" type="text"   id="motivo_modal_txt"    name="motivo_modal_txt"  required >
                    <strong><a>ESTADO</a></strong> 
                    <input class="form-control text-left " style="width: 100%" type="text"   id="estado_modal_txt"    name="estado_modal_txt"  required >
                    <strong><a>TIPO</a></strong> 
                    <input class="form-control text-left " style="width: 100%" type="text"   id="tipo_modal_txt"    name="tipo_modal_txt"  required >
                    
                    <div class="modal-footer align-right">
                        <input  class="btn bg-white"  type="button"  onclick="updateModalMotivos()"  id="btn_apd_usuario" value="ACEPTAR" >
                        <input  class="btn bg-white"  type="button"   data-dismiss="modal"   value="CANCELAR" >            
                    </div>
                </form>   
            </div>
        </div>
    </div>
</div>   


 
