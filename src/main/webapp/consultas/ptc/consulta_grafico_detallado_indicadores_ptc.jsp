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
   // String tipo_grafico_ptc= "bar";//request.getParameter("tipo_grafico_cla") ;
    String[] array_clasificadora_ptc= request.getParameterValues("clasif_cla");
    String grilla_html="";
   // String clasificadora="";
        JSONObject GlobalPTC = null;             

   try {
      StringBuilder clasificadorasBuilder = new StringBuilder();
 
for (String clasificadora : array_clasificadora_ptc) {
    if (clasificadorasBuilder.length() > 0) {
        clasificadorasBuilder.append(",");
    }
    clasificadorasBuilder.append(clasificadora);
}

    GlobalPTC= new JSONObject();                

    String query ="  exec [MAE_PTC_INDICADORES_GRAFICO] "
            + "@area            ='"+clasificadorasBuilder +"',     "
            + "@fecha_inicio    ='"+fecha_desde_ptc+"',  "
            + "@fecha_fin       ='"+fecha_hasta_ptc+"'   ";
   
     String query_grilla="  exec [MAE_PTC_INDICADORES_CYO_DETALLADO2] "
            + "@area            ='"+clasificadorasBuilder +"',     "
            + "@fecha_inicio    ='"+fecha_desde_ptc+"',  "
            + "@fecha_fin       ='"+fecha_hasta_ptc+"'   ";
     
    PreparedStatement pt_grilla=connection.prepareStatement(query_grilla);
    ResultSet rs_grilla=pt_grilla.executeQuery();
    
    
    PreparedStatement pt=connection.prepareStatement(query);
    ResultSet rs=pt.executeQuery();
    
    
    while(rs.next()) 
    { 
        GlobalPTC.put("PTC",            rs.getString("PTCX"));
        GlobalPTC.put("REPROCESOS",     rs.getString("RPX"));
        GlobalPTC.put("SUBPRODUCTOS",   rs.getString("PIX"));
        GlobalPTC.put("ROTOS",          rs.getString("RX"));
        GlobalPTC.put("F",              rs.getString("FX"));
        GlobalPTC.put("FFC",            rs.getString("FFCX"));
        GlobalPTC.put("OT",             rs.getString("OTX"));
        GlobalPTC.put("PS",             rs.getString("PSX"));
        GlobalPTC.put("PM",             rs.getString("PMX"));
        GlobalPTC.put("EC",             rs.getString("ECX"));
        GlobalPTC.put("SS",             rs.getString("S/SX"));
        GlobalPTC.put("S",              rs.getString("SX"));
        GlobalPTC.put("A",              rs.getString("AX"));
        GlobalPTC.put("B",              rs.getString("BX"));
        GlobalPTC.put("C",              rs.getString("CX"));
        GlobalPTC.put("D",              rs.getString("DX"));
        GlobalPTC.put("SUPER",          rs.getString("SUPERX"));
        GlobalPTC.put("J",              rs.getString("JX"));
        GlobalPTC.put("G",              rs.getString("GX"));
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
                   + "<td>"+rs_grilla.getString("CP")+"</td>"
                   + "<td>"+rs_grilla.getString("SL")+"</td>"
                   + "<td>"+rs_grilla.getString("RP")+"</td>"
                   + "<td>"+rs_grilla.getString("F")+"</td>"
                   + "<td>"+rs_grilla.getString("FFC")+"</td>"
                   + "<td>"+rs_grilla.getString("OT")+"</td>"
                   + "<td>"+rs_grilla.getString("R")+"</td>"
                    + "<td>"+rs_grilla.getString("PM")+"</td>"
                   + "<td>"+rs_grilla.getString("PS")+"</td>" 
                   + "<td>"+rs_grilla.getString("PI")+"</td>"
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
                   + "<td>"+rs_grilla.getString("RPX")+"</td>"
                   + "<td>"+rs_grilla.getString("FX")+"</td>"
                   + "<td>"+rs_grilla.getString("FFCX")+"</td>"
                   + "<td>"+rs_grilla.getString("OTX")+"</td>"
                   + "<td>"+rs_grilla.getString("RX")+"</td>"
                   + "<td>"+rs_grilla.getString("PMX")+"</td>"
                   + "<td>"+rs_grilla.getString("PSX")+"</td>"
                   + "<td>"+rs_grilla.getString("PIX")+"</td>"
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
 
 
 
 
 
 
                                         