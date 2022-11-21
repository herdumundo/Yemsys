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
   
     JSONObject charts = new JSONObject();
  try {
        PreparedStatement pst,pst2 ;
    ResultSet  rs2 ;      
    Statement st;
    ResultSet rs;
    DecimalFormat formatea = new DecimalFormat("###,###.##");
    st=connection.createStatement();
    String query="cantidad_aves";
    String query_huevos="huevos_dias";
    String titulo="AVES POR AVIARIOS";
    String titulo_barra="CANTIDADES AVES";
    String color_grafico="rgb(209, 75, 75)";
    int min=20000;
    int max=70000;
    
    
    
       pst2 = connection.prepareStatement(" select * from ppr_pry_fecha");
    rs2 = pst2.executeQuery();
    String fecha="";
      while (rs2.next()) 
            {
              fecha=rs2.getString("fecha");
            }
    
   
      
        
         rs=st.executeQuery(" SELECT id,AVIARIO,LOTE,ubicacion,fecha_produccion,fecha_predescarte,id_padre "
                 + "FROM v_ppr_pry_productividad_semanas GROUP BY ubicacion, AVIARIO,LOTE,fecha_produccion,fecha_predescarte,id_padre,id " );
    
        JSONObject DataScale= new JSONObject();
         
        JSONObject  contenidoData,  dataOptions, fechaObj,   data,
                    DataAves, DataScaleAves,  DataPoint,              
                    ticksScaleAves, TitleScaleAves, ContenidoPoint, 
                               Category        = new JSONObject();
      
        JSONArray   categories,     Dataset,        contenido_subcategorias,
                    array_aves,array_fechas_fin,array_id,array_padre,array_color,array_ubicacion,     dataArray       = new JSONArray();       
        
         
    //////////////////////////////////////////AVES //////////////////////////////////////////////////////////////////////////////////        
    
                    DataAves = new JSONObject();
                    DataAves.put("label",               "PRODUCTIVIDAD");
                    DataAves.put("yAxisID",             "Y");
                    DataAves.put("backgroundColor",     "green");
                    DataAves.put("borderColor",         "green");
                    DataAves.put("pointRadius",         3);
                    DataAves.put("borderWidth",         1);
                    DataAves.put("align",               "start");
                    DataAves.put("type",                "line");
                    DataAves.put("tension",             "0.2");
                     
                    DataScaleAves= new JSONObject();                
                    
                    TitleScaleAves= new JSONObject();          
                    TitleScaleAves.put("display",       true);
                    TitleScaleAves.put("text",          "PRODUCTIVIDAD");
                    DataScaleAves.put("title",          TitleScaleAves);
                    ticksScaleAves= new JSONObject(); 
                    ticksScaleAves.put("stepSize",      25);// NIVEL VERTICAL DE AVES.
                    DataScaleAves.put("ticks",          ticksScaleAves);
                    DataScaleAves.put("type",           "bar");
                    DataScaleAves.put("display",        true);
                    DataScaleAves.put("beginAtZero",    true);
                    DataScaleAves.put("position",       "right");  
                  ////////////////////////////////////////////////////////////////////////////  
                    
                    ContenidoPoint= new JSONObject();
                    ContenidoPoint.put("radius",        0);
                    DataPoint= new JSONObject();
                    DataPoint.put("point",              ContenidoPoint);
                    contenido_subcategorias         = new JSONArray();
                    array_fechas_fin                   = new JSONArray();
                    array_aves                      = new JSONArray();
                    array_ubicacion                      = new JSONArray();
                    array_padre                      = new JSONArray();
                    array_id                      = new JSONArray();
                    array_color                      = new JSONArray();

                  while(rs.next()) 
                { 
                    // este recorre la cantidad de registros que hay en ese mes y en ese aviario
                    contenido_subcategorias.put (rs.getString("aviario")            );
                    array_aves.put              ( rs.getString("fecha_produccion")  );
                    array_fechas_fin.put              ( rs.getString("fecha_predescarte")  );
                    array_padre.put              ( rs.getString("id_padre")  );
                    array_id.put              ( rs.getString("id")  );
                 
                    if(rs.getString("ubicacion").equals("PPR") ){
                    array_color.put              ( 100  );
                    }
                    else {
                    array_color.put              ( 0  );
                    }
                    
                     

//  array_aves.put              ( rs.getString("fecha_predescarte")  );
                    //array_fechas.put(array_aves);
                } ////FIN DEL RECORRIDO LARGO
                 
                categories=new JSONArray();
                categories.put(Category);   
                
                DataAves.put    (   "data",array_aves);  
                DataAves.put    (   "data2",array_fechas_fin);  
                DataAves.put    (   "data3",array_ubicacion);  
                DataAves.put    (   "padre",array_padre);  
                DataAves.put    (   "id",array_id);  
                DataAves.put    (   "color",array_color);  
                 
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
                data.put("type",  "bar");
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
 
 