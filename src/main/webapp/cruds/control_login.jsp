<%-- 
    Document   : logincontrol
    Created on : 03/03/2020, 08:04:55 AM
    Author     : hvelazquez
--%>

<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@include file="../cruds/conexion.jsp" %>
<%@page session="true" %>
<%    
    String usu = request.getParameter("usuario");
    String cla = request.getParameter("pass");
    
    String area = "";
    String area_form = "";
    String user_name = "";
    String nombre_usu = "";
    String clasificadora = "";
    String cod_usuario = "";
    int tipo_respuesta = 0;
    String id_rol = "";
  
    MessageDigest m = MessageDigest.getInstance("MD5");
    m.reset();
    m.update(cla.getBytes());
    byte[] digest = m.digest();
    BigInteger bigInt = new BigInteger(1, digest);
    String clavehASH = bigInt.toString(16);

    try {
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call stp_mae_yemsys_login(?,?,?,?,?,?,?,?)}");
        callableStatement.setString(1, usu);
        callableStatement.setString(2, clavehASH);
        callableStatement.registerOutParameter("nombre", java.sql.Types.VARCHAR);
        callableStatement.registerOutParameter("cod_usuario", java.sql.Types.VARCHAR);
        callableStatement.registerOutParameter("clasificadora", java.sql.Types.VARCHAR);
        callableStatement.registerOutParameter("tipo", java.sql.Types.INTEGER);
        callableStatement.registerOutParameter("id_rol", java.sql.Types.VARCHAR);
        callableStatement.registerOutParameter("username", java.sql.Types.VARCHAR);

        callableStatement.execute();
        tipo_respuesta  = callableStatement.getInt("tipo");
        user_name       = callableStatement.getString("username");
        nombre_usu      = callableStatement.getString("nombre");
        clasificadora   = callableStatement.getString("clasificadora");
        cod_usuario     = callableStatement.getString("cod_usuario");
        id_rol          = callableStatement.getString("id_rol");

    } catch (Exception e) {

    } finally {
        if (tipo_respuesta == 0) 
        {
            response.sendRedirect("../login_error.jsp");
        } 
        else 
        {
            String notificacion = "  <a class='nav-link  ' data-toggle='dropdown' href='#' aria-expanded='false'>  <i class='far fa-bell '></i>     <span class='badge badge-danger navbar-badge animacion' id='contador_notificacion'>0</span>    </a><div class='dropdown-menu dropdown-menu-lg dropdown-menu-right ' style='left: inherit; right: 0px;' id='notificacion'>   <span class='dropdown-item dropdown-header bg-navy'>Notificaciones</span>   </div>";
            HttpSession sesionOk = request.getSession();
            sesionOk.setAttribute("user_name", user_name);
            sesionOk.setAttribute("nombre_usuario", nombre_usu);
            sesionOk.setAttribute("clasificadora", clasificadora);
            sesionOk.setAttribute("area_log", clasificadora);
            sesionOk.setAttribute("id_usuario", cod_usuario);
            area = clasificadora;

            String area_fallas = "CCH";
            String categoria = "FCO";
            String titulo_modulo_reproceso = "ALIMENTACION DE REPROCESAR RECLASIFICAR";
            String nav_area = "";
            String area_nuevo = "";
            if (area.equals("A")) {
                area_form = "CCHA";
                area_nuevo = "CCHA";
                nav_area = "<i class='fas fa-home'>CCHA</i>";
            } else if (area.equals("B")) {
                nav_area = "<i class='fas fa-home'>CCHB</i>";
                area_form = "CCHB";
                area_nuevo = "CCHB";
            } else if (area.equals("H")) {
                nav_area = "<i class='fas fa-home'>CCHH</i>";
                area_form = "CCHH";
                area_nuevo = "CCHH";
            } else if (area.equals("C")) {
                nav_area = "<i class='fas fa-home'>CYO</i>";
                area_form = "CYO";
                area_nuevo = "CYO";
            } else if (area.equals("S")) {
                nav_area = "<i class='fas fa-home'>SUBPRODUCTOS</i>";
                area_form = "SUBPRODUCTOS";
            } else if (area.equals("D")) {
                notificacion = "";
                nav_area = "<i class='fas fa-home'>DIRECTORIO</i>";
                area_form = "SUBPRODUCTOS";

            } else if (area.equals("O")) {
                nav_area = "<i class='fas fa-home'>LAVADOS</i>";
                titulo_modulo_reproceso = "ALIMENTACION DE REPROCESAR LAVAR";
                area_form = "OVO";
                area_fallas = "OVO";
                categoria = "LDO";
                area_nuevo = "LAVADOS";
            }
            else  {
                notificacion = "";
            }

            sesionOk.setAttribute("notificacion", notificacion);
            sesionOk.setAttribute("titulo_reproceso", titulo_modulo_reproceso);
            sesionOk.setAttribute("area_cch", area_form);
            sesionOk.setAttribute("area_fallas", area_fallas);
            sesionOk.setAttribute("categoria", categoria);
            sesionOk.setAttribute("nav_area", nav_area);
            sesionOk.setAttribute("area_gm", area);
            sesionOk.setAttribute("area", area_form);
            sesionOk.setAttribute("area_nuevo", area_nuevo);
            sesionOk.setAttribute("id_rol", id_rol);
            response.sendRedirect("../menu.jsp");
        }
        connection.close();
    }  


    /*
    Statement stmt;
    
    
        stmt =connection.createStatement(); 
        ResultSet rs = stmt.executeQuery("select * from usuarios where  password  is not null ");

        while (rs.next()){
            
             MessageDigest m = MessageDigest.getInstance("MD5");
        m.reset();
        m.update(rs.getString("password").getBytes());
        byte[] digest = m.digest();
        BigInteger bigInt = new BigInteger(1, digest);
        String clavehASH = bigInt.toString(16);
    
    try {
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call stp_mae_yemsys_update_masivo_pass(?,?)}");
        callableStatement.setString(1, rs.getString("cod_usuario"));
        callableStatement.setString(2, clavehASH);

        callableStatement.execute();
       
    } catch (Exception e) 
    {
       
    }  
        }
     */
   
    
    
    
    
    
%>
