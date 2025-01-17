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

    SentenciaSQL ="insert into CIUDAD values (" & idciudad & ", '" & ciudad & "', '" & tasa_aeropuerto & "')"
    Set rs = Conexion.execute(SentenciaSQL)

    response.write("La Ciudad se ha introducido con &eacute;xito en la Base de Datos.")
    Conexion.Close
    Set Conexion = nothing

    Response.Redirect("listaciudades.asp")
%>

</body>