<!DOCTYPE html>
<html>
    <body>
        <% on Error Resume Next Set Conexion = Server.CreateObject("ADODB.Connection") Conexion.ConnectionString = "Data Source=agencia; USER=SYSDBA; PASSWORD=masterkey" Conexion.Mode = 1 Conexion.Open if Err.Description <>"" then Response.Write("Error: " & Err.Description & "
     ") else Response.Write("Conexión exitosa") end if Conexion.Close Set Conexion = nothing %>
  </body>
</html>

