<!DOCTYPE html>
<!-- #include file = pruebaConexion.asp-->
<!-- #include file = conexionsegura.asp-->
<html lang="es">
<head>
    <!-- Scripts y CSS -->

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
            padding: 10px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%; /* Full width */
            box-sizing: border-box;
        }

        header img {
            max-width: 150px;
            height: auto;
        }

        header nav a {
            color: #fff;
            text-decoration: none;
            margin: 0 10px;
            font-weight: bold;
        }

        header nav a:hover {
            text-decoration: underline;
        }

        /* Container Styles */
        #container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            text-align: center;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        #return a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
            transition: background-color 0.3s;
        }

        #return a:hover {
            background-color: #0056b3;
        }

        /* Footer Styles */
        footer {
            background-color: #007bff;
            color: #fff;
            text-align: center;
            padding: 10px 0;
            margin-top: 20px;
            width: 100%; /* Full width */
            box-sizing: border-box;
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

    <!-- Main Content -->
    <div id="container">
        <h1> Bienvenido a listar ciudades</h1>
        <table>
            <thead>
                <tr>
                    <th>ID Ciudad</th>
                    <th>Ciudad</th>
                    <th>Tasa Aeropuerto</th>
                </tr>
            </thead>
            <tbody>
                <%
                Set origen = Conexion.Execute("select IDCIUDAD, CIUDAD, TASA_AEROPUERTO from CIUDAD ORDER BY IDCIUDAD") 
                do while not origen.EOF
                    Response.Write("<tr><td>" & origen("IDCIUDAD") & "</td><td>" & origen("CIUDAD") & "</td><td>" & origen("TASA_AEROPUERTO") & "</td></tr> ")
                origen.MoveNext
                loop
                %>
            </tbody>
        </table>
        <div id="return">
            <a href="menu_inicial.html">Volver</a>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 American Airlines. Todos los derechos reservados.</p>
        <p>Contacta con nosotros: 1-800-433-7300</p>
    </footer>
</body>
</html>
