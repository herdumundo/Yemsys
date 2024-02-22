<%-- 
    Document   : contenedor_desechos
    Created on : 16-ene-2024, 16:19:28
    Author     : hvelazquez
--%>
<%@include  file="../../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%    String ubicacion = request.getParameter("ubicacion");
    String itemCode = request.getParameter("itemCode");
    String uMedida = request.getParameter("uMedida");
    StringBuilder tr = new StringBuilder();

    PreparedStatement psDetalle;
    ResultSet rsDetalle;
    String query2 = "    select  BatchNum,convert(int,Quantity ) as Quantity,isnull(conteo,0) as  conteo, convert(int,(Quantity-isnull(conteo,0)) ) as diferencia,"
            + "     isnull(TIPOLOTE,'') as TIPOLOTE ,isnull(contado,'NO') as contado  "
            + "     from  vimar.dbo.oibt T1 LEFT OUTER   JOIN vim_recuento_invetario_pendiente T2 ON T1.BatchNum COLLATE DATABASE_DEFAULT=T2.LOTE and  t1.ItemCode=t2.itemCode COLLATE DATABASE_DEFAULT  and estado='P'  where  whscode='" + ubicacion + "' and Quantity>0  and t1.ItemCode='" + itemCode + "'	"
            + "     UNION ALL "
            + "     select  LOTE COLLATE DATABASE_DEFAULT AS BatchNum,convert(int,cantidad ) as Quantity,isnull(conteo,0) as "
            + "     conteo, convert(int,(cantidad-isnull(conteo,0)) ) as diferencia ,TIPOLOTE ,isnull(contado,'NO') as contado  from vim_recuento_invetario_pendiente where  ubicacion='" + ubicacion + "'   and  ItemCode='" + itemCode + "' AND TIPOLOTE='LOTE MANUAL' and estado<>'C'    ";
    psDetalle = connection.prepareStatement(query2);
    rsDetalle = psDetalle.executeQuery();

    while (rsDetalle.next()) {
        String fila3 = " <h5><span class=\"badge badge-success right\">" + rsDetalle.getString("diferencia") + "</span></h5 >";
        String fila4 = "  ";
        if (rsDetalle.getInt("diferencia") >= 0 && rsDetalle.getString("contado").equals("SI")) {
            fila3 = " <h5><span class=\"badge badge-danger right\">" + rsDetalle.getString("diferencia") + "</span></h5>";
        } else if (rsDetalle.getInt("conteo") == 0 && rsDetalle.getString("contado").equals("NO")) {
            fila3 = " <h5><span class=\"badge badge-warning right\">" + rsDetalle.getString("diferencia") + "</span></h5>";

        }
        if (rsDetalle.getString("TIPOLOTE").equals("LOTE MANUAL")) {
            fila4 = " <i class=\"fas fa-trash \" onclick=\"eliminarLoteNuevoRecuentoInventario('" + ubicacion + "','" + rsDetalle.getString("BatchNum") + "','" + itemCode + "','" + uMedida + "')\" style=\"color: red\"></i> ";
        }
        tr.append("<tr>"
                + "<td onclick=\"cuadroRecuentoInventarioVimar('" + rsDetalle.getString("BatchNum") + "', '" + rsDetalle.getString("Quantity") + "', '" + ubicacion + "', '" + itemCode + "','" + uMedida + "')\">" + rsDetalle.getString("BatchNum") + "</td>"
                + "<td>" + rsDetalle.getString("Quantity") + "</td>"
                + "<td>" + fila3 + " </td>"
                + "<td>" + rsDetalle.getString("conteo") + fila4 + "</td></tr> ");
    }
    rsDetalle.close();
    JSONObject ob = new JSONObject();
    ob = new JSONObject();
    ob.put("mensaje", tr);
    out.print(ob);
%>
