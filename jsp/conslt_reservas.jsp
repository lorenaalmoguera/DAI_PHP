<%@ page language="java" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%@ include file="pruebaConexion.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta de Reservas de Vuelos</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
    <!-- Menú de Navegación Superior -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">AMERICAN AIRLINES</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="menu_inicial.html">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="conslt_reservas.jsp">Consultar Reservas</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="insert_vuelos.jsp">Insertar Vuelos</a>
                </li>
            </ul>
        </div>
    </nav>

    <section class="container mt-4">
        <h2 class="text-center mb-4">Consulta de Reservas</h2>
        
        <form method="post" action="conslt_reservas.jsp">
            <div class="form-group">
                <label for="dni_pasajero">DNI del Pasajero:</label>
                <input type="text" id="dni_pasajero" name="dni" class="form-control" placeholder="Introduzca el DNI" required>
            </div>

            <div class="form-group">
                <label for="ciudad_origen">Ciudad de Origen:</label>
                <select id="ciudad_origen" name="origen" class="form-control">
                    <option value="">Seleccione una ciudad</option>
                    <%
                        Connection connection = null;
                        PreparedStatement ps = null;
                        ResultSet resultSet = null;

                        try {
                            connection = DriverManager.getConnection(DB_CONNECTION_STRING, DB_USER, DB_PASSWORD);
                            String queryCities = "SELECT IDCIUDAD, CIUDAD FROM CIUDAD";
                            ps = connection.prepareStatement(queryCities);
                            resultSet = ps.executeQuery();

                            while (resultSet.next()) {
                                int cityId = resultSet.getInt("IDCIUDAD");
                                String cityName = resultSet.getString("CIUDAD");
                                out.println("<option value='" + cityId + "'>" + cityName + "</option>");
                            }
                        } catch (SQLException ex) {
                            out.println("<option>Error al cargar las ciudades</option>");
                            ex.printStackTrace();
                        } finally {
                            if (resultSet != null) try { resultSet.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                            if (ps != null) try { ps.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                            if (connection != null) try { connection.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                        }
                    %>
                </select>
            </div>

            <button type="submit" class="btn btn-success btn-block mt-3">Buscar Reservas</button>
        </form>

        <%
            String dniParam = request.getParameter("dni");
            String origenParam = request.getParameter("origen");

            if (dniParam != null && (origenParam == null || origenParam.isEmpty())) {
                out.println("<div class='alert alert-danger mt-4'>Por favor, seleccione una ciudad de origen.</div>");
            } else if (dniParam != null && origenParam != null && !origenParam.isEmpty()) {
                Connection connection2 = null;
                PreparedStatement ps2 = null;
                ResultSet resultSet2 = null;

                try {
                    int selectedCityId = Integer.parseInt(origenParam);

                    connection2 = DriverManager.getConnection(DB_CONNECTION_STRING, DB_USER, DB_PASSWORD);
                    String queryReservations = 
                        "SELECT lr.idreserva, r.idvuelo, r.apellidos, r.nombre, lr.CIUDAD_ORIGEN, " +
                        "lr.CIUDAD_DESTINO, lr.fecha_vuelo, lr.compania, lr.cancelado " +
                        "FROM listado_reservas lr " +
                        "JOIN reserva r ON lr.idreserva = r.idreserva " +
                        "JOIN ciudad co ON lr.CIUDAD_ORIGEN = co.ciudad " +
                        "WHERE co.idciudad = ? AND r.nif = ?";
                    ps2 = connection2.prepareStatement(queryReservations);
                    ps2.setInt(1, selectedCityId);
                    ps2.setString(2, dniParam);
                    resultSet2 = ps2.executeQuery();

                    if (resultSet2.next()) {
                        out.println("<table class='table table-striped table-bordered mt-4'>");
                        out.println("<thead><tr><th>ID Reserva</th><th>ID Vuelo</th><th>Apellidos</th><th>Nombre</th><th>Ciudad Origen</th><th>Ciudad Destino</th><th>Fecha Vuelo</th><th>Compania</th><th>Cancelado</th></tr></thead>");
                        out.println("<tbody>");
                        
                        do {
                            int IDReserva = resultSet2.getInt("IDRESERVA");
                            int IDVuelo = resultSet2.getInt("IDVUELO");
                            String Apellidos = resultSet2.getString("APELLIDOS");
                            String Nombre = resultSet2.getString("NOMBRE");
                            String Origen = resultSet2.getString("CIUDAD_ORIGEN");
                            String Destino = resultSet2.getString("CIUDAD_DESTINO");
                            java.sql.Date Fecha = resultSet2.getDate("FECHA_VUELO");
                            String Airline = resultSet2.getString("COMPANIA");
                            int EstadoReserva = resultSet2.getInt("CANCELADO");

                            String formattedDate = new SimpleDateFormat("yyyy-MM-dd").format(Fecha);
                            String cancellationStatus = (EstadoReserva == 1) ? "Sí" : "No";

                            out.println("<tr>");
                            out.println("<td>" + IDReserva + "</td>");
                            out.println("<td>" + IDVuelo + "</td>");
                            out.println("<td>" + Apellidos + "</td>");
                            out.println("<td>" + Nombre + "</td>");
                            out.println("<td>" + Origen + "</td>");
                            out.println("<td>" + Destino + "</td>");
                            out.println("<td>" + formattedDate + "</td>");
                            out.println("<td>" + Airline + "</td>");
                            out.println("<td>" + cancellationStatus + "</td>");
                            out.println("</tr>");
                        } while (resultSet2.next());

                        out.println("</tbody></table>");
                    } else {
                        out.println("<div class='alert alert-warning mt-4'>No se encontraron reservas para el DNI proporcionado.</div>");
                    }
                } catch (SQLException ex) {
                    out.println("<div class='alert alert-danger mt-4'>Error al realizar la consulta de reservas.</div>");
                    ex.printStackTrace();
                } finally {
                    if (resultSet2 != null) try { resultSet2.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                    if (ps2 != null) try { ps2.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                    if (connection2 != null) try { connection2.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                }
            }
        %>
    </section>

    <!-- Bootstrap JS (opcional si usas JavaScript de Bootstrap) -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
