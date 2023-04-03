<%@page import="java.text.DecimalFormat"%>
<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%    
    DecimalFormat formatea = new DecimalFormat("###,###.##");
    DecimalFormat formatea2 = new DecimalFormat("###.###");
    JSONObject ob = new JSONObject();
    String grilla_html = "";
    String cabecera = "";
     try 
     {
        String father =  request.getParameter("father");
        ResultSet rs_GM;
        Statement st = connection.createStatement();
        float cantidad =0; 
         rs_GM = st.executeQuery(""
                 + "    select   "
                 + "        A.Father,A.ChildNum,A.Code,B.ItemName,  A.Quantity  "
                 + "   /* case  "
                 + "        when len(convert(varchar,convert(int,A.Quantity)))=3 "
                 + "            then left(convert(varchar, A.Quantity),7) "
                 + "        when len(convert(varchar,convert(int,A.Quantity)))=2 "
                 + "            then left(convert(varchar, A.Quantity),6) "
                 + "    else   "
                 + "        left(convert(varchar, A.Quantity),5) end as Quantity */ , "
                 + "       "
                 + "      B.AvgPrice ,B.ItmsGrpCod "
                 + "    from  "
                 + "        maehara.dbo.itt1 A with (nolock) "
                 + "        INNER JOIN  maehara.dbo.OITM B with (nolock) ON A.CODE=B.ItemCode "
                 + "    WHERE  "
                 + "        FATHER='"+father+"'  ");

        cabecera = " <table id='tb_formulacion' class=' table-bordered compact display' style='width:100%'>"
                + "<thead>"

                + ""
                + "<tr>"
                + " <th  style='color: #fff; background: black;' >CODIGO</th>      "
                + " <th  style='color: #fff; background: black;' >INGREDIENTE</th>      "
                + " <th  style='color: #fff; background: black;' >DOSIS NUEVA</th>      "
                + " <th  style='color: #fff; background: black;' >DOSIS ACTUAL</th>      "
                + " <th  style='color: #fff; background: black;' >COSTO</th>      "
                + " <th  style='color: #fff; background: black;' >GRUPO</th>      "
                + " <th  style='color: #fff; background: black;' >CODIGO FORMULA</th>      " 
                + " <th  style='color: #fff; background: black;' >ACCIÓN</th>      " 
                + " </thead> "
                + " <tbody >";
        while (rs_GM.next()) 
        {
            grilla_html = grilla_html
                    + "<tr > "
                    + "<td style=\"font-weight:bold\" >   " + rs_GM.getString("Code") + "</td>"
                    + "<td style=\"font-weight:bold\">   " + rs_GM.getString("ItemName") + "</td>"
                    + "<td  class='single_line2 only '   style=\"font-weight:bold\" id=\""+rs_GM.getString("Code")+"\" "
                    + " contenteditable=\"true\" estado=\"NEUTRO\"  "
                     + "costo=\""+rs_GM.getString("AvgPrice").trim()+"\" "
                    + "grupo=\""+rs_GM.getString("ItmsGrpCod").trim()+"\"    "
                    + "ingrediente=\""+rs_GM.getString("ItemName").trim()+"\"    "
                    + "cantidad_historial=\""+ formatea2.format(rs_GM.getDouble("Quantity") ).replaceAll(",", ".") +"\"  "
                    + "grilla='true' cantidad=\""+ formatea2.format(rs_GM.getDouble("Quantity") ).replaceAll(",", ".")+"\">" +  formatea2.format(rs_GM.getDouble("Quantity") ) + "</td>"
                    
                    
                    
                    + "<td style=\"font-weight:bold\" >   " +  formatea2.format(rs_GM.getDouble("Quantity") ) + "</td>"
                    + "<td style=\"font-weight:bold\">   " + formatea.format(rs_GM.getFloat("AvgPrice")) + "</td>"
                    + "<td style=\"font-weight:bold\">   " + rs_GM.getString("ItmsGrpCod") + "</td>"
                    + "<td style=\"font-weight:bold\">   " + rs_GM.getString("Father") + "</td>"
                    + "<td style=\"font-weight:bold\">    <input id=\"BTN"+rs_GM.getString("Code")+"\"  type=\"button\" class=\"form-control bg-success "+rs_GM.getString("Code")+" \" onclick=\"calculo_grilla_solicitud_bal('"+rs_GM.getString("Code")+"',1) \" value=\"Quitar de formula\"></td>"
                    + "</tr>";
            
            cantidad=cantidad+ rs_GM.getFloat("Quantity") ;
        }
         
        ob.put("grilla",cabecera + grilla_html + "</tbody></table>" );
        ob.put("total",cantidad );
        
        rs_GM.close();
    } catch (Exception e) {
        ob.put("grilla", e.toString());  
    } finally {
        connection.close();
        out.print(ob ); 
    }


%>


 