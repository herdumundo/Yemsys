<%@include  file="../../../versiones.jsp" %>
<%@include  file="../../../chequearsesion.jsp" %>
<%@include  file="../../../cruds/conexion.jsp" %> 
<%@ page contentType="application/json; charset=utf-8" %>
<%
    String linea = (String) sesionOk.getAttribute("clasificadora");
   //c String linea = "LINEA04";
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    String filas="";
    int c=0;
    int tipo=0;
    String contenedor="";
        try {
         ResultSet rs;
         Statement st = connection.createStatement();
         rs = st.executeQuery("select distinct m.id,m.nro_carro,m.cantidad_actual, convert(char(10), v.InDate, 103) as fecha, "
            + "ar.U_TIPOHUEVO  "
            + "from "
            + " carros_asignados m with(nolock) , "
            + "vimar.dbo.obtn v     with(nolock) "
            + "inner join vimar.dbo.oitm ar   with(nolock) on v.itemcode=ar.itemcode "
            + "inner join vimar.dbo.obbq b    with(nolock) on v.AbsEntry=b.SnBMDAbs and b.WhsCode='CEN002'  "
            + "where "
            + "m.cod_lote=v.DistNumber collate database_default and "
            + "m.estado='A' and m.linea='"+linea+"' and m.cantidad_actual>0 "
            + "order by 2");
     
            while (rs.next())
            {
               filas=filas+"<tr id='"+rs.getString(1)+"'>    "
                    + "<td style='font-weight: bold;' onclick='detalle_fallas("+rs.getString(1)+","+rs.getString(2)+");'>"+rs.getString(2)+"</td> "
                    + " <td style='font-weight: bold;' onclick='detalle_fallas("+rs.getString(1)+","+rs.getString(2)+");'>"+rs.getString(3)+"</td>   "
                    + "<td style='font-weight: bold;' onclick='detalle_fallas("+rs.getString(1)+","+rs.getString(2)+");'>" +rs.getString(4)+"</td> "
                    + "<td style='font-weight: bold;' onclick='detalle_fallas("+rs.getString(1)+","+rs.getString(2)+");'>"+rs.getString(5)+"</td> "
                    + "<td>  "
                    + "<a  class='btn btn-success btn-icon-split'  data-toggle='modal' data-target='#cuadro1' onclick='enviar_id_modal("+rs.getString(2)+","+rs.getString(1)+");' > "
                    + " <span class='icon text-white-50'>  <i class='fas fa-info-circle'></i>  </span>  <span class='text'>Cargar</span>  </a> </td>   "
                    + "<td> "
                    + "<a   class='btn btn-warning btn-icon-split' onclick='finalizar_fallas("+rs.getString(1)+","+rs.getString(2)+");'>  "
                    + "<span class='icon text-white-50'>  <i class='fas fa-exclamation-triangle'></i>  "
                    + "</span> <span class='text'>Finalizar</span>  "
                    + " </a> </td>    </tr> ";
                    c++; 
            }   
           
            if (c>0){
                
                   contenedor=" <table id='table' class='display responsive nowrap' style='width:100%'> "
                +               "<thead> "
                +               "<tr>   "
                +               "<th>   " 
                +               "Carro  " 
                +               "</th>  " 
                +               "<th>   " 
                +               "Cantidad " 
                +               "</th> " 
                +               "<th > " 
                +               "Fecha puesta " 
                +               "</th> " 
                +               "<th> " 
                +               "Tipo " 
                +               "</th> " 
                +               "<th>Fallas</th> <th>Finalizar</th> " 
                +               "</tr> "
                +               "</thead> "
                +               "<tbody> "
                +               ""+filas+" </tbody> </table> "; 
                 tipo=1;
            }
    
            else {
                
           contenedor=" <div style='font-weight: bold;' class='alert alert-warning alert-dismissible fade show' role='alert'> NO SE ENCONTRARON RESULTADOS </div>  ";
           tipo=0;
           
            
            }
         } catch (Exception e) {
               contenedor=" <div style='font-weight: bold;' class='alert alert-warning alert-dismissible fade show' role='alert'> "+e.toString()+" </div>  ";
         
            }    
        ob.put("contenido",contenedor);
        ob.put("tipo",tipo);
        out.print(ob);
       %>
       
       
       
