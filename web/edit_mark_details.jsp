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
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>

<script>
var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
          $scope.getSubjectName=function (){
          //  alert('getsubject name callled ....');
           $http.get("GetSubjectDetails?"+$scope.subjectid).then(function (response) {
            $scope.mySubName = response.data.Name;
           }); 
        };
});
</script>
<script>
    function validate(){
        if(confirm("Are you Confirm ?")){
            return true;
        }
       return false;
    }
</script>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<%
if(request.getParameter("updated")!=null){
    out.println("<script>alert('Mark Updated  !')</script>");
}
if(request.getParameter("failed")!=null){
    out.println("<script>alert('Failed !')</script>");
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
          <li class="active"><a href="home.jsp"> Home </a></li>
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
  <%
   Connection con=db.Dbconnection.getCon();
            String query="select * from mark_details where id='"+request.getQueryString()+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		
		
		
  %>
   
<div class="container" ng-app="myApp" ng-controller="myCtrl">
    <div class="col-sm-2"></div>
    <div class="col-sm-4">
        <%
        if(rt.next())
            
        {
        %>
        <form action="UpdateCumCon?<%=request.getQueryString()%>" method="post" onsubmit="return validate()">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>Update Cumaltive Conversion  </h3>
				</div>
				<div class="panel-body">
                                        Type:
                                        <div class="form-group">
                                            <input type="text" name="type" class="form-control" value="<%=rt.getString("type_")%>" readonly="">
                                            
					</div>
                                        Max Mark:
                                        <div class="form-group">
                                            <input type="text" name="mark" value="<%=rt.getString("max_mark")%>" required="required" class="form-control" />
                                       </div>
                                       Convert to:
                                        <div class="form-group">
                                            <input type="text" name="convert" value="<%=rt.getString("convert_to")%>" required="required" class="form-control" />
                                       </div>
                                    
                                    
					
                                    <button type="submit" class="btn btn-success">SUBMIT</button>
				</div>
			</div>
            </form>
        <%
        }
        else{
            %>
            <center>
                <h1>Details not found !</h1>
            </center>
        <%
        }
        
        	rt.close();
            ps.close();
            con.close();
        %>
    </div>
	<div class="col-sm-4" style="">
         
		</div>

        	
		<!--  LINE-1 Content  -->
		
                <div style="height: 100px;">
			
		</div>
		
		
			
</div>

	<nav class="navbar navbar-fixed-bottom footer col-md-12">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Science and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</nav>
	
	

</body>
</html>