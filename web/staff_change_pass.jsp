<%@page import="Beans.GetSubjects"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="css/style.css">
<script>
    function validate(){
        if(document.getElementById("newpass").value!==document.getElementById("newpass1").value){
            alert('Password Does not matched');
            document.getElementById("newpass").value="";
             document.getElementById("newpass1").value="";
              document.getElementById("newpass").focus();
              return false;
        }
    }
</script>
</head>
<body>
<%
if(request.getParameter("changed")!=null){
    out.println("<script>alert('Password Changed !')</script>");
}
if(request.getParameter("incorrect")!=null){
    out.println("<script>alert('Old Password is Incorrect !')</script>");
}
if(request.getParameter("failed")!=null){
    out.println("<script>alert('Process Failed !')</script>");
}
%>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">St.Joseph's College of Arts and Scinence</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      
      
      <ul class="nav navbar-nav navbar-right">
         <li class="active"><a href="staff_home.jsp"> Home </a></li>
<!--          <li><a href="add_stud_details.jsp"> Student </a></li>-->
          
<!--          <li><a href="allocate_sub.jsp"> Subject to Staff </a></li>
          <li><a href="allocate_sub_class.jsp"> Subject to Class </a></li>-->
<li><a href="staff_change_pass.jsp"> Change Password </a></li>
               <li><a href="index.html"> Logout </a></li>
      </ul>
    </div>
  </div>
</nav>
  
   
<div class="container">
    <div class="col-sm-4"></div>
    <div class="col-sm-4" >
          
		
	
             
        <form action="StaffChangePass" method="post" onsubmit="return validate()">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>Change Password  </h3>
				</div>
				<div class="panel-body">
                                        
                                       
                                    
                                        <div class="form-group">
                                            Enter Old Password:
                                            <input type="password" name="oldpass" id='oldpass' required="required" class="form-control" placeholder="Enter Old Password" />
                                       </div>
                                    
					<div class="form-group">
                                            Enter New Password:
                                            <input type="password" name="newpass" id='newpass' required="required" class="form-control" placeholder="Enter New Password" />
					</div>
                                        <div class="form-group">
                                            Re-Enter New Password:
                                            <input type="password" name="newpass1" id='newpass1' required="required" class="form-control" placeholder="Re-Enter New Password" />
					</div>
<!--                                        <div class="form-group">
                                            <input type="text" name="regno" required="required" class="form-control" placeholder="Enter Reg.No" />
					</div>-->
					
                                    <button type="submit" class="btn btn-success">Change</button>
				</div>
			</div>
            </form>
        </div>
		</div>
    
		
		<!--  LINE-1 Content  -->
		
		<div class="col-md-4">
			
		</div>
		
		
			
</div>

	<nav class="navbar navbar-fixed-bottom footer col-md-12">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Science and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</nav>
	
	

</body>
</html>