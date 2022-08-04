<%@include  file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%          
    if (sesion == true) 
    {
        try 
        {
            String codigo_mesa = request.getParameter("codigo_mesa");
            String id_lote = request.getParameter("id_carrito");
            PreparedStatement pss = connection.prepareStatement("update lotes set cod_cambio ='" + codigo_mesa + "' where cod_interno='" + id_lote + "' ");
            pss.executeUpdate();
         
        } catch (Exception e) 
        {
        
        }
        finally
        {
            connection.close();
        }
    }
%>  