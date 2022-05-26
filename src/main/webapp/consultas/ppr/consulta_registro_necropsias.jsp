<%-- 
    Document   : consulta_mortandad_lotes
    Created on : 03/02/2022, 13:22:50
    Author     : csanchez
--%>

<%@page import="org.bouncycastle.jcajce.provider.asymmetric.dsa.DSASigner.detDSA"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.Connection"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page" /><%

SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd");
 //   SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
    String desde = request.getParameter("desde_necropsias");
    String hasta = request.getParameter("hasta_necropsias");
    

    //2022-01-02
    

 DecimalFormat df = new DecimalFormat("0.0");
 DecimalFormat formatea = new DecimalFormat("###,###.##");
    
    String lote_id = "";
    String lote_name = "";
    String saldo_aves = "";
    String lote_fnac = "";
    String fecha_80_sems = "";
    Date fecha;
    double score= 0;
    String miles = "";
    String grilla_html = "";
    String cabecera = "  "
           + "  <div style='width: 100% 'class='col-12'>"
           + "<div class='card'>"
           + "   <center> "
           + "  <div   class='card-body  '>"
           + "<table id='datosnecropsiasregistrados1' class='table-bordered compact' style='width: 100% '>"
           + "<thead class='informe bg-navy'>"
           + " <tr >"
                + "<th  width='200'>Fecha</th>"
                + "<th  width='200'>Lote</th>"
                + "<th  width='200'>Aviario</th>"
                + "<th  width='200'>P.H.M</th>"
                + "<th  width='200'>Enter.</th>"
                + "<th  width='200'>Molleja</th>"
                + "<th  width='200'>Higado</th>"
                + "<th  width='300'></th>"
                + "<th  width='150'></th>"
           + " </tr>"
           + "  </thead>"
           + " <tbody  >" ;   
   
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    try {
         JSONObject objet = new JSONObject();                            
        objet = new JSONObject();
        PreparedStatement pt = clases.controles.connectSesion.prepareStatement("exec [stp_mae_ppr_select_necropsias] @desde='"+desde+"', @hasta='"+hasta+"'");
        ResultSet rs2 = pt.executeQuery();
        
        while (rs2.next()) {    //phm enteritis molleja higado
           
            fecha=rs2.getDate("fecha");
             grilla_html = grilla_html + "<tr class='tablagrilla'><td id='fecha2' align='center'style= 'dislay: none; ';>"
            + rs2.getString("fecha") +"  </td> <td id='lote2'align='center' style= 'dislay: none; ';>  "
            + rs2.getString("lote") +"   </td><td id='aviario2'align='center' id='3'  style= 'dislay: none; ';> "
            + rs2.getString("aviario")+"</td><td align='center'  style= 'dislay: none; ';>  "
            + df.format(rs2.getDouble("phm_max"))+"-"+ df.format(rs2.getDouble("phm_pro"))+"-"+ df.format(rs2.getDouble("phm_min"))+"</td><td align='center'  style= 'dislay: none; ';>  "
            + df.format(rs2.getDouble("enteritis_max"))+"-"+ df.format(rs2.getDouble("enteritis_pro"))+"-"+ df.format(rs2.getDouble("enteritis_min"))+"</td><td align='center'  style= 'dislay: none; ';>  "
            + df.format(rs2.getDouble("molleja_max"))+"-"+ df.format(rs2.getDouble("molleja_pro"))+"-"+ df.format(rs2.getDouble("molleja_min"))+"</td><td align='center'  style= 'dislay: none; ';>  "
            + df.format(rs2.getDouble("higado_max"))+"-"+ df.format(rs2.getDouble("higado_pro"))+"-"+ df.format(rs2.getDouble("higado_min"))+"</td>"
            + "<td align='center'  style= 'dislay: none; ';>"  
            + "<button id='btnSelect' type='text'class='text-center bg-navy' "
            + "onclick='traer_vista_necropsias_score_ppr("+rs2.getString("pnecsco_nec")+","+rs2.getDate("fecha")+") '>"
            + "<i class='fa fa-search'></i> ver / editar</button>"
            + "<input  type='hidden' id='idfecha1' name='idfecha1' ></td> "
            + "<td align='center'  style= 'dislay: none; ';>"  
            + "<button id='btnSelect' type='text'class='text-center bg-navy' "
            + "onclick='modificar_necropsias_ppr("+rs2.getString("idlote")+")'>"
            + "<i class='fa fa-delete'></i>Borrar</button>"
            + "<input  type='hidden' id='idfecha1' name='idfecha1' ></td> "
            + "</tr>";
             
           
        
            lote_id = rs2.getString("fecha");
          

        }
        
              
        objet.put("grilla_a", miles+cabecera + grilla_html + "</tbody>  </table>  </div></center></div>  </div>" );

        objet.put("fecha", lote_id);
        
        
   

        out.print(objet);
    } catch (Exception e) {
        String asda = e.getMessage();
    }

%>
