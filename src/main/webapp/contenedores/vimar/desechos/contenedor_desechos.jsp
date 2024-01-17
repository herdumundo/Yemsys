<%-- 
    Document   : contenedor_desechos
    Created on : 16-ene-2024, 16:19:28
    Author     : hvelazquez
--%>
<%@include  file="../../../cruds/conexion.jsp" %>


<%
    PreparedStatement ps, ps2,ps3;
    ResultSet rs;

    for (int i = 1; i <= 7; i++) {
    
String query= " select o.DocNum , convert(int,w.Quantity)  as cantidad, convert(varchar,w.DocDate,103) as fecha, w.Dscription "
+ " from  	vimar.dbo.wtr1 w   inner join vimar.dbo.owtr o on w.DocEntry=o.DocEntry  where comments='rotos linea0"+i+"'   "
+ " and o.canceled='N'  and o.DocNum  not in (select nro_transferencia  "
+ " from GrupoMaehara.dbo.desechos v where  v.nro_transferencia=o.DocNum and w.Dscription collate database_default=tipo_huevo)";

    ps = connection.prepareStatement (query);
    rs = ps.executeQuery();         

%>


<div class="row">
            <div class="col-12">

                <div class="card">
                    <div class="card-header bg-black"  data-card-widget="collapse">
                        <h3 class="card-title" >  Linea <%=i%>  </h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                             
                        </div>
                    </div>
                    <div class="card-body">
                         <input style="display: none" type="text" name="numero" value="<%=i%>">
                         <table class="table">
                             <thead>
                            <tr>
                                <th>Nro.</th> 
                                <th>Cantidad</th> 
                                <th>Fecha Transferencia</th> 
                                <th>Tipo</th> 
                                <th>Accion</th> 
                            </tr>
                             </thead>
                             <tbody>
                                 <%
                                 
        while (rs.next())
            {
            
  
                                 %>
                                 <tr>
                                     <td><h5><span class='badge badge-dark right'><%=rs.getString(1)%> </span></h5>  </td>
                                     <td><h5><span class='badge badge-dark right'><%=rs.getString(2)%> </span></h5>  </td>
                                     <td><h5><span class='badge badge-dark right'><%=rs.getString(3)%> </span></h5>  </td>
                                     <td><h5><span class='badge badge-dark right'><%=rs.getString(4)%> </span></h5>  </td>
                                     <td><h5><span class="badge badge-danger right" onclick="cuadroDesechos(<%=rs.getString(1)%>,<%=rs.getString(2)%>,'<%=rs.getString(3)%>','<%=rs.getString(4)%>','Linea <%=i%>')" >Cargar</span></h5>  </td>
                                     <% }   
                                 %>    
                                 </tr>  
                             </tbody>
                         </table>
                    </div>
 
                </div>

            </div>
        </div>

</div>

<%
    }


%>