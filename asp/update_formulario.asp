<!DOCTYPE html>
<!-- #include file="pruebaConexion.asp" -->
<!-- #include file="conexionsegura.asp" -->

<head>
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

        /* Container Styles */
        #content {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        table {
            width: 100%;
            margin: 20px 0;
            border-collapse: collapse;
            background-color: #fff;
        }

        td {
            padding: 10px;
            text-align: left;
        }

        input[type="text"] {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
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

    <!-- Main content area -->
    <div id="content">
        <h2>Actualizar Ciudad</h2>
        <%
            id_recibido = request.querystring("id")

            Set consulta = Conexion.Execute("select IDCIUDAD, CIUDAD, TASA_AEROPUERTO from CIUDAD where IDCIUDAD=" & id_recibido)
            id = consulta("IDCIUDAD")
            ciudad = consulta("CIUDAD")
            tasa = consulta("TASA_AEROPUERTO")
        %>

        <form name="formulario_1" action="actualizar_ciudad_formulario.asp" method="post">
            <table>
                <tr>
                    <td>Código Ciudad:</td>
                    <td>
                        <input type="text" name="idciudad" readonly value="<%= id %>">
                    </td>
                </tr>
                <tr>
                    <td>Ciudad:</td>
                    <td>
                        <input type="text" name="ciudad" value="<%= ciudad %>">
                    </td>
                </tr>
                <tr>
                    <td>Tasa Aeropuerto:</td>
                    <td>
                        <input type="text" name="tasa_aeropuerto" value="<%= tasa %>">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <input type="submit" name="actualizar_ciudad" value="Actualizar Ciudad">
                    </td>
                </tr>
            </table>
        </form>
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
