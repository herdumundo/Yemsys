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
 
        String fecha= request.getParameter("fecha") ;
 
    JSONObject chartsdet = new JSONObject();
    clases.controles.VerificarConexion();
     PreparedStatement pt=clases.controles.connectSesion.prepareStatement("exec [stp_mae_ppr_select_huevo_grafico_periodo]  @aviario='"+aviario+"',@fecha='"+fecha+"'");
    ResultSet rs=pt.executeQuery();
 
        
        JSONObject DataScale= new JSONObject();
         
        JSONObject  contenidoData,          dataOptions,        data,
                    DataGramoAve,           DataProducPad,      DataProductividad, 
                    DataCaudalimetro,       DataBalacPad,
                    DataA,              ticksA,
                    ContenidoTitle,         DataTitle,          ContenidoPoint,     
                    DataPoint,              fecha1              = new JSONObject();
      
        JSONArray   fecha2,                 Dataset,                 contenido_fecha, 
                    contenido_gramo,        contenido_padron_prod,   contenido_productividad,
                    contenido_caudalimetro, contenido_balc_pad,
                
                    dataArray           = new JSONArray();         

                    String aviarios=(aviario);
                   

                    
                    DataGramoAve= new JSONObject();
                    DataGramoAve.put("label",  "gr/ave");
                    DataGramoAve.put("yAxisID","A");
                    DataGramoAve.put("backgroundColor",    "rgba(255, 0, 0)");
                    DataGramoAve.put("borderColor",  "rgba(255, 0, 0)");
                    DataGramoAve.put("borderWidth",    2);
                    DataGramoAve.put("type",  "line");
                    
                    DataProducPad= new JSONObject();
                    DataProducPad.put("label",  "Productiv. Pad");
                    DataProducPad.put("yAxisID","A");
                    DataProducPad.put("backgroundColor",    "rgba(207, 52, 235)");
                    DataProducPad.put("borderColor",  "rgba(207, 52, 235)");
                    DataProducPad.put("borderWidth",    2);
                    DataProducPad.put("type",  "line");
                    
                    DataProductividad= new JSONObject();
                    DataProductividad.put("label",  "Productiv.");
                    DataProductividad.put("yAxisID","A");
                    DataProductividad.put("backgroundColor",    "rgba(99, 255, 132)");
                    DataProductividad.put("borderColor",  "rgba(99, 255, 132)");
                    DataProductividad.put("borderWidth",    2);
                    DataProductividad.put("type",  "line");
                    
                    DataCaudalimetro= new JSONObject();
                    DataCaudalimetro.put("label",  "ml/ave");
                    DataCaudalimetro.put("yAxisID","A");
                    DataCaudalimetro.put("backgroundColor",    "rgba(255, 0, 0, 0.5)");
                    DataCaudalimetro.put("borderColor",  "rgba(255, 0, 0, 0.5)");
                    DataCaudalimetro.put("borderWidth",    2);
                    DataCaudalimetro.put("type",  "line");
                    
                    DataBalacPad= new JSONObject();
                    DataBalacPad.put("label",  "gr/ave Pad.");
                    DataBalacPad.put("yAxisID","A");
                    DataBalacPad.put("backgroundColor",    "rgba(132, 132, 132)");
                    DataBalacPad.put("borderColor",  "rgba(132, 132, 132)");
                    DataBalacPad.put("borderWidth",    2);
                    DataBalacPad.put("type",  "line");

                    
                    DataA= new JSONObject();                
                    DataA.put("type",    "linear");
                    DataA.put("display",    true);
                    DataA.put("position",    "left");
                    DataA.put("suggestedMin",    0);
                    DataA.put("suggestedMax",    200);
                    
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

                     contenido_fecha        = new JSONArray();
                     contenido_gramo         = new JSONArray();
                     contenido_balc_pad      = new JSONArray();
                     contenido_caudalimetro  = new JSONArray();
                     contenido_padron_prod   = new JSONArray();
                     contenido_productividad = new JSONArray();
                 
                while(rs.next()) 
                {
                    // este recorre la cantidad de registros que hay en ese rango de fecha y en ese aviario
                    
                    
                    contenido_fecha.put       (rs.getString("dl_fecha"));
                    contenido_gramo.put       (rs.getInt("gramo_ave"));
                    contenido_padron_prod.put (rs.getInt("pad_productividad"));
                    contenido_balc_pad.put    (rs.getInt("balan_pad"));    
                    contenido_caudalimetro.put(rs.getInt("caudalimetro")); 
                    contenido_productividad.put(rs.getInt("productividad"));
                    
                ////FIN DEL RECORRIDO LARGO
                 }
                
                
                fecha2=new JSONArray();
                fecha2.put(fecha1);   
                DataGramoAve     .put     ("data",contenido_gramo);
                DataProducPad    .put     ("data",contenido_padron_prod);
                DataProductividad.put     ("data",contenido_productividad);
                DataCaudalimetro .put     ("data",contenido_caudalimetro);
                DataBalacPad     .put     ("data",contenido_balc_pad);
                
                
               
                Dataset= new JSONArray();
                Dataset.put(DataGramoAve);  
                Dataset.put(DataProducPad);
                Dataset.put(DataProductividad);  
                Dataset.put(DataCaudalimetro ); 
                Dataset.put(DataBalacPad     ); 
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
           clases.controles.DesconnectarBDsession();             

       
        out.print(chartsdet); 
%>
