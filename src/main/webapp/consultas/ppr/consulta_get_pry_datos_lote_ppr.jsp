<%-- 
    Document   : datos
    Created on : 02-ene-2022, 19:57:59
    Author     : aespinola
--%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@include  file="../../cruds/conexion.jsp" %>  
<%@include  file="../../chequearsesion.jsp" %>
<%    String lote = request.getParameter("lote");;
        JSONObject ob = new JSONObject();
try 
    
    {
        String fechaA="";
        String fechaB="";
        int cantidadAvesUltimo=0 ;
        String eddadProduccionDias="";
        String eddadProduccionSemanas="";
        String fechaProduccion="";
        String eddadPredescarteDias="";
        String eddadPredescarteSemanas="";
        String fechaPredescarte="";
        
        Statement st,st2;
        ResultSet rs, rs2 ;
        int id_cab=0;
        st = connection.createStatement();
        st2  = connection.createStatement();
        
        
        ob=new JSONObject();
        rs = st.executeQuery(" select * from ppr_pry_cab where lote='"+lote.trim()+"' ");

        while (rs.next()) 
        {
            fechaA                      =rs.getString("fecha_nacimiento");
            fechaB                      =rs.getString("fecha_nacimiento_b");
           // cantidadAvesUltimo          =rs.getString("");
            eddadProduccionDias         =rs.getString("edad_produccion_dias");
            eddadProduccionSemanas      =rs.getString("edad_produccion_semanas");
            fechaProduccion             =rs.getString("fecha_produccion");
            eddadPredescarteDias        =rs.getString("edad_descarte_dias");
            eddadPredescarteSemanas     =rs.getString("edad_descarte_semanas");
            fechaPredescarte            =rs.getString("fecha_predescarte");
            id_cab                      =rs.getInt("id");
            
            ob.put("fechaA",                    fechaA);
            ob.put("fechaB",                    fechaB);
            ob.put("eddadProduccionDias",       eddadProduccionDias);
            ob.put("eddadProduccionSemanas",    eddadProduccionSemanas);
            ob.put("fechaProduccion",           fechaProduccion);
            ob.put("eddadPredescarteDias",      eddadPredescarteDias);
            ob.put("eddadPredescarteSemanas",   eddadPredescarteSemanas);
            ob.put("fechaPredescarte",          fechaPredescarte);
 
        }
        rs2 = st2.executeQuery("select* from ppr_pry_det_carga  where id in ( select max(id) as id_carga from ppr_pry_det_carga  where id_cab= "+id_cab  +" 	 )  ");
        
         while (rs2.next()) 
        { 
          cantidadAvesUltimo= rs2.getInt("cantidad_aves");
            ob.put("cantidad_aves",          cantidadAvesUltimo);
        }
         
    } catch (Exception e) {
        String error = e.getMessage();
    } finally {
        connection.close();
        out.print(ob);
    }
%>

