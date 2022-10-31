<%@page import="java.text.DecimalFormat"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../cruds/conexion.jsp" %>
<%    
    PreparedStatement pst ;
    ResultSet rs ;
    pst = connection.prepareStatement(" select * from v_mae_ppr_cuadro_lotes_pry");
    rs = pst.executeQuery();
    DecimalFormat formatea = new DecimalFormat("###,###.##");
    int aves_inicial=0;
    int aves_actual=0;
    int promedio_semana=0;
%>
<table  id="grilla_proyeccion_lotes" class=' table-bordered compact hover' style='width:100%'>
        <thead>
        <th></th>
        <th class="text-center">Aviario.</th>
        <th class="text-center">Fecha nacimiento</th>
        <th class="text-center">Lote</th>
        <th class="text-right">Aves inicial</th>
        <th class="text-right">Aves actual</th>
        <th class="text-center">Semana actual</th>
        <th class="text-center">Edad produccion (dias)</th>
        <th class="text-center">Fecha produccion</th>
        <th class="text-center">Fecha predescarte</th>
  
        </thead>
        <tbody>
            <% while (rs.next()) 
            {%>
            <tr>
                <td>
                    <button class="btn btn-xs btn-success"onclick="edit_lote_proyeccion_ppr('<%=rs.getString("id")%>', '<%=rs.getString("lote")%>', '<%=rs.getString("aviario")%>', '<%=rs.getString("cantidad_aves")%>', '<%=rs.getString("fecha_nacimiento")%>', '<%=rs.getString("fecha_produccion")%>', '<%=rs.getString("fecha_predescarte")%>')"  title="Editar lote"><i class="fa fa-pencil"></i></button>
                    <button class="btn btn-xs btn-warning"   onclick="ajuste_lote_proyeccion_ppr('<%=rs.getString("id")%>', '<%=rs.getString("lote")%>', '<%=rs.getString("aviario")%>', '<%=rs.getString("cantidad_aves")%>', '<%=rs.getString("fecha_nacimiento")%>', '<%=rs.getString("fecha_produccion")%>', '<%=rs.getString("fecha_predescarte")%>', '<%=rs.getString("dias_predescarte")%>', '<%=rs.getString("semanas_predescarte")%>')" title="Ajuste de Saldo de aves"><i class="fa fa-calculator"></i></button>
                    <button class="btn btn-xs bg-navy"  data-toggle="modal" data-target="#exampleModalPreview"  onclick="grafico_proyeccion_ppr(<%=rs.getString("id")%>, '<%=rs.getString("aviario")%>', '<%=rs.getString("fecha_nacimiento_form")%>', '<%=rs.getString("fecha_produccion_form")%>', '<%=rs.getString("fecha_predescarte_form")%>', '<%=rs.getString("lote")%>', '<%=rs.getString("raza_name")%>')"  title="Visualizar grafico"><i class="fa fa-eye"></i></button>
                    <% if (rs.getString("nuevo").equals("1")){
                     %><button class="btn btn-xs btn-danger" onclick="ppr_pro_lotes_delete(<%=rs.getString("id")%>);"  title="Eliminar lote" ><i class="fa fa-trash-o"></i></button> <%
                    }
                        %>
                    
                </td>                
                <td class="text-center"><%=rs.getString("aviario")%></td>
                <td class="text-center"><%=rs.getString("fecha_nacimiento_form")%></td>
                <td class="text-center"><%=rs.getString("lote")%></td>
                <td class="text-right"><%=formatea.format(rs.getInt("cantidad_aves"))%></td>
                <td class="text-right"><%=formatea.format(rs.getInt("cantidad_semana_lote"))%></td>
                <td class="text-center"><%=rs.getString("semana_lote_barra")%></td>
                <td class="text-center"><%=rs.getString("edad_produccion_dias")%></td>
                <td class="text-center"><%=rs.getString("fecha_produccion_form")%></td>
                <td class="text-center"><%=rs.getString("fecha_predescarte_form")%></td>
               
 

            </tr>
            <%   
                
            aves_inicial = aves_inicial +   rs.getInt("cantidad_aves");
            aves_actual = aves_actual +     rs.getInt("cantidad_semana_lote");
            promedio_semana = promedio_semana +     rs.getInt("semana_lote_barra");
  
                
                } %>
        </tbody>
        <tfoot>  
            <tr> 
                <td  colspan='4'></td>  
                <td class="text-right" style="font-weight: bold; background: rgb(0, 0, 0);color: #fff;"   > <%=formatea.format(aves_inicial)%> </td>  
                <td class=" text-right" style="font-weight: bold; background: rgb(0, 0, 0);color: #fff;"   >  <%=formatea.format(aves_actual)%>  </td>  
                <td class=" text-center" style="font-weight: bold; background: rgb(0, 0, 0);color: #fff;"   >Promedio:  <%=promedio_semana/20%>  </td>  
            </tr>  
           </tfoot> 
    </table>