<%@include  file="../../chequearsesion.jsp" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
    
    
<%      String usuario = (String) sesionOk.getAttribute("usuario");
        String clasificadora = (String) sesionOk.getAttribute("clasificadora");
        String user_name = (String) sesionOk.getAttribute("nombre_usuario");
        String calendario= request.getParameter("calendario");
         String disposicion=request.getParameter("combo_disposicion");
         String tipo_consulta=request.getParameter("tipo");
        
  %>
   
  <script>
         $('.record_table tr').click(function (event) {
       if (event.target.type !== 'checkbox') {
           $(':checkbox', this).trigger('click');
       }
   });

   $("input[type='checkbox']").change(function (e) {
       if ($(this).is(":checked")) {
           $(this).closest('tr').addClass("highlight_row");
       } else {
           $(this).closest('tr').removeClass("highlight_row");
       }
   });  
  //$('#tabla_rep td:last-child:contains(R)').closest('tr').css('background-color', '#FFA07A').css('.record_table tr:hover { background: #eee; }');
       $('#tabla_rep td:last-child:contains(R)').closest('tr').css('background-color', '#FFA07A');
      $('#tabla_rep td:last-child:contains(.)').closest('tr').css('background-color', '#00FFFF');
      $("tr").not(':first').hover(
              function () {
                  $(this).css("background", "yellow");
              },
              function () {
                  $('#tabla_rep td:last-child:contains(R)').closest('tr').css('background-color', '#FFA07A');
                  $('#tabla_rep td:last-child:contains(.)').closest('tr').css('background-color', '#00FFFF');
              }
      );
      //$('#tabla_rep td:last-child:contains(R)').hover("background","yellow");


  </script>
  <form method="post" id="formulario" >
            <table  id="tabla_rep" data-row-style="rowStyle" class="table record_table"data-toggle="table" data-click-to-select="true">
                <thead>
                <th >
                COD INTERNO
                </th> 
                <th >
                ESTADO COSTEO 
                </th>
                 <th >
                Nro carro
                </th><th >
                Tipo Huevo
                </th>
                <th>
                Cantidad
                </th>
                 <th>
                Disposicion
                </th>
                  <th>
                Estado
                  </th><!-- comment -->
                     <th>
                Tipo
                </th>
                <th><input type="checkbox" id="box_reproceso"> 
                <label for="box_reproceso">SELECCIONAR</label></th>
                    
                </thead>
                <tbody id="grilla_rep">
                    <%
                 clases.controles.VerificarConexion();   
                Connection cn = clases.controles.connectSesion; 
                fuente.setConexion(cn);       
                ResultSet rs = fuente.obtenerDato(" exec [mae_ptc_select_reproceso] @clasificadora='"+clasificadora+"',@fecha='"+calendario+"',@disposicion="+Integer.parseInt(disposicion)+",@tipo_consulta='"+tipo_consulta+"'");
        //NOTA: LA CONSULTA select_reproceso_ptc, HACE REFERENCIA A LAS NUEVAS TABLAS DE LOTES m_lotes.
            while(rs.next()){
                    %>  
                <tr  id="<%=rs.getString(1)%>">  
                <td><%=rs.getString(7)%></td>
                <td><%=rs.getString(8)%></td>
                <td  id="nro_carro"><%=rs.getString(2)%></td>
                <td id="tipo_huevo"><%=rs.getString(3)%></td>
                <td id="cantidad"><%=rs.getString(4)%></td>
               <td id="disposicion"><%=rs.getString(5)%></td>
               <td  id="estado"><%=rs.getString(6)%></td>
               <td><%=rs.getString(8)%></td>
                <td id="check"> <input name="checks[]" class="checkbox" type='checkbox' value="<%=rs.getString(1)%>-<%=rs.getString(7)%>-<%=rs.getString(8)%>"/></td>
                <td style="display: none" id="oculto"><%=rs.getString(6)%></td>          
                </tr> 
                <%}
                   cn.close();
clases.controles.DesconnectarBDsession();
                %>      
           
                </tbody>   
                </table>
        </form>

              
              
               
               
     