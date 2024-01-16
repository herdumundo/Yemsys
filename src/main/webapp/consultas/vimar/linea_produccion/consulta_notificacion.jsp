<%@page import="org.apache.http.client.config.RequestConfig"%>
<%@page import="org.apache.http.util.EntityUtils"%>
<%@page import="org.apache.http.HttpEntity"%>
<%@page import="org.apache.http.client.methods.HttpGet"%> 
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@page import="org.apache.http.impl.client.HttpClients"%>
<%@page import="org.apache.http.entity.StringEntity"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../../chequearsesion.jsp" %>
<%@include file="../../../cruds/conexion.jsp" %>
  <% 
 
    String linea = (String) sesionOk.getAttribute("clasificadora");
   // String linea = "L";
    JSONObject ob = new JSONObject();
    ob=new JSONObject();  
    int tipo=0;
     
    char ultimo = linea.charAt(linea.length()-1);
    
    
    
    if(linea.equals("LINEA07")){
        tipo=0 ;
    }
    else {
     int minutos=0;
    String sql_tiempo="";
    String sql="select count(*) as cantidad from vimar.dbo.owor o with(nolock), vimar.dbo.oitm oi with(nolock) "
            + "where  o.itemcode=oi.itemcode and "
            + "(convert(varchar,o.duedate,103)=convert(varchar,getdate(),103) "
            + "or convert(varchar, o.duedate,103)=convert(varchar, dateadd(d, -1, getdate()),103)) "
            + "and U_MAQUINA ='L"+ultimo+"' and o.status='R'  and o.docnum not in "
            + "(select  nro_produccion from GrupoMaehara.dbo.parada_produccion with(nolock) where linea='"+linea+"'  and estado in ('a','c','p')) ";
    
    ResultSet consulta_disponibles;
            Statement st = connection.createStatement();
            consulta_disponibles = st.executeQuery(sql);   
  
    if(consulta_disponibles.next()){
    
        sql_tiempo=" select  DATEDIFF(minute, fecha,  GETDATE()) as tiempo  from parada_produccion with(nolock) where linea='"+linea+"'  and estado in ('a')";
         
        ResultSet consulta_minutos;
            Statement st1 = connection.createStatement();
            consulta_minutos = st1.executeQuery(sql_tiempo);   
        
        while (consulta_minutos.next())
        {
            
            minutos=consulta_minutos.getInt("tiempo");
        }
    
    
    if (minutos>60){
      tipo=1;
    }
    
    else {
        
         tipo=0;
    }
    }
    
    else
    {
          tipo=0;
            
   }   
        
    }
    
        ob.put("tipo", tipo);
        out.print(ob);

%>