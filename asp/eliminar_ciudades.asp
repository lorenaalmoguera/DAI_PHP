<!-- #include file = pruebaConexion.asp-->
<!-- #include file = conexionsegura.asp-->
<!DOCTYPE html>
<html>
    <head>

    </head>
    
    <body>
      <%
        id_recibido=request.querystring("id")
        Set consulta  =Conexion.Execute("delete from CIUDAD where IDCIUDAD=" & id_recibido)
        if Conexion.Errors.Count>0 then
        for each error in Conexion.Errors
        response.Write(Error.Number & " = " & Error.Desciption)
        next
        else
        response.Write("La ciudad se ha eliminado con exito.")
        end if
        Conexion.Close
        set Conexion = nothing
        Response.Redirect("listaciudades.asp")
      %>
    </body>
   
</html>