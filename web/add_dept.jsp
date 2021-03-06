<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="remote/bootstrap.min.css">

<!-- jQuery library -->
<script src="remote/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="remote/bootstrap.min.js"></script>
<script src="remote/angular.min.js"></script>

<link rel="stylesheet" href="css/style.css">
</head>
<body>
<%
if(request.getParameter("stored")!=null){
    out.println("<script>alert('Added !')</script>");
}
if(request.getParameter("failed")!=null){
    out.println("<script>alert('Failed !')</script>");
}
if(request.getParameter("has")!=null){
    out.println("<script>alert('Department Already Exist !')</script>");
}
%>
<nav class="navbar navbar-inverse">
    <%
String usertype=session.getAttribute("Type").toString();
String home_page="";
if(usertype.equalsIgnoreCase("admin")){
    home_page="home.jsp";
}
if(usertype.equalsIgnoreCase("hod")){
    home_page="hod_home.jsp";
}
%>
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
          <li class="active"><a href="<%=home_page%>"> Home </a></li>
          <li class="dropdown">
              <a href="#" data-toggle="dropdown"> Dept<span class="caret"></span> </a>
              <ul class="dropdown-menu" style="">
                  <li><a href="add_dept.jsp">Add Dept</a></li>
                  <li><a href="edit_dept.jsp">Edit Dept</a></li>
              </ul>
          </li>
          <li class="dropdown">
              <a href="#" data-toggle="dropdown"> Subject<span class="caret"></span> </a>
              <ul class="dropdown-menu">
                  <li><a href="add_subject.jsp">Add Subject</a></li>
                  <li><a href="edit_subject.jsp">Edit Subject</a></li>
              </ul>
          </li>
          <li class="dropdown">
              <a href="#" data-toggle="dropdown"> Staff<span class="caret"></span> </a>
              <ul class="dropdown-menu">
                  <li><a href="add_staff.jsp">Add Staff</a></li>
                  <li><a href="edit_staff.jsp">Edit Staff</a></li>
              </ul>
          </li>
            <li class="dropdown">
              <a href="#" data-toggle="dropdown"> Student<span class="caret"></span> </a>
              <ul class="dropdown-menu">
                  <li><a href="add_stud_details.jsp">Add Student</a></li>
                  <li><a href="edit_staff.jsp">Edit Student</a></li>
              </ul>
          </li>
          <li class="dropdown">
              <a href="#" data-toggle="dropdown"> Allocate<span class="caret"></span> </a>
              <ul class="dropdown-menu">
                    <li><a href="allocate_class_sub.jsp">Sub&Staff to Class</a></li>
                  <li><a href="subject_staff.jsp">Subject to Staff</a></li>
                  <li><a href="allocate_sub_class.jsp">Subject to Sem</a></li>
              </ul>
          </li>
          <li><a href="re_exam_entry.jsp"> Re-Exam Entry </a></li>
<!--          <li><a href="announce.jsp"> Announce  </a></li>-->
           
          <li class="dropdown">
              <a href="failure_list.jsp" data-toggle="dropdown"> Get List<span class="caret"></span> </a>
              <ul class="dropdown-menu">
                   <li ><a href="defaulters_list.jsp"> Defaulters List</a></li>
                   <li ><a href="failure_list.jsp"> Failures List </a></li>
                   <li ><a href="single_failures.jsp"> Single Failures List</a></li>
                   <li ><a href="mark_list.jsp"> Mark List </a></li>
                   <li ><a href="cumulative_list.jsp"> Cumulative List </a></li>
                   <li ><a href="cum_single_failures.jsp"> Cum.Single Fail List </a></li>
              </ul>
          </li>
           <li class="dropdown">
              <a href="#" data-toggle="dropdown"> Others<span class="caret"></span> </a>
              <ul class="dropdown-menu">
                  <li><a href="announce.jsp">Announce</a></li>
                  <li><a href="conversions.jsp">Convertions</a></li>
              </ul>
          </li>
           <li class="dropdown">
              <a href="failure_list.jsp" data-toggle="dropdown"> Profile<span class="caret"></span> </a>
              <ul class="dropdown-menu" style="left: -70px;">
                  <li><a href="change_password.jsp"> Change Password </a></li>
                    <li><a href="index.html"> Logout </a></li>
              </ul>
          </li>
          
      </ul>
    </div>
  </div>
</nav>
  
   
<div class="container">
    <div class="col-sm-4"></div>
	<div class="col-sm-4" style="margin-top: 100px;">
            <form action="AddDept" method="post">
                <div class="panel panel-default" >
				<div class="panel-heading">
					<h3>Add New Department  </h3>
				</div>
				<div class="panel-body">
                                        <div class="form-group">
                                           
                                            <select name="graduate" required="required" class="form-control">
                                                <option value="">--Select Graduate---</option>
                                                <option value="ug">UG</option>
                                                <option value="pg">PG</option>
                                            </select>
                                            
					</div>
                                        <div class="form-group">
                                           
                                            <input type="text" min="1" name="department" required="required" class="form-control" placeholder="Enter Department" />
					</div>
					<div class="form-group">
                                            <input type="number" min="1" name="semcount" required="required" class="form-control" placeholder="Enter NO of Semester" />
					</div>
					
                                    <button type="submit" class="btn btn-success">SUBMIT</button>
				</div>
			</div>
            </form>
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