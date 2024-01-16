<%@include  file="../../../versiones.jsp" %>
<%@include  file="../../../chequearsesion.jsp" %>
<%@include  file="../../../cruds/conexion.jsp" %>
<%@page import="org.json.JSONObject"%>
<%@ page contentType="application/json; charset=utf-8" %>
<%
         String id_carro = request.getParameter("id_carro");
         String nro_carro = request.getParameter("nro_carro");

        JSONObject ob = new JSONObject();
        ob=new JSONObject();
        String filas="";
        String contenedor="";
         ResultSet rs;
         Statement st = connection.createStatement();
         rs = st.executeQuery("exec [vim_select_fallas_html] @cod_interno="+id_carro+"");
         int c=0;
         int tipo=0;
            if (rs.next()){
               filas=rs.getString("html") ;
          
            }
           
            if (filas.equals("")){
                 contenedor="<div style='font-weight: bold;' class='alert alert-warning alert-dismissible fade show' role='alert'> SIN DESECHOS PARA EL CARRO NRO."+nro_carro+" </div>";
           tipo=0;
           
               
            }
    
            else {
                
              contenedor="<table data-row-style='rowStyle' data-toggle='table' class='table' data-click-to-select='true'>"
                +           "<thead> "
                +           "<tr> "
                +           "<th>Cantidad</th> "
                +           "<th>Tipo</th> "
                +           "</tr> "
                +           "</thead> "
                +           "<tbody> "
                +           ""+filas+" </tbody> </table>"; 
                 tipo=1;
            
            }
            
        ob.put("contenido",contenedor);
        ob.put("tipo",tipo);
        out.print(ob);
       %>
       
       
       
