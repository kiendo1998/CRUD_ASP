<!-- #include file="DBManager.asp" -->
    <% 
    Dim connection_string
    connection_string = "DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ="
    connection_string = connection_string & Server.mappath("Student.accdb") & ";"
    Dim dbman
    Set dbman = (New DBManager)(connection_string)

    %>
    <% 
        Dim curPage 'trang hiện tại
        Dim numPerPage  'Số bản ghi trong 1 trang 
                
        Dim totalPe 'tổng số bản ghi

        numPerPage = 5 

        if not IsEmpty(request.querystring("page")) then
        curPage = request.querystring("page")
        else 
        curPage = 1
        end if
        Set totalPe = dbman.query("Select count(*) as total from student", empty)
                
        Dim per
        per = 0

        if not totalPe.EOF then 
        per = totalPe.Fields("total")
        end if

        Dim numPage
        if per mod 5 = 0 then
        numPage = per\5
        else
             numPage = per\5 + 1
        end if
                                    
        curPage = CInt(curPage)
           
    %>
    <% 
    Dim rsa
    Dim num 
    Dim query
    if curPage = 1 then
        query = "select top "&numPerPage&" * FROM student"
    else
        num = numPerPage * (curPage - 1)
        query = "select top "&numPerPage&" * from student where student.id not in (select top "&num&" id from  student order by id) order by id"
    end if
    Set rsa = dbman.query(query, empty)
    %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Chương trình quản lý Sinh Viên</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style.css">
<script type="text/javascript">
$(document).ready(function(){
	// Activate tooltip
	$('[data-toggle="tooltip"]').tooltip();
	
	// Select/Deselect checkboxes
	var checkbox = $('table tbody input[type="checkbox"]');
	$("#selectAll").click(function(){
		if(this.checked){
			checkbox.each(function(){
				this.checked = true;                        
			});
		} else{
			checkbox.each(function(){
				this.checked = false;                        
			});
		} 
	});
	checkbox.click(function(){
		if(!this.checked){
			$("#selectAll").prop("checked", false);
		}
	});
});
</script>
</head>
<body>
    <div class="container">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-6">
						<h2>Quản Lý <b>Sinh Viên</b></h2>
					</div>
					<div class="col-sm-6">
						<a href="student-add.asp?action=add" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Thêm mới sinh viên</span></a>
						<!--<a href="#deleteEmployeeModal" class="btn btn-danger" data-toggle="modal"><i class="material-icons">&#xE15C;</i> <span>Xóa tất cả</span></a>-->						
					</div>
                </div>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
						<th>STT</th>
                        <th>Họ tên</th>
                        <th>Giới tính</th>
                        <th>Địa chỉ</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Lớp quản lý</th>
                        <th>Điểm tích lũy</th>
                        <th>Ngày sinh</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        Dim x
                        x = 1
                        do While Not rsa.EOF
                    %>
                    <tr>
                        <td>
                            <%  Response.write(x) %>
                        </td>
                        <td>
                            <%  Response.write(rsa("name")) %>
                        </td>
                        <td>
                            <%  Response.write(rsa("gender")) %>
                        </td>
                        <td>
                            <%  Response.write(rsa("address")) %>
                        </td>
                        <td>
                            <%  Response.write(rsa("email")) %>
                        </td>
                        <td>
                            <%  Response.write(rsa("phone")) %>
                        </td>
                        <td>
                            <%  Response.write(rsa("class")) %>
                        </td>
                        <td>
                            <%  Response.write(rsa("cpa")) %>
                        </td>
                        <td>
                            <%  Response.write(rsa("dateofbirth")) %>
                        </td>
                        <td>
                            
                                <% Response.write("<a class='edit' data-toggle='modal'  href='student-add.asp?id="& rsa("ID") &"&action=edit'><i class='material-icons' data-toggle='tooltip' title='Edit'>&#xE254;</i></a>") %>
                                <% Response.write("<a class='delete' data-toggle='modal'  href='student-delete.asp?id="& rsa("ID") &"'><i class='material-icons' data-toggle='tooltip' title='Delete'>&#xE872;</i></a>") %>
                        </td>
                    </tr>
                    <% 
                        x=x+1 
                        rsa.MoveNext  
                    Loop %>    
                </tbody>
            </table>
            <div class="clearfix">
                <div class="hint-text">Hiển thị <b>5</b> trong tổng số <b><%response.write(per)%></b> Sinh viên</div>
                <ul class="pagination">
                    <%if (curPage>1) then 
                    Response.write("<li class='page-item'><a href='/StudentManager.asp?page="&curPage-1&"' class='page-link'>Trang trước</a></li>")
                    else
                        Response.write("<li class='page-item disabled'><a href='#' class='page-link'>Trang trước</a></li>")
                    end if%>
                    <%
                     for i = 1 to numPage 
                        if curPage = i then
                            Response.write("<li class='page-item active'>")
                            else 
                                Response.write("<li class='page-item '>")
                            end if
                                Response.write("<a href='/StudentManager.asp?page="&i&"' class='page-link'>"&i&"</a></li>")
                            Next
                    %>
                    <%if (curPage<numPage) then
                    Response.write("<li class='page-item'><a href='/StudentManager.asp?page="&curPage+1&"' class='page-link'>Trang tiếp theo</a></li>")
                    else
                        Response.write("<li class='page-item disabled'><a href='#' class='page-link'>Trang tiếp theo</a></li>")
                    end if%>
                </ul>
            </div>
			<!-- <div class="clearfix">
                <div class="hint-text">Hiển thị <b>5</b> trong tổng số <b>25</b> Sinh viên</div>
                <ul class="pagination">
                    <li class="page-item disabled"><a href="#">Trang trước</a></li>
                    <li class="page-item"><a href="#" class="page-link">1</a></li>
                    <li class="page-item"><a href="#" class="page-link">2</a></li>
                    <li class="page-item active"><a href="#" class="page-link">3</a></li>
                    <li class="page-item"><a href="#" class="page-link">4</a></li>
                    <li class="page-item"><a href="#" class="page-link">5</a></li>
                    <li class="page-item"><a href="#" class="page-link">Trang tiếp theo</a></li>
                </ul>
            </div> -->
        </div>
    </div>
</body>
</html>                                		                            