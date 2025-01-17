<!DOCTYPE html>
<!-- #include file = pruebaConexion.asp-->

<head>
    <!-- Scripts y CSS -->
</head>
<body>
<%  
   
    idreserva = Request.QueryString("vuelo")
    fechaHoy = Now()
    cancelarvar = 1

    Response.Write("Fecha de hoy: " & fechaHoy)

    Set rs = Conexion.Execute("SELECT IDVUELO FROM RESERVA WHERE IDRESERVA = " & idreserva)
    If Not rs.EOF Then
        idvuelo = CInt(rs("IDVUELO"))
    End If
    rs.Close
    

    Set rs = Conexion.Execute("SELECT FECHA FROM VUELO WHERE IDVUELO = " & idvuelo)
    IF NOT.rs.EOF Then
        fechaVuelo = CDate(rs("FECHA")) ' Directly assign the value without CDate conversion
    END IF
    rs.Close
    
    Response.Write("Fecha del vuelo: " & fechaVuelo)

    dif = DateDiff("d", fechaHoy, fechaVuelo)

    IF dif < 2 THEN
        Response.Write("QUEDAN MENOS DE 48H PARA EL VUELO Y POR LO TANTO NO SE PUEDE CANCELAR")
    ELSE
        Response.Write("PROCEDEMOS A REALIZAR LA CANCELACION...")
        Response.Write("OBTENEMOS EL NUMERO DE ASIENTOS RESERVADOS...")
        Set rs = Conexion.Execute("SELECT N_ASIENTOS FROM RESERVA WHERE IDRESERVA = " & idreserva)
        IF NOT.rs.EOF Then
            nasientos = CInt(rs("N_ASIENTOS"))
        End IF
        rs.Close

        Set rs = Conexion.Execute("SELECT N_PLAZAS_DISPONIBLES FROM VUELO WHERE IDVUELO = " & idvuelo)
        IF NOT.rs.EOF THEN
            plazas_disponibles = CInt(rs("N_PLAZAS_DISPONIBLES"))
        End IF
        rs.Close


        plazas_disponibles = plazas_disponibles + nasientos

        SentenciaSQL = "Update RESERVA set CANCELADO=" & cancelarvar & " WHERE IDRESERVA=" & idreserva
        Set rs = Conexion.Execute(SentenciaSQL)
        Conexion.Close
        Conexion = nothing

        SentenciaSQL = "Update VUELO set N_PLAZAS_DISPONIBLES=" & plazas_disponibles & " WHERE IDVUELO =" &idvuelo
        Set rs = Conexion.Execute(SentenciaSQL)
        Conexion.Close
        Conexion = nothing
    END IF
    Response.redirect("listavuelos.asp")
%>

</body>