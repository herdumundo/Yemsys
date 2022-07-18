<%-- 
    Document   : logincontrol
    Created on : 03/03/2020, 08:04:55 AM
    Author     : hvelazquez
--%>
 
<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page session="true" %>
<%
    clases.controles.connectarBD();
    Statement stmt = clases.controles.connect.createStatement();
    //SE TIENE QUE PASAR A SP
    String usu = request.getParameter("usuario");
    String cla = request.getParameter("pass");
    ResultSet rs = stmt.executeQuery("select * from usuarios where usuario = '" + usu + "' and password = '" + cla + "' and clasificadora <>'u'");
    String area = "";
    try {

        if (rs.isBeforeFirst()) {
            while (rs.next()) {
                //  String id_usuario = "";
                String area_form = "";
                String user_name = rs.getString("usuario");
                String nombre_usu = rs.getString("nombre");
                String clasificadora = rs.getString("clasificadora");
                String cod_usuario = rs.getString("cod_usuario");
                String notificacion = "  <a class='nav-link  ' data-toggle='dropdown' href='#' aria-expanded='false'>  <i class='far fa-bell '></i>     <span class='badge badge-danger navbar-badge animacion' id='contador_notificacion'>0</span>    </a><div class='dropdown-menu dropdown-menu-lg dropdown-menu-right ' style='left: inherit; right: 0px;' id='notificacion'>   <span class='dropdown-item dropdown-header bg-navy'>Notificaciones</span>   </div>";
                HttpSession sesionOk = request.getSession();
                sesionOk.setAttribute("user_name", user_name);
                sesionOk.setAttribute("nombre_usuario", nombre_usu);
                sesionOk.setAttribute("clasificadora", clasificadora);
                sesionOk.setAttribute("area_log", clasificadora);
                sesionOk.setAttribute("id_usuario", cod_usuario);
                area = rs.getString("clasificadora");
 
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

                sesionOk.setAttribute("notificacion", notificacion);
                sesionOk.setAttribute("titulo_reproceso", titulo_modulo_reproceso);
                sesionOk.setAttribute("area_cch", area_form);
                sesionOk.setAttribute("area_fallas", area_fallas);
                sesionOk.setAttribute("categoria", categoria);
                sesionOk.setAttribute("nav_area", nav_area);
                sesionOk.setAttribute("area_gm", area);
                sesionOk.setAttribute("area", area_form);
                sesionOk.setAttribute("area_nuevo", area_nuevo);
                sesionOk.setAttribute("id_rol", rs.getString("id_rol"));
                response.sendRedirect("../menu.jsp");
            }
        } else {
            response.sendRedirect("../login_error.jsp");
        }
    } catch (Exception e) {
    } finally {

        clases.controles.DesconnectarBD();
    }

  /*    
    try {
      long tiempo = System.currentTimeMillis();
       Algorithm algorithm = Algorithm.HMAC256("secret");
        String token = JWT.create()
                .withIssuer("auth0")
                .sign(algorithm);

        Algorithm algorithm2 = Algorithm.HMAC256("secret"); //use more secure key
        JWTVerifier verifier = JWT.require(algorithm2)
                .withIssuer("auth0")
                .build(); //Reusable verifier instance
        DecodedJWT jwt = verifier.verify(token);
            String asd =jwt.getToken();
          String has=asd;  
        long tiempo = System.currentTimeMillis();
      
		//Creamos el token
        String jwtToken = Jwts.builder()
        		.claim("roles", "sad")
                .setSubject("dddddd")
                .setIssuer("http://www.infointernet.es")
                .setIssuedAt(new Date(tiempo))
                .setExpiration(new Date(tiempo+90000))
                .signWith(SignatureAlgorithm.HS512, RestSecurityFilter.KEY)
                .compact();
 
        
        
    } catch (Exception e) {
        String asdasd = e.getMessage();
    }
 
      String SECRETs = "DelapatriaelaltonombreengloriosoesplendorconservemosyensusarasdenuevojuremosmMorirantesqueesclavosvivir";
        
        Map<String,Object> header = new HashMap();
        header.put("typ", "JWT");
        Key key = new SecretKeySpec(SECRETs.getBytes(), SignatureAlgorithm.HS512.getJcaName());
 
        byte[] bytesEncoded = Base64.encodeBase64(key.getEncoded());

 
        String jws = Jwts.builder()
                  .setHeaderParams(header)
                  //claim personalizado
                  .claim("lvl","hernanjose86@hotmail.com")
                  //claim standar
                  .setIssuer("mouse")
                  .setSubject("JC")
                  .setExpiration(new Date(tiempo+90000))
                  .setIssuedAt(new Date(tiempo))
                   //firma
                  .signWith(SignatureAlgorithm.HS512, new String(bytesEncoded))
                  .compact();
     
        
   String has=jws;*/

        
    //  JSONObject json = Json.createObjectBuilder().add("JWT", "").build();
    /*
  Algorithm algorithm = Algorithm.HMAC256("secret");
  Map<String, Object> headerClaims = new HashMap();
  Map<String, Object> payloadClaims = new HashMap();
  payloadClaims.put("ID", "12");
  payloadClaims.put("NAME", "datos2");
  payloadClaims.put("ROL", "payTest");

  headerClaims.put("alg", "HMAC256");
  headerClaims.put("typ", "JWT");
  String token = JWT.create()
      .withHeader(headerClaims)
      .withPayload(payloadClaims)
      .withExpiresAt(expiry)
      .sign(algorithm);
    
    
     */
    // String[] parts = token.split("\\.");
    //String tok= parts[0];
    /*try {
         
  JSONObject header = new JSONObject( Base64.getUrlDecoder().decode(parts[0])  );
  JSONObject payload = new JSONObject( Base64.getUrlDecoder().decode(parts[1])  );

  String asd= payload.getString("iss");
    
   } catch (Exception e) {
       String asd=e.getMessage();
   }
    
     */
//String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXUyJ9.eyJpc3MiOiJhdXRoMCJ9.AbIJTDMFc7yUa5MhvcP03nJPyCPzZtQcGEp-zWfOkEE-";
/*try {
    
    
  Algorithm algorithms = Algorithm.HMAC256("secret"); //use more secure key
  JWTVerifier verifier = JWT.require(algorithm)
      .withIssuer("auth0")
      .build(); //Reusable verifier instance
 DecodedJWT jwt =   verifier.verify(token);
    
} catch (JWTVerificationException   e){
  //Invalid signature/claims
 String asd=e.getMessage();
}
*/
%>
