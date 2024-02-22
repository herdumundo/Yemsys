<%-- 
    Document   : crud_desechos
    Created on : 17-ene-2024, 8:22:32
    Author     : hvelazquez
--%>

<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../../chequearsesion.jsp" %>
<%@include file="../../../cruds/conexion.jsp" %>
<%    
    String tipo_huevo = request.getParameter("tipo");
    String nroTransf = request.getParameter("id");
    String cantidad = request.getParameter("cantidad");
    String gramos = request.getParameter("gramos");
    String itemCode = "";
    int tipo_respuesta = 1;
    String mensaje = "";
    try {
        if (tipo_huevo.equals("HUEVO TIPO A X DOCENA")) {
            itemCode = "A";
        } else if (tipo_huevo.equals("HUEVO TIPO B X DOCENA")) {
            itemCode = "B";
        } else if (tipo_huevo.equals("HUEVO TIPO C X DOCENA")) {
            itemCode = "C";
        } else if (tipo_huevo.equals("HUEVO TIPO D X DOCENA")) {
            itemCode = "D";
        } else if (tipo_huevo.equals("HUEVO TIPO SUPER X DOCENA")) {
            itemCode = "SUPER";
        } else if (tipo_huevo.equals("HUEVO TIPO JUMBO X DOCENA")) {
            itemCode = "JUMBO";
        }

        if (gramos != null && gramos.trim().matches("\\d+") && Integer.parseInt(gramos.trim()) > 0) {
    
        connection.setAutoCommit(false);
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call [vim_prod_desechos_averiados](?,?,?,?,?,?,? )}");
        callableStatement.setInt(1, Integer.parseInt(nroTransf.trim()));
        callableStatement.setString(2, tipo_huevo);
        callableStatement.setString(3, itemCode);
        callableStatement.setInt(4, Integer.parseInt(cantidad.trim()));
        callableStatement.setInt(5, Integer.parseInt(gramos.trim()));
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.registerOutParameter("tipo_respuesta", java.sql.Types.INTEGER);
        callableStatement.execute();

        tipo_respuesta = callableStatement.getInt("tipo_respuesta");
        mensaje = callableStatement.getString("mensaje");

        if (tipo_respuesta == 0) {
            connection.rollback();
        } else {
          //     connection.rollback();
          connection.commit();
        }
} else {
    tipo_respuesta = 0; // Set to a specific value to indicate that the procedure was not called.
    mensaje = "Gramos no debe quedar vacio o debe ser mayor a Cero.";
}
    } catch (Exception e) {
        connection.rollback();
        mensaje = e.toString();
    }
    JSONObject ob = new JSONObject();
    ob = new JSONObject();
    ob.put("tipo", tipo_respuesta);
    ob.put("msg", mensaje);
    out.print(ob);%>  