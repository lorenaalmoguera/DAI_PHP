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
        PRECIO_BASE = request.form("PRECIO_BASE")

        respone.write(idavion)
        response.write(avion)
        response.write(n_plazas)
        response.write(PRECIO_BASE)

        SentenciaSQL = "UPDATE AVION SET AVION='" & avion & "', n_plazas=" & n_plazas & ", PRECIO_BASE=" & PRECIO_BASE & " WHERE IDAVION=" & idavion


        Set rs = Conexion.Execute(SentenciaSQL)

        response.write("El avi&oacute;n se ha modificado con &eacute;xito.")

        Conexion.Close

        Set Conexion = nothing
        Response.Redirect("listaraviones.asp")
    %>


</body>