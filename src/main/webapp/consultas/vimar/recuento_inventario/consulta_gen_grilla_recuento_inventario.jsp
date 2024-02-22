<%-- 
    Document   : contenedor_desechos
    Created on : 16-ene-2024, 16:19:28
    Author     : hvelazquez
--%>
<%@include  file="../../../cruds/conexion.jsp" %>
<%   
 
    String ubicacion = request.getParameter("ubicacion");
    PreparedStatement ps, psDetalle;
    ResultSet rs, rsDetalle;
    String query = "  SELECT DISTINCT T0.ItemCode,T0.ItemName,CONVERT(INT,T1.U_CanCaja) AS U_CanCaja FROM vimar.dbo.oibt T0 INNER JOIN VIMAR.DBO.OITM T1 ON T0.ItemCode=T1.ItemCode where  T0.whscode='" + ubicacion + "' and Quantity>0 ";
    ps = connection.prepareStatement(query);
    rs = ps.executeQuery();
    while (rs.next()) {
       // String query2 = " select BatchNum,convert(int,Quantity ) as Quantity,isnull(conteo,0) as  conteo, convert(int,(Quantity-isnull(conteo,0)) ) as diferencia from vimar.dbo.oibt T1 LEFT OUTER JOIN vim_recuento_invetario_pendiente T2 ON T1.BatchNum COLLATE DATABASE_DEFAULT=T2.LOTE and estado='P' where  whscode='" + ubicacion + "' and Quantity>0  and t1.ItemCode='" + rs.getString("ItemCode") + "' ";
        
        String query2="    select  BatchNum,convert(int,Quantity ) as Quantity,isnull(conteo,0) as  conteo, convert(int,(Quantity-isnull(conteo,0)) ) as diferencia,isnull(TIPOLOTE,'') as TIPOLOTE,isnull(contado,'NO') as contado    "
        + " from  vimar.dbo.oibt T1 LEFT OUTER   JOIN vim_recuento_invetario_pendiente T2 ON T1.BatchNum COLLATE DATABASE_DEFAULT=T2.LOTE and T1.ItemCode COLLATE DATABASE_DEFAULT=T2.ItemCode  and estado='P'  where  whscode='"+ubicacion+"' and Quantity>0  and t1.ItemCode='"+rs.getString("ItemCode")+"' 	"
        + "                 UNION ALL "
        + "                 select  LOTE COLLATE DATABASE_DEFAULT AS BatchNum,convert(int,cantidad ) as Quantity,isnull(conteo,0) as  conteo, "
        + " convert(int,(cantidad-isnull(conteo,0)) ) as diferencia ,TIPOLOTE,isnull(contado,'NO') as contado   "
        + " from vim_recuento_invetario_pendiente where  ubicacion='"+ubicacion+"'   and  ItemCode='"+rs.getString("ItemCode")+"' AND TIPOLOTE='LOTE MANUAL' and estado<>'C'    "; 
        
        psDetalle = connection.prepareStatement(query2);
        rsDetalle = psDetalle.executeQuery();
%>
<div class="row">
    <div class="col-12">

        <div class="card collapsed-card">
            <div class="card-header bg-black"  data-card-widget="collapse">
                <h3 class="card-title" >  <%=rs.getString("ItemCode")%> - <%=rs.getString("ItemName")%>  <%if(rs.getInt("U_CanCaja")>1){ %> ,CAJAS DE <%=rs.getString("U_CanCaja")%><%}%>  </h3>
                <div class="card-tools">
                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                        <i class="fas fa-plus"></i>
                    </button>

                </div>
            </div>
            <div class="card-body" id="card<%=rs.getString("ItemCode")%>">
                <button type="button" class="bg-success " onclick="cuadroRecuentoInventarioNuevoLoteVimar('<%=rs.getString("ItemCode")%>','<%=ubicacion%>','<%=rs.getInt("U_CanCaja")%>')" >
                    <i class="fas fa-plus"></i>
                </button>
                <table class="table" id="<%=rs.getString("ItemCode")%>">
                    <thead>
                        <tr>
                        <th>LOTE</th> 
                        <th>SAP</th> 
                        <th>DIFERENCIA</th> 
                        <th>CONTEO</th> 

                        </tr>
                    </thead>
                    <tbody id="tbody<%=rs.getString("ItemCode")%>">
                        <%
                            while (rsDetalle.next()) {
                        %>   
                        <tr>
                        <td onclick="cuadroRecuentoInventarioVimar('<%=rsDetalle.getString("BatchNum")%>', '<%=rsDetalle.getString("Quantity")%>', '<%=ubicacion%>', '<%=rs.getString("ItemCode")%>','<%=rs.getInt("U_CanCaja")%>')"><%=rsDetalle.getString("BatchNum")%></td>
                        <td><%=rsDetalle.getString("Quantity")%></td>
                        <td>
                            <%  if(rsDetalle.getInt("diferencia")>=0 && rsDetalle.getString("contado").equals("SI")) {%> <h5><span class="badge badge-danger right"><%=rsDetalle.getString("diferencia")%></span></h5> <%} 
                                else if (rsDetalle.getInt("conteo")==0&& rsDetalle.getString("contado").equals("NO")) {%> <h5><span class="badge badge-warning right"><%=rsDetalle.getString("diferencia")%></span></h5> <%} 
                                else {%> <h5><span class="badge badge-success right"><%=rsDetalle.getString("diferencia")%></span></h5> <%}%>
                           
                            
                        </td>
                        <td><%=rsDetalle.getString("conteo")%> 
                        <% if(rsDetalle.getString("TIPOLOTE").equals("LOTE MANUAL")){ %>  <i class="fas fa-trash " onclick="eliminarLoteNuevoRecuentoInventario('<%=ubicacion%>','<%=rsDetalle.getString("BatchNum")%>','<%=rs.getString("ItemCode")%>','<%=rs.getInt("U_CanCaja")%>')" style="color: red"></i> <%} %>  </td>

                        </tr>  
                        <%
                            }
                        %> 
                    </tbody>
                </table>
            </div>

        </div>

    </div>
</div>
</div>
<%
    }

    connection.close();
 
%>