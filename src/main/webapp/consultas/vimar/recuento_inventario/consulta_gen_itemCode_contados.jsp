<%-- 
    Document   : consulta_gen_grilla_recuento_inventario
    Created on : 22-ene-2024, 10:42:57
    Author     : hvelazquez
--%>
<%@include  file="../../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>

<%    String ubicacion = request.getParameter("ubicacion");
    //String itemCode = request.getParameter("itemCode");
    JSONObject ob = new JSONObject();
    StringBuilder options = new StringBuilder();
     try {
        PreparedStatement ps;
        ResultSet rs;
        String query = "   select distinct ItemCode from vim_recuento_invetario_pendiente where ubicacion='"+ubicacion+"' and ESTADO='P'";

        ps = connection.prepareStatement(query);
        rs = ps.executeQuery();
        options.append("<label class=\"btn btn-success \"> <input type=\"radio\" name=\"options\" id=\"option_a1\" autocomplete=\"off\" checked=\"\"  > CONTADOS </label>");

        while (rs.next()) {
            options.append("<label id='optionContados"+rs.getString("ItemCode")+"' class=\"btn btn-secondary \"> <input type=\"radio\" name=\"options\" id=\"option_a1\" autocomplete=\"off\" checked=\"\"  > ").append(rs.getString("ItemCode")).append("</label>");
     
    }
    } catch (Exception e) {
        ob.put("option", e.toString());

    } finally {
        connection.close();
        ob.put("option", options.toString());
        out.print(ob);
    }
%>