<%-- 
    Document   : consulta_gen_grilla_recuento_inventario
    Created on : 22-ene-2024, 10:42:57
    Author     : hvelazquez
--%>
<%@include  file="../../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>

<%    String ubicacion = request.getParameter("ubicacion");
     JSONObject ob = new JSONObject();
      try {
        PreparedStatement ps;
        ResultSet rs;
        String query = " select distinct itemcode from 	(	select   		isnull(contado,'NO') as contado    , t1.ItemCode from  vimar.dbo.oibt T1 LEFT OUTER   JOIN vim_recuento_invetario_pendiente T2 ON T1.BatchNum COLLATE DATABASE_DEFAULT=T2.LOTE and T1.ItemCode COLLATE DATABASE_DEFAULT=T2.ItemCode  and estado='P'  where  whscode='"+ubicacion+"' and Quantity>0  	UNION ALL select   isnull(contado,'NO') as contado   ,ItemCode COLLATE DATABASE_DEFAULT from  	vim_recuento_invetario_pendiente where  ubicacion='"+ubicacion+"'     	AND TIPOLOTE='LOTE MANUAL' ) t where contado='NO'  ";
        JSONArray optionsArray = new JSONArray();
        ps = connection.prepareStatement(query);
        rs = ps.executeQuery();
         while (rs.next()) {
         optionsArray.put(rs.getString("itemcode"));


    }
            ob.put("options", optionsArray);

    } catch (Exception e) {
        ob.put("option", e.toString());

    } finally {
        connection.close();
        out.print(ob);
    }
%>