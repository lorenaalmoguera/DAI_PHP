<!-- #include file=conexion.asp -->
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="estilo/listar_busqueda.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <title>BUSQUEDA</title>
    <style>
        body, html {
            height: 100%;
            margin: 0;
        }
        .logo-container {
            text-align: center;
            padding: 20px;
            background-color: transparent;
            color: white;
        }
        .logo-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 20px 0;
        }
        .logo-container img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
        }
        .menu-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .menu-list {
            list-style: none;
            padding: 0;
            margin-top: 20px;
        }
        .menu-list li {
            margin: 20px 0;
        }
        .menu-list a {
            font-size: 24px;
            padding: 10px 20px;
            display: block;
            color: white;
            background-color: #343a40;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .menu-list a:hover {
            background-color: #495057;
        }
    </style>
    </style>
    <script>
        function createAjaxObject() {
            var obj;
            if (window.XMLHttpRequest) {
                obj = new XMLHttpRequest();
            } else {
                try {
                    obj = new ActiveXObject("Microsoft.XMLHTTP");
                } catch (e) {
                    console.error('El navegador utilizado no está soportado.');
                }
            }
            return obj;
        }

        function handleDestinationsResponse() {
            if (oXML.readyState === 4 && oXML.status === 200) {
                var xml = oXML.responseXML.documentElement;
                var dropdown = document.getElementById("vuelos-vuelta");

                if (xml == null) {
                    dropdown.innerHTML = "<option value=''>No hay destinos disponibles</option>";
                } else {
                    dropdown.innerHTML = "<option value='0'>Todos los destinos</option>";

                    var cities = xml.getElementsByTagName('ciudades');
                    var options = '';

                    for (var i = 0; i < cities.length; i++) {
                        var cityId = cities[i].getElementsByTagName('id_cd')[0].firstChild.data;
                        var cityName = cities[i].getElementsByTagName('ciudad_destino')[0].firstChild.data;
                        options += "<option value='" + cityId + "'>" + cityName + "</option>";
                    }
                    dropdown.innerHTML += options;
                }
            }
        }

        function fetchDestinations() {
            var originId = document.getElementById("vuelos-ida").value;
            oXML = createAjaxObject();
            oXML.open('POST', 'consulta_ciudades.asp', true);
            oXML.onreadystatechange = handleDestinationsResponse;
            oXML.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            oXML.send('origen=' + originId);
        }

        function handleFlightsResponse() {
            if (oXML.readyState === 4 && oXML.status === 200) {
                var xml = oXML.responseXML.documentElement;
                var table = document.getElementById("tabla_vuelos");

                var tableContent = "<tr><th>Id Vuelo</th><th>Ciudad Origen</th><th>Ciudad Destino</th><th>Fecha</th><th>Precio</th><th>Duración</th></tr>";

                var flights = xml.getElementsByTagName('vuelo');

                for (var i = 0; i < flights.length; i++) {
                    tableContent += "<tr>";
                    tableContent += "<td>" + flights[i].getElementsByTagName('id_vuelo')[0].firstChild.data + "</td>";
                    tableContent += "<td>" + flights[i].getElementsByTagName('ciudad_origen')[0].firstChild.data + "</td>";
                    tableContent += "<td>" + flights[i].getElementsByTagName('ciudad_destino')[0].firstChild.data + "</td>";
                    tableContent += "<td>" + flights[i].getElementsByTagName('fecha')[0].firstChild.data + "</td>";
                    tableContent += "<td>" + flights[i].getElementsByTagName('precio')[0].firstChild.data + "</td>";
                    tableContent += "<td>" + flights[i].getElementsByTagName('duracion')[0].firstChild.data + "</td>";
                    tableContent += "</tr>";
                }

                table.innerHTML = tableContent;
            }
        }

        function fetchFlights() {
            var originId = document.getElementById("vuelos-ida").value;
            var destinationId = document.getElementById("vuelos-vuelta").value;
            oXML = createAjaxObject();
            oXML.open('POST', 'consulta_vuelos.asp', true);
            oXML.onreadystatechange = handleFlightsResponse;
            oXML.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            oXML.send('co=' + originId + '&cd=' + destinationId);
        }
    </script>
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
                <li class="nav-item active">
                    <a class="nav-link" href="busqueda.asp">Consultar Vuelos</a>
                </li>
            </ul>
        </div>
    </nav>
    <div class ="contenedor-enorme">
        <div class="container-fluid" id="vuelos">
            <div class="logo-container">
                <img src="estilo/logo.jpg" alt="Imagen de la Web">
            </div>
                <div class="col-12" id="busca-vuelos">
                        <div>
                            <label for="vuelos-ida" class="form-label">Origen</label>
                            <select class="form-select select-css" name="origen" id="vuelos-ida" onChange="fetchDestinations()">
                                <option value="0" selected>Origen</option>
                                <%
                                Set origen = Conexion.Execute("select IDCIUDAD, CIUDAD from CIUDAD order by CIUDAD")
                                do while not origen.EOF
                                    Response.Write("<option value='" & origen("IDCIUDAD") & "'>" & origen("CIUDAD") & "</option>")
                                    origen.MoveNext
                                loop
                                %>
                            </select>
                        </div>
                        <div>
                            <label for="vuelos-vuelta" class="form-label">Destinos</label>
                            <select class="form-select select-css" name="destino" id="vuelos-vuelta" onChange="fetchFlights()">
                                <option value="0" selected>Destinos</option>
                            </select>
                        </div>
                </div>
        </div>

        <div class="container-fluid" id="mostrar-vuelos">
            <div class="mostrando-vuelos" id="mostrando-vuelos">
                <h2 class="descubre">Vuelos disponibles:</h2>
                <table id="tabla_vuelos" name="tabla_vuelos" class="table"></table>
            </div>
        </div>
    </Div>
</body>

</html>
