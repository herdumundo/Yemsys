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
<%    JSONObject ob = new JSONObject();
    String option = "";
    try {
        String father = request.getParameter("father");
        ResultSet rs_GM;
        Statement st = connection.createStatement();
        rs_GM = st.executeQuery( 
         "      select "
        +"          ItemCode as Code,ItemName,AvgPrice,ItmsGrpCod from maehara.dbo.OITM	     "
        +"      WHERE   " 
	+"	ItemCode like '%MATP%' and "
	+"	ItemCode not in "
        +"      (   "
        +"		select  "
	+"			A.Code   "
	+"		from  "
	+"			maehara.dbo.itt1 A  with (nolock)  " 
	+"			INNER JOIN  maehara.dbo.OITM B with (nolock)  ON A.CODE=B.ItemCode  " 
	+"		WHERE    "
	+"			FATHER='"+father+"' "
	+"		union all "
	+"		select "
        +"                  descripcion collate database_default "
        +"              from "
        +"                  mae_bal_mtp_bloqueados  with (nolock) "  
	+"	) order by itemname ");

        while (rs_GM.next()) 
        {
            option = option
                    + "<option "
                    + " codigo='"+rs_GM.getString(1)+"'  "
                    + " descripcion='"+rs_GM.getString(2)+"' "
                    + " cantidad_planificada='0' "
                    + " cantidad_real='0' "
                    + " costo='"+rs_GM.getString(3)+"' "
                    + " grupo='4' "
                    + " codigo_formula='"+father+"' "
                    
                    + "  value='" + rs_GM.getString(1) + "'> " + rs_GM.getString(2) + " </option> ";
        }
        
     
        ob.put("select", option);

        rs_GM.close();
    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
        out.print(ob);
    }
%> 

