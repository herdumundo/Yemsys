<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%    JSONObject ob = new JSONObject();

    String id = request.getParameter("id_seleccionado");
    String cod_formula = request.getParameter("formula_seleccionada");
    String desc_formula = request.getParameter("desc_formula");

    try {
            String grilla_html="";
            String  cabecera = " <table id='tb_formulacion_pendiente' class='table-bordered compact' style='width:100%'>"
                    + " <thead>"
                    + "     <tr>"
                    + "         <th  style='color: #fff; background: black;' >NRO</th>      "
                    + "         <th  style='color: #fff; background: black;' >FECHA</th>      "
                    + "         <th  style='color: #fff; background: black;' >FORMULA</th>      "
                    + "         <th  style='color: #fff; background: black;' >USUARIO</th>      "
                    + "         <th  style='color: #fff; background: black;' >ESTADO</th>      "
                    + "         <th  style='color: #fff; background: black;' >ACCIÓN</th>      " 
                    + "     </tr>"
                    + " </thead> "
                    + " <tbody >";

            ResultSet rs_GM;
            Statement st = connection.createStatement();
            rs_GM = st.executeQuery(" "
                    + "     select t1.id,convert(varchar,fecha_registro,103) as fecha,cod_formula,usuario, formula,t2.descripcion"
                    + "     from mae_bal_mtp_cab_solicitud t1 inner join mae_bal_estados t2 on t1.estado=t2.id  "
                    + "     where estado=1  and cod_formula not in ('"+cod_formula+"')   ");
            String tr="<tr style='display:none'><td>"+id+"</td><td>"+desc_formula+"</td><td  colspan='4'><input id='formula_seleccionada' data-formula=\""+cod_formula+"\" data-id_pedido=\""+id+"\" type=\"button\" class=\"form-control  bg-warning\" value=\"Formula seleccionada\"></td>  </tr> ";
            while (rs_GM.next()) 
            {
                grilla_html = grilla_html
                        + "<tr > "
                        + "<td > "   +   rs_GM.getString("id") + "</td>"
                        + "<td >   "  +   rs_GM.getString("fecha") + "</td>"
                        + "<td >   "  +   rs_GM.getString("formula") + "</td>"
                        + "<td >   "  +   rs_GM.getString("usuario") + "</td>"
                        + "<td >   "  +   rs_GM.getString("descripcion") + "</td>"
                        + "<td ><input data-boleano=\"false\" data-formula=\""+rs_GM.getString("cod_formula")+"\" id=\""+rs_GM.getString("id")+"\" onclick='seleccionar_row_formulacion_pendiente_bal("+rs_GM.getString("id")+");' type=\"button\" class=\"form-control  bg-navy\" value=\"Seleccionar\"></td>"
                         + "</tr>";
            }
            ob.put("grilla",cabecera +tr+ grilla_html + "</tbody></table>" );

            rs_GM.close();
    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
        out.print(ob);
    }
%> 

