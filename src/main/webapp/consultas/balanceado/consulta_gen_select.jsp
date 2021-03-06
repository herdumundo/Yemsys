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
        rs_GM = st.executeQuery(" "
                + "    select    "
                + "        A.Code,B.ItemName,CONVERT(varchar, convert(money, B.AvgPrice), 1)   as AvgPrice ,   B.ItmsGrpCod   "
                + "    from    "
                + "        maehara.dbo.itt1 A   "
                + "        INNER JOIN  maehara.dbo.OITM B ON A.CODE=B.ItemCode      "
                + "    WHERE    "
                + "        code like '%MATP%' and code not in "
                + "         (   "
                + "             select  A.Code   from  maehara.dbo.itt1 A   "
                + "             INNER JOIN  maehara.dbo.OITM B ON A.CODE=B.ItemCode    "
                + "             WHERE    FATHER='" + father + "'"
                        + "     union all "
                + "         select descripcion collate database_default from mae_bal_mtp_bloqueados "

                        + " ) group by   A.Code,B.ItemName ,B.AvgPrice, B.ItmsGrpCod  ");

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

