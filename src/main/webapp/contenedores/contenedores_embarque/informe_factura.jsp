<%-- 
    Document   : informe_factura
    Created on : 05/03/2020, 11:04:47 AM
    Author     : hvelazquez
--%>
<%@page import="clases.controles"%>
<%@page import="clases.embarque"%>
<%@page import="java.sql.*"%>
<%@include  file="../../chequearsesion.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
  <% 
     String version=clases.versiones.contenedores_embarque_informe_factura;
     //<%=version%>
 %>  
<!DOCTYPE html>
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')">
    <label ><%=version%></label>  
</div>
</head>
<body>
    <%        try {
        
        
            controles.connectarBD();
            fuente.setConexion(clases.controles.connect);
            ResultSet rs, rs2;
            String area = (String) sesionOk.getAttribute("area");
            String chofer = "";
            String camion = "";
            rs = fuente.obtenerDato(""
                    + " select distinct a.numatcard,a.DocEntry , convert(varchar,a.docdate,103) as fecha ,a.u_cod_camion,c.Name,c.code  "
                    + "from "
                    + "" + clases.variables.BD2 + ".dbo.oinv a with(nolock) "
                    + " inner join " + clases.variables.BD2 + ".dbo.inv1 b with(nolock) on a.DocEntry=b.DocEntry and b.WhsCode='" + area + "'   "
                    + " inner join " + clases.variables.BD2 + ".dbo.[@CHOFERES] c with(nolock) on a.U_Cod_Chofer=c.Code   "
                    + " and a.isIns='Y' and a.InvntSttus='o'  and b.InvntSttus='o'"
                    + " where a.NumAtCard collate database_default not in (select nro_factura from " + clases.variables.BD + ".dbo.embarque_cab with(nolock) "
                    + "  where   estado_sincro in('N','P','F' ) and area='" + area + "' "
                    + ")"
                    + " order by a.numatcard ");
            String num_fact = "";
            String docentry = "";
            String tipo = "";
            String desc = "";
            String estado = "";
            int cantidad = 0;
            int cantidad_resto = 0;
            String estado_formateado = "";
            String caja = "";
            int resto = 0;
            String texto = "";
            String fecha = "";
            String cod_chofer = "";
            int sum = 0;

    %>
    <div class="col-lg-20 ">
        <div class="position-relative p-3 bg-navy"  >
            <div class="ribbon-wrapper">
                <div class="ribbon bg-warning">
                    EMBARQUE
                </div>
            </div>
            <center><b>EMBARQUES DISPONIBLES</b></center>
        </div>
    </div>  <br>    

    <form id="form1">
        <%                String factura_formato = "";
            while (rs.next()) {
                num_fact = rs.getString("numatcard");
                docentry = rs.getString("DocEntry");
                fecha = rs.getString("fecha");
                chofer = rs.getString("Name");
                cod_chofer = rs.getString("code");
                camion = rs.getString("u_cod_camion");
                rs2 = fuente.obtenerDato("  "
                        + " select itemcode,InvntSttus,Dscription,"
                        + "(convert(int,(Quantity - isnull(delivrdqty,0))*12)) as cantidad,WhsCode "
                        + " from  " + clases.variables.BD2 + ".dbo.inv1 with(nolock)  where docentry='" + docentry + "' and whsCode='" + area + "' and InvntSttus='o'");
                factura_formato = num_fact.substring(8);
        %>
        <div class="row">
            <div class="col-12">

                <div class="card">
                    <div class="card-header bg-navy">
                        <h3 class="card-title"><%=num_fact%>   FECHA:<%=fecha%>         CHOFER:<%=chofer%>        CAMION:<%=camion%>   </h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-tool" data-card-widget="remove" title="Remove">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <table   class="table border" data-click-to-select="true">
                            <thead class="bg-black">
                            <th>
                                TIPO
                            </th> 
                            <th>
                                DESCRIPCION
                            </th> 
                            <th>
                                CANTIDAD
                                PENDIENTE
                            </th> 
                            </thead>
                            <tbody>
                            <tbody> 
                                <%  while (rs2.next()) {
                                        tipo = rs2.getString("itemcode");
                                        desc = rs2.getString("Dscription");
                                        cantidad = rs2.getInt("cantidad");
                                        cantidad_resto = rs2.getInt("cantidad");

                                        if (cantidad < 4320) {
                                            if (tipo.equals("1")) {
                                                if (cantidad < 2160) {
                                                    cantidad = (cantidad / 180);
                                                    texto = "CAJONES: " + cantidad;
                                                } else {
                                                    cantidad = cantidad / 2160;
                                                    texto = "CARROS: " + cantidad;
                                                }
                                            } else {
                                                cantidad = cantidad / 360;
                                                texto = "CAJONES: " + cantidad;

                                            }
                                        } else {
                                            cantidad = cantidad / 4320;
                                            caja = "CARROS";
                                            resto = (cantidad_resto % 4320) / 360;
                                            if (resto == 0) {
                                                texto = "CARROS: " + cantidad;

                                            } else {
                                                texto = "CARROS: " + cantidad + " Y CAJONES: " + resto;
                                            }
                                        }
                                %>
                                <tr>
                                    <td><b><%=tipo%> </b></td>
                                    <td><b><%=desc%> </b></td>
                                    <td><b><%=texto%> </b></td>

                                </tr> 
                                <%}
                                    rs2.close();%>

                            </tbody> 

                        </table>
                    </div>

                    <div class="card-footer">
                        <input type="button" value="IR A EMBARQUE FACTURA NRO.<%=num_fact%>"  onclick="traer_embarque('<%=camion%>', '<%=num_fact%>', '<%=cod_chofer%>', '<%=fecha%>')" class="form-control bg-navy">
                    </div>

                </div>

            </div>
        </div>     

        <br><br>
        <%
                sum++;
            }
            rs.close();
            //controles.DesconnectarBD();        
            if (sum == 0) {
        %>
        <br>
        <button type="button" class="btn btn-danger btn-block btn-lg ui-accordion-content ui-corner-bottom ui-helper-reset ui-widget-content ui-accordion-content-active"
                id="ui-id-2" aria-labelledby="ui-id-1" role="tabpanel" aria-hidden="false" style="">
            <i class="fa fa-bell"></i>NO DISPONE DE EMBARQUES PENDIENTES</button>


        <%    }   %>
    </form> 

    <%   
        
        } catch (Exception e) {
            out.print(e.toString());
        }
    finally{
        clases.controles.DesconnectarBD();
        clases.controles.VerificarConexion();
}   
    %>

</body>