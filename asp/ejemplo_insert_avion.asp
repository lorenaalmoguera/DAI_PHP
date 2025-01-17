<!DOCTYPE html>
<!-- #include file = pruebaConexion.asp-->
<!-- #include file = conexionsegura.asp-->

<head>
    <!-- Scripts y CSS -->
</head>
<body>
    <%
        idavion=request.form("idavion")
        avion=request.form("avion")
        n_plazas=request.form("n_plazas")
        precio_base=request.form("precio_base")

        SentenciaSQL ="insert into AVION values (" & idavion & ", '" & avion & "', '" & n_plazas & "', '" & precio_base & "')"
        Set rs = Conexion.execute(SentenciaSQL)

        response.write("El avion se ha introducido con &eacute;xito en la Base de Datos.")
        Conexion.Close
        Set Conexion = nothing
        Response.Redirect("listaraviones.asp")
    %>
</body>