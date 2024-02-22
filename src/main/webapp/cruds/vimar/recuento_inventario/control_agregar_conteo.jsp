
<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../../chequearsesion.jsp" %>
<%@include file="../../../cruds/conexion.jsp" %>
<%    if (sesion == true) {

        StringBuilder tr = new StringBuilder();
        int tipo_respuesta = 1;
        try {
            String lote = request.getParameter("lote");
            String itemCode = request.getParameter("itemCode");
            String cantidad = request.getParameter("cantidad");
            String conteo = request.getParameter("conteo");
            String ubicacion = request.getParameter("ubicacion");
            String id_usuario = (String) sesionOk.getAttribute("id_usuario");
            String uMedida = request.getParameter("uMedida");
            String conteoCaja = request.getParameter("conteoCaja");
            int cajaTotal = 0;
            int total = 0;

            if (conteoCaja != null && !conteoCaja.trim().equals("")) { 
                if (uMedida != null || !uMedida.equals("")) {
                    cajaTotal = Integer.parseInt(conteoCaja) * Integer.parseInt(uMedida);
                }
            }
            if (conteo == null || conteo.equals("")) {
                    conteo="0"; 
                }
            total = cajaTotal + Integer.parseInt(conteo);

            connection.setAutoCommit(false);
            CallableStatement callableStatement = null;
            callableStatement = connection.prepareCall("{call [vim_prod_recuento_agregar](?,?,?,?,?,?,?,?,?,?)}");
            callableStatement.setString(1, lote);
            callableStatement.setInt(2, Integer.parseInt(cantidad));
            callableStatement.setInt(3, total);
            callableStatement.setString(4, ubicacion);
            callableStatement.setString(5, itemCode);
            callableStatement.setString(6, "LOTE SAP");
            callableStatement.setString(7, "SI");
            callableStatement.setInt(8, Integer.parseInt(id_usuario));
            callableStatement.registerOutParameter("tipo", java.sql.Types.INTEGER);
            callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
            callableStatement.execute();

            tipo_respuesta = callableStatement.getInt("tipo");
            // mensaje = callableStatement.getString("mensaje");
            if (tipo_respuesta == 0) {
                connection.rollback();
            } else {
                connection.commit();
                PreparedStatement psDetalle;
                ResultSet rsDetalle;
                String query2 = "    select  BatchNum,convert(int,Quantity ) as Quantity,isnull(conteo,0) as  conteo, convert(int,(Quantity-isnull(conteo,0)) ) as diferencia,"
                        + "     isnull(TIPOLOTE,'') as TIPOLOTE ,isnull(contado,'NO') as contado  "
                        + "     from  vimar.dbo.oibt T1 LEFT OUTER   JOIN vim_recuento_invetario_pendiente T2 ON T1.BatchNum COLLATE DATABASE_DEFAULT=T2.LOTE and  t1.ItemCode=t2.itemCode COLLATE DATABASE_DEFAULT  and estado='P'  where  whscode='" + ubicacion + "' and Quantity>0  and t1.ItemCode='" + itemCode + "'	"
                        + "     UNION ALL "
                        + "     select  LOTE COLLATE DATABASE_DEFAULT AS BatchNum,convert(int,cantidad ) as Quantity,isnull(conteo,0) as "
                        + "     conteo, convert(int,(cantidad-isnull(conteo,0)) ) as diferencia ,TIPOLOTE ,isnull(contado,'NO') as contado  from vim_recuento_invetario_pendiente where  ubicacion='" + ubicacion + "'   and  ItemCode='" + itemCode + "' AND TIPOLOTE='LOTE MANUAL'";
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
            }

        } catch (Exception e) {
            connection.rollback();
            //   mensaje = e.toString();
        } finally {
            connection.close();
            JSONObject ob = new JSONObject();
            ob = new JSONObject();
            ob.put("tipo", tipo_respuesta);
            ob.put("mensaje", tr);
            out.print(ob);
        }
    }
%>  