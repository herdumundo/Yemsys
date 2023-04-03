<%@page import="java.text.DecimalFormat"%>
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
     try 
     {
        String      id_boca   = request.getParameter("id_boca");
        Statement   st      = connection.createStatement(); 
        ResultSet   rs; 
        String tr="";
       // rs = st.executeQuery("select isnull(max(lt_fin),0)  as fin from itkv_salida1 WHERE ID_boca='"+id_boca+"' ");
        rs = st.executeQuery("select  lt_fin  as fin from itkv_salida1 WHERE  id in ( select  max(id)  from itkv_salida1 where   ID_boca='"+id_boca+"'	)");
        
            String litro="";
        while (rs.next()) 
        {
           
           litro=rs.getString("fin");
           
        }
        
     
         ob.put("litro", litro);
        
        rs.close();
    } catch (Exception e) 
    {
        ob.put("litro", e.getMessage());
    } finally {
        connection.close();
        out.print(ob);
    }
%> 

