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
    String fecha_desde= request.getParameter("fecha_desde") ;
    String fecha_hasta= request.getParameter("fecha_hasta") ;
    String tipo_grafico= request.getParameter("tipo_grafico") ;
    String tipoConsulta= request.getParameter("tipoConsulta") ;
    String[] array_aviarios= request.getParameterValues("aviarios");
    String[] array_categoria= request.getParameterValues("categorias");
    
    String aviario="";
    String categoria="";
    int tot_mortandad=0;
    boolean mortandad   =true;
    boolean consumo_bal =true;
    boolean product     =true;
    boolean caudalimetro=true;
    boolean temp_min=true;
    boolean temp_max=true;
    boolean pad_bal=true;
    boolean pad_prod=true;
    boolean huevo=true;
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    JSONObject charts = new JSONObject();
  try {
          
    for(int i=0; i<array_aviarios.length; i++)   
    {
        if (array_aviarios.length > 0)
        {
            if(i==0)
            {
                aviario="'"+array_aviarios[i]+"'";  
            }
            else 
            {
                aviario=aviario  + ",'" +array_aviarios[i]+"'"; 
            }
        }
    }
    
    for(int i=0; i<array_categoria.length; i++)   
    {
        if(array_categoria[i].equals("mortandadd")){
            mortandad   =false;
        }
        else  if(array_categoria[i].equals("consumo_ball")){
            consumo_bal   =false;
        }
        else  if(array_categoria[i].equals("producto")){
            product   =false;
        }                   
        else  if(array_categoria[i].equals("caudalime")){
            caudalimetro   =false;
        }                    
        else  if(array_categoria[i].equals("temp_mini")){
            temp_min   =false;
        }                    
        else  if(array_categoria[i].equals("temp_maxi")){
            temp_max   =false;
        }                    
        else  if(array_categoria[i].equals("pad_bala")){
            pad_bal   =false;
        }                    
        else  if(array_categoria[i].equals("pad_produ")){
            pad_prod   =false;
        }  
        else  if(array_categoria[i].equals("huevo")){
            huevo   =false;
        }
    } 
    
  
    
      String query ="SELECT  FORMAT(vis.fecha,'dd-MM')fecha,SUM(vis.muertes) as muertes,SUM(vis.caudalimetro)as caudalimetro,"
      + "sum(vis.temp_min) as temp_min,sum(vis.temp_max) as temp_max,SUM(vis.consumo_bal) as consumo_bal,"
      + "SUM(vis.product) as product, sum(con.huevos)  as huevocontador,sum(vis.bal_pad)  as bal_pad, "
      + "sum(vis.product_pad)  as product_pad  FROM vis_mae_ppr_grafico vis "
      + "inner join vis_mae_huevos_aviarios con on  vis.aviario=con.aviario and  vis.fecha= con.fecha "
      + "where vis.aviario IN  ("+aviario+")  and vis.fecha BETWEEN '"+fecha_desde+"' and '"+fecha_hasta+"' "
      + " group by vis.fecha ORDER BY vis.fecha asc";
    
        
   if(tipoConsulta.equals("promedio"))
   {
      query="SELECT  FORMAT(vis.fecha,'dd-MM')fecha,SUM(vis.muertes) as muerte,CONVERT(NUMERIC(10,1),round( avg(vis.muertes),0)) AS muertes,"
              + "SUM(vis.caudalimetro)as caudalimetr,CONVERT(NUMERIC(10,1),round( avg(vis.caudalimetro),2)) AS caudalimetro,"
              + "sum(vis.temp_min) as temp_mi,CONVERT(NUMERIC(10,1),round( avg(vis.temp_min),2)) AS temp_min,"
              + "sum(vis.temp_max) as temp_ma,CONVERT(NUMERIC(10,1),round( avg(vis.temp_max),2)) AS temp_max,"
              + "SUM(vis.consumo_bal) as consumo_ba,CONVERT(NUMERIC(10,1),round( avg(vis.consumo_bal),2))  as consumo_bal,"
              + "SUM(vis.product) as produc,CONVERT(NUMERIC(10,1),round( avg(vis.product),2))  as product,"
              + "sum(con.huevos)  as huevocontado,CONVERT(NUMERIC(10,1),round( avg(con.huevos),2))  as huevocontador,"
              + "sum(vis.bal_pad) as bal_pa,    CONVERT(NUMERIC(10,1), round( avg(vis.bal_pad),2)) as bal_pad,"
              + "sum(vis.product_pad)  as product_pa,CONVERT(NUMERIC(10,1),    round( avg(vis.product_pad),2))  as product_pad "
              + "FROM vis_mae_ppr_grafico vis inner join vis_mae_huevos_aviarios con on  vis.aviario=con.aviario and  vis.fecha= con.fecha"
              + " where vis.aviario IN  ("+aviario+")   and vis.fecha BETWEEN '"+fecha_desde+"' and '"+fecha_hasta+"' group by vis.fecha"
              + " ORDER BY vis.fecha asc";
    };
    if(tipoConsulta.equals("minimo"))
   {
      query="SELECT FORMAT(vis.fecha,'dd-MM')fecha,MIN(vis.muertes) as muertes,MIN(vis.caudalimetro)as caudalimetro,"
              + "MIN(vis.temp_min) as temp_min,MIN(vis.temp_max) as temp_max,MIN(vis.consumo_bal) as consumo_bal,"
              + "MIN(vis.product) as product,MIN(con.huevos)  as huevocontador, MIN(vis.bal_pad) as bal_pad,  "
              + "MIN(vis.product_pad) as product_pad FROM vis_mae_ppr_grafico vis "
              + "inner join vis_mae_huevos_aviarios con on  vis.aviario=con.aviario and  vis.fecha= con.fecha "
              + "  where vis.aviario IN  ("+aviario+")  and vis.fecha  BETWEEN '"+fecha_desde+"' and '"+fecha_hasta+"'  "
              + "group by vis.fecha ORDER BY vis.fecha asc";
    };
     if(tipoConsulta.equals("maximo"))
   {
      query="SELECT  FORMAT(vis.fecha,'dd-MM')fecha,MAX(vis.muertes) as muertes, "
              + "MAX(vis.caudalimetro)as caudalimetro,  "
              + "MAX(vis.temp_min) as temp_min, MAX(vis.temp_max) as temp_max,"
              + "MAX(vis.consumo_bal) as consumo_bal, MAX(vis.product) as product, "
              + "MAX(con.huevos)  as huevocontador, MAX(vis.bal_pad) as bal_pad, "
              + "MAX(vis.product_pad) as product_pad  "
              + "FROM vis_mae_ppr_grafico vis inner join vis_mae_huevos_aviarios con on  vis.aviario=con.aviario and  vis.fecha= con.fecha   "
              + "where vis.aviario IN  ("+aviario+")  and vis.fecha   BETWEEN '"+fecha_desde+"' and '"+fecha_hasta+"' group by vis.fecha ORDER BY vis.fecha asc";
    };
    PreparedStatement pt=clases.controles.connectSesion.prepareStatement(query);
    ResultSet rs=pt.executeQuery();
 
        
        JSONObject DataScale= new JSONObject();
         
        JSONObject  contenidoData,          dataOptions,        data,
                    DataMortandad,          DataAgua,           DataBalanceado, DataPadProdu,
                    DataTempMin,            DataTempMax,        DataProducto,   DataPadBalan, DataHuevo,
                    DataA,                  DataB,              DataC, 
                    DataD,                  ticksA,             ticksB,  
                    ticksC,                 ticksD,             TitleB,
                    TitleC,                 TitleD,             ContenidoTitle,
                    DataTitle,              ContenidoPoint,     DataPoint,
                    Category                = new JSONObject();
      
        JSONArray   categories,             Dataset,            contenido_subcategorias, 
                    contenido_balanceados,  contenido_mortandad,contenido_caudalimetro,
                    contenido_temp_min,     contenido_tem_max,  contenido_product,     
                    contenido_pad_pro,      contenido_pad_bal,  contenido_huevo,
                    dataArray               = new JSONArray();         
                          
           
                    
            while(rs.next()) // va a recorrer 22 veces
            {
                    String aviarios=(aviario);
                    
                    DataMortandad = new JSONObject();
                    
                    DataMortandad.put("label",  "Muertos");
                    DataMortandad.put("type",tipo_grafico);
                    DataMortandad.put("yAxisID", "C");
                    DataMortandad.put("backgroundColor",    "rgba(99, 255, 132)");
                    DataMortandad.put("borderColor",  "rgba(99, 255, 132)");
                    DataMortandad.put("borderWidth",       2);
                    DataMortandad.put("hidden",    mortandad);
                    
                     DataHuevo = new JSONObject();
                    
                    DataHuevo.put("label",  "Contadores Huevos");
                    DataHuevo.put("type",tipo_grafico);
                    DataHuevo.put("yAxisID", "B");
                    DataHuevo.put("backgroundColor",    "#ffcc00");
                    DataHuevo.put("borderColor",  "#ffcc00");
                    DataHuevo.put("borderWidth",       2);
                    DataHuevo.put("hidden",    huevo);
                    
                   
                    DataAgua= new JSONObject();
                    DataAgua.put("label",  "Cons. Agua.");
                    DataAgua.put("yAxisID","A");
                    DataAgua.put("backgroundColor",    "rgb(132, 132, 132)");
                    DataAgua.put("borderColor",  "rgb(132, 132, 132)");
                    DataAgua.put("borderWidth",  2);
                    DataAgua.put("type",  tipo_grafico);
                    DataAgua.put("hidden",    caudalimetro);
                    
                    DataBalanceado= new JSONObject();
                    DataBalanceado.put("label",  "Cons. Bal.");
                    DataBalanceado.put("yAxisID","A");
                    DataBalanceado.put("backgroundColor",    "rgb(207, 52, 235)");
                    DataBalanceado.put("borderColor",  "rgb(207, 52, 235)");
                    DataBalanceado.put("borderWidth",    2);
                    DataBalanceado.put("type",  tipo_grafico);
                    DataBalanceado.put("hidden",    consumo_bal);
                    
                    DataTempMin= new JSONObject();
                    DataTempMin.put("label",  "Temp. Min.");
                    DataTempMin.put("type",  tipo_grafico);
                    DataTempMin.put("yAxisID","D");
                    DataTempMin.put("backgroundColor",    "rgba(0, 0, 255, 0.5)");
                    DataTempMin.put("borderColor",  "rgba(0, 0, 255, 0.5)");
                    DataTempMin.put("borderWidth",    2);
                    DataTempMin.put("hidden",    temp_min);
                    
                    DataTempMax= new JSONObject();
                    DataTempMax.put("label",  "Temp. Max. ");
                    DataTempMax.put("type",  tipo_grafico);
                    DataTempMax.put("yAxisID","D");
                    DataTempMax.put("backgroundColor",    "rgba(255, 0, 0, 0.5)");
                    DataTempMax.put("borderColor",  "rgba(255, 0, 0, 0.5)");
                    DataTempMax.put("borderWidth",    2);
                    DataTempMax.put("hidden",    temp_max);

                    
                    DataProducto= new JSONObject();                
                    DataProducto.put("label",  "% Product. ");
                    DataProducto.put("yAxisID","B");
                    DataProducto.put("type",  tipo_grafico);
                    DataProducto.put("backgroundColor",    "rgb(235, 125, 52)");
                    DataProducto.put("borderColor",  "rgb(235, 125, 52)");
                    DataProducto.put("borderWidth",    2);
                    DataProducto.put("hidden",    product);

                    DataPadProdu= new JSONObject();                
                    DataPadProdu.put("label",  "% Pad. Product.");
                    DataPadProdu.put("yAxisID","B");
                    DataPadProdu.put("type",  tipo_grafico);
                    DataPadProdu.put("backgroundColor",    "rgb(#335EFF)");
                    DataPadProdu.put("borderColor",  "rgb(#335EFF)");
                    DataPadProdu.put("borderWidth",    2);
                    DataPadProdu.put("hidden",    pad_prod);

                    DataPadBalan= new JSONObject();                
                    DataPadBalan.put("label",  "% Pad. balanc.");
                    DataPadBalan.put("yAxisID","B");
                    DataPadBalan.put("type",  tipo_grafico);
                    DataPadBalan.put("backgroundColor",    "rgb(255, 0, 0)");
                    DataPadBalan.put("borderColor",  "rgb(255, 0, 0)");
                    DataPadBalan.put("borderWidth",    2);
                    DataPadBalan.put("hidden",    pad_bal);
                    
                    
                    
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
                   
                    contenido_subcategorias = new JSONArray();
                    contenido_balanceados = new JSONArray();
                    contenido_mortandad = new JSONArray();
                    contenido_caudalimetro = new JSONArray();
                    contenido_temp_min = new JSONArray();
                    contenido_tem_max = new JSONArray();
                    contenido_product = new JSONArray(); 
                    contenido_huevo = new JSONArray(); 
                    contenido_pad_bal = new JSONArray(); 
                    contenido_pad_pro = new JSONArray(); 
                   while(rs.next()) 
                   { 
                    // este recorre la cantidad de registros que hay en ese mes y en ese aviario
                    
                    
                    contenido_subcategorias.put(rs.getString("fecha"));
                    contenido_mortandad.put(rs.getString("muertes"));
                    contenido_balanceados.put(rs.getInt("consumo_bal"));
                    contenido_caudalimetro.put(rs.getString("caudalimetro"));
                    contenido_temp_min.put(rs.getString("temp_min")); 
                    contenido_tem_max.put(rs.getString("temp_max"));
                    contenido_product.put(rs.getString("product")); 
                    contenido_huevo.put(rs.getString("huevocontador")); 
                    contenido_pad_bal.put(rs.getString("bal_pad"));
                    contenido_pad_pro.put(rs.getString("product_pad")); 
                    
                } ////FIN DEL RECORRIDO LARGO
                 
        
                
                categories=new JSONArray();
                categories.put(Category);   
                
                DataMortandad.put(    "data",contenido_mortandad);  
                DataAgua.put(         "data",contenido_caudalimetro);   
                DataBalanceado.put(   "data",contenido_balanceados);
                DataTempMin.put(      "data",contenido_temp_min);
                DataTempMax.put(      "data",contenido_tem_max);   
                DataProducto.put(     "data",contenido_product); 
                DataHuevo.put(        "data",contenido_huevo);
                DataPadProdu.put(     "data",contenido_pad_bal);   
                DataPadBalan.put(     "data",contenido_pad_pro); 
                
   
                
                Dataset= new JSONArray();
                Dataset.put(DataMortandad);   
                Dataset.put(DataAgua);   
                Dataset.put(DataBalanceado);   
                Dataset.put(DataTempMin);   
                Dataset.put(DataTempMax);   
                Dataset.put(DataProducto); 
                Dataset.put(DataHuevo); 
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
                
                data.put("type",  tipo_grafico);
                dataOptions= new JSONObject();   
                dataOptions.put("scales", DataScale);
                dataOptions.put("plugins", DataTitle);
                dataOptions.put("elements", DataPoint);

                data.put("options",dataOptions);

                dataArray.put(data);
                
                
            }
            
             charts.put("charts", dataArray); 
             charts.put("totales", dataArray); 
         
      } catch (Exception e) {
          String error=e.getMessage();
      }
  finally{
    clases.controles.DesconnectarBDsession();             
    out.print(charts); 

  }
 %>
 
 