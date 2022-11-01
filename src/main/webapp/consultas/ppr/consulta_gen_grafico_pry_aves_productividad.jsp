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
    String query_huevos="huevos_dias";
    String titulo="AVES POR AVIARIOS";
    String titulo_barra="CANTIDADES AVES";
    String color_grafico="rgb(209, 75, 75)";
    int min=20000;
    int max=70000;
    
    if(tipo!=null)
    {
            query="semana_lote_barra";
            query_huevos="huevos_padron";
            titulo="SEMANAS POR AVIARIOS";
            titulo_barra="SEMANAS";
            color_grafico="rgb(4, 82, 13)";
            min=0;
            max=150;
    }
        rs=st.executeQuery(" select  aviario, "
			+"				isnull(cantidad_semana_lote,0) as cantidad_aves,  "
                        +"    isnull(semana_lote_barra,0) as semana_lote_barra,  "
                        +"    isnull(huevos_padron,0) as huevos_padron,  "
                        +"    isnull(huevos_carga,0) as huevos_carga "
                + "         FROM ppr_pry_cab	  t1 left join   "
                + "         v_ppr_pry_productividad_semanas t2 on t1.id=t2.id_cab and t1.semana_lote_barra=t2.semanas  " );
        JSONObject DataScale= new JSONObject();
         
        JSONObject  contenidoData,  dataOptions,    data,
                    DataAves,DataHuevos,       DataScaleAves,  DataPoint,              
                    ticksScaleAves,ticksScaleHuevos, TitleScaleAves,TitleScaleHuevos, ContenidoPoint,DataScaleHuevos,     
                               Category        = new JSONObject();
      
        JSONArray   categories,     Dataset,        contenido_subcategorias,
                    array_aves,array_huevos,     dataArray       = new JSONArray();       
        
         
    //////////////////////////////////////////AVES //////////////////////////////////////////////////////////////////////////////////        
    
                    DataAves = new JSONObject();
                    DataAves.put("label",               "PRODUCTIVIDAD");
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
                    TitleScaleAves.put("text",          "PRODUCTIVIDAD");
                    DataScaleAves.put("title",          TitleScaleAves);
                    ticksScaleAves= new JSONObject(); 
                    ticksScaleAves.put("stepSize",      25);// NIVEL VERTICAL DE AVES.
                    DataScaleAves.put("ticks",          ticksScaleAves);
                    DataScaleAves.put("type",           "linear");
                    DataScaleAves.put("display",        true);
                    DataScaleAves.put("beginAtZero",    true);
                    DataScaleAves.put("position",       "right"); 
                    DataScaleAves.put("min",            5000);
                    DataScaleAves.put("max",            500000); 
                  ////////////////////////////////////////////////////////////////////////////  
                    
                  
                    DataHuevos= new JSONObject();
                    DataHuevos.put("label",             "PRODUCTIVIDAD PADRON");
                    DataHuevos.put("yAxisID",           "A");
                    DataHuevos.put("backgroundColor",   "rgb(209, 224, 0)");
                    DataHuevos.put("borderColor",       "rgb(203, 142, 11)");
                    DataHuevos.put("borderWidth",       2);
                    DataHuevos.put("pointRadius",       2);
                    DataHuevos.put("type",              "line");
                    DataHuevos.put("tension",           "0.4");
                  
                    DataScaleHuevos= new JSONObject(); //PRINCIPAL PARA METER TODO LO RELACIONADO AL SCALE               
                    
                    TitleScaleHuevos= new JSONObject();                
                    TitleScaleHuevos.put("display",                   true);
                    TitleScaleHuevos.put("text",                      "PRODUCTIVIDAD PADRON");
                    
                    DataScaleHuevos.put("title",                      TitleScaleHuevos); // DENTRO DE TITLE SE INSERTAN DISPLAY Y TEXT. VER ARRIBA.
                    
                    ticksScaleHuevos= new JSONObject(); 
                    ticksScaleHuevos.put("stepSize",                  25);
                    
                    DataScaleHuevos.put("ticks",                    ticksScaleHuevos);//EN DataScalePadron SE AGREGAN STEPSIZE. VER ARRIBA.
                    DataScaleHuevos.put("type",                       "linear");
                    DataScaleHuevos.put("display",                    true);
                    DataScaleHuevos.put("position",                   "right");
                    DataScaleHuevos.put("min",            5000);
                    DataScaleHuevos.put("max",            500000);   
                    
                    ContenidoPoint= new JSONObject();
                    ContenidoPoint.put("radius",        0);
                    DataPoint= new JSONObject();
                    DataPoint.put("point",              ContenidoPoint);
                    contenido_subcategorias         = new JSONArray();
                    array_aves                      = new JSONArray();
                    array_huevos                = new JSONArray();
                while(rs.next()) 
                { 
                    // este recorre la cantidad de registros que hay en ese mes y en ese aviario
                    contenido_subcategorias.put (rs.getString("aviario")            );
                    array_aves.put              ( rs.getInt("huevos_carga")  );
                    array_huevos.put            ( rs.getInt("huevos_padron")       );
                     
                } ////FIN DEL RECORRIDO LARGO
                 
                categories=new JSONArray();
                categories.put(Category);   
                
                DataAves.put    (   "data",array_aves);  
                DataHuevos.put  (   "data",array_huevos);
                Dataset= new JSONArray();
                Dataset.put(DataAves);  
                Dataset.put(DataHuevos);   
                
                contenidoData= new JSONObject();
                data= new JSONObject(); 
                
                contenidoData.put("labels", contenido_subcategorias);
                contenidoData.put("datasets",    Dataset);
                contenidoData.put("datasetFill ",    false);
                contenidoData.put("lineAtIndex ",    30);
                DataScale.put(    "Y",DataScaleAves);  
                DataScale.put(    "A",DataScaleHuevos);  
                
                
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
 
 