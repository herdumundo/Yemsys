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
    String fecha_desde_ptc= request.getParameter("fecha_desde_cla") ;
    String fecha_hasta_ptc= request.getParameter("fecha_hasta_cla") ;
    String tipo_grafico_ptc= request.getParameter("tipo_grafico_cla") ;
    String[] array_clasificadora_ptc= request.getParameterValues("clasif_cla");
    String[] array_categoria_ptc= request.getParameterValues("categorias2_cla");
    
    String clasificadora="";
    String script="function () {"
                +"var chartInstance = this.chart,"
                    +"ctx = chartInstance.ctx;"
                    +"ctx.textAlign = 'center';"
                    +"ctx.fillStyle = 'rgba(0, 0, 0, 1)'"
                   +" ctx.textBaseline = 'bottom';"
                    // Loop through each data in the datasets
                   +" this.data.datasets.forEach(function (dataset, i) {"
                      +"  var meta = chartInstance.controller.getDatasetMeta(i);"
                       +" meta.data.forEach(function (bar, index) {"
                        +"    var data = dataset.data[index];"
                        +"    ctx.fillText(data, bar._model.x, bar._model.y - 5);"
                       +" });"
                    +"});"
               +" }";
    String categoria="";
    int tot_mortandad=0;
    boolean ptc   =true;
    boolean rp =true;
    boolean pi     =true;
    boolean r     =true;
   

    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    JSONObject charts_clasificadora = new JSONObject();
    
    for(int i=0; i<array_clasificadora_ptc.length; i++)   
    {
        if (array_clasificadora_ptc.length > 0)
        {
            if(i==0)
            {
                clasificadora="'"+array_clasificadora_ptc[i]+"'";  
            }
            else 
            {
                clasificadora=clasificadora  + ",'" +array_clasificadora_ptc[i]+"'"; 
            }
        }
    }
    for(int i=0; i<array_categoria_ptc.length; i++)   
    {
        if(array_categoria_ptc[i].equals("ptcc")){
            ptc   =false;
        }
        else  if(array_categoria_ptc[i].equals("rpp")){
            rp   =false;
        }
        else  if(array_categoria_ptc[i].equals("pii")){
            pi   =false;
        } 
        else  if(array_categoria_ptc[i].equals("rr")){
            r   =false;
        }
        
    } 
   
    
      String query ="select FORMAT(fecha,'dd-MM')fecha,CONVERT(NUMERIC(10,2),(SUM(ptc)/(SUM(ptc)+sum(pi)))*100)PTC_POR,CONVERT(NUMERIC(10,2),(SUM(rp)/(SUM(rp)+SUM(ptc)+sum(pi)))*100)RP_POR,CONVERT(NUMERIC(10,2),(SUM(pi)/(SUM(ptc)+sum(pi)))*100)PI_POR,CONVERT(NUMERIC(10,2),sum(r)/(SUM(ptc)+(SUM(pi))+(SUM(r)))*100) as R_POR from v_mae_ptc_indicadores where clasificadora_origen in ("+clasificadora+") and FECHA between '"+fecha_desde_ptc+"' and '"+fecha_hasta_ptc+"'GROUP BY FECHA order by fecha";
      
    PreparedStatement pt=clases.controles.connectSesion.prepareStatement(query);
    ResultSet rs=pt.executeQuery();
 
        
        JSONObject DataScale= new JSONObject();
         
        JSONObject  contenidoData,          dataOptions,        data,
                    Dataptc,                Datapi, Datar,      ption, datalab,tooltips,hover,animation,chartinstance,function,
                    Datarp,
                    DataA,                  DataB,              DataC, 
                    DataD,                  ticksA,             TitleA,ticksB,  
                    ticksC,                 ticksD,             TitleB,
                    TitleC,                 TitleD,             ContenidoTitle,
                    DataTitle,              ContenidoPoint,     DataPoint,
                    Category                = new JSONObject();
      
        JSONArray   categories,             Dataset,            contenido_subcategorias, 
                    contenido_rp,           contenido_ptc,      contenido_cantidad,
                    contenido_pi,           contenido_r,
                    dataArray               = new JSONArray();  
                    
                          
           
                    
            while(rs.next()) // va a recorrer 22 veces
            {
                    String clasificadora2=(clasificadora);
                    
                    tooltips = new JSONObject();
                    tooltips.put("enabled",  true);

                    hover = new JSONObject();
                    hover.put("animationDuration",  1);
                    
                    function = new JSONObject();
                    function.put("duration",  1);
                    
                    animation = new JSONObject();
                    animation.put("duration",  1);
                    animation.put("onComplete",  script);

                    
                    Dataptc = new JSONObject();
                    
                    Dataptc.put("label",  "PTC");
                    Dataptc.put("type",tipo_grafico_ptc);
                    Dataptc.put("yAxisID", "C");
                    Dataptc.put("backgroundColor",    "rgba(99, 255, 132)");
                    Dataptc.put("borderColor",  "rgba(99, 255, 132)");
                    Dataptc.put("borderWidth",       2);
                    Dataptc.put("hidden",    ptc);
                    
                     Datarp = new JSONObject();
                    
                    Datarp.put("label",  "REPROCESO");
                    Datarp.put("type",tipo_grafico_ptc);
                    Datarp.put("yAxisID", "B");
                    Datarp.put("backgroundColor",    "#ffcc00");
                    Datarp.put("borderColor",  "#ffcc00");
                    Datarp.put("borderWidth",       2);
                    Datarp.put("hidden",    rp);

                    Datapi= new JSONObject();
                    
                    Datapi.put("label",  "SUBPRODUCTO");
                    Datapi.put("yAxisID","A");
                    Datapi.put("backgroundColor",    "rgb(132, 132, 132)");
                    Datapi.put("borderColor",  "rgb(132, 132, 132)");
                    Datapi.put("borderWidth",  2);
                    Datapi.put("type",  tipo_grafico_ptc);
                    Datapi.put("hidden",    pi);
                    
                    Datar= new JSONObject();
                    
                    Datar.put("label",  "ROTOS");
                    Datar.put("yAxisID","D");
                    Datar.put("backgroundColor",    "rgb(255, 0, 186)");
                    Datar.put("borderColor",  "rgb(255, 0, 186)");
                    Datar.put("borderWidth",  2);
                    Datar.put("type",  tipo_grafico_ptc);
                    Datar.put("hidden",    r);

                    DataA= new JSONObject();                
                    DataA.put("type",    "linear");
                    DataA.put("display",    true);
                    DataA.put("position",    "left");
                    DataA.put("suggestedMin",    0);
                    DataA.put("suggestedMax",    100);
                    
                    TitleA= new JSONObject();                
                    TitleA.put("display",    true);
                    TitleA.put("text",    "SUBPRODUCTO");
                    DataA.put("title",    TitleA);
                    ticksA= new JSONObject(); 
                    ticksA.put("stepSize",    10);
                    DataA.put("ticks",    ticksA);
                    
                    DataB= new JSONObject();                
                    DataB.put("type",    "linear");
                    DataB.put("display",    true);
                    DataB.put("position ",    "right");
                    DataB.put("suggestedMin",    0);
                    DataB.put("suggestedMax",    100);
                    
                    TitleB= new JSONObject();                
                    TitleB.put("display",    true);
                    TitleB.put("text",    "REPROCESO");
                    DataB.put("title",    TitleB);
                    ticksB= new JSONObject(); 
                    ticksB.put("stepSize",    5);
                    DataB.put("ticks",    ticksB);
                 
                    DataC= new JSONObject();                
                    DataC.put("type",    "linear");
                    DataC.put("display",    true);
                    DataC.put("position",    "right");
                    DataC.put("suggestedMin",    0);
                    DataC.put("suggestedMax",    100);

                    TitleC= new JSONObject();                
                    TitleC.put("display",    true);
                    TitleC.put("text",    "PTC");
                    DataC.put("title",    TitleC);
                    ticksC= new JSONObject(); 
                    ticksC.put("stepSize",    20);
                    DataC.put("ticks",    ticksC);
                    
                    DataD= new JSONObject();                
                    DataD.put("type",    "linear");
                    DataD.put("display",    true);
                    DataD.put("position",    "right");
                    DataD.put("suggestedMin",    0);
                    DataD.put("suggestedMax",    15);
                    TitleD= new JSONObject();                
                    TitleD.put("display",    true);
                    TitleD.put("text",    "ROTOS");
                    DataD.put("title",    TitleD);
                    ticksD= new JSONObject(); 
                    ticksD.put("stepSize",    0.5);
                    DataD.put("ticks",    ticksD);
 
                    ContenidoTitle= new JSONObject();
                    ContenidoTitle.put("diplay",    true);
                    ContenidoTitle.put("text",    clasificadora2);
                    
                    DataTitle= new JSONObject();
                    DataTitle.put("title",ContenidoTitle); 
                    
                    ContenidoPoint= new JSONObject();
                    ContenidoPoint.put("radius",    0);
                    
                    DataPoint= new JSONObject();
                    DataPoint.put("point",   ContenidoPoint);
                    
                    
                   
                    contenido_subcategorias = new JSONArray();
                    contenido_rp = new JSONArray();
                    contenido_ptc = new JSONArray();
                    contenido_pi = new JSONArray(); 
                    contenido_r = new JSONArray(); 
                   while(rs.next()) 
                       
                   { 
                    // este recorre la cantidad de registros que hay en ese mes y en ese aviario
                    
                    
                    contenido_subcategorias.put(rs.getString("fecha")+" "+clasificadora);
                    contenido_ptc.put(rs.getString("PTC_POR"));
                    contenido_rp.put(rs.getString("RP_POR"));
                    contenido_pi.put(rs.getString("PI_POR")); 
                    contenido_r.put(rs.getString("R_POR")); 

                    
                    } ////FIN DEL RECORRIDO LARGO
                 
                  
                
                categories=new JSONArray();
                categories.put(Category);   
                
                Dataptc.put(    "data",contenido_ptc);  
                Datarp.put(         "data",contenido_rp);   
                Datapi.put(        "data",contenido_pi);
                Datar.put(        "data",contenido_r);
                
   
                //option=new JSONObject();
               // option.put("tooltips",tooltips);
               // option.put("hover",hover);
                //option.put("animation",animation);
                
                Dataset= new JSONArray();
                Dataset.put(Dataptc);   
                Dataset.put(Datarp);   
                Dataset.put(Datapi);
                Dataset.put(Datar);
                contenidoData= new JSONObject();
                data= new JSONObject();
                
              
                contenidoData.put("labels", contenido_subcategorias);
                contenidoData.put("datasets",    Dataset);
                
                
                DataScale.put(    "A",DataA);  
                DataScale.put(    "B",DataB);  
                DataScale.put(    "C",DataC);
                DataScale.put(    "D",DataD);

                
                data.put("data",contenidoData);
                
                data.put("type",  tipo_grafico_ptc);
                dataOptions= new JSONObject();   
                dataOptions.put("scales", DataScale);
                dataOptions.put("plugins", DataTitle);
                dataOptions.put("elements", DataPoint);
               // dataOptions.put("dataset", option);

                data.put("options",dataOptions);

                dataArray.put(data);
                
                
            }
           
            
             PreparedStatement pt2 = clases.controles.connectSesion.prepareStatement("select CONVERT(NUMERIC(10,2),(SUM(ptc)/(SUM(ptc)+sum(pi)))*100) as ptc2,CONVERT(NUMERIC(10,2),(SUM(rp)/(SUM(rp)+SUM(ptc)+sum(pi)))*100) as rp2,CONVERT(NUMERIC(10,2),(SUM(pi)/(SUM(ptc)+sum(pi)))*100) as pi2,CONVERT(NUMERIC(10,2),sum(r)/(SUM(ptc)+(SUM(pi))+(SUM(r)))*100) as r from v_mae_ptc_indicadores where clasificadora_origen in ("+clasificadora+") and FECHA between '"+fecha_desde_ptc+"' and '"+fecha_hasta_ptc+"'");
       ResultSet rs2 = pt2.executeQuery();
        
        //PreparedStatement pt2 = clases.controles.connectSesion.prepareStatement("select * from v_mae_ptc_indicadores where  FECHA between '"+fecha_desde_ptc+"' and '"+fecha_hasta_ptc+"'");
       // ResultSet rs2 = pt2.executeQuery();
        
        JSONObject DataScale2= new JSONObject();
         
        JSONObject  contenidoData2,          dataOptions2,        data2,
                    Dataptc2,                Datapi2,             datalab2,
                    Datarp2,                 Datar2,
                    DataA2,                  DataB2,              DataC2, 
                    DataD2,                  ticksA2,             ticksB2,  
                    ticksC2,                 ticksD2,             TitleB2,
                    TitleC2,                 TitleD2,             ContenidoTitle2, TitleA2,
                    DataTitle2,              ContenidoPoint2,     DataPoint2,
                    Category2                = new JSONObject();
      
        JSONArray   categories2,             Dataset2,            contenido_subcategorias2, 
                    contenido_rp2,           contenido_ptc2,      contenido_cantidad2,
                    contenido_pi2,          contenido_r2,
                    dataArray2               = new JSONArray();    
        
        while(rs2.next()) // va a recorrer 22 veces
            {
                    String clasificadora22=(clasificadora);
                    
                    
                    Dataptc2 = new JSONObject();
                    
                    Dataptc2.put("label",  "PTC");
                    Dataptc2.put("type",tipo_grafico_ptc);
                    Dataptc2.put("yAxisID", "C");
                    Dataptc2.put("backgroundColor",    "rgba(99, 255, 132)");
                    Dataptc2.put("borderColor",  "rgba(99, 255, 132)");
                    Dataptc2.put("borderWidth",       2);
                    Dataptc2.put("hidden",    ptc);
                    
                    Datarp2 = new JSONObject();
                    
                    Datarp2.put("label",  "REPROCESO");
                    Datarp2.put("type",tipo_grafico_ptc);
                    Datarp2.put("yAxisID", "B");
                    Datarp2.put("backgroundColor",    "#ffcc00");
                    Datarp2.put("borderColor",  "#ffcc00");
                    Datarp2.put("borderWidth",       2);
                    Datarp2.put("hidden",    rp);

                    Datapi2= new JSONObject();
                    
                    Datapi2.put("label",  "SUBPRODUCTO");
                    Datapi2.put("type", tipo_grafico_ptc);
                    Datapi2.put("yAxisID","A");
                    Datapi2.put("backgroundColor",    "rgb(132, 132, 132)");
                    Datapi2.put("borderColor",  "rgb(132, 132, 132)");
                    Datapi2.put("borderWidth",  2);
                    Datapi2.put("hidden",    pi);
                    
                     Datar2= new JSONObject();
                    
                   Datar2.put("label",  "ROTOS");
                   Datar2.put("yAxisID","D");
                   Datar2.put("backgroundColor",    "rgb(255, 0, 186)");
                   Datar2.put("borderColor",  "rgb(255, 0, 186)");
                   Datar2.put("borderWidth",  2);
                   Datar2.put("type",  tipo_grafico_ptc);
                   Datar2.put("hidden",    r);

                    DataA2= new JSONObject();                
                    DataA2.put("type",    "linear");
                    DataA2.put("display",    true);
                    DataA2.put("position",    "left");
                    DataA2.put("suggestedMin",    0);
                    DataA2.put("suggestedMax",    100);
                    
                    TitleA2= new JSONObject();                
                    TitleA2.put("display",    true);
                    TitleA2.put("text",    "SUBPRODUCTO");
                    DataA2.put("title",    TitleA2);
                    ticksA2= new JSONObject(); 
                    ticksA2.put("stepSize",    10);
                    DataA2.put("ticks",    ticksA2);

                    
                    DataB2= new JSONObject();                
                    DataB2.put("type",    "linear");
                    DataB2.put("display",    true);
                    DataB2.put("position ",    "left");
                    DataB2.put("suggestedMin",    0);
                    DataB2.put("suggestedMax",    100);
                    
                    TitleB2= new JSONObject();                
                    TitleB2.put("display",    true);
                    TitleB2.put("text",    "REPROCESO");
                    DataB2.put("title",    TitleB2);
                    ticksB2= new JSONObject(); 
                    ticksB2.put("stepSize",    5);
                    DataB2.put("ticks",    ticksB2);
                    
                  //  TitleB2= new JSONObject();                
                  //  TitleB2.put("display",    true);
                 //   TitleB2.put("text",    "pi");
                   // DataB2.put("title",    TitleB2);
                  //  ticksB2= new JSONObject(); 
                  //  ticksB2.put("stepSize",    5);
                  //  DataB2.put("ticks",    ticksB2);
                 
                    DataC2= new JSONObject();                
                    DataC2.put("type",    "linear");
                    DataC2.put("display",    true);
                    DataC2.put("position",    "right");
                    DataC2.put("suggestedMin",    0);
                    DataC2.put("suggestedMax",    "max");
                    TitleC2= new JSONObject();                
                    TitleC2.put("display",    true);
                    TitleC2.put("text",    "PTC");
                    DataC2.put("title",    TitleC2);
                    ticksC2= new JSONObject(); 
                    ticksC2.put("stepSize",    20);
                    DataC2.put("ticks",    ticksC2);
                    
                    
                    
                    
                    DataD2= new JSONObject();                
                    DataD2.put("type",    "linear");
                    DataD2.put("display",    true);
                    DataD2.put("position",    "right");
                    DataD2.put("suggestedMin",    0);
                    DataD2.put("suggestedMax",    20);
                    TitleD2= new JSONObject();                
                    TitleD2.put("display",    true);
                    TitleD2.put("text",    "ROTOS");
                    DataD2.put("title",    TitleD2);
                    ticksD2= new JSONObject(); 
                    ticksD2.put("stepSize",    0.5);
                    DataD2.put("ticks",    ticksD2);
 
                    ContenidoTitle2= new JSONObject();
                    ContenidoTitle2.put("diplay",    true);
                    ContenidoTitle2.put("text",    clasificadora22);
                    
                    DataTitle2= new JSONObject();
                    DataTitle2.put("title",ContenidoTitle2); 
                    
                    ContenidoPoint2= new JSONObject();
                    ContenidoPoint2.put("radius",    0);
                    
                    DataPoint2= new JSONObject();
                    DataPoint2.put("point2",   ContenidoPoint2);
                    
                    
                   
                    contenido_subcategorias2 = new JSONArray();
                    contenido_rp2 = new JSONArray();
                    contenido_ptc2 = new JSONArray();
                    contenido_pi2 = new JSONArray(); 
                    contenido_r2 = new JSONArray();
                   
                    // este recorre la cantidad de registros que hay en ese mes y en ese aviario
                    
                    
                    //contenido_subcategorias2.put('"+fecha_desde_ptc+"' / '"+fecha_hasta_ptc+"');
                    //contenido_ptc2.put(rs2.getString("ptc2"));
                    //contenido_rp2.put(rs2.getString("rp2"));
                    //contenido_pi2.put(rs2.getString("pi2")); 
                     // va a recorrer 22 veces
                    
                    contenido_subcategorias2.put(""+fecha_desde_ptc+" / "+fecha_desde_ptc+""+" "+clasificadora);
                    contenido_ptc2.put(rs2.getString("ptc2"));
                    contenido_rp2.put(rs2.getString("rp2"));
                    contenido_pi2.put(rs2.getString("pi2")); 
                    contenido_r2.put(rs2.getString("r")); 
                    
                    
                
                categories2=new JSONArray();
                categories2.put(Category2);   
                
                Dataptc2.put(    "data",contenido_ptc2);  
                Datarp2.put(         "data",contenido_rp2);   
                Datapi2.put(        "data",contenido_pi2);
                Datar2.put(        "data",contenido_r2);
                
   
                
                Dataset2= new JSONArray();
                Dataset2.put(Dataptc2);   
                Dataset2.put(Datarp2);   
                Dataset2.put(Datapi2);
                Dataset2.put(Datar2);   
                contenidoData2= new JSONObject();
                data2= new JSONObject();
                
              
                contenidoData2.put("labels", contenido_subcategorias2);
                contenidoData2.put("datasets",    Dataset2);
                
                DataScale2.put(    "A",DataA2);  
                DataScale2.put(    "B",DataB2);  
                DataScale2.put(    "C",DataC2); 
                DataScale2.put(    "D",DataD2);

                
                data2.put("data",contenidoData2);
                
                data2.put("type",  tipo_grafico_ptc);
                dataOptions2= new JSONObject();   
                dataOptions2.put("scales", DataScale2);
                dataOptions2.put("plugins", DataTitle2);
                dataOptions2.put("elements", DataPoint2);

                data2.put("options",dataOptions2);

                dataArray2.put(data2);
                
                
            }
            
             charts_clasificadora.put("charts_clasificadora", dataArray); 
             charts_clasificadora.put("totales", dataArray); 
             charts_clasificadora.put("totales2", dataArray2); 
         clases.controles.DesconnectarBDsession();   
         out.print(charts_clasificadora); 
 %>
 
 