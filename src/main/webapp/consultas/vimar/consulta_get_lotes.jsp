<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@page language="java" import="java.sql.*" errorPage="error.jsp" %>
 <%@include  file="../../cruds/conexion.jsp" %> 

<%    
JSONObject ob = new JSONObject();
String codBarra = request.getParameter("codBarra");
String origen = request.getParameter("origen"); 

String ItemCode="";
String ItemName="";
String LoteLargo="";
String Lote="";
String LoteCorto="";
String CodigoBarra="";
String Onhand="";


    try {
     //   String father = request.getParameter("father");
        ResultSet rsOrigen_GM;
        Statement st = connection.createStatement();
        rsOrigen_GM = st.executeQuery( "select *,convert(int,onhand) as onhandInt "
                + "from vimar.[dbo].[A0_TRAZ_TRANSF_CODEBARS]"
                + " where CODIGOBARRA='"+codBarra+"' and WhsCode='"+origen+"'");

        while (rsOrigen_GM.next())
        {
            //recuperamos el valor de las columnas de la base de datos
             ItemCode=rsOrigen_GM.getString("ItemCode"); 
             ItemName=rsOrigen_GM.getString("ItemName");
             LoteLargo=rsOrigen_GM.getString("LoteLargo");
             Lote=rsOrigen_GM.getString("Lote");
             LoteCorto=rsOrigen_GM.getString("LoteCorto");
             CodigoBarra=rsOrigen_GM.getString("CodigoBarra");
             Onhand=rsOrigen_GM.getString("onhandInt");
         }
                rsOrigen_GM.close();

     
        ob.put("VariableJsonItemCode", ItemCode);
        ob.put("VariableJsonItemName", ItemName);
        ob.put("VariableJsonLoteLargo", LoteLargo);
        ob.put("VariableJsonLote", Lote);
        ob.put("VariableJsonLoteCorto", LoteCorto);
        ob.put("VariableJsonCodigoBarra", CodigoBarra);
        ob.put("VariableJsonOnhand", Onhand);


    } catch (Exception e) {
         ob.put("error", e.toString());

    } finally {
        connection.close();
        out.print(ob);
    }
%> 

