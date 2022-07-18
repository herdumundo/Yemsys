<%-- 
    Document   : consulta_mortandad_lotes
    Created on : 03/02/2022, 13:22:50
    Author     : aespinola
--%>

<%@page import="org.bouncycastle.jcajce.provider.asymmetric.dsa.DSASigner.detDSA"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" /><%  
     String estado="";
     String grilla_html = "";
     String cabecera = "  "
             + "  <div style='width: 100% 'class='col-12'>"
             + "<div class='card'>"
             + "   <center> "
             + "  <div   class='card-body  '>"
             + "<table id='datosnecropsiasregistrados1' class='table-bordered compact' style='width: 100% '>"
             + "<thead class='informe bg-navy'>"
             + " <tr >"
             + "<th  width='200'>Lote</th>"
             + "<th  width='200'>Nombre lote</th>"
             + "<th  width='200'>Lote pedido</th>"
             + "<th  width='200'>Aviario</th>"
             + "<th  width='200'>Estado</th>"
             + "<th  width='200'>Fecha lote nacim.</th>"
             + "<th  width='200'>Raza lote</th>"
             + "<th  width='200'></th>"
             + "<th  width='120'></th>"
             + " </tr>"
             + "  </thead>"
             + " <tbody  >";

     clases.controles.connectarBD();
      JSONObject objet = new JSONObject();
     try {
        
         PreparedStatement pt=clases.controles.connect.prepareStatement(""
                 + "select top ((select count(avi_id) from ppr_aviarios where avi_activo=1  and avi_name not like'C1%')+"
                 + "(select count(lote_id) from ppr_lotes where lote_fnac >'2022-01-20' and lote_aviario is null)) "
                 + "lote_id,lote_activo,lote_name,isnull(lote_aviario,'Lote disponible') as lote_aviario ,lote_fped,lote_cped,lote_fnac,lote_raza,lote_cped "
                 + "from  ppr_lotes where lote_activo=1 "
                 + "group by lote_id,lote_aviario,lote_fped,lote_cped,lote_crec,lote_activo,lote_fnac,lote_raza,lote_name "
                 + "order by lote_id desc");
         ResultSet rs = pt.executeQuery();

         while (rs.next()) {    
                       if(rs.getString("lote_activo").startsWith("1")){
                     estado="Activo";
                    }else{  
                     estado="Disponible";
                     }
                
 
                    grilla_html = grilla_html + "<tr class='tablagrilla'>"
                                + "<td align='center' style= 'dislay: none; ';>" + rs.getString("lote_id") + "</td>"
                                + "<td align='center' style= 'dislay: none; ';>" + rs.getString("lote_name") + " </td>"
                                + "<td align='center' style= 'dislay: none; ';>" + rs.getString("lote_cped") + " </td>"
                                + "<td align='center' style= 'dislay: none; ';>" + rs.getString("lote_aviario") + "</td>"
                                + "<td align='center' style= 'dislay: none; ';>" + estado + "</td>"
                                + "<td align='center' style= 'dislay: none; ';>" + rs.getString("lote_fnac") + " </td>"
                                + "<td align='center' style= 'dislay: none; ';>" + rs.getString("lote_raza") + "</td>"
                                + "<td align='center' style= 'dislay: none; ';>"
                                + "<button id='btnSelect' type='text' class='text-center bg-navy' onclick='edit_lotes_ppr("+rs.getString("lote_id")+",\""+rs.getString("lote_name")+"\","+rs.getString("lote_raza")+","
                                + "                                                                       "+rs.getString("lote_cped")+",\""+rs.getString("lote_fped")+"\",\""+rs.getString("lote_fnac")+"\")' >"
                                + "<i class='fa fa-search'></i> ver / editar</button>"
                                + "<input  type='hidden' id='idfecha1' name='idfecha1' ></td> "
                                + "<td align='center'  style= 'dislay: none; ';>"
                                + "<button id='btnSelect' type='text'class='text-center bg-navy' "
                                + "onclick='modificar_estado_lote_ppr("+rs.getString("lote_id")+")'>"
                                + "<i class='fa fa-delete'></i>Desactivar</button>"
                                + "<input  type='hidden' id='idfecha1' name='idfecha1' ></td> "
                                + "</tr>";
             

         }

         objet.put("grilla_a", cabecera + grilla_html + "</tbody>  </table>  </div></center></div>  </div>");

        
     } catch (Exception e) {
         }
    finally{
    out.print(objet); 
    clases.controles.DesconnectarBD();
    }
%>
