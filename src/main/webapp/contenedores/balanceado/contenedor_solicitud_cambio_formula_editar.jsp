<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 

<%    
    String version = contenedores_bal_solicitudad_cambio_formula;
    String version_desc = desc_contenedores_bal_solicitudad_cambio_formula;
    PreparedStatement ps, ps2, ps3;
    ResultSet rs, rs2,rs3;
    String id =  request.getParameter("id");
    String estado =  request.getParameter("estado");
    String desc_mtp="";
    String name_formula="";
    String cod_formula="";    
    DecimalFormat formatea = new DecimalFormat("###,###.##");
    DecimalFormat formatea2 = new DecimalFormat("###.###");
    try {
        ps = connection.prepareStatement("select *,"
                + " CASE WHEN CONVERT(VARCHAR,fecha_modificacion,103)='01/01/1900' THEN  null ELSE (CONVERT(VARCHAR,fecha_modificacion,103)) END AS fecha_modificacion_form  "
                + " from mae_bal_mtp_cab_solicitud where id="+id+"");
        rs = ps.executeQuery();
       String fecha="";
        while (rs.next()) 
        {
            
            cod_formula=rs.getString("cod_formula");
            name_formula=rs.getString("formula");
            fecha=rs.getString("fecha_modificacion_form");
        }
        rs.close();
         
        if(fecha==null){
            fecha="";
        }
        
      ps2 = connection.prepareStatement(" "
                + "    select    "
                + "        A.Code,B.ItemName,CONVERT(varchar, convert(money, B.AvgPrice), 1)   as AvgPrice ,   B.ItmsGrpCod   "
                + "    from    "
                + "        maehara.dbo.itt1 A   "
                + "        INNER JOIN  maehara.dbo.OITM B ON A.CODE=B.ItemCode      "
                + "    WHERE    "
                + "        code like '%MATP%' and code not in "
                + "         (   select  A.Code   from  maehara.dbo.itt1 A   "
                + "            INNER JOIN  maehara.dbo.OITM B ON A.CODE=B.ItemCode    "
                + "            WHERE    FATHER='" + cod_formula + "' "
                        + " ) group by   A.Code,B.ItemName ,B.AvgPrice, B.ItmsGrpCod  ");
      
        rs2 = ps2.executeQuery();
        String option="";
         while (rs2.next()) 
        {
            option = option
                    + "<option "
                    + " codigo='"+rs2.getString(1)+"'  "
                    + " descripcion='"+rs2.getString(2)+"' "
                    + " cantidad_planificada='0' "
                    + " cantidad_real='0' "
                    + " costo='"+rs2.getString(3)+"' "
                    + " grupo='4' "
                    + " codigo_formula='"+cod_formula+"' "
                    + "  value='" + rs2.getString(1) + "'> " + rs2.getString(2) + " </option> ";
        }
         rs2.close();
 

String cabecera="";
String grilla_html="";

  ps3 = connection.prepareStatement(""
                 + "    select "
          + "               codigo_formula as father,1 as childnum,codigo_mtp as Code,descripcion as itemName,cantidad_nueva, "
          + "               cantidad_actual as quantity,grupo as itmsgrpcod, accion,costo as avgprice "
          + "           from "
          + "               mae_bal_mtp_det_solicitud  "
          + "           where "
          + "               id_cab="+id+" ");

        cabecera = " <table id='tb_formulacion' class=' table-bordered compact' style='width:100%'>"
                + "<thead>"
                + "<tr>"
                + " <th  style='color: #fff; background: black;' >CODIGO</th>      "
                + " <th  style='color: #fff; background: black;' >INGREDIENTE</th>      "
                + " <th  style='color: #fff; background: black;' >DOSIS NUEVA</th>      "
                + " <th  style='color: #fff; background: black;' >DOSIS ACTUAL</th>      "
                + " <th  style='color: #fff; background: black;' >COSTO</th>      "
                + " <th  style='color: #fff; background: black;' >GRUPO</th>      "
                + " <th  style='color: #fff; background: black;' >CODIGO FORMULA</th>      " 
                + " <th  style='color: #fff; background: black;' >ACCIÓN</th>      " 
                + " </thead> "
                + " <tbody >";
        rs3 = ps3.executeQuery();
        while (rs3.next()) 
        {
            String boton= "<td style=\"font-weight:bold\">    <input id=\"BTN"+rs3.getString("Code")+"\"  type=\"button\" class=\"form-control bg-success "+rs3.getString("Code")+" \" onclick=\"calculo_grilla_edit_solicitud_bal('"+rs3.getString("Code")+"',1) \" value=\"Quitar de formula\"></td>";
             
            String td_cantidad_editable= "<td  class='single_line2 only'   style=\"font-weight:bold\" id=\""+rs3.getString("Code")+"\" "
                    + " contenteditable=\"true\" estado=\"NEUTRO\"  "
                    + "costo=\""+rs3.getString("AvgPrice").trim()+"\" "
                    + "grupo=\""+rs3.getString("ItmsGrpCod").trim()+"\"    "
                    + "ingrediente=\""+rs3.getString("ItemName").trim()+"\"    "
                    + "cantidad_historial=\""+ formatea2.format(rs3.getDouble("cantidad_nueva") ).replaceAll(",", ".") +"\"  "
                    + "cantidad_sap=\""+ formatea2.format(rs3.getDouble("quantity") ).replaceAll(",", ".") +"\"  "
                    + "grilla='true' cantidad=\""+ formatea2.format(rs3.getDouble("cantidad_nueva") ).replaceAll(",", ".")+"\">" +  formatea2.format(rs3.getDouble("cantidad_nueva") ) + "</td>";
                   
             if(rs3.getString("accion").equals("NUEVO")  )
             {
               
              boton= "<td style=\"font-weight:bold\">    <input id=\"BTN"+rs3.getString("Code")+"\"  type=\"button\" class=\"form-control bg-warning "+rs3.getString("Code")+" \"onclick=\"eliminar_fila_mtp_edit_sol('"+rs3.getString("Code")+"') \" value=\"Deshacer\"></td>";
            
             
             }
            else if(rs3.getString("accion").equals("MODIFICADO")  ){
                
                 td_cantidad_editable= "<td  class='single_line2 only'   style=\"font-weight:bold\" id=\""+rs3.getString("Code")+"\" "
                    + " contenteditable=\"true\" estado=\"MODIFICADO\"  "
                    + "costo=\""+rs3.getString("AvgPrice").trim()+"\" "
                    + "grupo=\""+rs3.getString("ItmsGrpCod").trim()+"\"    "
                    + "ingrediente=\""+rs3.getString("ItemName").trim()+"\"    "
                    + "cantidad_historial=\""+ formatea2.format(rs3.getDouble("cantidad_nueva") ).replaceAll(",", ".") +"\"  "
                    + "cantidad_sap=\""+ formatea2.format(rs3.getDouble("quantity") ).replaceAll(",", ".") +"\"  "
                    + "grilla='true' cantidad=\""+ formatea2.format(rs3.getDouble("cantidad_nueva") ).replaceAll(",", ".")+"\">" +  formatea2.format(rs3.getDouble("cantidad_nueva") ) + "</td>";
                    
            }
                   
                   
            grilla_html = grilla_html
                    + "<tr id='row"+ rs3.getString("Code") +"' > "
                    + "<td style=\"font-weight:bold\" >   " + rs3.getString("Code") + "</td>"
                    + "<td style=\"font-weight:bold\">   " + rs3.getString("ItemName") + "</td>"
                    +td_cantidad_editable
                    
                    
                    + "<td style=\"font-weight:bold\" >   " +  formatea2.format(rs3.getDouble("Quantity") ) + "</td>"
                    + "<td style=\"font-weight:bold\">   " +  rs3.getString("AvgPrice")  + "</td>"
                    + "<td style=\"font-weight:bold\">   " + rs3.getString("ItmsGrpCod") + "</td>"
                    + "<td style=\"font-weight:bold\">   " + rs3.getString("Father") + "</td>"
                    +boton
                    + "</tr>";
            
           // cantidad=cantidad+ rs3.getFloat("Quantity") ;
        }



String grilla= cabecera + grilla_html + "</tbody></table>"; 

%>

<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>', '<%=version_desc%>')">
    <label ><%=version%></label> 
</div>
</head><!-- comment -->
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy "  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                BAL
            </div>
        </div>
        <center><b>MODIFICACION DE SOLICITUD</b></center>
    </div>
</div> 

<form   method="post"  id="formulario" >

    <input type="hidden" id="id_pedido" name="id_pedido" value="<%=id%>">
    <input type="hidden" id="estado" name="estado" value="<%=estado%>">

    
 <label>Cambio realizable a partir de la fecha</label>
 <input type="text" required="required" id="fecha_solicitud" class="form-control datepicker" value="<%=fecha%>" placeholder="Ingrese fecha"> 

    
    
    <table class="table">
        <tbody>
                <td width="30%"><label>FORMULA</label>
                    <select class="form-control" id="select_formula" name="select_formula" ">
                         
                        <option class="text-center"  descripcion="<%=name_formula%>" value="<%=cod_formula%>"><%=name_formula%></option>  
                    </select>
                </td>
                <td width="50%"><label>MATERIA PRIMA</label>
                    <select class="form-control" id="select_mtp" name="select_mtp"  >
                            <%=option%>
                    </select>
                     
                </td>
                <td width="20%"> <label>-</label><input class=" form-control btn bg-red" type="button"  id="btn_solicitar" value="Agregar materia prima" onclick="add_filas_sol_edit_bal();">
                </td>
            </tr>
          
            
        </tbody>
    </table>


     

    <br>
    <div class="card card-dark " >
        <div class="card-header">
            <strong><a>INSUMOS DE FORMULACIÓN </a></strong>
        </div>

        <strong><a>Total</a></strong>
         <label  id="total_insumos" ></label>
        <strong><a>Faltantes</a></strong>
        <label  id="total_insumos_faltantes" ></label>
         
         
        
        <%=grilla%>
        
        

    </div>


    <div class="modal-footer align-right ">
        <input class="btn bg-navy" type="submit"   id="btn_solicitar" value="MODIFICAR">
    </div>

</form>

<%
    } catch (Exception e) {
        out.print(e.getMessage());
    } finally {
        connection.close();
    }%>