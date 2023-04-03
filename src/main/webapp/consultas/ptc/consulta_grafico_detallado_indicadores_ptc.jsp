<%-- 
    Document   : datos
    Created on : 02-ene-2022, 19:57:59
    Author     : aespinola
--%>
<%@include  file="../../cruds/conexion.jsp" %> 
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8"%>
 
<% 
    String fecha_desde_ptc= request.getParameter("fecha_desde_cla") ;
    String fecha_hasta_ptc= request.getParameter("fecha_hasta_cla") ;
    String tipo_grafico_ptc= "bar";//request.getParameter("tipo_grafico_cla") ;
    String[] array_clasificadora_ptc= request.getParameterValues("clasif_cla");
    String grilla_html="";
    String clasificadora="";
        JSONObject GlobalPTC = null;             

   try {
      
    for(int i=0; i<array_clasificadora_ptc.length; i++)   
    {
        if (array_clasificadora_ptc.length > 0)
        {
            if(i==0)
            {
                clasificadora=""+array_clasificadora_ptc[i]+"";  
            }
            else 
            {
                clasificadora=clasificadora  + "," +array_clasificadora_ptc[i]+""; 
            }
        }
    } 
    GlobalPTC= new JSONObject();                

    String query ="  exec [MAE_PTC_INDICADORES_SUB_TEST] "
            + "@area            ='"+clasificadora +"',     "
            + "@fecha_inicio    ='"+fecha_desde_ptc+"',  "
            + "@fecha_fin       ='"+fecha_hasta_ptc+"'   ";
   
     String query_grilla="  exec [MAE_PTC_INDICADORES_CYO_DETALLADO] "
            + "@area            ='"+clasificadora +"',     "
            + "@fecha_inicio    ='"+fecha_desde_ptc+"',  "
            + "@fecha_fin       ='"+fecha_hasta_ptc+"'   ";
     
    PreparedStatement pt_grilla=connection.prepareStatement(query_grilla);
    ResultSet rs_grilla=pt_grilla.executeQuery();
    
    
    PreparedStatement pt=connection.prepareStatement(query);
    ResultSet rs=pt.executeQuery();
    
    
    while(rs.next()) 
    { 
        GlobalPTC.put("PTC",            rs.getString("PTC"));
        GlobalPTC.put("REPROCESOS",     rs.getString("RP"));
        GlobalPTC.put("SUBPRODUCTOS",   rs.getString("PI"));
        GlobalPTC.put("ROTOS",          rs.getString("R"));
        GlobalPTC.put("F",              rs.getString("F"));
        GlobalPTC.put("FFC",            rs.getString("FFC"));
        GlobalPTC.put("OT",             rs.getString("OT"));
        GlobalPTC.put("PS",             rs.getString("PS"));
        GlobalPTC.put("PM",             rs.getString("PM"));
        GlobalPTC.put("EC",             rs.getString("EC"));
        GlobalPTC.put("SS",             rs.getString("S/S"));
        GlobalPTC.put("S",              rs.getString("S"));
        GlobalPTC.put("A",              rs.getString("A"));
        GlobalPTC.put("B",              rs.getString("B"));
        GlobalPTC.put("C",              rs.getString("C"));
        GlobalPTC.put("D",              rs.getString("D"));
        GlobalPTC.put("SUPER",          rs.getString("SUPER"));
        GlobalPTC.put("J",              rs.getString("J"));
        GlobalPTC.put("G",              rs.getString("G"));
    }  
    
    
    
  String cabecera=""
            + " <table id='tb_grilla' class='table-bordered  display' style='width:100%'>"
            + "     <thead>"
            + "         <tr>"
            + "             <th style='color: #fff; background: black;' >DIA</th>      "
            + "             <th style='color: #fff; background: black;' >FECHA DE CLASIF.</th> "
            + "             <th style='color: #fff; background: black;' >Tipo A</th> "
            + "             <th style='color: #fff; background: black;' >Tipo B </th> "
            + "             <th style='color: #fff; background: black;' >Tipo C</th> "
            + "             <th style='color: #fff; background: black;' >Tipo 4TA</th> "
            + "             <th style='color: #fff; background: black;' >Tipo SUPER</th> "
            + "             <th style='color: #fff; background: black;' >Tipo JUMBO</th> "
            + "             <th style='color: #fff; background: black;' >Tipo GIGANTE</th> "
            + "             <th style='color: #fff; background: black;' >TOTAL PTC</th> "
            + "             <th style='color: #fff; background: black;' >Semi Sucio</th> "
            + "             <th style='color: #fff; background: black;' >Sucio</th> "
            + "             <th style='color: #fff; background: black;' >Error de codificación</th> "
            + "             <th style='color: #fff; background: black;' >Cepillado</th> "
            + "             <th style='color: #fff; background: black;' >Segundo lavado</th> "
            + "             <th style='color: #fff; background: black;' >Total RP</th> "
            + "             <th style='color: #fff; background: black;' >Fisurados</th> "
            + "             <th style='color: #fff; background: black;' >FFC</th> "
            + "             <th style='color: #fff; background: black;' >Otros</th> "
            + "             <th style='color: #fff; background: black;' >ROTOS</th> "
            + "             <th style='color: #fff; background: black;' >PM</th> "
            + "             <th style='color: #fff; background: black;' >PS</th> "
            + "             <th style='color: #fff; background: black;' >TOTAL DE SUBTOS</th> "
            + "             <th style='color: #fff; background: black;' >% Tipo A </th> "
            + "             <th style='color: #fff; background: black;' >% Tipo B</th> "
            + "             <th style='color: #fff; background: black;' >% Tipo C</th> "
            + "             <th style='color: #fff; background: black;' >% Tipo 4TA</th> "
            + "             <th style='color: #fff; background: black;' >% Tipo SUPER</th> "
            + "             <th style='color: #fff; background: black;' >% Tipo JUMBO</th> "
            + "             <th style='color: #fff; background: black;' >% Tipo GIGANTE</th> "
            + "             <th style='color: #fff; background: black;' >% PTC/DIA </th> "
            + "             <th style='color: #fff; background: black;' >% S/S</th> "
            + "             <th style='color: #fff; background: black;' >% Sucios</th> "
            + "             <th style='color: #fff; background: black;' >% Error de codificación</th> "
            + "             <th style='color: #fff; background: black;' >% Total RP</th> "
            + "             <th style='color: #fff; background: black;' >% Fisurados</th> "
            + "             <th style='color: #fff; background: black;' >% FFC</th> "
            + "             <th style='color: #fff; background: black;' >% Otros</th> "
            + "             <th style='color: #fff; background: black;' >% ROTOS</th> "
            + "             <th style='color: #fff; background: black;' >% PM</th> "
            + "             <th style='color: #fff; background: black;' >% PS</th> "
            + "             <th style='color: #fff; background: black;' >% SUBTOS ACUMULATIVO</th> "
            + "         </tr>"
            + "     </thead> "
            + "     <tbody>";    
    
        while(rs_grilla.next())
        {
            grilla_html=grilla_html+
           "<tr   >"
                   + "<td>"+rs_grilla.getString("fecha_nombre")+"</td>"
                   + "<td>"+rs_grilla.getString("fecha")+"</td>"
                   + "<td>"+rs_grilla.getString("AX")+"</td>"
                   + "<td>"+rs_grilla.getString("BX")+"</td>"
                   + "<td>"+rs_grilla.getString("CX")+"</td>"
                   + "<td>"+rs_grilla.getString("DX")+"</td>"
                   + "<td>"+rs_grilla.getString("SUPERX")+"</td>"
                   + "<td>"+rs_grilla.getString("JX")+"</td>"
                   + "<td>"+rs_grilla.getString("GX")+"</td>"
                   + "<td>"+rs_grilla.getString("PTCX")+"</td>"
                   + "<td>"+rs_grilla.getString("S/SX")+"</td>"
                   + "<td>"+rs_grilla.getString("SX")+"</td>"
                   + "<td>"+rs_grilla.getString("ECX")+"</td>"
                   + "<td>"+rs_grilla.getString("CPX")+"</td>"
                   + "<td>"+rs_grilla.getString("SLX")+"</td>"
                   + "<td>"+rs_grilla.getString("RPX")+"</td>"
                   + "<td>"+rs_grilla.getString("FX")+"</td>"
                   + "<td>"+rs_grilla.getString("FFCX")+"</td>"
                   + "<td>"+rs_grilla.getString("OTX")+"</td>"
                   + "<td>"+rs_grilla.getString("RX")+"</td>"
                    + "<td>"+rs_grilla.getString("PMX")+"</td>"
                   + "<td>"+rs_grilla.getString("PSX")+"</td>" 
                   + "<td>"+rs_grilla.getString("PIX")+"</td>"
                   + "<td>"+rs_grilla.getString("A")+"</td>"
                   + "<td>"+rs_grilla.getString("B")+"</td>"
                   + "<td>"+rs_grilla.getString("C")+"</td>"
                   + "<td>"+rs_grilla.getString("D")+"</td>"
                   + "<td>"+rs_grilla.getString("SUPER")+"</td>"
                   + "<td>"+rs_grilla.getString("J")+"</td>"
                   + "<td>"+rs_grilla.getString("G")+"</td>"
                   + "<td>"+rs_grilla.getString("PTC")+"</td>"
                   + "<td>"+rs_grilla.getString("S/S")+"</td>"
                   + "<td>"+rs_grilla.getString("S")+"</td>"
                   + "<td>"+rs_grilla.getString("EC")+"</td>"
                   + "<td>"+rs_grilla.getString("RP")+"</td>"
                   + "<td>"+rs_grilla.getString("F")+"</td>"
                   + "<td>"+rs_grilla.getString("FFC")+"</td>"
                   + "<td>"+rs_grilla.getString("OT")+"</td>"
                   + "<td>"+rs_grilla.getString("R")+"</td>"
                   + "<td>"+rs_grilla.getString("PM")+"</td>"
                   + "<td>"+rs_grilla.getString("PS")+"</td>"
                   + "<td>"+rs_grilla.getString("PI")+"</td>"
             + " </tr>";
         }
    
         GlobalPTC.put("grilla",cabecera+grilla_html+"</tbody></table>");
    
                 
    } catch (Exception e) 
    {
        String error=e.getMessage();
    }
finally{
    out.print(GlobalPTC);
    connection.close();
}

              
           
            
         
 %>
 
 
 
 
 
 
                                         