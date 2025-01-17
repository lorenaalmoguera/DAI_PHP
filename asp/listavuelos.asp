<!DOCTYPE html>
<!-- #include file = pruebaConexion.asp-->
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vuelos Disponibles</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        /* Header Styles */
        header {
            background-color: #007bff;
            color: #fff;
            padding: 20px 0;
            text-align: center;
        }

        header img {
            max-width: 150px;
            height: auto;
            margin-bottom: 10px;
        }

        header nav a {
            color: #fff;
            text-decoration: none;
            margin: 0 15px;
            font-weight: bold;
        }

        header nav a:hover {
            text-decoration: underline;
        }

        /* Banner Styles */
        .banner {
            width: 100%;
            height: 300px;
            background-image: url('img/banner.jpg');
            background-size: cover;
            background-position: center;
            margin-bottom: 30px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .banner h1 {
            color: #fff;
            font-size: 48px;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.7);
        }

        /* Container Styles */
        #container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #007bff;
        }

        /* Form Styles */
        #formulario-vuelos {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 30px;
            gap: 15px;
        }

        select {
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        .buscar {
            padding: 10px 20px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .buscar:hover {
            background-color: #218838;
        }

        .icono-avion img {
            vertical-align: middle;
        }

        .visualizar_reservas {
            display: block;
            width: 200px;
            text-align: center;
            padding: 10px 20px;
            margin: 20px auto 0;
            background-color: #17a2b8;
            color: #fff;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .visualizar_reservas:hover {
            background-color: #138496;
        }

        /* Footer Styles */
        footer {
            background-color: #007bff;
            color: #fff;
            text-align: center;
            padding: 15px 0;
            margin-top: 20px;
        }

        footer a {
            color: #fff;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <!-- Header with logo and navigation -->
    <header>
        <a href="menu_inicial.html"><img src="img/logo.jpg" alt="American Airlines Logo"></a>
        <nav>
            <a href="listaciudades.asp">Listar Ciudades</a>
            <a href="listavuelos.asp">Listar Vuelos</a>
            <a href="insertar_ciudad_formulario.asp">Insertar Ciudad</a>
            <a href="listaraviones.asp">Listar Aviones</a>
            <a href="ejemplo_update.asp">Actualizar Ciudades</a>
            <a href="actualizar_aviones_ejemplo_update.asp">Actualizar Aviones</a>
            <a href="eliminar_ciudades_tabla.asp">Eliminar Ciudades</a>
        </nav>
    </header>

    <!-- Banner Section -->
    <div class="banner">
        <img src="img/logo.jpg" alt="American Airlines Logo">
    </div>

    <!-- Main content area -->
    <div id="container">
        <form method="get" action="listarvuelosaccion.asp" id="formulario-vuelos">
            <div>
                <select name="origen" id="vuelos-ida">
                    <option value="defecto" selected>Origen</option>
                    <%
                    Set origen = Conexion.Execute("select IDCIUDAD, CIUDAD from CIUDAD order by CIUDAD")
                    do while not origen.EOF
                    Response.Write("<option value='" & origen("IDCIUDAD") & "'>" & origen("CIUDAD") &"</option>")
                    origen.MoveNext
                    loop
                    %>
                </select>
            </div>
            <div class="icono-avion">
                <img src="img/avion.png" height="25px" alt="Icono Avión">
            </div>
            <div>
                <select name="destino" id="vuelos-ida">
                    <option value="defecto" selected>Destino</option>
                    <%
                    Set origen = Conexion.Execute("select IDCIUDAD, CIUDAD from CIUDAD order by CIUDAD")
                    do while not origen.EOF
                    Response.Write("<option value='" & origen("IDCIUDAD") & "'>" & origen("CIUDAD") &"</option>")
                    origen.MoveNext
                    loop
                    %>
                </select>
            </div>
            <button class="buscar" type="submit">Buscar</button>
        </form>
        <a href="consultarReserva.asp" class="visualizar_reservas">Visualizar Reservas</a>
    </div>

    <!-- Footer with information about American Airlines -->
    <footer>
        <p>&copy; 2024 American Airlines. Todos los derechos reservados.</p>
        <p>Contacta con nosotros: 1-800-433-7300</p>
        <p>Sitio web oficial: <a href="https://www.aa.com" target="_blank">www.aa.com</a></p>
    </footer>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
