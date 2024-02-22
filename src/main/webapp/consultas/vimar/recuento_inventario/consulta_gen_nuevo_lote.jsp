<%-- 
    Document   : consulta_gen_grilla_recuento_inventario
    Created on : 22-ene-2024, 10:42:57
    Author     : hvelazquez
--%>
<%@include  file="../../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>

<%    String ubicacion = request.getParameter("ubicacion");
    String itemCode = request.getParameter("itemCode");
    JSONObject ob = new JSONObject();
    StringBuilder options = new StringBuilder();
    options.append("<option class='text-center' value=''> </option>");
    try {
        PreparedStatement ps;
        ResultSet rs;
        String query = "select distinct BatchNum from vimar.dbo.oibt T1  where  whscode='" + ubicacion + "' and Quantity=0  and ItemCode='" + itemCode + "'  "
                + " and BatchNum not in (select  BatchNum from vimar.dbo.oibt T1   where  whscode='" + ubicacion + "' and Quantity>0  and ItemCode='" + itemCode + "' ) ";

        ps = connection.prepareStatement(query);
        rs = ps.executeQuery();
        while (rs.next()) {
            options.append("<option class='text-center' value='").append(rs.getString("BatchNum")).append("'>").append(rs.getString("BatchNum")).append("</option>");
        }
    } catch (Exception e) {
        ob.put("option", e.toString());

    } finally {
        connection.close();
        ob.put("option", options.toString());
        out.print(ob);
    }
%>