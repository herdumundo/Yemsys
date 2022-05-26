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
        String aviario= request.getParameter("aviario") ;
 
        String lote= request.getParameter("lote") ;
    
    JSONObject chartsdet = new JSONObject();
    clases.controles.VerificarConexion();
    PreparedStatement pt=clases.controles.connectSesion.prepareStatement("exec [stp_mae_ppr_select_huevo_grafico_lote]  @aviario='"+aviario+"',@lote='"+lote+"'");
    ResultSet rs=pt.executeQuery();
 
        
        JSONObject DataScale= new JSONObject();
         
        JSONObject  contenidoData,          dataOptions,        data,
                    DataPadron,             DataProductividad, 
                    DataCaudalimetro,       DataVialibilidad,
                    DataA,              ticksA,
                    ContenidoTitle,         DataTitle,          ContenidoPoint,     
                    DataPoint,              ejex              = new JSONObject();
      
        JSONArray   eje_x,                 Dataset,                 contenido_orden, 
                    contenido_padron,       contenido_productividad,
                    contenido_vialibilidad_pad,
                
                    dataArray           = new JSONArray();         

                    String aviarios=(lote);
                   

                    
                    DataPadron= new JSONObject();
                    DataPadron.put("label",  "Productiv. Pad");
                    DataPadron.put("yAxisID","A");
                    DataPadron.put("backgroundColor",    "rgba(207, 52, 235)");
                    DataPadron.put("borderColor",  "rgba(207, 52, 235)");
                    DataPadron.put("borderWidth",    2);
                    DataPadron.put("type",  "line");
                    
                    DataProductividad= new JSONObject();
                    DataProductividad.put("label",  "Productiv.");
                    DataProductividad.put("yAxisID","A");
                    DataProductividad.put("backgroundColor",    "rgba(255, 0, 0, 0.5)");
                    DataProductividad.put("borderColor",  "rgba(255, 0, 0, 0.5)");
                    DataProductividad.put("borderWidth",    2);
                    DataProductividad.put("type",  "line");
                    
                   
                    DataVialibilidad= new JSONObject();
                    DataVialibilidad.put("label",  "Pad. Viabilidad");
                    DataVialibilidad.put("yAxisID","A");
                    DataVialibilidad.put("backgroundColor",    "rgba(99, 255, 132)");
                    DataVialibilidad.put("borderColor",  "rgba(99, 255, 132)");
                    DataVialibilidad.put("borderWidth",    2);
                    DataVialibilidad.put("type",  "line");

                    
                    DataA= new JSONObject();                
                    DataA.put("type",    "linear");
                    DataA.put("display",    true);
                    DataA.put("position",    "left");
                    DataA.put("suggestedMin",    0);
                    DataA.put("suggestedMax",    100);
                    
                    ticksA= new JSONObject(); 
                    ticksA.put("stepSize",    10);
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

                    contenido_orden        = new JSONArray();
                    contenido_padron         = new JSONArray();
                    contenido_vialibilidad_pad      = new JSONArray();
                    contenido_productividad   = new JSONArray();
                  
                while(rs.next()) 
                {
                    // este recorre la cantidad de registros que hay en ese rango de fecha y en ese aviario
                    
                    
                    contenido_orden.put       (rs.getString("fila"));
                    contenido_padron.put       (rs.getInt("pad_productividad"));
                    contenido_productividad.put (rs.getInt("productividad"));
                    contenido_vialibilidad_pad.put    (rs.getInt("pad_viabilidad"));    
                   
                    
                ////FIN DEL RECORRIDO LARGO
                 }
                
                clases.controles.DesconnectarBDsession();             
                eje_x=new JSONArray();
                eje_x.put(eje_x);   
                DataPadron     .put     ("data",contenido_padron);
                DataProductividad    .put     ("data",contenido_productividad);
                DataVialibilidad     .put     ("data",contenido_vialibilidad_pad);
                
                
               
                Dataset= new JSONArray();
                Dataset.put(DataPadron);  
                Dataset.put(DataProductividad);
                Dataset.put(DataVialibilidad); 
                contenidoData= new JSONObject();
                data= new JSONObject();
                
              
                contenidoData.put("labels", contenido_orden);
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
