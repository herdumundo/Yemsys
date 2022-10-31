<%-- 
    Document   : datos
    Created on : 02-ene-2022, 19:57:59
    Author     : aespinola
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@include  file="../../cruds/conexion.jsp" %>  
<%@include  file="../../chequearsesion.jsp" %>
<%   
   
    String tipo =  request.getParameter ("tipo");;
    JSONObject charts = new JSONObject();
  try {
          
    Statement st;
    ResultSet rs;
    DecimalFormat formatea = new DecimalFormat("###,###.##");
    st=connection.createStatement();
    String query="cantidad_aves";
    String titulo="AVES POR AVIARIOS";
    String titulo_barra="CANTIDADES AVES";
    String color_grafico="rgb(209, 75, 75)";
    int min=20000;
    int max=70000;
    
    if(tipo!=null){
            query="semana_lote_barra";
            titulo="SEMANAS POR AVIARIOS";
            titulo_barra="SEMANAS";
            color_grafico="rgb(4, 82, 13)";
            min=0;
            max=150;
       }
        rs=st.executeQuery("SELECT aviario,cantidad_semana_lote as cantidad_aves,semana_lote_barra  FROM ppr_pry_cab" );
        JSONObject DataScale= new JSONObject();
         
        JSONObject  contenidoData,  dataOptions,    data,
                    DataAves,       DataScaleAves,  DataPoint,              
                    ticksScaleAves, TitleScaleAves, ContenidoPoint,     
                               Category        = new JSONObject();
      
        JSONArray   categories,     Dataset,        contenido_subcategorias,
                    array_aves,     dataArray       = new JSONArray();       
        
         
    //////////////////////////////////////////AVES //////////////////////////////////////////////////////////////////////////////////                      
                    DataAves = new JSONObject();
                    DataAves.put("label",               titulo);
                    DataAves.put("yAxisID",             "Y");
                    DataAves.put("backgroundColor",     color_grafico);
                    DataAves.put("borderColor",         color_grafico);
                    DataAves.put("pointRadius",         3);
                    DataAves.put("borderWidth",         1);
                    DataAves.put("type",                "line");
                    DataAves.put("tension",             "0.2");
                     
                    DataScaleAves= new JSONObject();                
                    
                    TitleScaleAves= new JSONObject();          
                    TitleScaleAves.put("display",       true);
                    TitleScaleAves.put("text",          titulo_barra);
                    DataScaleAves.put("title",          TitleScaleAves);
                    ticksScaleAves= new JSONObject(); 
                    ticksScaleAves.put("stepSize",      25);// NIVEL VERTICAL DE AVES.
                    DataScaleAves.put("ticks",          ticksScaleAves);
                    DataScaleAves.put("type",           "linear");
                    DataScaleAves.put("display",        true);
                    DataScaleAves.put("beginAtZero",    true);
                    DataScaleAves.put("position",       "right"); 
                   /* DataScaleAves.put("min",            min);
                    DataScaleAves.put("max",            max);*/
                  ////////////////////////////////////////////////////////////////////////////  
                    ContenidoPoint= new JSONObject();
                    ContenidoPoint.put("radius",        0);
                    DataPoint= new JSONObject();
                    DataPoint.put("point",              ContenidoPoint);
                    contenido_subcategorias         = new JSONArray();
                    array_aves                      = new JSONArray();
 
                while(rs.next()) 
                { 
                    // este recorre la cantidad de registros que hay en ese mes y en ese aviario
                    contenido_subcategorias.put (   rs.getString("aviario")             );
                    array_aves.put              (  formatea.format(rs.getInt(query))         );
                     
                } ////FIN DEL RECORRIDO LARGO
                 
                categories=new JSONArray();
                categories.put(Category);   
                
                DataAves.put(       "data",array_aves);  
   
                Dataset= new JSONArray();
                Dataset.put(DataAves);  
                
                contenidoData= new JSONObject();
                data= new JSONObject(); 
                
                contenidoData.put("labels", contenido_subcategorias);
                contenidoData.put("datasets",    Dataset);
                contenidoData.put("datasetFill ",    false);
                contenidoData.put("lineAtIndex ",    30);
                DataScale.put(    "Y",DataScaleAves);  
                data.put("data",contenidoData); 
                data.put("type",  "linear");
                dataOptions= new JSONObject();   
                dataOptions.put("scales", DataScale);
                dataOptions.put("elements", DataPoint);
                dataOptions.put("showAllTooltips", true);
                dataOptions.put("responsive", false);
                
                 
                data.put("options",dataOptions);
                  
                dataArray.put(data);
                charts.put("charts", dataArray); 
    
      } 
    catch (Exception e) 
    {
        String error=e.getMessage();
    }
      finally
    {
      connection.close();
      out.print(charts);
    } 
 %>
 
 