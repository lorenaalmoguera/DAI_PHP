<!DOCTYPE html>
<!-- #include file = pruebaConexion.asp-->
<!-- #include file = conexionsegura.asp-->

<head>
    <!-- Scripts y CSS -->
</head>
<body>
    <h1> Bienvenido a buscar vuelos</h1>

    <form name="formulario_1" action="buscar_vuelos.asp" method="post">
        <select name="origen" id ="origen">
            <option value ="0">Todos los or&iacute;genes</option>
            <%
            Set origen = Conexion.Execute("select IDCIUDAD, CIUDAD from CIUDAD order by CIUDAD")
            do while not origen.EOF
                Response.Write("<option value='" & origen("IDCIUDAD") & "'>" & origen("CIUDAD") & "</option>")
                origen.MoveNext
            loop

            set destino = Conexion.Execute("select IDCIUDAD, CIUDAD from CIUDAD order by CIUDAD")
            %>
        </select>
        <select name ="destinos" id ="destinos">
            <option value="0">Todos los destinos</option>
            <%
            Set destinos = Conexion.Execute("select IDCIUDAD, CIUDAD from CIUDAD order by CIUDAD")
            do while not destinos.EOF
                Response.Write("<option value='" & destinos("IDCIUDAD") & "'>" & destinos("CIUDAD") & "</option>")
                destinos.MoveNext
            loop
            %>
        </select>

            <input type="submit" id="buscar" value="Buscar" />
    </form>
</body>