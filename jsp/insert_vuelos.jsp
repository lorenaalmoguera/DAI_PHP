<%@ page language="java" %>
<%@ page import="java.io.*, java.sql.*, java.text.SimpleDateFormat, java.text.ParseException, java.util.Date" %>
<%@ include file="pruebaConexion.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <!-- Scripts y CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <title>Insertar Vuelo</title>
</head>
<body>
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
    <div id="content">
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            int newIdVuelo = 1; // Valor por defecto
            try {
                conn = DriverManager.getConnection(DB_CONNECTION_STRING, DB_USER, DB_PASSWORD);
                String sql = "SELECT MAX(IDVUELO) AS MAX_ID FROM VUELO";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();
                if (rs.next()) {
                    newIdVuelo = rs.getInt("MAX_ID") + 1;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (stmt != null) {
                    try {
                        stmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
        <section class="container mt-4">
            <form method="POST">
                <div>
                    <label for="idvuelo" class="form-label">ID VUELO:</label>
                    <input class="form-control" type="text" id="idvuelo" name="idvuelo" value="<%= newIdVuelo %>" readonly>
                </div>
                <div>
                    <label for="id_co" class="form-label">ID CIUDAD ORIGEN:</label>
                    <input class="form-control" type="text" id="id_co" name="id_co" required>
                </div>
                <div>
                    <label for="id_cd" class="form-label">ID CIUDAD DESTINO:</label>
                    <input class="form-control" type="text" id="id_cd" name="id_cd" required>
                </div>
                <div>
                    <label for="fecha" class="form-label">FECHA:</label>
                    <input class="form-control" type="date" id="fecha" name="fecha" required>
                </div>
                <div>
                    <label for="id_cmp" class="form-label">ID COMPANIA:</label>
                    <input class="form-control" type="text" id="id_cmp" name="id_cmp" required>
                </div>
                <div>
                    <label for="id_a" class="form-label">ID AVION:</label>
                    <input class="form-control" type="text" id="id_a" name="id_a" required>
                </div>
                <div>
                    <label for="dur" class="form-label">DURACION:</label>
                    <input class="form-control" type="text" id="dur" name="dur" required>
                </div>
                <div>
                    <label for="np" class="form-label">PLAZAS DISPONIBLES:</label>
                    <input class="form-control" type="text" id="np" name="np" disabled>
                </div>
                <div>
                    <button type="submit" class="btn btn-success btn-block mt-3">INSERTAR</button>
                </div>
            </form>
       
        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                conn = null;
                stmt = null;
                rs = null;
                boolean ciudadOrigenExiste = false;
                boolean ciudadDestinoExiste = false;
                boolean ciudadesSonDiferentes = false;

                try {
                    String idCo = request.getParameter("id_co");
                    String idCd = request.getParameter("id_cd");
                    String fecha = request.getParameter("fecha");
                    String idCmp = request.getParameter("id_cmp");
                    String idA = request.getParameter("id_a");
                    String dur = request.getParameter("dur");

                    // Verificar que todos los campos están completos
                    if (idCo == null || idCd == null || fecha == null || idCmp == null || idA == null || dur == null ||
                        idCo.isEmpty() || idCd.isEmpty() || fecha.isEmpty() || idCmp.isEmpty() || idA.isEmpty() || dur.isEmpty()) {
                        out.println("<p>Todos los campos son obligatorios.</p>");
                        out.println("<center><a href='insert_vuelos.jsp' class='btn btn-warning'>Volver a intentarlo</a></center>");
                    } else {
                        conn = DriverManager.getConnection(DB_CONNECTION_STRING, DB_USER, DB_PASSWORD);

                        // Verificar si la ciudad de origen existe
                        String sqlVerificarCiudad = "SELECT COUNT(*) AS TOTAL FROM CIUDAD WHERE IDCIUDAD = ?";
                        stmt = conn.prepareStatement(sqlVerificarCiudad);
                        stmt.setInt(1, Integer.parseInt(idCo));
                        rs = stmt.executeQuery();
                        if (rs.next() && rs.getInt("TOTAL") > 0) {
                            ciudadOrigenExiste = true;
                        }

                        // Verificar si la ciudad de destino existe
                        stmt.setInt(1, Integer.parseInt(idCd));
                        rs = stmt.executeQuery();
                        if (rs.next() && rs.getInt("TOTAL") > 0) {
                            ciudadDestinoExiste = true;
                        }

                        // Verificar si las ciudades son diferentes
                        ciudadesSonDiferentes = !idCo.equals(idCd);

                        if (ciudadOrigenExiste && ciudadDestinoExiste && ciudadesSonDiferentes) {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            Date date = sdf.parse(fecha);
                            java.sql.Date sqlDate = new java.sql.Date(date.getTime());

                            String sqlInsert = "INSERT INTO VUELO (IDVUELO, IDCIUDADORIGEN, IDCIUDADDESTINO, FECHA, IDCOMPANIA, IDAVION, DURACION) VALUES (?, ?, ?, ?, ?, ?, ?)";
                            stmt = conn.prepareStatement(sqlInsert);
                            stmt.setInt(1, newIdVuelo);
                            stmt.setInt(2, Integer.parseInt(idCo));
                            stmt.setInt(3, Integer.parseInt(idCd));
                            stmt.setDate(4, sqlDate);
                            stmt.setInt(5, Integer.parseInt(idCmp));
                            stmt.setInt(6, Integer.parseInt(idA));
                            stmt.setInt(7, Integer.parseInt(dur));
                            stmt.executeUpdate();

                            out.println("<p>El vuelo se ha insertado exitosamente.</p><br><a href='insert_vuelos.jsp' class='btn btn-warning'>OK</a>");
                        } else {
                            if (!ciudadOrigenExiste) {
                                out.println("<p>La ciudad de origen no existe.</p>");
                            }
                            if (!ciudadDestinoExiste) {
                                out.println("<p>La ciudad de destino no existe.</p>");
                            }
                            if (!ciudadesSonDiferentes) {
                                out.println("<p>La ciudad de origen y destino no pueden ser la misma.</p>");
                            }
                            out.println("<center><a href='insert_vuelos.jsp' class='btn btn-warning'>Volver a intentarlo</a></center>");
                        }
                    }
                } catch (SQLException | ParseException e) {
                    out.println("<p>No se ha podido añadir el vuelo. Revise los datos.</p>");
                    out.println("<center><a href='insert_vuelos.jsp' class='btn btn-warning'>Volver a intentarlo</a></center>");
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    if (rs != null) {
                        try {
                            rs.close();
                        } catch (SQLException e) {
                            out.println("<p>Error al cerrar ResultSet: " + e.getMessage() + "</p>");
                            e.printStackTrace();
                        }
                    }
                    if (stmt != null) {
                        try {
                            stmt.close();
                        } catch (SQLException e) {
                            out.println("<p>Error al cerrar PreparedStatement: " + e.getMessage() + "</p>");
                            e.printStackTrace();
                        }
                    }
                    if (conn != null) {
                        try {
                            conn.close();
                        } catch (SQLException e) {
                            out.println("<p>Error al cerrar Connection: " + e.getMessage() + "</p>");
                            e.printStackTrace();
                        }
                    }
                }
            }
        %>
    </div>
</section>
</body>
</html>
