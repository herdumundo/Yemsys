<%@include  file="../../../versiones.jsp" %>
<%@include  file="../../../chequearsesion.jsp" %>
<%@include  file="../../../cruds/conexion.jsp" %>   

<%  String version = "";
    String version_desc = "";
    String linea = (String) sesionOk.getAttribute("clasificadora");
   // String linea = "LINEA04";
    String linea_parte_final = linea.replace("LINEA0", "");
    ResultSet rs;
    Statement st = connection.createStatement();
    rs = st.executeQuery("select b.sysnumber, a.whscode, b.itemcode, b.distnumber, b.MnfSerial, "
            + "b.LotNumber,b.InDate,convert(numeric(12,0), a.onhandqty) as quantity,"
            + "c.SL1Code, c.AbsEntry,b.itemName "
            + "from  "
            + "vimar.dbo.obbq a with(nolock) "
            + "inner join vimar.dbo.obtn b with(nolock) on a.snbmdabs = b.absentry "
            + "inner join vimar.dbo.obin c with(nolock) on a.binabs = c.absentry "
            + "where "
            + "a.onhandqty >= 360 and a.whscode = 'CEN002' "
            + "and c.SL1Code='" + linea + "'  "
            + "and b.distnumber collate database_default not in (select cod_lote from GrupoMaehara.dbo.carros_asignados v with(nolock) where estado in ('A','C','F') "
            + "and linea='" + linea + "' and cantidad_actual<>0)");


%>
<head>
<label ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>', '<%=version_desc%>')">
    <label ><%=version%></label> 
</div> 
</head>
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                VIM
            </div>
        </div>
        <center><b>ASIGNACION DE CARROS A LINEAS</b></center>
    </div>
</div>

<div class="input-group">
    <input type="button" class="form-control btn btn-success"  data-toggle="modal" data-target="#modal_inicio_produccion"   value="Iniciar produccion">
    <span class="input-group-addon">-</span>
    <input type="button"  class="form-control btn btn-dark"  data-toggle="modal" data-target="#modal_fin_produccion" value="Finalizar produccion"  >
</div>

<form id="form_asignar_carros"   method="POST"> 
    <br>
    <div id="div_cbox_carro"> 
        SELECCIONE CARRO
        <div id="combo" class="form-group">
            <select  name="cbox_carro"   id="cbox_carro" class="form-control"  multiple="multiple" required >
                <% while (rs.next()) {
                %>        
                <option value="<%=rs.getString(5)%>-<%=rs.getString(8)%>-<%=rs.getString(4)%>"><%=rs.getString(5)%> - <%=rs.getString(11)%>- Cantidad:<%=rs.getString(8)%></option>
                <%  }
                %> 
            </select>
        </div>
    </div>
    <input type="submit" class="form-control" value="UTILIZAR CARROS" >
</form>



<form id="form_inicio_produccion"  method="POST">
    <div class="modal fade" id="modal_inicio_produccion" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <div id="div_cbox_op"> 
                        INICIAR ORDEN DE PRODUCCION
                        <div id="combo" class="form-group">            
                            <select  name="cbox_inicio"   id="cbox_inicio" class="form-control" required>
                                <%
                                    ResultSet rs1;
                                    Statement st1 = connection.createStatement();
                                    rs1 = st1.executeQuery(" select o.docnum,o.itemcode, right(oi.codebars,3) as codebars from vimar.dbo.owor o,vimar.dbo.oitm oi "
                                            + "where  o.itemcode=oi.itemcode and  (convert(varchar,o.duedate,103)=convert(varchar,getdate(),103) or convert(varchar, o.duedate,103)=convert(varchar, dateadd(d, -1, getdate()),103)) "
                                            + "and U_MAQUINA ='L" + linea_parte_final + "' and o.status='R'   and o.docnum not in (select  nro_produccion "
                                            + "from GrupoMaehara.dbo.parada_produccion where linea='" + linea + "'  and estado in ('a','c','p'))  ");
                                    while (rs1.next()) {
                                %>      
                                <option value="<%=rs1.getString(1)%>-<%=rs1.getString(3)%>"><%=rs1.getString(1)%> ||TIPO:<%=rs1.getString(2)%> ||  COD. BARRA: <%=rs1.getString(3)%></option>
                                <%  }
                                %> 
                            </select>
                        </div>
                    </div> 
                </div>
                <input type="submit" class=" form-control btn-success" value="Registrar"   >
            </div>
        </div>  
    </div>
</form> 

<form id="form_prod_cierre"  method="POST">
    <div class="modal fade" id="modal_fin_produccion" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <div id="div_cbox_op"> 
                        FINALIZAR ORDEN DE PRODUCCION
                        <div id="combo" class="form-group">
                            <select  name="cbox_op_fin"   id="cbox_op_fin" class="form-control" required >
                                <%
                                    ResultSet rs2;
                                    Statement st2 = connection.createStatement();
                                    rs2 = st2.executeQuery(" select  nro_produccion,paquete from GrupoMaehara.dbo.parada_produccion where linea='" + linea + "' and estado in ('a')");

                                    while (rs2.next()) {
                                %>    
                                <option value="<%=rs2.getString(1)%>"><%=rs2.getString(1)%> ||COD. BARRA:<%=rs2.getString(2)%></option>
                                <%}
                                %> 
                            </select>
                        </div>
                    </div>
                </div>
                <input type="submit" class="form-control btn-success" value="Registrar"  >
            </div>
        </div>  
    </div>
</form> 