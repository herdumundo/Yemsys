 
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
    ResultSet rs,rs2;
    DecimalFormat formatea = new DecimalFormat("###,###.##");
    st=connection.createStatement();
    String query="cantidad_aves";
    String query_huevos="huevos_dias";
    String titulo="AVES POR AVIARIOS";
    String titulo_barra="CANTIDADES AVES";
    String color_grafico="rgb(209, 75, 75)";
    int min=20000;
    int max=70000;
    PreparedStatement pst,pst2 ;
     pst2 = connection.prepareStatement(" select * from ppr_pry_fecha");
    rs2 = pst2.executeQuery();
    String fecha="";
      while (rs2.next()) 
            {
              fecha=rs2.getString("fecha");
            }
    
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
      
          rs=st.executeQuery("SELECT t1.* "
                  + "   FROM v_ppr_pry_productividad_semanas t1 inner join "
                  + "    ppr_pry_cab t2 on t1.id=t2.id and t1.semanas=t2.semana_lote_barra"
                  + " where t1.fecha_predescarte>'"+fecha+"'  and  t1.fecha_produccion<= '"+fecha+"'" );
        JSONObject DataScale= new JSONObject();
         
        JSONObject  contenidoData,  dataOptions,    data,
                    DataAves,DataHuevos,       DataScaleAves,  DataPoint,              
                    ticksScaleAves,ticksScaleHuevos, TitleScaleAves,TitleScaleHuevos, ContenidoPoint,DataScaleHuevos,     
                               Category        = new JSONObject();
      
        JSONArray   categories,     Dataset,        contenido_subcategorias,
                    array_aves,array_huevos,     dataArray       = new JSONArray();       
        
         
    //////////////////////////////////////////AVES //////////////////////////////////////////////////////////////////////////////////        
    
                    DataAves = new JSONObject();
                    DataAves.put("label",               "VIABILIDAD");
                    DataAves.put("yAxisID",             "Y");
                    DataAves.put("backgroundColor",     "rgba(158, 0, 0, 1)");
                    DataAves.put("borderColor",         "rgba(158, 0, 0, 1)");
                    DataAves.put("pointRadius",         3);
                    DataAves.put("align",               "start");
                    DataAves.put("borderWidth",         1);
                    DataAves.put("type",                "line");
                    DataAves.put("tension",             "0.2");
                     
                    DataScaleAves= new JSONObject();                
                    
                    TitleScaleAves= new JSONObject();          
                    TitleScaleAves.put("display",       true);
                    TitleScaleAves.put("text",          "VIABILIDAD");
                    DataScaleAves.put("title",          TitleScaleAves);
                    ticksScaleAves= new JSONObject(); 
                    ticksScaleAves.put("stepSize",      25);// NIVEL VERTICAL DE AVES.
                    DataScaleAves.put("ticks",          ticksScaleAves);
                    DataScaleAves.put("type",           "linear");
                    DataScaleAves.put("display",        true);
                    DataScaleAves.put("beginAtZero",    true);
                    DataScaleAves.put("position",       "right"); 
                    DataScaleAves.put("min",            5000);
                    DataScaleAves.put("max",            70000); 
                  ////////////////////////////////////////////////////////////////////////////  
                    
                  
                    DataHuevos= new JSONObject();
                    DataHuevos.put("label",             "VIABILIDAD PADRON");
                    DataHuevos.put("yAxisID",           "A");
                    DataHuevos.put("backgroundColor",   "black");
                    DataHuevos.put("borderColor",       "black");
                    DataHuevos.put("borderWidth",       2);
                    DataHuevos.put("align",             "end");
                    DataHuevos.put("pointRadius",       2);
                    DataHuevos.put("type",              "line");
                    DataHuevos.put("tension",           "0.4");
                  
                    DataScaleHuevos= new JSONObject(); //PRINCIPAL PARA METER TODO LO RELACIONADO AL SCALE               
                    
                    TitleScaleHuevos= new JSONObject();                
                    TitleScaleHuevos.put("display",                   true);
                    TitleScaleHuevos.put("text",                      "VIABILIDAD PADRON");
                    
                    DataScaleHuevos.put("title",                      TitleScaleHuevos); // DENTRO DE TITLE SE INSERTAN DISPLAY Y TEXT. VER ARRIBA.
                    
                    ticksScaleHuevos= new JSONObject(); 
                    ticksScaleHuevos.put("stepSize",                  25);
                    
                    DataScaleHuevos.put("ticks",                    ticksScaleHuevos);//EN DataScalePadron SE AGREGAN STEPSIZE. VER ARRIBA.
                    DataScaleHuevos.put("type",                       "linear");
                    DataScaleHuevos.put("display",                    true);
                    DataScaleHuevos.put("position",                   "right");
                    DataScaleHuevos.put("min",            5000);
                    DataScaleHuevos.put("max",            70000);   
                    
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
                    array_aves.put              ( rs.getInt("aves_carga")  );
                    array_huevos.put            ( rs.getInt("aves_padron")       );
                     
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
 
 