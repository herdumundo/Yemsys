<%-- 
    Document   : vista_html_mortandad
    Created on : 08/02/2022, 15:24:34
    Author     : csanchez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>Dibujar tabla HTML con JavaScript</title>
        <link href="style.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
        <h1>Tabla HTML dibujada con JS</h1>
        <a href="//parzibyte.me/blog">By Parzibyte</a>
        <table>
            <thead>
                <tr>
                    <th>ID Lote</th>
                    <th>Lote</th>
                    <th>Edad prom./dias</th>
                    <th>Edad prom./mes</th>
                    <th>Saldo inicial</th>
                    <th>Muertos</th>
                    <th>% Mort.</th>
                </tr>
            </thead>
            <tbody id="cuerpoTabla">

            </tbody>
        </table>
        <script src="script.js">
	</script>
    </body>

</html>
