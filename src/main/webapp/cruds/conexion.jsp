<%-- 
    Document   : conexion
    Created on : 13-jun-2022, 8:17:33
    Author     : hvelazquez
--%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>

<%
   //  String user = "sa";
   String user = "sa";
    String passwd = "Paraguay2017";
    // String db = "GrupoMaehara";
     String db = "GrupoMaehara";
    // String db = "GrupoMaehara"; 
    
    
    Connection connection=null;
 
        try 
        {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection("jdbc:sqlserver://172.16.1.202;databasename=" + db, user, passwd);
        }
        catch (SQLException se) {

            switch (se.getErrorCode()){
                case 1017:
                    System.out.println("USUARIO O CONTRASEŅA INCORRECTA, FAVOR VERIFIQUE.");
                    break;
                case  17002  :
                case  20:
                      System.out.println("ERROR DE CONEXION, VERIFIQUE LA RED.");
                    break;
                case  17452:
                       System.out.println("USUARIO O CONTRASEŅA INCORRECTA, FAVOR VERIFIQUE.");
                    break;
                default :
                       System.out.println(se.getErrorCode());
                       out.print(se.toString());
             }
        }
        catch (ClassNotFoundException e)
        {
              out.print(e.toString());
        }
 

%>