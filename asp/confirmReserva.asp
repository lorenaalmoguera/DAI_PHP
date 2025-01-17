<!DOCTYPE html>
<!-- #include file = pruebaConexion.asp-->

<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmación de Reserva</title>
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

        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        .boton-reserva {
            padding: 8px 12px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            cursor: pointer;
        }

        .boton-reserva:hover {
            background-color: #218838;
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
        <h1>Confirmación de Reserva</h1>
        <%
            Dim idreserva, precio_final

            idreserva = Request.QueryString("idreserva")
            precio_final = Request.QueryString("precio")

            ' Mostrar los valores en la página
            Response.Write("<p>ID de Reserva: <strong>" & idreserva & "</strong></p>")
            Response.Write("<p>Precio Final: <strong>" & precio_final & " USD</strong></p>")
            
            Dim idvuelo, query, rs, destino, origen

            ' Definir la consulta SQL para obtener el IDVUELO basado en la IDRESERVA
            query = "SELECT IDVUELO FROM RESERVA WHERE IDRESERVA = " & idreserva

            ' Ejecutar la consulta
            Set rs = Conexion.Execute(query)

            ' Obtener el IDVUELO si se encuentra un resultado
            If Not rs.EOF Then
                idvuelo = rs("IDVUELO")
            Else
                idvuelo = "No se encontró el vuelo"
            End If

            ' Cerrar el recordset
            rs.Close
            Set rs = Nothing

            ' Consultas para obtener ID de ciudades de origen y destino
            query2 = "SELECT IDCIUDADORIGEN FROM VUELO WHERE IDVUELO = " & idvuelo
            query3 = "SELECT IDCIUDADDESTINO FROM VUELO WHERE IDVUELO = " & idvuelo

            Set rs2 = Conexion.Execute(query2)
            If Not rs2.EOF Then
                destino = rs2("IDCIUDADORIGEN")
            End If
            rs2.Close

            Set rs3 = Conexion.Execute(query3)
            If Not rs3.EOF Then
                origen = rs3("IDCIUDADDESTINO")
            End If
            rs3.Close
        %>

        <h2>Vuelos de Vuelta Disponibles</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Ciudad Origen</th>
                    <th>Ciudad Destino</th>
                    <th>Fecha</th>
                    <th>Duración</th>
                    <th>Precio</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody>
                <%
                    queryvuelos = "SELECT * FROM VUELO WHERE IDCIUDADORIGEN = " & origen & " AND IDCIUDADDESTINO = " & destino
                    Set vuelos = Conexion.Execute(queryvuelos)

                    Do While Not vuelos.EOF

                        Set rs = Conexion.Execute("SELECT CIUDAD FROM CIUDAD WHERE IDCIUDAD = " & vuelos("IDCIUDADORIGEN"))
                        If Not rs.EOF Then
                            rsorigen = rs("CIUDAD")
                        End If
                        rs.Close

                        Set rs = Conexion.Execute("SELECT CIUDAD FROM CIUDAD WHERE IDCIUDAD = " & vuelos("IDCIUDADDESTINO"))
                        If Not rs.EOF Then
                            rsdestino = rs("CIUDAD")
                        End If
                        rs.Close

                        miid = vuelos.Fields("IDVUELO").value

                        nuevoquery = "EXECUTE PROCEDURE PRECIO_VUELO(" & miid & ")"
                        Set precio = Conexion.Execute(nuevoquery)

                        If Not precio.EOF Then
                            preciovuelo = precio.Fields("PRECIO_VUELO").Value
                        End If

                        %>
                        <tr>
                            <td><%=vuelos("IDVUELO")%></td>
                            <td><%=rsorigen%></td>
                            <td><%=rsdestino%></td>
                            <td><%=vuelos("FECHA")%></td>
                            <td><%=vuelos("DURACION")%></td>
                            <td><%=Round(preciovuelo, 2)%></td>
                            <td>
                                <a href='reservar.asp?vuelo=<%=vuelos("IDVUELO")%>'>
                                    <button class='boton-reserva'>Reservar</button>
                                </a>
                            </td>
                        </tr>
                        <%
                        vuelos.MoveNext
                    Loop

                    ' Clean up the recordset
                    If Not vuelos Is Nothing Then
                        vuelos.Close
                        Set vuelos = Nothing
                    End If
                %>
            </tbody>
        </table>

        <a class="btn-primary" href="listavuelos.asp">Volver a la Lista de Vuelos</a>
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
