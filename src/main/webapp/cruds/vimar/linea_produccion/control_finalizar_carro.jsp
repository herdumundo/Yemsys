<%@include  file="../../../versiones.jsp" %>
<%@include  file="../../../chequearsesion.jsp" %>
<%@include  file="../../../cruds/conexion.jsp" %> 
<%@ page contentType="application/json; charset=utf-8" %>
<%
    //Connection cn = conexion.crearConexion();
    //fuente.setConexion(cn);
      
    int id= Integer.parseInt(request.getParameter("id"));
    int tipo_respuesta=0;
    String mensaje="";
        try {
                
           
                connection.setAutoCommit(false);
                CallableStatement  callableStatement=null;   
                    callableStatement = connection.prepareCall("{call [vim_prod_fallas_finalizar_carro](?,?,? )}");
                    callableStatement .setInt(1,   id );
                    callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
                    callableStatement.registerOutParameter("detalle_mensaje", java.sql.Types.VARCHAR);
                    callableStatement.execute();

                    tipo_respuesta = callableStatement.getInt("mensaje");
                    mensaje = callableStatement.getString("detalle_mensaje");

                   if(tipo_respuesta==0){
                       connection.rollback();
                   } 

                   else{
                       //cn.rollback();
                       connection.commit();
                   }                    
           
       
                
            } catch (Exception e) {
                connection.rollback();
                mensaje=e.toString();
            }
            JSONObject ob = new JSONObject();
            ob=new JSONObject();
            ob.put("tipo", tipo_respuesta);
            ob.put("mensaje",mensaje);
            out.print(ob);  %>  