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
<%

    String staffid=session.getAttribute("StaffId").toString();

%>
<script>
var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
    
   // alert('staff id :'+'<%=staffid%>');
       $http.get("GetSubjects?<%=staffid%>").then(function (response) {
            $scope.mySubjects = response.data.Data;
         });

});
</script>

</head>
<body>

<nav class="navbar navbar-inverse">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">St.Joseph's College of Arts and Science</a>
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
  
   
<div class="container" ng-app="myApp" ng-controller="myCtrl">
    <div style="height: 100px;"></div>
    <%
    String name=session.getAttribute("StaffName").toString();
    %>
    <center>
         <h1> Welcome ! <%=name.toUpperCase()%></h1>
    </center>
   

    <div class="col-md-12">
        <table style="width: 100%" class="table table-hover">
            <caption>
                <center>
                <h1>Handling Subjects</h1>
                </center>
            </caption>
            <tr style="background-color: #cccccc;">
                <th>Sub.Code</th>
                <th>Sub.Name</th>
                <th>Dept</th>
             <th>Sem</th>
             <th>Section</th>
                <th>Action</th>
            </tr>
            
            <tr ng-repeat="x in mySubjects" >
              <td>{{x.SubjectCode}}</td> 
              <td>{{x.SubjectName}}</td> 
              <td>{{x.Department}} </td>
              <td>{{x.Semester}}</td>
              <td>{{x.Section}}</td>
              <td>
                 <a href="mark_entry.jsp?{{x.SubjectId}}">Enter Mark</a> &nbsp;&nbsp;&nbsp;&nbsp;
<!--                 <a href="re_exam_entry.jsp?{{x.SubjectCode}}">Re-Exam Enter Mark</a>&nbsp;&nbsp;&nbsp;&nbsp;-->
                 <a href="get_mark_list.jsp?{{x.SubjectId}}">Get Mark List</a> &nbsp;&nbsp;&nbsp;&nbsp;
                 <a href="cumulative.jsp?{{x.SubjectId}}">Get Cumulative</a>
                 
              </td>
            </tr>
        </table>
    </div>
	   <div style="height: 400px;"></div>
	
	
		
		<!--  LINE-1 Content  -->
		
		<div class="col-md-4">
			
		</div>
		
		
			
</div>

	<div class="footer col-md-12">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Scinence and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</div>
	
	

</body>
</html>