 
<%@page import="clases.variables"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<% 
    int res_out=1;
    int res_out2=0;
    int identity=0;
    int resultad_final=1;
            
    String tipo_mensaje="";
    clases.controles.connectarBD();   
    Connection cn = clases.controles.connect; 
    fuente.setConexion(cn);  
    String destino= request.getParameter("destino") ;
    String valor= request.getParameter("valor") ;
    String tipo_transferencia=request.getParameter("tipo_transferencia");
    String fecha=request.getParameter("fecha");
    String nombre_usuario=(String)sesionOk.getAttribute("nombre_usuario");
    int id_camion=0;
    // int cantidad=0;
    int tipo_huevo_int=0;

    String camion="";
    String chofer="";
    String estado_costeo="";

    int id_chofer=0;
    String cbox_camion=request.getParameter("cbox_camion");
    String cbox_chofer=request.getParameter("cbox_chofer");
    String area=(String)sesionOk.getAttribute("clasificadora");
    String mensaje="";
    try 
    { 
          cn.setAutoCommit(false);
          int unidad_medida=0;
          int tipo_huevo=0;
          String tipo_huevo_conte="";
          int cantidad=0;
          String cod_lote="";
          int cod_interno=0;
          String cod_carrito="";
          String estado_liberacion="";
          String valores_coma="";
          String motivo="";
          
          String[] txt_contenido_grilla_array = valor.split("&"); 
          String[] txt_contenido_chofer_array = cbox_camion.split("-"); 
          String[] txt_contenido_camion_array = cbox_chofer.split("-"); 
          
          for(int i=0; i<txt_contenido_chofer_array.length; i++)
                            {
                       id_chofer=Integer.valueOf(txt_contenido_chofer_array[0]);
                       chofer=txt_contenido_chofer_array[1];
                            }
          for(int i=0; i<txt_contenido_camion_array.length; i++)
                            {
                          id_camion=Integer.valueOf( txt_contenido_camion_array[0]);
                           camion=txt_contenido_camion_array[1];
                            }
          
          CallableStatement  callableStatement=null;   
          callableStatement = cn.prepareCall("{call mae_ptc_insert_cab_transferenciaLotes( ?, ?, ?, ?, ?, ?, ?, ?, ?,?,? )}" );
          callableStatement .setString(1,destino);
          callableStatement .setString(2, area);
          callableStatement .setString(3,nombre_usuario);
          callableStatement .setInt(4,id_camion);
          callableStatement .setString(5,camion);
          callableStatement .setInt(6,id_chofer);
          callableStatement .setString(7,chofer);
          callableStatement .setString(8,tipo_transferencia);
          callableStatement .setString(9,fecha);
          
          callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
          callableStatement.registerOutParameter("identity", java.sql.Types.INTEGER);
          callableStatement.execute();
          res_out2 = callableStatement.getInt("mensaje");
          identity = callableStatement.getInt("identity");
        
          for(int i=0; i<txt_contenido_grilla_array.length; i++)
                {
                        valores_coma=txt_contenido_grilla_array[i];
                        String[] sub_valores_array = valores_coma.split("-"); 
                        cod_interno = Integer.parseInt( sub_valores_array[0]);
                        cod_lote =  sub_valores_array[1];
                        cod_carrito =  sub_valores_array[2];
                        estado_liberacion =  sub_valores_array[3];
                        motivo=sub_valores_array[4];
                        estado_costeo=sub_valores_array[5];
                        cantidad=Integer.parseInt(sub_valores_array[6]);
                        tipo_huevo_conte= sub_valores_array[7] ; 


                        if(tipo_huevo_conte.equals("A")){
                        tipo_huevo=4;
                        }
                        else if(tipo_huevo_conte.equals("B")){
                        tipo_huevo=5;
                        }else if(tipo_huevo_conte.equals("C")){
                        tipo_huevo=6;
                        }else if(tipo_huevo_conte.equals("D")){
                        tipo_huevo=7;
                        }else if(tipo_huevo_conte.equals("S")){
                        tipo_huevo=3;
                        }else if(tipo_huevo_conte.equals("J")){
                        tipo_huevo=2;
                        }else if(tipo_huevo_conte.equals("G")){
                        tipo_huevo=1;
                        }

                   callableStatement = cn.prepareCall("{call mae_ptc_insert_det_transferenciaLotes( ?, ?, ?, ?, ? ,?,?,?,?,?,?,?)}");
                  callableStatement .setInt(1,identity);//cabecera.
                  callableStatement .setInt(2, cod_interno);
                  callableStatement .setString(3,cod_lote);
                  callableStatement .setString(4, cod_carrito);
                  callableStatement .setString(5, estado_liberacion);
                  callableStatement .setString(6, destino);
                  callableStatement .setString(7, motivo);
                  callableStatement .setString(8, estado_costeo);
                  callableStatement .setString(9, tipo_transferencia);
                  callableStatement .setInt(10, cantidad);
                  callableStatement .setInt(11, tipo_huevo);
                  callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER); 
                  callableStatement.execute();
                  res_out = callableStatement.getInt("mensaje");

                  //valor_estado=valor_estado+estado_lote;
                  resultad_final=resultad_final*res_out;  
               
           }
                
                 
          if (resultad_final==0)
          {
             cn.rollback(); 
             mensaje="ERROR, INTENTE DE NUEVO!";
             tipo_mensaje="0";
          }   
          else 
          {
            //     cn.rollback(); 
            cn.commit();
               mensaje="TRANSFERENCIA REALIZADA CON EXITO!";
               tipo_mensaje="1";
          }
   
     
          } catch (Exception e) {
      
      cn.rollback();
      mensaje=e.toString();
      tipo_mensaje="3";
       }
          
   JSONObject ob = new JSONObject();
          
   ob=new JSONObject();
          ob.put("tipo", tipo_mensaje);
          ob.put("mensaje", mensaje);
          
      
   out.print(ob); 
      %>  
   
 
