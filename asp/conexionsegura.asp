<!DOCTYPE html>
<html>
    <body>
      
        <%
        LOGINOK = session("SESSIONLOGINOK") 
        IF LOGINOK <> 1 THEN
           response.redirect("login.html")
        END IF
        %>
  </body>
</html>