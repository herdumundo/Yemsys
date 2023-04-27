<%-- 
    Document   : informe_factura
    Created on : 05/03/2020, 11:04:47 AM
    Author     : hvelazquez
--%>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
  
 <body>
    <%    
    try 
    {
        String area =(String) sesionOk.getAttribute("clasificadora");
        String fecha =request.getParameter("fecha");
        String tipo =request.getParameter("tipo");
        String tipo_reporte =request.getParameter("tipo_reporte");
        Statement stmt, stmt1, stmt2, stmt3;

        ResultSet rs ;
        
        String bd_area="area ";
        String bd_areaRs="";
    
        if(tipo_reporte.equals("2")){
            bd_area="destino ";
        }
        stmt = connection.createStatement();
        rs = stmt.executeQuery ("select * "
               + "from lotes_transferencia "
               + "where convert(varchar,fecha,103)='"+fecha+"'"
               + " and "+bd_area+"='"+area+"' and tipo_transferencia='"+tipo+"' and reprocesado is null  order by 1 desc");
   
     
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
              <form action="cruds/ptc/control_reporte_transferencia.jsp" method="get" target="_black" > 
                
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
finally{
connection.close();
}
         
        %>
         
 </body>