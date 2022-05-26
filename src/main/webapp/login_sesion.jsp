<html >
    <head>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <title>YemSys</title>
   <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
    </head>
     
 <body class="hold-transition login-page">
<div class="login-box">
  <!-- /.login-logo -->
  <div class="card card-outline card-danger">
    <div class="card-header text-center">
  <img src="img/YEMSYS2.png" width="150" height="50" alt=""/>      
    </div>
    <div class="card-body">
        <p class="login-box-msg"><strong>Inicio de sesión</strong></p>
                       <br>
       <form action="cruds/control_login.jsp" method="post">
        
          <div class="input-group mb-3">
              <input type="text" name="usuario" class="form-control" placeholder="Usuario" required>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
            <input type="password" name="pass"class="form-control" placeholder="Contraseña" required>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-8">
            <div class="icheck-primary">
              <input type="checkbox" id="remember">
             
            </div>
          </div>
          <!-- /.col -->
          <div class="col-4">
            <button type="submit" class="btn bg-navy btn-block">Ingresar</button>
          </div>
          <!-- /.col -->
        </div>
      </form>
                                <!-- Remind Passowrd -->
                                <footer class="footer">
                                   <div class="alert alert-default-danger" role="alert">
                                     <span class="glyphicon glyphicon-exclamation-sign">LA SESION HA CADUCADO.</span>
                                    </div>
                                </footer>
                            </div>
                        </div>
                    </div>
           
 </body>
 <script src="plugins/jquery/jquery.min.js"></script>
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="dist/js/adminlte.min.js"></script>
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
