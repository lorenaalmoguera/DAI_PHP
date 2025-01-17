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
            text-align: center;
        }

        h1, h2 {
            color: #007bff;
        }

        p {
            font-size: 18px;
            color: #333;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
            padding: 10px 20px;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
            margin-top: 20px;
        }

        .btn-primary:hover {
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

    <!-- Main content area -->
    <div id="container">
        <h1>Confirmación de Reserva</h1>

        <%
            idreserva = request.form("idreserva")
            apellidos = request.form("apellidos")
            nombre = request.form("nombre")
            dni = request.form("nif")
            idvuelo = request.form("idvuelo")
            n_asientos = request.form("n_asientos")
            estado = request.form("cancelado")

            plazasdisp = "SELECT N_PLAZAS_DISPONIBLES from VUELO where IDVUELO = " & idvuelo
            Set rs = Conexion.Execute(plazasdisp)
            p = rs("N_PLAZAS_DISPONIBLES")

            If (p < CInt(n_asientos)) Then
                Response.Write("<p>Lo sentimos, no hay suficientes plazas disponibles.</p>")
        %>
                <a href="listavuelos.asp"><button>volver</button></a>
        <%
            Else
                sq = "INSERT INTO RESERVA VALUES ('" & idreserva & "', '" & apellidos & "', '" & nombre & "', '" & dni & "', '" & idvuelo & "', '" & n_asientos & "', '0')"
                rs = Conexion.Execute(sq)
                p = p - n_asientos

                sqplazas = "UPDATE VUELO SET N_PLAZAS_DISPONIBLES = " & p & " WHERE IDVUELO = " & idvuelo
                Conexion.Execute(sqplazas)

                ' Calcula el precio de la reserva
                precio_query = "EXECUTE PROCEDURE PRECIO_VUELO(" & idvuelo & ")"
                Set precio_resultado = Conexion.Execute(precio_query)

                If Not precio_resultado.EOF Then
                    precio_final = precio_resultado.Fields("PRECIO_VUELO").Value * CInt(n_asientos)
                End If

                precio_resultado.Close
                Set precio_resultado = Nothing

                Response.Write("<h2>Reserva realizada con éxito</h2>")
                Response.Write("<p>ID de Reserva: <strong>" & idreserva & "</strong></p>")
                Response.Write("<p>Precio Final: <strong>" & Round(precio_final, 2) & " USD</strong></p>")
                Response.Redirect "confirmReserva.asp?idreserva=" & idreserva & "&precio=" & Round(precio_final, 2)
            End If
           
        %>


</body>
</html>
