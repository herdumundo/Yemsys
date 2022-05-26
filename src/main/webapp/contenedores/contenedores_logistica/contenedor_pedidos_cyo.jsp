<%@page import="clases.fuentedato"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
 <%     
    clases.controles.connectarBD();
    fuente.setConexion(clases.controles.connect);
    ResultSet rs;
    rs = fuente.obtenerDato("select * from  maehara.dbo.[@CAMIONES] where u_estado='Activo' and   u_desc<>'' ");
    
 try {
         
    %>
    <select class="btn btn-dark"  id="cbox_camion" style="font-weight: bold;color:white;" >
        <option  capacidad="0" codigo="0" disabled selected class="btn btn-dark" >CAMION</option>
        <%while(rs.next())
        { %><option capacidad="<%=rs.getString("u_capacidad")%>"  value="<%=rs.getString("code")%>" codigo="<%=rs.getString("code")%>"><%=rs.getString("code")%>-<%=rs.getString("u_desc")%> </option><%  } %>
    </select>   
    
    <input type="hidden"  id="id_pedido"> 
    <input type="hidden" id="huevos_cargados"> 
 
    <input type="hidden" id="id_chofer"> 
    <input type="button" value="MODIFICAR PEDIDO"   onclick="registrar_pedido_mod_cyo();"  class="form-control bg-navy" id="btn_generar"style="font-weight: bold;color:white;"   >
     <div id="contenido_grilla_tipos"> 
      
    </div>
    
    <div id="contenido_grilla"> 
      
    </div>
    
    
    <%
     } catch (Exception e) {
     }
    finally{
    clases.controles.DesconnectarBD();
}
    %>