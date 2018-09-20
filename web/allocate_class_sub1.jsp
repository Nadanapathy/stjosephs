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
</head>
<body>
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
          <li class="active"><a href="<%=home_page%>"> Home </a></li>
     
<!--       
          <li class="dropdown">
              <a href="#" data-toggle="dropdown"> Allocate<span class="caret"></span> </a>
              <ul class="dropdown-menu">
                  <li><a href="hod_subject_staff.jsp">Subject to Staff</a></li>
                  <li><a href="allocate_sub_class.jsp">Subject to Sem</a></li>
              </ul>
          </li>
          <li><a href="re_exam_entry.jsp"> Re-Exam Entry </a></li>
        
          <li class="dropdown">
              <a href="failure_list.jsp" data-toggle="dropdown"> Get List<span class="caret"></span> </a>
              <ul class="dropdown-menu">
                   <li ><a href="defaulters_list.jsp"> Defaulters List</a></li>
                   <li ><a href="failure_list.jsp"> Failures List </a></li>
                   <li ><a href="mark_list.jsp"> Mark List </a></li>
              </ul>
          </li>
          
           <li class="dropdown">
              <a href="failure_list.jsp" data-toggle="dropdown"> Profile<span class="caret"></span> </a>
              <ul class="dropdown-menu" style="left: -70px;">
                  <li><a href=""> Change Password </a></li>
                    <li><a href="index.html"> Logout </a></li>
              </ul>
          </li>-->
          
      </ul>
    </div>
  </div>
</nav>
  
   
<div class="container">
    <div class="col-sm-12">
        <form action="allocate_class_sub1.jsp" method="post">
            Section :
            <select name="section" required="">
                <option value="">--select section--</option>
                <option value="a">A</option>
                 <option value="b">B</option>
                  <option value="c">C</option>
                   <option value="d">D</option>
                    <option value="e">E</option>
                     <option value="f">F</option>
            </select>
            Semester:
            <select name="semester" required="">
                 <option value="">--select semester--</option>
                <option value="1">1</option>
                 <option value="2">2</option>
                  <option value="3">3</option>
                   <option value="4">4</option>
                    <option value="5">5</option>
                     <option value="6">6</option>
            </select>
            Shift:
            <select name="shift" required="">
                 <option value="">--select shift--</option>
                <option value="d">D</option>
                <option value="e">E</option>
            </select>
          
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
            <input type="submit" value="Submit">
        </form>
    </div>
    <div>
        <form
    </div>
	<div class="col-sm-4" style="margin-top: 100px;">
          
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