<%
Class DBManager
     Private m_connect

     Public Sub Class_Initialize
         Response.AppendToLog "Initializing DBManager"

     End Sub
     
     Public Default Function Init(connect_string)
           Set m_connect = CreateObject("ADODB.Connection")
           m_connect.open connect_string
           Set Init = me 
     End Function

    Public Function Query(sql_string, params)
          Dim cmd: Set cmd = CreateObject("ADODB.Command")
          cmd.ActiveConnection = m_connect
          cmd.CommandText = sql_string
          Dim rs

          If IsArray(params) Then
             Set rs = cmd.Execute(,params)
          ElseIf Not IsEmpty(params) Then
             Set rs = cmd.Execute(,Array(params))
          Else 
             Set rs = cmd.Execute 
          End If
          Set Query = rs

    End Function

    Public Sub Class_Terminate
           Response.AppendToLog "Terminating DBManager"
           m_connect.close
           Set m_connect = Nothing
    End Sub 
           
End Class
%>