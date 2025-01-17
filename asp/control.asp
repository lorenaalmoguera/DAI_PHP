<!DOCTYPE html>
<html>
    <body>
        <%
        admin = request.form("usuario")
        contra = request.form("password")
    
        IF contra = "1234" AND admin = "admin" THEN
            session("SESSIONLOGINOK") = 1
            response.redirect("menu_inicial.html")
        ELSE
            response.redirect("login.html")
        END IF
        %>
        
  </body>
</html>