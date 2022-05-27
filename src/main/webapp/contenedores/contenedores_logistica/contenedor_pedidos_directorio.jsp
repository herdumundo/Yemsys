<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>   
 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

 <% 
    clases.controles.connectarBD();
    fuente.setConexion(clases.controles.connect);
    ResultSet rs;
    String fecha_actual = "";
    try 
    {
        rs = fuente.obtenerDato(" select   GETDATE()  as hora ");
        while(rs.next())
        {    
            fecha_actual = rs.getString("hora");
        }
        rs.close();  
    } 
    catch (Exception e) 
    {
    }
    finally
    {
       clases.controles.DesconnectarBD();
    }
       
%> 
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=clases.versiones.contenedores_stok_vimar_directorio %>','VERSION: <%=clases.versiones.contenedores_stok_vimar_directorio %>','<%=clases.versiones.desc_contenedores_stok_vimar_directorio %>'  )">
    <label ><%=clases.versiones.contenedores_stok_vimar_directorio%></label> 
</div>
</head>    
<div class="col-lg-20 " onclick="ir_stock_directorio_cyo()">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning ">
DIR
</div>
</div>
 <i class="fas fa-envelope"></i> Última Actualización:<%=fecha_actual%>
     <center><b>STOCK CYO MAEHARA</b></center>
</div>
   </div> 

<!-- comment -->

 

  <div id="contenido_grilla"> 
     </div> 

  <div id="contenido_grilla_mixto"> 
     </div> 


