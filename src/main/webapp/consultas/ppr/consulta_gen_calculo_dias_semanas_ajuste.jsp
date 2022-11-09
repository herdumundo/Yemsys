<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%    JSONObject ob = new JSONObject();
     try {
        String id = request.getParameter("id");
        String fecha = request.getParameter("fecha");
        String dias="";
        String semanas="";
        String saldo_ave="";
        ResultSet rs_GM;
        Statement st = connection.createStatement();
        rs_GM = st.executeQuery(" select * from	ppr_pry_det_carga WHERE id_cab="+id+" AND FECHA=convert(date,'"+fecha+"')");
      
        while (rs_GM.next()) 
        {
            dias=rs_GM.getString("dias");
            semanas=rs_GM.getString("semanas");
            saldo_ave=rs_GM.getString("cantidad_aves");
        }
    
        ob.put("dias", dias);
        ob.put("semanas", semanas);
        ob.put("saldo_ave", saldo_ave);
        rs_GM.close();
    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
        out.print(ob);
    }
%> 

