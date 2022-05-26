<%-- 
    Document   : consulta_chart_detalle_prueba
    Created on : 19/01/2022, 14:00:09
    Author     : csanchez
--%>

<%@page import="org.json.JSONArray"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@include  file="../../chequearsesion.jsp" %>
 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
  <% 
      String aviario1= request.getParameter("aviario1") ;
        String fechad= request.getParameter("fechad") ;
        String fechah= request.getParameter("fechah") ;
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
        JSONObject chartsdet = new JSONObject();
    PreparedStatement pt=clases.controles.connectSesion.prepareStatement("select fecha, sum(cant) as cant from ppr_contador where fecha BETWEEN '"+fechad+"'and '"+fechah+"'and aviario='"+aviario1+"'group by fecha order by fecha");
    ResultSet rs=pt.executeQuery();
 
        
        JSONObject DataScale= new JSONObject();
         
        JSONObject  contenidoData,          dataOptions,        data,
                    DataCantidad,           DataA,              ticksA,
                    ContenidoTitle,         DataTitle,          ContenidoPoint,     
                    DataPoint,              fecha1              = new JSONObject();
      
        JSONArray   fecha2,                 Dataset,            contenido_fecha, 
                    contenido_cantidad,     dataArray           = new JSONArray();         

                    String aviarios=(aviario1);

                    
                    DataCantidad= new JSONObject();
                    DataCantidad.put("label",  "Historico Contador Aviario: "+aviario1+" | desde "+fechad+" hasta "+fechah);
                    DataCantidad.put("yAxisID","A");
                    DataCantidad.put("backgroundColor",    "rgba(255, 0, 0, 0.5)");
                    DataCantidad.put("borderColor",  "rgba(255, 0, 0, 0.5)");
                    DataCantidad.put("borderWidth",    2);
                    DataCantidad.put("type",  "line");

                    
                    DataA= new JSONObject();                
                    DataA.put("type",    "linear");
                    DataA.put("display",    true);
                    DataA.put("position",    "left");
                    DataA.put("suggestedMin",    0);
                    DataA.put("suggestedMax",    600);
                    
                    ticksA= new JSONObject(); 
                    ticksA.put("stepSize",    600);
                    DataA.put("ticks",    ticksA);


                    ContenidoTitle= new JSONObject();
                    ContenidoTitle.put("diplay",    true);
                    ContenidoTitle.put("text",    aviarios);
                    
                    DataTitle= new JSONObject();
                    DataTitle.put("title",ContenidoTitle); 
                    
                    ContenidoPoint= new JSONObject();
                    ContenidoPoint.put("radius",    0);
                    
                    DataPoint= new JSONObject();
                    DataPoint.put("point",   ContenidoPoint);

                    contenido_fecha = new JSONArray();
                    contenido_cantidad = new JSONArray();
  
                while(rs.next()) 
                {
                    // este recorre la cantidad de registros que hay en ese rango de fecha y en ese aviario
                    
                    
                    contenido_fecha.put(rs.getString("fecha"));
                    contenido_cantidad.put(rs.getInt("cant"));
                    
                    
                ////FIN DEL RECORRIDO LARGO
                 }
                
        clases.controles.DesconnectarBDsession();             
                fecha2=new JSONArray();
                fecha2.put(fecha1);   
                  
                DataCantidad.put("data",contenido_cantidad);
     
               
                Dataset= new JSONArray();
                Dataset.put(DataCantidad);    
                contenidoData= new JSONObject();
                data= new JSONObject();
                
              
                contenidoData.put("labels", contenido_fecha);
                contenidoData.put("datasets",    Dataset);
                
                 DataScale.put(    "A",DataA);   
                
                data.put("data",contenidoData);
                
                data.put("type",  "bar");
                dataOptions= new JSONObject();   
                dataOptions.put("scales", DataScale);
                dataOptions.put("plugins", DataTitle);
                dataOptions.put("elements", DataPoint);

                data.put("options",dataOptions);

                dataArray.put(data);

                chartsdet.put("chartsdet", dataArray); 
         
         out.print(chartsdet); 
%>
