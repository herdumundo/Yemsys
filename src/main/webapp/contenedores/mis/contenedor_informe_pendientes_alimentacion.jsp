<%@include  file="../../versiones.jsp" %>


<%
    String version = contenedores_mis_contenedor_informe_pendientes_alimentacion;
    String version_desc = desc_contenedores_mis_contenedor_informe_pendientes_alimentacion;

%> 

<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>', '<%=version_desc%>')">
    <label ><%=version%></label> 
</div>
</head>
<input type="hidden" id="tipo" name="tipo" value="RP">
<div class="container-fluid">
    <div class="col-lg-20 ">
        <div class="position-relative p-3 bg-navy"  >
            <div class="ribbon-wrapper">
                <div class="ribbon bg-warning">
                    MIS
                </div>
            </div>
            <center><b>VISUALIZACIÓN DE PENDIENTES A ALIMENTAR</b></center>
        </div>
    </div>  <br>      




    <br>

    <div id="div_grilla"> </div>

    <div class='container'>Total: 
        <span id='total'></span>
        <table id='example' class='table'>
            <thead>
                <tr>
                    <td>Fecha puesta    </td>
                    <td>Codigo          </td>
                    <td>Cantidad        </td>
                    <td>Origen          </td>
                    <td>Tipo huevo      </td>
                    <td>Motivo          </td>
                </tr>
            </thead>

        </table>
    </div>  