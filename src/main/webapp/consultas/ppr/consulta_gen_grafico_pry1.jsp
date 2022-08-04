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
    String aviario =  request.getParameter ("aviario");;
     JSONObject charts = new JSONObject();
    
    Statement st,st2,st3;
    ResultSet rs,rs2,rs3 ;
    int min=0;
    int max=0;
    st=connection.createStatement();
    st2=connection.createStatement();
    st3=connection.createStatement();
    
    rs=st.executeQuery("select * from ppr_pry_det 	where id in ( 	select id 	from ( 			select max(id) as id,semanas  from	ppr_pry_det where id_cab="+id+" group by semanas 		)  d )" );
    rs2=st2.executeQuery(" select min(cantidad_aves) as min,max(cantidad_aves) as max from ppr_pry_det 	where id_cab="+id );
    rs3=st3.executeQuery("select *, format(convert(date,fecha),'dd/MM/yyyy') as fecha_form from ppr_pry_det 	where     id_cab="+id +" and comentario is not null" );
 
      while(rs2.next()) 
                {
                    min=rs2.getInt("min");
                    max=rs2.getInt("max");
                    
                } 
        JSONObject DataScale= new JSONObject();
         
        JSONObject  contenidoData,          dataOptions,        data,
                    DataMortandad,          DataAgua,          DataC, 
                   DataB, DataD,                  ticksA,             ticksB,  
                    ticksC,                 ticksD,             TitleB,
                    TitleC,                 TitleD,             ContenidoTitle,
                    DataTitle,              ContenidoPoint,     DataPoint,
                    Category                = new JSONObject();
      
        JSONArray   categories,             Dataset,            contenido_subcategorias, 
                    contenido_balanceados,  contenido_mortandad, 
                    dataArray               = new JSONArray();         
                          
                    String aviarios=(aviario);
                    
                    DataMortandad = new JSONObject();
                    
                    DataMortandad.put("label",  "Aves");
                    DataMortandad.put("yAxisID","A");
                    DataMortandad.put("backgroundColor",    "rgb(186, 6, 6)");
                    DataMortandad.put("borderColor",  "rgb(186, 6, 6)");
                    DataMortandad.put("borderWidth",  2);
                    DataMortandad.put("type",  "line");
                    
                    DataAgua= new JSONObject();
                    DataAgua.put("label",  "Aves padron");
                    DataAgua.put("yAxisID","A");
                    DataAgua.put("backgroundColor",    "rgb(132, 132, 132)");
                    DataAgua.put("borderColor",  "rgb(132, 132, 132)");
                    DataAgua.put("borderWidth",  2);
                    DataAgua.put("type",  "line");
                    
                    
                    DataB= new JSONObject();                
                    DataB.put("type",    "linear");
                    DataB.put("display",    true);
                    DataB.put("position",    "right");
                    DataB.put("min",    min-1000);
                    DataB.put("max",    max);
                    
                    TitleB= new JSONObject();                
                    TitleB.put("display",    true);
                    TitleB.put("text",    "Aves padron");
                    DataB.put("title",    TitleB);
                    ticksB= new JSONObject(); 
                    ticksB.put("stepSize",    25);
                    DataB.put("ticks",    ticksB);
                 
                    DataC= new JSONObject();                
                    DataC.put("type",    "linear");
                    DataC.put("display",    true);
                    DataC.put("position",    "right");
                    DataC.put("min",    min-1000);
                    DataC.put("max",    max);
                    TitleC= new JSONObject();                
                    TitleC.put("display",    true);
                    TitleC.put("text",    "Aves");
                    DataC.put("title",    TitleC);
                    ticksC= new JSONObject(); 
                    ticksC.put("stepSize",    1000);
                    
                    DataC.put("ticks",    ticksC);
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
                   
                while(rs.next()) 
                { 
                    // este recorre la cantidad de registros que hay en ese mes y en ese aviario
                    
                    
                    contenido_subcategorias.put(rs.getString("semanas"));
                    contenido_mortandad.put(rs.getString("cantidad_aves"));
                    contenido_balanceados.put(rs.getString("cantidad_aves_pad"));
                    
                 } ////FIN DEL RECORRIDO LARGO
                 
                categories=new JSONArray();
                categories.put(Category);   
                
                DataMortandad.put(      "data",contenido_mortandad);  
                DataAgua.put(           "data",contenido_balanceados);

                Dataset= new JSONArray();
                Dataset.put(DataMortandad);   
                Dataset.put(DataAgua);   
                contenidoData= new JSONObject();
                data= new JSONObject();
                contenidoData.put("labels", contenido_subcategorias);
                contenidoData.put("datasets",    Dataset);
                DataScale.put(    "A",DataC);  
                DataScale.put(    "B",DataB);  
                data.put("data",contenidoData);
                data.put("type",  "bar");
                dataOptions= new JSONObject();   
                dataOptions.put("scales", DataScale);
                dataOptions.put("plugins", DataTitle);
                dataOptions.put("elements", DataPoint);
                dataOptions.put("showAllTooltips", true);

                data.put("options",dataOptions);

                dataArray.put(data);
                
                
                
                
            String     cabecera = " <table id='tb_log' class=' table'  >"
                + "<thead>"

                + "<tr><th colspan='5' style='color: #fff; background: black;'>Historial de ajustes </th></tr>"
                + "<tr>"
                + " <th  style='color: #fff; background: black;' >Fecha</th>      "
                + " <th  style='color: #fff; background: black;' >Semana</th>      "
                + " <th  style='color: #fff; background: black;' >Saldo nuevo</th>      "
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
                    + "<td style=\"font-weight:bold\">" +   rs3.getString("fecha_form") + "</td>"
                    + "<td style=\"font-weight:bold\">" +   rs3.getString("semanas") + "</td>"
                    + "<td style=\"font-weight:bold\">" +   formatea.format(rs3.getInt("cantidad_aves") ) + "</td>"
                    + "<td style=\"font-weight:bold\">" +   rs3.getString("usuario")  + "</td>"
                    + "<td style=\"font-weight:bold\">" +   rs3.getString("comentario") + "</td>"
                      + "</tr>";
            
         }  
                
                
                
                
                
                
                
                
                charts.put("charts", dataArray); 
                charts.put("grilla", cabecera + grilla_html + "</tbody></table>"); 
         
                out.print(charts); 
 %>
 
 