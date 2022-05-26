<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@include  file="../../chequearsesion.jsp" %>
<%  
    String usuario =            (String) sesionOk.getAttribute("usuario");
    String clasificadora =      (String) sesionOk.getAttribute("clasificadora");
    String clasificadora_cch =  (String) sesionOk.getAttribute("area_cch");
    String perfil =             (String) sesionOk.getAttribute("perfil");
    String user_name =          (String) sesionOk.getAttribute("nombre_usuario");
    String calendario= request.getParameter("fecha");
    %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
 
 
    <table id="grilla_eliminar" class="table table-striped table-bordered" style="width:100%">
                <thead>
                    <th>
                    Nro carro
                    </th>
                    <th>
                    Fecha de puesta
                    </th>
                    <th>
                    Tipo Huevo
                    </th>
                    <th>
                    Cantidad
                    </th>
                    <th>
                    Tipo
                    </th>
                    <th>
                    ACCION
                    </th>   
                </thead>
            <tbody id="grilla_eliminar">
            <%

        clases.controles.connectarBD();   
        Connection cn = clases.controles.connect; 
        fuente.setConexion(cn);
        ResultSet rs = fuente.obtenerDato(" exec [mae_ptc_select_eliminarLotes] @fecha='"+calendario+"',@area='"+clasificadora+"',@area_cch='"+clasificadora_cch+"',@perfil='"+perfil+"'");
            while(rs.next())
                {%>  
                <tr id="<%=rs.getString("cod_lote")%>">  
                    <td> <b><%=rs.getString("cod_carrito")%>  </b></td>
                    <td> <b><%=rs.getString("Fecha_eliminar")%></b></td>
                    <td> <b><%=rs.getString("tipo_huevo")%></b></td> 
                    <td> <b><%=rs.getString("cantidad")%></b></td>
                    <td> <b><%=rs.getString("tipo")%></b></td>
                    <td> <i class="fas fa-trash fa-2x text-danger" onclick="validacion_eliminacion_ptc('<%=clasificadora_cch%>','<%=rs.getString("cod_interno")%>','<%=rs.getString("cantidad")%>','<%=rs.getString("itemcode")%>','<%=calendario%>','<%=rs.getString("cod_carrito")%>','<%=rs.getString("cod_lote")%>','<%=rs.getString("tipo")%>');" ></i>
                    </td>  
                <%}
                    cn.close();
                    controles.DesconnectarBD();
                %>   
                </tr> 
            </tbody>   
    </table>   
      