<%@page import="org.json.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
<%   
            if (sesion == true) {

     String numero_factura = request.getParameter("nro_factura");
    String area = (String) sesionOk.getAttribute("area_gm");
    String area_cch = (String) sesionOk.getAttribute("area");
    int mensaje = 0;
    int ultimo = Integer.parseInt(numero_factura.substring(numero_factura.length() - 7));
    String grilla = "";
    int i = 0;
    String total_restante = "";
    int total_carros = 0;
    
    try 
    {
        ResultSet rs, res_fac_cant, rs2;
        Statement stmt1, stmt2, stmt3;
        //CAMBIAR BASE DE DATOS                 
        stmt1 = connection.createStatement();
        rs2 = stmt1.executeQuery("select sum(cantidad) as cantidad from ( "
                + "select  case itemcode when 1 then sum(convert(int,(b.Quantity)*12)/180) "
                + "else sum(convert(int,(b.Quantity)*12)/360) end as 'cantidad', ItemCode  "
                + "from "
                + "      " + clases.variables.BD2 + ".dbo.oinv a  with(nolock)  "
                + "   inner join  " + clases.variables.BD2 + ".dbo.inv1 b  with(nolock) on a.DocEntry=b.DocEntry  "
                + "where      "
                + " a.DocStatus='o'"
                + "and b.WhsCode='" + area_cch + "'  "
                + "and a.NumAtCard='" + numero_factura + "'"
                + "group by ItemCode) t");
        if (rs2.next()) 
        {
            total_carros =  rs2.getInt("cantidad");
        }
        stmt2 = connection.createStatement();
        res_fac_cant = stmt2.executeQuery(" select CONCAT('A_',sum(A),',B_',sum(B),',C_',sum(C),',D_',sum(D),',S_',sum(S),',J_',sum(J),',G_',sum(G)) AS total_restante  from ( "
                + "select  case itemcode when 1 then sum(convert(int,(b.Quantity-isnull(b.delivrdqty,0))*12)) else 0 end as 'G', "
                + "case itemcode when 2 then sum(convert(int,(b.Quantity-isnull(b.delivrdqty,0))*12)) else 0 end as 'j',           "
                + "case itemcode when 3 then sum(convert(int,(b.Quantity-isnull(b.delivrdqty,0))*12)) else 0 end as 's', "
                + "case itemcode when 4 then sum(convert(int,(b.Quantity-isnull(b.delivrdqty,0))*12)) else 0 end as 'a',           "
                + "case itemcode when 5 then sum(convert(int,(b.Quantity-isnull(b.delivrdqty,0))*12)) else 0 end as 'b', "
                + "case itemcode when 6 then sum(convert(int,(b.Quantity-isnull(b.delivrdqty,0))*12)) else 0 end as 'c',       "
                + "case itemcode when 7 then sum(convert(int,(b.Quantity-isnull(b.delivrdqty,0))*12)) else 0 end as 'd'  "
                + "from  " + clases.variables.BD2 + ".dbo.oinv a  with(nolock)  "
                + " inner join  " + clases.variables.BD2 + ".dbo.inv1 b  with(nolock) on a.DocEntry=b.DocEntry "
                + "where b.InvntSttus='o'   "
                + "and   a.DocStatus='o'and b.WhsCode='" + area_cch + "' and a.NumAtCard='" + numero_factura + "' group by ItemCode ) T" );
        if (res_fac_cant.next()) 
        {
            total_restante = res_fac_cant.getString("total_restante");
        }
        stmt3 = connection.createStatement();
        rs = stmt3.executeQuery("exec [select_embarque_lotes_pendientes] @area='" + area + "',@nro_factura=" + ultimo + "");
        while (rs.next()) 
        {
            grilla = grilla + "<tr class='suma' id='row" + rs.getString("identificador_lote") + "'  > "
                    + "<td class='ocultar'>" + rs.getString("cod_lote") + "</td>"
                    + "<td class='font-weight-bold' >" + rs.getString("tipo_huevo") + "</td>"
                    + "<td class='font-weight-bold'>" + rs.getString("carro") + "</td>"
                    + "<td class='ocultar' >" + rs.getString("cod_huevo") + "</td>"
                    + "<td class='font-weight-bold'  >" + rs.getString("cantidad") + "</td>"
                    + "<td class='font-weight-bold' >" + rs.getString("fecha_puesta") + "</td>"
                    + "<td class='font-weight-bold'  >  <a class='btn btn-danger font-weight-bold remove'> <i class='fa fa-trash-o fa-lg'></i> Eliminar</a>  </td>"
                    + "<td  class='ocultar' >" + rs.getString("estado_lote") + "</td>"
                    + "<td for='id'  class='ocultar' >" + rs.getString("identificador_lote") + "</td><td>" + i + "</td> "
                    + "</tr> ";
            i++;
        }
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call [mae_cch_embarque_insertar_lotes_disponibles](?,?,?)}");
        callableStatement.setString(1, area_cch);
        callableStatement.setString(2, area);

        callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
        callableStatement.execute();
        mensaje = callableStatement.getInt("mensaje");
    } catch (Exception e) 
    {
        //     clases.controles.connect.rollback();
    } finally 
    {
        JSONObject ob = new JSONObject();
        ob = new JSONObject();
        ob.put("grilla", grilla);
        ob.put("count", i);
        ob.put("div_aviso", "<div class='alert alert-success alert-dismissible fade show' role='alert' "
                + "id='div_aviso_sincro'   >  <strong onclick='sincronizar_lotes()'>"
                + "<center>LOTES SINCRONIZADOS CORRECTAMENTE, SI DESEA VOLVER A ACTUALIZAR LOS LOTES DISPONIBLES PRESIONE AQUI.</center></strong>  "
                + " <button type='button' class='close' data-dismiss='alert' aria-label='Close'>  <span aria-hidden='true'>&times;</span>  </button>  </div>");
        ob.put("codigo", total_restante);
        ob.put("total", total_carros / 12);
        connection.close();
        out.print(ob);
    }}
%>  