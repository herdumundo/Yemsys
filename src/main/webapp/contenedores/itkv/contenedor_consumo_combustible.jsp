<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 

<%    
    PreparedStatement ps, ps2;
    ResultSet rs, rs2;
    try 
    {
        ps = connection.prepareStatement("  select *,b.descripcion as desc_estado,"
                + " case when  toneladas_proyectada='' then 'INDEFINIDO' ELSE   toneladas_proyectada end as toneladas_desc"
                + " from mae_bal_mtp_cab_solicitud a inner join mae_bal_estados b on a.estado=b.id and a.estado=3");// 3
        rs = ps.executeQuery();
 %>
<style>
     tr:hover {color:#ffffff ; background-color: #001940;}
</style>
<head>   
<label  ><b></b></label> 
 
</head><!-- comment -->
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                ITKV
            </div>
        </div>
        <center><b>REGISTRO DE CONSUMO DE COMBUSTIBLE</b></center>
    </div>
</div> 
 
<form id="form_add_consumo" method="post" class="  bg-black"  >
               
                 
                 <br>
                <strong ><a>Responsable</a></strong>
                <select class="form-control">
                    <option>resp 1</option>
                    <option>resp 2</option>
                    <option>resp 3</option>
                    <option>resp 4</option>
                </select>
            <strong ><a>Activo</a></strong>
                <select class="form-control">
                    <option>CAMION 1</option>
                    <option>CAMION 2</option>
                    <option>CAMION 3</option>
                    <option>CAMION 4</option>
                </select> 
                  
                  
                 <strong ><a>Km/Ho</a></strong>
                 <input type="number" class="form-control" placeholder="Ingrese Km/Ho">
                 <br>
                 <br>
                 <br>
                <strong ><a>Boca de expendio</a></strong>
                <select class="form-control">
                    <option>Boca 1</option>
                    <option>Boca 2</option>
                    <option>Boca 3</option>
                    <option>Boca 4</option>
                </select>                   
                <strong ><a>Litros inicio</a></strong>
                 <input type="number" class="form-control" placeholder="Ingrese litros inicio">
               <strong ><a>Litros final</a></strong>
                 <input type="number" class="form-control" placeholder="Ingrese litros final">
               <strong ><a>Litros cargados</a></strong>
                 <input type="number" class="form-control" placeholder="Ingrese litros cargados">
                              
		
                 <div class="modal-footer align-right " >
                    <input  class="btn bg-white"  type="button"   onclick="registrar_usuario_ppr()"    id="btn_add_usuario" value="REGISTRAR" >
                    
                    <input  class="btn bg-white"  type="button"  onclick="cancelar_usuarios_ppr()"   value="CANCELAR" >
                     
                    
                </div>
            </form>

 
           
                            
  
         

     
 

            
            
            
            
            
<%
    } catch (Exception e) {

    } finally {
        connection.close();
    }%>