<!DOCTYPE html>
<!-- #include file = pruebaConexion.asp-->
<!-- #include file = conexionsegura.asp-->

<head>
    <!-- Scripts y CSS -->
</head>
<body>
    <% 
        idciudad=request.form("idciudad")
        ciudad=request.form("ciudad")
        tasa_aeropuerto=request.form("tasa_aeropuerto")

        respone.write(idciudad)
        response.write(ciudad)
        response.write(tasa_aeropuerto)

        SentenciaSQL = "Update CIUDAD set CIUDAD='" & ciudad & "', TASA_AEROPUERTO=" & tasa_aeropuerto & " where IDCIUDAD=" & idciudad

        Set rs = Conexion.Execute(SentenciaSQL)

        response.write("La Ciudad se ha modificado con &eacute;xito.")

        Conexion.Close

        Set Conexion = nothing
        Response.Redirect("listaciudades.asp")
    %>


</body>