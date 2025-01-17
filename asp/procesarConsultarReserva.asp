<!DOCTYPE html>
<!-- #include file = pruebaConexion.asp-->

<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservas</title>
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
        #container {
            max-width: 800px;
            margin: 50px auto;
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

        .tabla {
            margin-top: 20px;
        }

        #tabla {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        #tabla th, #tabla td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        #tabla th {
            background-color: #007bff;
            color: white;
        }

        .boton-reserva {
            padding: 5px 10px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .boton-reserva:hover {
            background-color: #c82333;
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
        <img src="img/logo.jpg" alt="American Airlines Logo">
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
    <div id="container">
        <h1>Reservas Disponibles</h1>
        <div class="tabla">
            <%
            dni = Request.form("dni")
            Response.Write("<p>Buscando resultados para: " & dni & "</p>")
            %>

            <table id="tabla">
                <thead>
                    <tr>
                        <th scope="col">ID RESERVA</th>
                        <th scope="col">APELLIDOS</th>
                        <th scope="col">NOMBRE</th>
                        <th scope="col">DNI</th>
                        <th scope="col">ID VUELO</th>
                        <th scope="col">ASIENTOS RESERVADOS</th>
                        <th scope="col">ACCIONES</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        query = "SELECT * FROM RESERVA WHERE NIF = '" & dni & "' AND CANCELADO = 0"
                        Set vuelos = Conexion.Execute(query)

                        Do While Not vuelos.EOF
                    %>
                    <tr>
                        <td><%=vuelos("IDRESERVA")%></td>
                        <td><%=vuelos("APELLIDOS")%></td>
                        <td><%=vuelos("NOMBRE")%></td>
                        <td><%=vuelos("NIF")%></td>
                        <td><%=vuelos("IDVUELO")%></td>
                        <td><%=vuelos("N_ASIENTOS")%></td>
                        <td>
                            <a href='cancelarvuelo.asp?vuelo=<%=vuelos("IDRESERVA")%>&dni=<%=vuelos("NIF")%>'>
                                <button class='boton-reserva'>Cancelar</button>
                            </a>
                        </td>
                    </tr>
                    <%
                        vuelos.MoveNext
                        Loop
                        If Not vuelos Is Nothing Then
                            vuelos.Close
                            Set vuelos = Nothing
                        End If
                    %>
                </tbody>
            </table>
        </div>
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
