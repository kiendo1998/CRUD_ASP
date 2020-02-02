<!--#include file="DBManager.asp"-->
<%
    Dim id, action 
    Dim connection_string
    connection_string = "DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ="
    connection_string = connection_string & Server.mappath("Student.accdb") & ";"
    Dim dbman
    Set dbman = (New DBManager)(connection_string)
    Dim name
    Dim gender
    Dim adderss
    Dim email
    Dim phone
    Dim class1
    Dim cpa
    Dim dateofbirth
    name = request.form("name")
    gender = request.form("gender")
    address = request.form("address")
    email = request.form("email")
    phone = request.form("phone")
    class1 = request.form("class")
    cpa = request.form("cpa")
    dateofbirth = request.form("dateofbirth")
    Dim result, result1
    action = request.querystring("action")
    If action = "add" then
        If IsEmpty(name) And IsEmpty(gender) And IsEmpty(ngaysinh) Then
        Else
        set result = dbman.query("INSERT INTO student(Name,Gender,Address,email,phone,class,cpa,dateofbirth) VALUES('"&name&"','"&gender&"','"&address&"','"&email&"','"&phone&"','"&class1&"','"&cpa&"','"&dateofbirth&"')",empty)
        Response.Redirect "StudentManager.asp"
        End If
    Else
        id = request.querystring("ID")
        set result = dbman.query("SELECT * From student where id= ?",id)
        If IsEmpty(name) And IsEmpty(gender) And IsEmpty(ngaysinh) Then
        Else
            Set result1 = dbman.query("UPDATE student set name = '"&name&"',gender = '"&gender&"',address = '"&address&"',email = '"&email&"', phone = '"&phone&"',class = '"&class1&"',cpa = '"&cpa&"',dateofbirth = '"&dateofbirth&"' where ID =" & id, empty)
            Response.redirect "StudentManager.asp"
        End If
    End If
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title></title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <style>
            .lb{
                text-align: right;
            }
        </style>

    </head>
    <body>
    <div class="container">
        <div class='row'>
            <div class="col-md-3"></div>
                <div class="col-md-6 title">
                    <h1><% If action = "add" then Response.write("Thêm mới Sinh viên") Else Response.write("Chỉnh sửa thông tin sinh viên") End If %></h1>
                    <br><br>
                </div>
                <div class="col-md-3 ">
        </div>
        <div class="col-md-12">
            <form action="#" method="POST">
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-3 lb"><b>Họ và tên</b></label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control"  name="name" placeholder="Nguyễn Văn A" value="<% If action = "edit" then Response.write(result("Name")) End IF %>" >
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-3 lb"><b>Giới Tính</b></label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control"  name="gender" placeholder="Nam" value="<% If action = "edit" then Response.write(result("Gender")) End IF %>" >
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-3 lb"><b>Địa chỉ</b></label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control"  name="address" placeholder="Hà Nội" value="<% If action = "edit" then Response.write(result("address")) End IF %>">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-3 lb"><b>Địa chỉ email</b></label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control"  name="email" placeholder="abc@gmail.com" value="<% If action = "edit" then Response.write(result("email")) End IF %>">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-3 lb"><b>Số điện thoại</b></label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control"  name="phone" placeholder="0986579099" value="<% If action = "edit" then Response.write(result("phone")) End IF %>">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-3 lb"><b>Lớp</b></label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control"  name="class" placeholder="61PM1" value="<% If action = "edit" then Response.write(result("class")) End IF %>">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-3 lb"><b>Điểm tích lũy</b></label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control"  name="cpa" placeholder="3.5" value="<% If action = "edit" then Response.write(result("cpa")) End IF %>">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-3 lb"><b>Ngày sinh</b></label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control"  name="dateofbirth" placeholder="mm-dd-yyyy" value="<% If action = "edit" then Response.write(result("dateofbirth")) End IF %>">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-sm-5 pull-right">
                            <button type="Submit"  class="btn btn-primary">Lưu</button>   
                        </div>
                    </div>
                </div>
            </form>

        </div>
    </div>
    </body>
</html>
