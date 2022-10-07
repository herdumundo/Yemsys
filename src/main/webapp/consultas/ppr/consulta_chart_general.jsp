<%-- 
    Document   : datos
    Created on : 02-ene-2022, 19:57:59
    Author     : aespinola
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
 
      JSONObject charts = new JSONObject();
      clases.controles.VerificarConexion();
    PreparedStatement pt=clases.controles.connectSesion.prepareStatement(" select  distinct(aviario) as aviario,  convert(int,right(aviario,len(aviario)-1) ) as numeros, "
            + " left(aviario,1) as letra  from vis_mae_ppr_grafico where  dateadd(day,-30,getdate())<=getdate() order by 3,2 asc");
    ResultSet rs=pt.executeQuery();
 
        
        JSONObject DataScale= new JSONObject();
         
        JSONObject  contenidoData,          dataOptions,        data,
                    DataMortandad,          DataAgua,           DataBalanceado, DataPadProdu,
                    DataTempMin,            DataTempMax,        DataProducto,   DataPadBalan,
                    DataA,                  DataB,              DataC, 
                    DataD,                  ticksA,             ticksB,  
                    ticksC,                 ticksD,             TitleB,
                    TitleC,                 TitleD,             ContenidoTitle,
                    DataTitle,              ContenidoPoint,     DataPoint,
                    Category                = new JSONObject();
      
        JSONArray   categories,             Dataset,            contenido_subcategorias, 
                    contenido_balanceados,  contenido_mortandad,contenido_caudalimetro,
                    contenido_temp_min,     contenido_tem_max,  contenido_product,
                    contenido_pad_pro,      contenido_pad_bal,
                    dataArray               = new JSONArray();         
                          
            int dd=0; 
                    
            while(rs.next()) // va a recorrer 22 veces
            {
 
                    String aviarios=rs.getString("aviario");
                    
                    DataMortandad = new JSONObject();
                    
                    DataMortandad.put("label",  "Muertos");
                    DataMortandad.put("type","bar");
                    DataMortandad.put("yAxisID", "C");
                    DataMortandad.put("backgroundColor",    "rgba(99, 255, 132)");
                    DataMortandad.put("borderColor",  "rgba(99, 255, 132)");
                    DataMortandad.put("borderWidth",       2);
                   
                    DataAgua= new JSONObject();
                    DataAgua.put("label",  "Cons. Agua.");
                    DataAgua.put("yAxisID","A");
                    DataAgua.put("backgroundColor",    "rgb(132, 132, 132)");
                    DataAgua.put("borderColor",  "rgb(132, 132, 132)");
                    DataAgua.put("borderWidth",  2);
                    DataAgua.put("type",  "line");
                    
                    DataBalanceado= new JSONObject();
                    DataBalanceado.put("label",  "Cons. Bal.");
                    DataBalanceado.put("yAxisID","A");
                    DataBalanceado.put("backgroundColor",    "rgb(207, 52, 235)");
                    DataBalanceado.put("borderColor",  "rgb(207, 52, 235)");
                    DataBalanceado.put("borderWidth",    2);
                    DataBalanceado.put("type",  "line");
                    
                    DataTempMin= new JSONObject();
                    DataTempMin.put("label",  "Temp. Min.");
                    DataTempMin.put("type",  "line");
                    DataTempMin.put("yAxisID","D");
                    DataTempMin.put("backgroundColor",    "rgba(0, 0, 255, 0.5)");
                    DataTempMin.put("borderColor",  "rgba(0, 0, 255, 0.5)");
                    DataTempMin.put("borderWidth",    2);

                    DataTempMax= new JSONObject();
                    DataTempMax.put("label",  "Temp. Max.");
                    DataTempMax.put("type",  "line");
                    DataTempMax.put("yAxisID","D");
                    DataTempMax.put("backgroundColor",    "rgba(255, 0, 0, 0.5)");
                    DataTempMax.put("borderColor",  "rgba(255, 0, 0, 0.5)");
                    DataTempMax.put("borderWidth",    2);

                    
                    DataProducto= new JSONObject();                
                    DataProducto.put("label",  "% Product.");
                    DataProducto.put("yAxisID","B");
                    DataProducto.put("type",  "line");
                    DataProducto.put("backgroundColor",    "rgb(235, 125, 52)");
                    DataProducto.put("borderColor",  "rgb(235, 125, 52)");
                    DataProducto.put("borderWidth",    2);
                    
                    DataPadProdu= new JSONObject();                
                    DataPadProdu.put("label",  "% Pad. Product.");
                    DataPadProdu.put("yAxisID","B");
                    DataPadProdu.put("type",  "line");
                    DataPadProdu.put("backgroundColor",    "rgb(#335EFF)");
                    DataPadProdu.put("borderColor",  "rgb(#335EFF)");
                    DataPadProdu.put("borderWidth",    2);
                    
                    DataPadBalan= new JSONObject();                
                    DataPadBalan.put("label",  "% Pad. balanc.");
                    DataPadBalan.put("yAxisID","B");
                    DataPadBalan.put("type",  "line");
                    DataPadBalan.put("backgroundColor",    "rgb(255, 0, 0)");
                    DataPadBalan.put("borderColor",  "rgb(255, 0, 0)");
                    DataPadBalan.put("borderWidth",    2);
                    
                    DataA= new JSONObject();                
                    DataA.put("type",    "linear");
                    DataA.put("display",    true);
                    DataA.put("position",    "left");
                    DataA.put("suggestedMin",    0);
                    DataA.put("suggestedMax",    300);
                    ticksA= new JSONObject(); 
                    ticksA.put("stepSize",    50);
                    DataA.put("ticks",    ticksA);
                    
                    DataB= new JSONObject();                
                    DataB.put("type",    "linear");
                    DataB.put("display",    true);
                    DataB.put("position",    "right");
                    DataB.put("suggestedMin",    0);
                    DataB.put("suggestedMax",    150);
                    TitleB= new JSONObject();                
                    TitleB.put("display",    true);
                    TitleB.put("text",    "% Prod.");
                    DataB.put("title",    TitleB);
                    ticksB= new JSONObject(); 
                    ticksB.put("stepSize",    25);
                    DataB.put("ticks",    ticksB);
                 
                    DataC= new JSONObject();                
                    DataC.put("type",    "linear");
                    DataC.put("display",    true);
                    DataC.put("position",    "right");
                    DataC.put("suggestedMin",    0);
                    DataC.put("suggestedMax",    30);
                    TitleC= new JSONObject();                
                    TitleC.put("display",    true);
                    TitleC.put("text",    "Muertos");
                    DataC.put("title",    TitleC);
                    ticksC= new JSONObject(); 
                    ticksC.put("stepSize",    10);
                    DataC.put("ticks",    ticksC);
                    
                    DataD= new JSONObject();                
                    DataD.put("type",    "linear");
                    DataD.put("display",    true);
                    DataD.put("position",    "right");
                    DataD.put("suggestedMin",    0);
                    DataD.put("suggestedMax",    30);
                    TitleD= new JSONObject();                
                    TitleD.put("display",    true);
                    TitleD.put("text",    "Temperatura ºC");
                    DataD.put("title",    TitleD);
                    ticksD= new JSONObject(); 
                    ticksD.put("stepSize",    10);
                    DataD.put("ticks",    ticksD);
 
                    
                    
                    
                    
                    
                    ContenidoTitle= new JSONObject();
                    ContenidoTitle.put("diplay",    true);
                    ContenidoTitle.put("text",    aviarios);
                    
                    DataTitle= new JSONObject();
                    DataTitle.put("title",ContenidoTitle); 
                    
                    ContenidoPoint= new JSONObject();
                    ContenidoPoint.put("radius",    0);
                    
                    DataPoint= new JSONObject();
                    DataPoint.put("point",   ContenidoPoint);
                   
                    
                    
                    
                    PreparedStatement pts=clases.controles.connectSesion.prepareStatement("select  aviario, FORMAT(fecha,'dd-MM')fecha, muertes,caudalimetro,"
                    + "temp_min,temp_max,product,consumo_bal,product,bal_pad, product_pad,fecha as fecha_registro from vis_mae_ppr_grafico where aviario='"+aviarios+"' and "
                    + "  DATEDIFF(day,fecha,getdate())<=30 order by 12" );
 
                ResultSet rss=pts.executeQuery();
                
                    contenido_subcategorias = new JSONArray();
                    contenido_balanceados = new JSONArray();
                    contenido_mortandad = new JSONArray();
                    contenido_caudalimetro = new JSONArray();
                    contenido_temp_min = new JSONArray();
                    contenido_tem_max = new JSONArray();
                    contenido_product = new JSONArray();  
                    contenido_pad_bal = new JSONArray(); 
                    contenido_pad_pro = new JSONArray();
                while(rss.next()) 
                { 
                    // este recorre la cantidad de registros que hay en ese mes y en ese aviario
                    
                    
                    contenido_subcategorias.put(rss.getString("fecha"));
                    contenido_mortandad.put(rss.getString("muertes"));
                    contenido_balanceados.put(rss.getInt("consumo_bal"));
                    contenido_caudalimetro.put(rss.getString("caudalimetro"));
                    contenido_temp_min.put(rss.getString("temp_min")); 
                    contenido_tem_max.put(rss.getString("temp_max"));
                    contenido_product.put(rss.getString("product")); 
                    contenido_pad_bal.put(rss.getString("bal_pad"));
                    contenido_pad_pro.put(rss.getString("product_pad")); 
                    
                } ////FIN DEL RECORRIDO LARGO
                 
                
                
                categories=new JSONArray();
                categories.put(Category);   
                
                DataMortandad.put(    "data",contenido_mortandad);  
                DataAgua.put(         "data",contenido_caudalimetro);   
                DataBalanceado.put(   "data",contenido_balanceados);
                DataTempMin.put(      "data",contenido_temp_min);
                DataTempMax.put(      "data",contenido_tem_max);   
                DataProducto.put(     "data",contenido_product); 
                DataPadProdu.put(     "data",contenido_pad_bal);   
                DataPadBalan.put(      "data",contenido_pad_pro);
               
                Dataset= new JSONArray();
                Dataset.put(DataMortandad);   
                Dataset.put(DataAgua);   
                Dataset.put(DataBalanceado);   
                Dataset.put(DataTempMin);   
                Dataset.put(DataTempMax);   
                Dataset.put(DataProducto); 
                Dataset.put(DataPadProdu);
                Dataset.put(DataPadBalan);
                contenidoData= new JSONObject();
                data= new JSONObject();
                
              
                contenidoData.put("labels", contenido_subcategorias);
                contenidoData.put("datasets",    Dataset);
                
                 DataScale.put(    "A",DataA);  
                DataScale.put(    "B",DataB);  
                DataScale.put(    "C",DataC);  
                DataScale.put(    "D",DataD);  

                
                data.put("data",contenidoData);
                
                data.put("type",  "bar");
                dataOptions= new JSONObject();   
                dataOptions.put("scales", DataScale);
                dataOptions.put("plugins", DataTitle);
                dataOptions.put("elements", DataPoint);

                data.put("options",dataOptions);
 
                dataArray.put(data);
                
                dd++;   
            }
        clases.controles.DesconnectarBDsession();             
        charts.put("charts", dataArray); 
         
         out.print(charts); 
 %>
 