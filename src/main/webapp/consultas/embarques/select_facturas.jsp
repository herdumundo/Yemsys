
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page contentType="application/json; charset=utf-8" %>
 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>   
 <%@include  file="../../chequearsesion.jsp" %>

<%

    clases.controles.connectarBD();   
    Connection cn = clases.controles.connect;
    fuente. setConexion(cn);  
    
    String area =(String) sesionOk.getAttribute("area");
    String numero_factura = request.getParameter("numero");  
    ResultSet rs,res_fac_cant; 
            
    int caja_tipo_A = 0;
    int caja_tipo_B = 0;
    int caja_tipo_C = 0;
    int caja_tipo_D = 0;
    int caja_tipo_J = 0;
    int caja_tipo_S = 0;
    int caja_tipo_G = 0;

    int total_cajon_g = 0;
    int total_cajon_j = 0;
    int total_cajon_s = 0;
    int total_cajon_a = 0;
    int total_cajon_b = 0;
    int total_cajon_c = 0;
    int total_cajon_d = 0;

       //CAMBIAR BASE DE DATOS                  //CAMBIAR BASE DE DATOS       
         
    int total_carros=0;
    rs = fuente.obtenerDato("select  case itemcode when 1 then sum(convert(int,(b.Quantity)*12)/180) "
              + "else sum(convert(int,(b.Quantity)*12)/360) end as 'cantidad', ItemCode  "
              + "from "
            + "      "+clases.variables.BD2+".dbo.oinv a  with(nolock)  "
              + "   inner join  "+clases.variables.BD2+".dbo.inv1 b  with(nolock) on a.DocEntry=b.DocEntry  "
              + "where      "
              + " a.DocStatus='o'"
              + "and b.WhsCode='"+area+"'  "
              + "and a.NumAtCard='"+numero_factura+"'"
              + "group by ItemCode");
    while(rs.next())
        { 

            total_carros=total_carros+rs.getInt("cantidad");

        }
         
            res_fac_cant = fuente.obtenerDato(" select  case itemcode when 1 then sum(convert(int,(b.Quantity-isnull(b.delivrdqty,0))*12)) else 0 end as 'G', "
                    + "case itemcode when 2 then sum(convert(int,(b.Quantity-isnull(b.delivrdqty,0))*12)) else 0 end as 'j',           "
                    + "case itemcode when 3 then sum(convert(int,(b.Quantity-isnull(b.delivrdqty,0))*12)) else 0 end as 's', "
                    + "case itemcode when 4 then sum(convert(int,(b.Quantity-isnull(b.delivrdqty,0))*12)) else 0 end as 'a',           "
                    + "case itemcode when 5 then sum(convert(int,(b.Quantity-isnull(b.delivrdqty,0))*12)) else 0 end as 'b', "
                    + "case itemcode when 6 then sum(convert(int,(b.Quantity-isnull(b.delivrdqty,0))*12)) else 0 end as 'c',       "
                    + "case itemcode when 7 then sum(convert(int,(b.Quantity-isnull(b.delivrdqty,0))*12)) else 0 end as 'd'  "
                    + "from  "+clases.variables.BD2+".dbo.oinv a  with(nolock)  "
                            + " inner join  "+clases.variables.BD2+".dbo.inv1 b  with(nolock) on a.DocEntry=b.DocEntry "
                    + "where b.InvntSttus='o'   "
                    + "and   a.DocStatus='o'and b.WhsCode='"+area+"' and a.NumAtCard='"+numero_factura+"' group by ItemCode");
              String total_restante="";
            while(res_fac_cant.next())
                { 
                  
                    caja_tipo_G = res_fac_cant.getInt("G");
                    caja_tipo_J =  res_fac_cant.getInt("j");
                    caja_tipo_S =  res_fac_cant.getInt("s");
                    caja_tipo_A =  res_fac_cant.getInt("a");
                    caja_tipo_B =  res_fac_cant.getInt("b");
                    caja_tipo_C =  res_fac_cant.getInt("c");
                    caja_tipo_D =  res_fac_cant.getInt("d");

                    total_cajon_g = caja_tipo_G + total_cajon_g;
                    total_cajon_j = caja_tipo_J + total_cajon_j;
                    total_cajon_s = caja_tipo_S + total_cajon_s;
                    total_cajon_a = caja_tipo_A + total_cajon_a;
                    total_cajon_b = caja_tipo_B + total_cajon_b;
                    total_cajon_c = caja_tipo_C + total_cajon_c;
                    total_cajon_d = caja_tipo_D + total_cajon_d;
                }
              
              
            total_restante="A_"+total_cajon_a+",B_"+total_cajon_b+",C_"+total_cajon_c+",D_"+total_cajon_d+",S_"+total_cajon_s+",J_"+total_cajon_j+",G_"+total_cajon_g+"";
            JSONObject ob = new JSONObject();
            ob=new JSONObject();
            ob.put("codigo", total_restante);
            ob.put("total", total_carros/12);
            cn.close();
            clases.controles.DesconnectarBD();
            out.print(ob);

%>

   