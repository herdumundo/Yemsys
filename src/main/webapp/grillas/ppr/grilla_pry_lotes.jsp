<%@page import="java.text.DecimalFormat"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../cruds/conexion.jsp" %>
<%    
    PreparedStatement pst,pst2 ;
    ResultSet rs,rs2 ;
     pst2 = connection.prepareStatement(" select * from ppr_pry_fecha");
    rs2 = pst2.executeQuery();
    String fecha="";
    
    pst = connection.prepareStatement(" select "
            + "                             t1.*,huevos_padron,t2.huevos_carga  "
            + "                         from "
            + "                         v_mae_ppr_cuadro_lotes_pry t1 "
            + "                         left join  v_ppr_pry_productividad_semanas t2 on t1.id=t2.id_cab and t1.semana_lote_barra =t2.semanas");
    rs = pst.executeQuery();
    
    while (rs2.next()) 
            {
              fecha=rs2.getString("fecha");
            }
    
    
    DecimalFormat formatea = new DecimalFormat("###,###.##");
    int aves_inicial=0;
    int aves_actual=0;
    int promedio_semana=0;
    int huevos_padron=0;
    int huevos_carga =0;
%>

<div class="card-header">
    <label>Fecha</label>
    <input type="date" class="form-control" value="<%=fecha%>" id="fecha_proyeccion_principal" onchange="modificar_fecha_carga_pry_global_ppr()">
</div><!-- comment -->



<table  id="grilla_proyeccion_lotes" class=' table-bordered compact hover' style='width:100%'>
        <thead>
        <th></th>
        <th class="text-center">Aviario.</th>
        <th class="text-center">Fecha nacimiento</th>
        <th class="text-center">Lote</th>
        <th class="text-right">Aves inicial</th>
        <th class="text-right">Aves actual</th>
        <th class="text-center">Semana actual</th>
        <th class="text-center">Huevos cargas</th>
        <th class="text-center">Huevos padron</th>
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
                <td class="text-center"><%=formatea.format(rs.getInt("huevos_carga"))%></td>
                <td class="text-center"><%=formatea.format(rs.getInt("huevos_padron"))%></td>
                <td class="text-center"><%=rs.getString("edad_produccion_dias")%></td>
                <td class="text-center"><%=rs.getString("fecha_produccion_form")%></td>
                <td class="text-center"><%=rs.getString("fecha_predescarte_form")%></td>
               
 

            </tr>
            <%   
                
            aves_inicial    = aves_inicial      +   rs.getInt("cantidad_aves");
            aves_actual     = aves_actual       +   rs.getInt("cantidad_semana_lote");
            promedio_semana = promedio_semana   +   rs.getInt("semana_lote_barra");
            huevos_padron   =huevos_padron      +   rs.getInt("huevos_padron");
            huevos_carga    =huevos_carga       +   rs.getInt("huevos_carga");
                
                } %>
        </tbody>
        <tfoot>  
            <tr> 
                <td  colspan='4'></td>  
                <td class="text-right" style="font-weight: bold; background: rgb(0, 0, 0);color: #fff;"   > <%=formatea.format(aves_inicial)%> </td>  
                <td class=" text-right" style="font-weight: bold; background: rgb(0, 0, 0);color: #fff;"   >  <%=formatea.format(aves_actual)%>  </td>  
                <td class=" text-center" style="font-weight: bold; background: rgb(0, 0, 0);color: #fff;"   >Promedio:  <%=promedio_semana/21%>  </td>  
                <td class=" text-center" style="font-weight: bold; background: rgb(0, 0, 0);color: #fff;"   >  <%=formatea.format(huevos_carga) %>  </td>  
                <td class=" text-center" style="font-weight: bold; background: rgb(0, 0, 0);color: #fff;"   >  <%=formatea.format(huevos_padron) %>  </td>  
            </tr>  
           </tfoot> 
    </table>