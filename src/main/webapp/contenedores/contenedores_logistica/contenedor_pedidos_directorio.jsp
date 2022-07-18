<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

 <% 
    ResultSet rs;
    PreparedStatement ps, ps2;
 
    String fecha_actual = "";
    try 
    {
        ps= connection.prepareStatement (" select   GETDATE()  as hora ");
        rs = ps.executeQuery();

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
       connection.close();
    }
       
%> 
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=contenedores_stok_vimar_directorio %>','VERSION: <%=contenedores_stok_vimar_directorio %>','<%=desc_contenedores_stok_vimar_directorio %>'  )">
    <label ><%=contenedores_stok_vimar_directorio%></label> 
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

 

  <div id="contenido_grilla"> 
     </div> 

  <div id="contenido_grilla_mixto"> 
     </div> 


