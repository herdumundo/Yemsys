<%@page import="clases.fuentedato"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%@include  file="../../versiones.jsp" %>
<%
    String version =  contenedores_ptc_stock_cyo;
    String version_desc =  desc_contenedores_ptc_stock_cyo;
%>
<label  ><b></b></label>
<div class="float-right d-none d-sm-inline-block" href="#" id="contenido_version"
     data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>', '<%=version_desc%>')" >
    <label neme="label_contenido" id="label_contenido" ><%=version%></label>  
</div>
</head>
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                PTC
            </div>
        </div>
        <center><b>STOCK CYO</b></center>
    </div>
</div>  <br>  



<div id="contenido_grilla"> 

</div>

