<!-- #include file=conexion.asp -->

<%
' Obtener los parámetros del formulario
origen = request.form("co")
destino = request.form("cd")

' Configuración de la respuesta
response.ContentType = "text/xml"
response.CacheControl = "no-cache, must-revalidate"

' Definir la consulta SQL según los parámetros recibidos
if origen = "0" and destino = "0" then
    query = "SELECT IDVUELO, CIUDAD_ORIGEN, CIUDAD_DESTINO, FECHA, DURACION, PRECIO FROM LISTA_VUELOS_PRECIO"
elseif origen <> "0" and destino = "0" then
    query = "SELECT IDVUELO, CIUDAD_ORIGEN, CIUDAD_DESTINO, FECHA, DURACION, PRECIO FROM LISTA_VUELOS_PRECIO WHERE CIUDAD_ORIGEN = (SELECT CIUDAD FROM CIUDAD WHERE IDCIUDAD = " & origen & ")"
else
    query = "SELECT IDVUELO, CIUDAD_ORIGEN, CIUDAD_DESTINO, FECHA, DURACION, PRECIO FROM LISTA_VUELOS_PRECIO WHERE CIUDAD_ORIGEN = (SELECT CIUDAD FROM CIUDAD WHERE IDCIUDAD = " & origen & ") AND CIUDAD_DESTINO = (SELECT CIUDAD FROM CIUDAD WHERE IDCIUDAD = " & destino & ")"
end if

set rs = conexion.execute(query)

' Generación del XML de respuesta
if not rs.Eof then
    %><?xml version="1.0" encoding="UTF-8" standalone="yes"?> <%
    response.write("<XML>")
    do while not rs.Eof
        response.write("<vuelo>")
        response.write("<id_vuelo>" & rs("IDVUELO") & "</id_vuelo>")
        response.write("<ciudad_origen>" & rs("CIUDAD_ORIGEN") & "</ciudad_origen>")
        response.write("<ciudad_destino>" & rs("CIUDAD_DESTINO") & "</ciudad_destino>")
        response.write("<fecha>" & rs("FECHA") & "</fecha>")
        response.write("<duracion>" & rs("DURACION") & "</duracion>")
        response.write("<precio>" & rs("PRECIO") & "</precio>")
        response.write("</vuelo>")
        rs.MoveNext
    loop
    response.write("</XML>")
end if
%>
