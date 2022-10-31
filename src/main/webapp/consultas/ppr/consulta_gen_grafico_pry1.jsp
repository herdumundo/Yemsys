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
   
    String id =  request.getParameter ("id");;
    JSONObject charts = new JSONObject();
  try {
          
    Statement st,st2,st3,st4,st5,st6;
    ResultSet rs,rs2,rs3,rs4,rs5,rs6  ;
    String  ultima_carga_ppr="0";
    int min=0;
    int max=0;
    st=connection.createStatement();
    st2=connection.createStatement();
    st3=connection.createStatement();
    st4=connection.createStatement();
    st5=connection.createStatement();
    st6=connection.createStatement();
    String semana_barra="";
    int id_lote=0;
     rs=st.executeQuery("  	select t1.*,t2.aves_padron  as cantidad_aves_pad from	ppr_pry_det_carga  t1 inner join v_mae_ppr_aves_padron t2 on t1.id_cab=t2.id_cab   and t1.semanas=t2.semanas   where     id in ( 	select id 	from ( 			select max(id) as id,semanas  from	ppr_pry_det_carga where id_cab="+id+" group by semanas 		)  d )" );
    
    rs2=st2.executeQuery(" select min(cantidad_aves) as min,max(cantidad_aves) as max from ppr_pry_det 	where id_cab="+id +"" );
    
     rs6=st6.executeQuery(" select semana_lote_barra as semana_ultima ,semana_barra from ppr_pry_cab 	where id="+id +"" );
    
    	while(rs6.next()){
           semana_barra=rs6.getString("semana_barra");
           ultima_carga_ppr=rs6.getString("semana_ultima");
        }
        
        
    rs5=st5.executeQuery("  select id_lote from ppr_pry_det_carga 	where id_cab="+id +"" );
    
    	while(rs5.next()){
           id_lote=rs5.getInt("id_lote");
        }
    
     rs3=st3.executeQuery("	select  dl_fecha as fecha_ajuste_form ,dl_fecha as fecha_registro_form ,"
             + "    dl_edadsems as semana_ajuste   ,dl_saldoaves as saldo_nuevo_form ,dl_muertos as ajuste ,'' as usuario, 'CARGA PPR' as comentario  "
             + " from ppr_datolotes  where dl_lote="+id_lote+"		and dl_muertos >0	 order by 1 " );
 
  /*   
     
    rs4=st4.executeQuery("select MAX(SEMANAS) as ultima_carga_ppr from ppr_pry_det_carga where tipo='CARGA'  and id_cab="+id );

    	while(rs4.next()){
           ultima_carga_ppr=rs4.getString("ultima_carga_ppr");
        }*/
        
        while(rs2.next()) 
        {
            min=rs2.getInt("min");
            max=rs2.getInt("max");
        } 
        
        JSONObject DataScale= new JSONObject();
         
        JSONObject  contenidoData,          dataOptions,        data,
                    DataAves,               DataAvesPadron,     DataScaleAves, 
                    DataScalePadron,        ticksScalePadron,             DataPoint,
                    ticksScaleAves,         TitleScalePadron,              
                    TitleScaleAves,         PluginTitle,          ContenidoPoint,  annotation,line1,lineGlobal,label,  
                    Category                = new JSONObject();
      
        JSONArray   categories,             Dataset,            contenido_subcategorias, 
                    array_avesPadron,       array_aves, 
                    dataArray               = new JSONArray();         
    //////////////////////////////////////////AVES PADRON//////////////////////////////////////////////////////////////////////////////////                      
                    DataAvesPadron= new JSONObject();
                    DataAvesPadron.put("label",             "Aves padron");
                    DataAvesPadron.put("yAxisID",           "A");
                    DataAvesPadron.put("backgroundColor",   "rgb(196, 187, 187)");
                    DataAvesPadron.put("borderColor",       "rgb(132, 132, 132)");
                    DataAvesPadron.put("borderWidth",       2);
                    DataAvesPadron.put("pointRadius",       2);
                    DataAvesPadron.put("type",              "line");
                    DataAvesPadron.put("tension",           "0.4");
     
                    DataScalePadron= new JSONObject(); //PRINCIPAL PARA METER TODO LO RELACIONADO AL SCALE               
                    
                    TitleScalePadron= new JSONObject();                
                    TitleScalePadron.put("display",                   true);
                    TitleScalePadron.put("text",                      "Aves padron");
                    
                    DataScalePadron.put("title",                      TitleScalePadron); // DENTRO DE TITLE SE INSERTAN DISPLAY Y TEXT. VER ARRIBA.
                    
                    ticksScalePadron= new JSONObject(); 
                    ticksScalePadron.put("stepSize",                  25);
                    
                    DataScalePadron.put("ticks",                    ticksScalePadron);//EN DataScalePadron SE AGREGAN STEPSIZE. VER ARRIBA.
                    DataScalePadron.put("type",                       "linear");
                    DataScalePadron.put("display",                    true);
                    DataScalePadron.put("position",                   "right");
                    DataScalePadron.put("min",                        min-5000);
                    DataScalePadron.put("max",                        max);
    //////////////////////////////////////////AVES //////////////////////////////////////////////////////////////////////////////////                      
                    DataAves = new JSONObject();
                    DataAves.put("label",               "Aves");
                    DataAves.put("yAxisID",             "B");
                    DataAves.put("backgroundColor",     "rgb(209, 75, 75)");
                    DataAves.put("borderColor",         "rgb(186, 6, 6)");
                    DataAves.put("pointRadius",         2);
                    DataAves.put("borderWidth",         2);
                    DataAves.put("type",                "line");
                    DataAves.put("tension",           "0.4");
                     
                    DataScaleAves= new JSONObject();                
                    
                    TitleScaleAves= new JSONObject();          
                    TitleScaleAves.put("display",       true);
                    TitleScaleAves.put("text",          "Aves");
                    
                    DataScaleAves.put("title",          TitleScaleAves);
                   
                    ticksScaleAves= new JSONObject(); 
                    ticksScaleAves.put("stepSize",      25);// NIVEL VERTICAL DE AVES.
                    
                    DataScaleAves.put("ticks",          ticksScaleAves);
                    DataScaleAves.put("type",           "linear");
                    DataScaleAves.put("display",        true);
                    DataScaleAves.put("position",       "right");
                    DataScaleAves.put("min",            min-5000);
                    DataScaleAves.put("max",            max);
                  ////////////////////////////////////////////////////////////////////////////  
                          
                    label= new JSONObject(); 
                    label.put("enabled",                true);
                   // label.put("content",                "CARGA PPR HASTA SEMANA "+ultima_carga_ppr);
                    
                    
                    line1= new JSONObject(); 
                    line1.put("type",                   "line");
                    line1.put("xMin",                   ultima_carga_ppr);
                    line1.put("xMax",                   ultima_carga_ppr );
                    line1.put("label",                  label);
                    
                    line1.put("borderColor",            "rgb( 11, 137, 9 )");
                    line1.put("borderWidth",            3);
                    
                    lineGlobal= new JSONObject(); 
                    lineGlobal.put("line1",             line1);
            
                    annotation= new JSONObject();  
                    annotation.put("annotations",       lineGlobal);
                    
                    
                    
                    PluginTitle= new JSONObject();
                    PluginTitle.put("title",            TitleScaleAves); 
                    PluginTitle.put("annotation",       annotation); 
                 
                    
                    ContenidoPoint= new JSONObject();
                    ContenidoPoint.put("radius",        0);
                    DataPoint= new JSONObject();
                    DataPoint.put("point",              ContenidoPoint);
                    contenido_subcategorias         = new JSONArray();
                    array_avesPadron                = new JSONArray();
                    array_aves                      = new JSONArray();
                   
                while(rs.next()) 
                { 
                    // este recorre la cantidad de registros que hay en ese mes y en ese aviario
                    contenido_subcategorias.put (   rs.getString("semanas")             );
                    array_aves.put              (   rs.getString("cantidad_aves")       );
                    array_avesPadron.put        (   rs.getString("cantidad_aves_pad")   );
                    
                } ////FIN DEL RECORRIDO LARGO
                 
                categories=new JSONArray();
                categories.put(Category);   
                
                DataAves.put(       "data",array_aves);  
                DataAvesPadron.put( "data",array_avesPadron);

                Dataset= new JSONArray();
                Dataset.put(DataAves);   
                Dataset.put(DataAvesPadron);   
                contenidoData= new JSONObject();
                data= new JSONObject(); 
                contenidoData.put("labels", contenido_subcategorias);
                contenidoData.put("datasets",    Dataset);
                contenidoData.put("datasetFill ",    false);
                contenidoData.put("lineAtIndex ",    30);
                
                
                DataScale.put(    "A",DataScaleAves);  
                DataScale.put(    "B",DataScalePadron);  
                data.put("data",contenidoData); 
                data.put("type",  "linear");
                
                dataOptions= new JSONObject();   
                dataOptions.put("scales", DataScale);
                dataOptions.put("plugins", PluginTitle );
                dataOptions.put("elements", DataPoint);
                dataOptions.put("showAllTooltips", true);

                data.put("options",dataOptions);

                dataArray.put(data);
                
                
            String     cabecera = " <table id='tb_log' class=' table'  >"
                + "<thead>"

                + "<tr><th colspan='7' style='color: #fff; background: black;'>Historial de ajustes </th></tr>"
                + "<tr>"
                + " <th  style='color: #fff; background: black;' >Fecha de ajuste</th>      "
                + " <th  style='color: #fff; background: black;' >Fecha de registro</th>      "
                + " <th  style='color: #fff; background: black;' >Semana</th>      "
                + " <th  style='color: #fff; background: black;' >Saldo nuevo</th>      "
                + " <th  style='color: #fff; background: black;' >Ajuste</th>      "
                + " <th  style='color: #fff; background: black;' >Usuario</th>      "
                + " <th  style='color: #fff; background: black;' >Comentario</th>"
                    + "</tr>      "
                
                + " </thead> "
                + " <tbody >";
                
                DecimalFormat formatea = new DecimalFormat("###,###.##");

            String grilla_html="";    
               while (rs3.next()) 
        {
            grilla_html = grilla_html
                    + "<tr > "
                    + "<td style=\"font-weight:bold\">"     +   rs3.getString("fecha_ajuste_form") + "</td>"
                    + "<td style=\"font-weight:bold\">"     +   rs3.getString("fecha_registro_form") + "</td>"
                    + "<td style=\"font-weight:bold\">"     +   rs3.getString("semana_ajuste") + "</td>"
                     + "<td style=\"font-weight:bold\">"    +   formatea.format(rs3.getInt("saldo_nuevo_form") ) + "</td>"
                     + "<td style=\"font-weight:bold\">"    +   rs3.getString("ajuste") + "</td>"
                     + "<td style=\"font-weight:bold\">"    +   rs3.getString("usuario")  + "</td>"
                    + "<td style=\"font-weight:bold\">"     +   rs3.getString("comentario") + "</td>"
                      + "</tr>";
            
         }  
                charts.put("charts", dataArray); 
                charts.put("grilla", cabecera + grilla_html + "</tbody></table>"); 
                charts.put("subtitulo",  "CARGA PPR HASTA SEMANA "+ultima_carga_ppr); 
                charts.put("semana_barra",  semana_barra); 
                charts.put("id_lote",  id_lote ); 
                
                
    
      } catch (Exception e) {
        String error=e.getMessage();
      }
      finally{
      connection.close();
      out.print(charts);
    } 
 %>
 
 