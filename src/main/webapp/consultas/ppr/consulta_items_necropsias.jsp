<%-- 
    Document   : consulta_mortandad_lotes
    Created on : 03/02/2022, 13:22:50
    Author     : csanchez
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql .PreparedStatement"%>
<%@page import="java.sql .ResultSet"%>
<%@page import="java.sql .Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql .Connection"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page" /><%
 String id_necrop_score = request.getParameter("score_id");
    
    String lote_id = "";
    String lote_name = "";
    String saldo_aves = "";
    String lote_fnac = "";
    String edad_sem = "";
    int item =1;
    String merma = "";
   
    String miles = "";
    String grilla_html = "";
    String cabecera = "";
   
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    try {//'"+desde+"'
         JSONObject objet = new JSONObject();                            
        objet = new JSONObject();
       
      
          PreparedStatement pt = clases.controles.connectSesion.prepareStatement
        ("select pneci_id ave, pneci_abbr items from ppr_necropsias_items");
        ResultSet rs2 = pt.executeQuery();
      
        cabecera =cabecera+ "  "
           + "<thead class='informe bg-navy'>"
           + " <tr >"
           + "<th  class='text-center'>Ave nro.</th>"; 
       
             while (rs2.next()) {    //phm enteritis molleja higado
             cabecera =cabecera+ "  "
            + "<th  class='text-center'>"+rs2.getString("items") +"</th>"; 
             
             
              if(rs2.getString("ave").startsWith("1")){
             grilla_html = grilla_html + "<tr class='tablagrilla'><td align='center'style= 'dislay: none; ';>"+rs2.getString("ave")+"</td>"
            + " <td  contenteditable='true' style='background-color: #ffddb8'  id='"+id_necrop_score+",1,1'  align='center' style= 'dislay: none; ';>   </td>"
            + " <td  contenteditable='true' style='background-color: #ffddb8'  id='"+id_necrop_score+",1,2'  align='center' style= 'dislay: none; ';>   </td>"
            + " <td contenteditable='true' style='background-color: #ffddb8'  id='"+id_necrop_score+",1,3'   align='center' style= 'dislay: none; ';>   </td>"
            + " <td contenteditable='true' style='background-color: #ffddb8'  id='"+id_necrop_score+",1,4'   align='center' style= 'dislay: none; ';>   </td>"
            + " <td><button class='bg-navy' onclick='consulta_necropsias_imagen_ppr("+id_necrop_score+","+rs2.getString("ave")+");'>ver archivos</button></td> "
            + "</tr>"
            ;}
                if(rs2.getString("ave").startsWith("2")){
             grilla_html = grilla_html + "<tr class='tablagrilla'><td align='center'style= 'dislay: none; ';>"+rs2.getString("ave") +"</td>"
            + " <td contenteditable='true' style='background-color: #ffddb8' id='"+id_necrop_score+",2,1'align='center' style= 'dislay: none; ';>   </td>"
            + " <td contenteditable='true' style='background-color: #ffddb8' id='"+id_necrop_score+",2,2'align='center' style= 'dislay: none; ';>   </td>"
            + " <td contenteditable='true' style='background-color: #ffddb8' id='"+id_necrop_score+",2,3'align='center' style= 'dislay: none; ';>   </td>"
            + " <td contenteditable='true' style='background-color: #ffddb8' id='"+id_necrop_score+",2,4'align='center' style= 'dislay: none; ';>   </td>"
            + " <td><button class='bg-navy' onclick='consulta_necropsias_imagen_ppr("+id_necrop_score+","+rs2.getString("ave")+");'>ver archivos</button></td> "
            + "</tr>"
            ;}
                  if(rs2.getString("ave").startsWith("3")){
             grilla_html = grilla_html + "<tr class='tablagrilla'><td align='center'style= 'dislay: none; ';>"+rs2.getString("ave") +"</td>"
            + " <td contenteditable='true' style='background-color: #ffddb8' id='"+id_necrop_score+",3,1' align='center' style= 'dislay: none; ';>   </td>"
            + " <td contenteditable='true' style='background-color: #ffddb8' id='"+id_necrop_score+",3,2' align='center' style= 'dislay: none; ';>   </td>"
            + " <td contenteditable='true' style='background-color: #ffddb8' id='"+id_necrop_score+",3,3' align='center' style= 'dislay: none; ';>   </td>"
            + " <td contenteditable='true' style='background-color: #ffddb8' id='"+id_necrop_score+",3,4' align='center' style= 'dislay: none; ';>   </td>"
            + " <td><button class='bg-navy' onclick='consulta_necropsias_imagen_ppr("+id_necrop_score+","+rs2.getString("ave")+");'>ver archivos</button></td> "
            + "</tr>"
            ;}
              if(rs2.getString("ave").startsWith("4")){
             grilla_html = grilla_html + "<tr class='tablagrilla'><td align='center'style= 'dislay: none; ';>"+rs2.getString("ave") +"</td>"
            + " <td contenteditable='true' style='background-color: #ffddb8' id='"+id_necrop_score+",4,1' align='center' style= 'dislay: none; ';>   </td>"
            + " <td contenteditable='true' style='background-color: #ffddb8' id='"+id_necrop_score+",4,2' align='center' style= 'dislay: none; ';>   </td>"
            + " <td contenteditable='true' style='background-color: #ffddb8' id='"+id_necrop_score+",4,3' align='center' style= 'dislay: none; ';>   </td>"
            + " <td contenteditable='true' style='background-color: #ffddb8' id='"+id_necrop_score+",4,4' align='center' style= 'dislay: none; ';>   </td>"
            + " <td><button class='bg-navy' onclick='consulta_necropsias_imagen_ppr("+id_necrop_score+","+rs2.getString("ave")+");'>ver archivos</button></td> "
            + "</tr>"
            ;}
         
          
           }
     
         objet.put("grilla_a", cabecera 
            + "<th  class='text-center'></th></tr></thead> <tbody >"
            +grilla_html +"</tbody>"
            +"<tfoot>"
            +"<td colspan='6' style='padding-top:10px;'>"
            + "<button id='btn_agre_ave' class=' bg-navy' onclick='necropsias_nuevafila_ppr();'>agregar ave</button>"
            + "<input type='hidden' value="+id_necrop_score+" id='necrop_id'>" 
            + "<input type='hidden' value='1'  id='1lastsco'>"
            + "</td>"
            +"</tfoot>"  );
        objet.put("fecha", lote_id);
        objet.put("edad", edad_sem);
        
        
   

        out.print(objet);
    } catch (Exception e) {
        String asda = e.getMessage();
    }

%>
