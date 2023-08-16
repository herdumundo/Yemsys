<%@page import="java.text.DecimalFormat"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../cruds/conexion.jsp" %>
<%    
    PreparedStatement pst,pst2,pst3 ;
    ResultSet rs,rs2,rs3 ;
    int contador=0;
    pst2 = connection.prepareStatement(" select * from ppr_pry_fecha");
    rs2 = pst2.executeQuery();
    String fecha="";
    String nivel_produccion="";
    String nivel_aves="";
    String clon="";
      while (rs2.next()) 
            {
              fecha=rs2.getString("fecha");
            }
    try {
            
   
    pst = connection.prepareStatement(" SELECT "
            + " t1.*,"
            + " t1.fecha_produccion     as fecha_produccion_form,"
            + " t1.fecha_nacimiento     as fecha_nacimiento_form,"
            + " t1.fecha_predescarte    as fecha_predescarte_form,"
            + " convert(varchar,t1.fecha_produccion,103)    as fecha_produccion_format,"
            + " convert(varchar,t1.fecha_nacimiento,103)    as fecha_nacimiento_format,"
            + " convert(varchar,t1.fecha_predescarte,103)    as fecha_predescarte_format"
            + " FROM "
            + " v_ppr_pry_productividad_semanas t1 "
            + " inner join  ppr_pry_cab t2 on t1.id=t2.id and t1.semanas=t2.semana_lote_barra"
            + "  /*where      t1.fecha_predescarte>'"+fecha+"'  and  t1.fecha_produccion<= '"+fecha+"'*/ ");
    rs = pst.executeQuery();
    
    
    pst3 = connection.prepareStatement(" SELECT count(t1.id) as contador FROM v_ppr_pry_productividad_semanas t1 inner join "
            + "  ppr_pry_cab t2 on t1.id=t2.id and t1.semanas=t2.semana_lote_barra"
            + " where     t1.fecha_predescarte>'"+fecha+"'  and  t1.fecha_produccion<= '"+fecha+"' ");
    rs3 = pst3.executeQuery();
     while (rs3.next()) 
            {
              contador =rs3.getInt("contador");
            }
    
    DecimalFormat formatea = new DecimalFormat("###,###.##");
    int aves_inicial=0;
    int aves_actual=0;
    int aves_padron=0;
    int promedio_semana=0;
    int huevos_padron=0;
    int huevos_carga =0;
    String color_semana="";
    String ubicacion="";
%>
         
    
 
    <table>
        <th><button type="button" class="btn bg-black btn-block btn-sm" onclick="abrir_crear_lote_proyeccion_ppr()" ><i class="fa fa-plus"></i> Nuevo lote</button> </th>
        <th>&nbsp; <label>Fecha</label>
        <input type="date"  value="<%=fecha%>" id="fecha_proyeccion_principal" onchange="modificar_fecha_carga_pry_global_ppr()"></th>
        
        <th> &nbsp;&nbsp;&nbsp;
             <input type="button"    value="Cargar venta predescarte"  onclick="ventana_venta_predescarte($('#fecha_proyeccion_principal').val())" class=" btn bg-navy" >
        </th><!-- comment -->
        <th> &nbsp;&nbsp;&nbsp;
             <input type="button"    value="Capacidades predescarte"  onclick="ventana_capacidad_pry_predescarte_ppr()" class=" btn bg-warning" >
        </th>    
    </table>

<table  id="grilla_proyeccion_lotes" class=' table-bordered compact hover' style='width:100%'>
        <thead>
        <th></th>
        <th class="text-center">Id lote</th>
        <th class="text-center">Aviario.</th>
        <th class="text-center">Lote</th>
        <th class="text-right">Aves inicial</th>
        <th class="text-right">Aves actual</th>
        <th class="text-center">Aves padron</th>
        <th class="text-center">Semana actual</th>
        <th class="text-center">Contador Orion</th>
        <th class="text-center">Huevos padron</th>
        <th class="text-center">Entrada</th>
        <th class="text-center">Salida</th>
        <th class="text-center">Ubicación</th>
  
        </thead>
        <tbody>
            <% while (rs.next()) 
            {
                if(rs.getString("ubicacion").equals("PRED"))
                {
                    clon="<h7><span class='badge badge-danger right'>"+rs.getString("ubicacion")+"</span></h7>";
                }
                else
                {
                    clon="<h7><span class='badge badge-success right'>"+rs.getString("ubicacion")+"</span></h7>";
                  }
                String boton="  <button class='btn btn-xs btn-warning' "
                        + "onclick=\"clonar_lote_predescarte("+rs.getString("id")+" ,'"+rs.getString("fecha_predescarte")+"',"
                        +rs.getString("aves_predescarte")+","//falta
                        + ""+rs.getString("edad_descarte_semanas")+","//falta
                        + "'"+rs.getString("fecha_nacimiento")+"','"
                        +rs.getString("lote")+"','"
                        +rs.getString("fecha_predescarte_format")+"')\"  title='Crear Lote Predescarte' ><i class='fa fa-clone'></i></button>";
            %>
            <tr>
                <td>
                    <button class="btn btn-xs btn-success"
                            onclick=" edit_lote_proyeccion_ppr(' <%=rs.getString("id")%>',  
                                            '<%=rs.getString("lote")%>',  
                                            '<%=rs.getString("aviario")%>',  
                                            '<%=rs.getString("aves_inicial")%>',  
                                            '<%=rs.getString("fecha_nacimiento")%>',  
                                            '<%=rs.getString("fecha_produccion")%>', 
                                            '<%=rs.getString("fecha_predescarte")%>', 
                                            '<%=rs.getString("aves_predescarte")%>', 
                                            '<%=rs.getString("edad_descarte_semanas")%>', 
                                            '<%=rs.getString("fecha_predescarte_format")%>', 
                                            '<%=rs.getString("clonado")%>'  ); 
                        ajuste_lote_proyeccion_ppr('<%=rs.getString("id")%>', '<%=rs.getString("lote")%>', '<%=rs.getString("aviario")%>', '<%=rs.getString("aves_inicial")%>', '<%=rs.getString("fecha_nacimiento")%>', '<%=rs.getString("fecha_produccion")%>', '<%=rs.getString("fecha_predescarte")%>', '<%=rs.getString("edad_descarte_dias")%>', '<%=rs.getString("semanas")%>');
                                            "  title="Editar lote"><i class="fa fa-pencil"></i></button>
                     <button class="btn btn-xs bg-navy"  data-toggle="modal" data-target="#exampleModalPreview"  onclick="grafico_proyeccion_ppr(<%=rs.getString("id")%>, '<%=rs.getString("aviario")%>', '<%=rs.getString("fecha_nacimiento_form")%>', '<%=rs.getString("fecha_produccion_form")%>', '<%=rs.getString("fecha_predescarte_form")%>', '<%=rs.getString("lote")%>', '<%=rs.getString("raza_name")%>')"  title="Visualizar grafico"><i class="fa fa-eye"></i></button>
                    <% if (rs.getString("id_lote")==null){
                     %><button class="btn btn-xs btn-danger" onclick="ppr_pro_lotes_delete(<%=rs.getString("id")%>);"  title="Eliminar lote" ><i class="fa fa-trash-o"></i></button> <%
                    }
                        %>
                </td> 
                <td class="text-center"><%=rs.getString("id")%></td>
                 <%
                if(rs.getInt("huevos_padron")>rs.getInt("huevos_carga"))
                {
                  nivel_produccion="<i class='nav-icon fas fa-arrow-circle-down text-blue' aria-hidden='true'></i>";   
                }
                else if(rs.getInt("huevos_padron")<rs.getInt("huevos_carga"))
                {
                  nivel_produccion="<i class='nav-icon fas fa-arrow-circle-up text-red' aria-hidden='true'></i>";   
                }
                else{
                  nivel_produccion="<i class='nav-icon fas fa-arrow-circle-right text-green' aria-hidden='true'></i>";   
  
                }
                 if(rs.getInt("aves_padron")>rs.getInt("aves_carga"))
                {
                  nivel_aves="<i class='nav-icon fas fa-arrow-circle-down text-blue' aria-hidden='true'></i>";   
                }
                else if(rs.getInt("aves_padron")<rs.getInt("aves_carga"))
                {
                  nivel_aves="<i class='nav-icon fas fa-arrow-circle-up text-red' aria-hidden='true'></i>";   
                }
                else{
                  nivel_aves="<i class='nav-icon fas fa-arrow-circle-right text-green' aria-hidden='true'></i>";   
  
                }
                 
                if(rs.getInt("semanas")<=18){
                   color_semana="primary"; 
                }
                else if(rs.getInt("semanas")<=44){
                   color_semana="success"; 
                }
                else if(rs.getInt("semanas")<=64){
                   color_semana="warning"; 
                }
                else 
                {
                   color_semana="danger"; 
                }


                %>
                <td class="text-center"><%=rs.getString("aviario")%></td>
                <td class="text-center"><%=rs.getString("lote")%></td>
                <td class="text-right"><%=formatea.format(rs.getInt("aves_inicial"))%></td>
                <td class="text-right"><%=nivel_aves+formatea.format(rs.getInt("aves_carga"))%></td>
                <td class="text-right"><%=formatea.format(rs.getInt("aves_padron"))%></td>
                <td class="text-center"><h5><span class='badge badge-<%=color_semana%> right'><%=rs.getString("semanas")%></span></h5> </td>
                <td class="text-right"><%=nivel_produccion+formatea.format(rs.getInt("huevos_carga"))%></td>
                <td class="text-center"><%=formatea.format(rs.getInt("huevos_padron"))%></td>
                <td class="text-center"><%=rs.getString("fecha_produccion_format")%></td>
                <td class="text-center"><%=rs.getString("fecha_predescarte_format")%></td>
                <td class="text-center"><%=clon%></td>
               
 

            </tr>
            <%   
                
            aves_inicial    = aves_inicial      +   rs.getInt("aves_inicial");
            aves_actual     = aves_actual       +   rs.getInt("aves_carga");
            aves_padron     = aves_padron       +   rs.getInt("aves_padron");
            
            
            promedio_semana = promedio_semana   +   rs.getInt("semanas");
            huevos_padron   =huevos_padron      +   rs.getInt("huevos_padron");
            huevos_carga    =huevos_carga       +   rs.getInt("huevos_carga");
                
                } %>
        </tbody>
        <tfoot>  
            <tr> 
                <td  colspan='4'></td>  
                <td class="text-right" style="font-weight: bold; background: rgb(0, 0, 0);color: #fff;"   > <%=formatea.format(aves_inicial)%> </td>  
                <td class=" text-right" style="font-weight: bold; background: rgb(0, 0, 0);color: #fff;"   >  <%=formatea.format(aves_actual)%>  </td>  
                <td class=" text-right" style="font-weight: bold; background: rgb(0, 0, 0);color: #fff;"   >  <%=formatea.format(aves_padron)%>  </td>  
                <td class=" text-center" style="font-weight: bold; background: rgb(0, 0, 0);color: #fff;"   >Promedio:  <%=promedio_semana/contador%>  </td>  
                <td class=" text-center" style="font-weight: bold; background: rgb(0, 0, 0);color: #fff;"   >  <%=formatea.format(huevos_carga) %>  </td>  
                <td class=" text-center" style="font-weight: bold; background: rgb(0, 0, 0);color: #fff;"   >  <%=formatea.format(huevos_padron) %>  </td>  
            </tr>  
           </tfoot> 
    </table>
            
            
            <%
            
            
        } catch (Exception e) 
{
out.println(e.getMessage());
        }
            %>