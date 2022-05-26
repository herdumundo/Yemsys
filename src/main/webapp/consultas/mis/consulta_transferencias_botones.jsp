<%-- 
    Document   : informe_factura
    Created on : 05/03/2020, 11:04:47 AM
    Author     : hvelazquez
--%>
 <%@page import="java.sql.*"%>
<%@include  file="../../chequearsesion.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
  
 <body>
    <%    
  
        String area =(String) sesionOk.getAttribute("clasificadora");
        String fecha =request.getParameter("fecha");
        String tipo =request.getParameter("tipo");
        String tipo_reporte =request.getParameter("tipo_reporte");
        clases.controles.VerificarConexion();
        Connection cn = clases.controles.connectSesion;
    
        fuente.setConexion(cn); 
        ResultSet rs ;
          try 
    {
        String bd_area="area ";
        String bd_areaRs="";
    
        if(tipo_reporte.equals("2")){
            bd_area="destino ";
        }
       rs = fuente.obtenerDato ("select * "
               + "from lotes_transferencia "
               + "where convert(varchar,fecha,103)='"+fecha+"'"
               + " and "+bd_area+"='"+area+"' and tipo_transferencia='"+tipo+"' order by 1 desc");
   
     
            while (rs.next())
            { 
            String nro_transferencia=rs.getString("id");
            if(tipo_reporte.equals("2")){
            bd_areaRs="area";
            }
            else{
            bd_areaRs="destino";
            }
            %>
              <br>
              <form action="cruds/mis/control_reporte_transferencias.jsp" method="get" target="_black" > 
                
                <input type="hidden" value="<%=nro_transferencia%>" name="nro_transferencia">
                <input type="hidden" value="<%=rs.getString("tipo_transferencia")%>" name="tipo_transferencia">
                <input type="submit" value="<%=rs.getString("fecha")%>  IR A TRANSFERENCIA NRO.  <%=nro_transferencia%> CLASIFICADORA: <%=rs.getString(bd_areaRs)%> "    class="form-control btn-danger">
          
          </form>
          <br>
 
        <%} 
            rs.close();
        } 
    catch (Exception e) 
    {

    }
    finally 
    {
        cn.close();
        clases.controles.DesconnectarBDsession();
    }
         
        %>
         
 </body>