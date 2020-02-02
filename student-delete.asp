<!-- #include file="DBManager.asp" -->

<% 
    Dim connection_string
    connection_string = "DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ="
    connection_string = connection_string & Server.mappath("Student.accdb") & ";"
    Dim dbman
    Set dbman = (New DBManager)(connection_string)
        Dim id
       
            id = request.querystring("ID")

            Set result = dbman.query("DELETE FROM student WHERE id = ?", id)
            Response.redirect "StudentManager.asp"

%>