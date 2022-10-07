<%@page import="org.json.JSONObject"%>
<%@include  file="../../cruds/conexion.jsp" %> 
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>

 <%    String grilla_html = "";
    String cabecera = "";
    try {
        String fecha = request.getParameter("fecha_alimentacion");
        ResultSet rs_GM;
        Statement st = connection.createStatement();

        rs_GM = st.executeQuery(" select"
                + " a.fecha_registro as fecha_alimentacion,c.cod_carrito,CONVERT(DATE,c.fecha_puesta) AS fecha_puesta ,c.cantidad,c.clasificadora_origen,d.desFallaZona,a.usuario, "
                + " c.tipo_huevo "
                + " from mae_ptc_alimentacion_hp a "
                + " inner join mae_ptc_alimentacion_hp_det b on a.id=b.id_cab"
                + " inner join lotes c on b.cod_interno=c.cod_interno "
                + " left outer join fallas d on c.zona_falla=d.codigo "
                + " where convert(date,fecha_alimentacion)='" + fecha + "'");

        cabecera = " <table id='tb_alimentacion' class='table table-striped table-bordered table-hover' style='width:100%'>"
                + "<thead>"
                + "<tr>"
                + " <th  style='color: #fff; background: black;' >FECHA DE ALIMENTACION</th>      "
                + " <th  style='color: #fff; background: black;' >CARRO/MESA</th>      "
                + " <th  style='color: #fff; background: black;' >FECHA PUESTA</th>      "
                + " <th  style='color: #fff; background: black;' >CANTIDAD</th>      "
                + " <th  style='color: #fff; background: black;' >TIPO DE HUEVO</th>      "
                + " <th  style='color: #fff; background: black;' >FALLA</th>      "
                + " <th  style='color: #fff; background: black;' >USUARIO</th>      "
                + " <th  style='color: #fff; background: black;' >ORIGEN</th>      "
                + "</tr>"
                + " </thead> "
                + " <tbody >";
        while (rs_GM.next()) {
            grilla_html = grilla_html
                    + "<tr> "
                    + "<td>   " + rs_GM.getString("fecha_alimentacion") + "</td>"
                    + "<td>   " + rs_GM.getString("cod_carrito") + "</td>"
                    + "<td>   " + rs_GM.getString("fecha_puesta") + "</td>"
                    + "<td>   " + rs_GM.getString("cantidad") + "</td>"
                    + "<td>   " + rs_GM.getString("tipo_huevo") + "</td>"
                    + "<td>   " + rs_GM.getString("desFallaZona") + "</td>"
                    + "<td>   " + rs_GM.getString("usuario") + "</td>"
                    + "<td>   " + rs_GM.getString("clasificadora_origen") + "</td>"
                    + "</tr>";
        }

        rs_GM.close();
    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
        out.print(cabecera + grilla_html + "</tbody></table>");
    }
%>


