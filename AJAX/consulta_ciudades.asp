<!-- #include file=conexion.asp -->

<%
' Obtener el parámetro del formulario
origen = request.form("origen")

' Configuración de la respuesta
response.ContentType = "text/xml"
response.CacheControl = "no-cache, must-revalidate"

' Generar la respuesta XML
response.write("<?xml version='1.0' encoding='UTF-8' standalone='yes'?>")
response.write("<XML>")

if origen = "0" then 
    response.write("<ciudades>")
    response.write("<id_cd>0</id_cd>")
    response.write("<ciudad_destino>Destino</ciudad_destino>")
    response.write("</ciudades>")
else
    sentenciaSQL = "SELECT IDCIUDADDESTINO FROM VUELO WHERE IDCIUDADORIGEN = '" & origen & "'"
    set rs = conexion.execute(sentenciaSQL)

    if not rs.Eof then
        do while not rs.Eof
            ciudadDestinoId = rs("IDCIUDADDESTINO")
            sentencia2 = "SELECT CIUDAD FROM CIUDAD WHERE IDCIUDAD = '" & ciudadDestinoId & "'"
            set rs2 = conexion.execute(sentencia2)

            response.write("<ciudades>")
            response.write("<id_cd>" & ciudadDestinoId & "</id_cd>")
            response.write("<ciudad_destino>" & rs2("CIUDAD") & "</ciudad_destino>")
            response.write("</ciudades>")
            
            rs.MoveNext
        loop 
    end if
end if

response.write("</XML>")
%>
