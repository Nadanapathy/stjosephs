<%-- 
    Document   : allocate_sub
    Created on : Aug 6, 2018, 8:52:58 PM
    Author     : unbox
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- jQuery library -->
<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

 Latest compiled JavaScript 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>-->
 
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
<link rel="stylesheet" href="css/style.css">
                

<script>
function myFunction() {
  var input, filter, table, tr, td,td1, i;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[2];
    td1 = tr[i].getElementsByTagName("td")[3];
    if (td) {
       
      if ((td.innerHTML.toUpperCase().indexOf(filter) > -1) || (td1.innerHTML.toUpperCase().indexOf(filter)>-1)) {
         
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }   
    
     
    
  }
}
</script>
    <%
        String id=request.getParameter("id");
        	 
	  Connection con=db.Dbconnection.getCon();
            String query="select * from staff_details where id='"+id+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
            String staffid="",staffname="",sdept="";
            if(rt.next()){
                staffid=rt.getString("staff_id");
                staffname=rt.getString("name_");
                sdept=rt.getString("department_");
            }
            
            rt.close();
            ps.close();
        %>
<script>
var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
    
   // alert('staff id :'+'<%=staffid%>');
       $http.get("GetSubjects?<%=staffid%>").then(function (response) {
            $scope.mySubjects = response.data.Data;
         });
         
    
      $scope.loadSubjects = function(id) {
          alert("id :"+id);
          $scope.staffid;
         
         
         $http.get("AddSubjects?"+id+","+ $scope.staffid).then(function (response) {
            //$scope.mySubjects = response.data.Status;
            alert(response.data.Status);
            
             $http.get("GetSubjects?"+ $scope.staffid).then(function (response) {
            $scope.mySubjects = response.data.Data;
         });
         });
        
        
          
    };
    
      $scope.removeSubjects = function(id) {
       //   alert("id :"+id);
          $scope.staffid;
         
         
         $http.get("RemoveSubjects?"+id).then(function (response) {
            //$scope.mySubjects = response.data.Status;
            alert(response.data.Status);
            
             $http.get("GetSubjects?"+ $scope.staffid).then(function (response) {
            $scope.mySubjects = response.data.Data;
         });
            
         });
        
        
          
    };
    
     
           
            
    
    
});
</script>
    </head>
    <body>
        <%
if(request.getParameter("stored")!=null){
    out.println("<script>alert('Added !')</script>");
}
if(request.getParameter("failed")!=null){
    out.println("<script>alert('Failed !')</script>");
}
%>
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
          <li ><a href="hod_home.jsp"> Home </a></li>
          <li class="active"><a href="hod_subject_staff.jsp"> Subject to Staff </a></li>
          <li><a href="hod_sub_class.jsp"> Subject to Sem </a></li>
<!--		<li><a href="#"> Allocate </a></li>
		<li><a href="#"> Result </a></li>
                <li><a href="#"> Get List </a></li>
                <li><a href="#"> Profile </a></li>-->
      </ul>
    </div>
  </div>
</nav>
        
        
        <div ng-app="myApp" ng-controller="myCtrl">
    
  
   
   
    
    
        <div class="container" style="min-height: 498px;">
            <div class="col-sm-4">
                      <h3 ng-init="staffid='<%=staffid%>'"> Staff ID:<%=staffid%></h3>
            </div>
            <div class="col-sm-4">
                      <h3>Staff Name:<%=staffname%></h3>
            </div>
            <div class="col-sm-4">
                      <h3>Department:<%=sdept.toUpperCase()%></h3>
            </div>
            
            <h1 style="text-align: center; margin-top: 100px;">Handling Subjects and Class</h1>
            
            <br>
            
                  <table class="table table-hover" >
             
                      <thead>
        <tr>
            <th>Subject Code</th>
            <th>Subject Name</th>
             <th>Dept</th>
             <th>Sem</th>
             <th>Section</th>
            <th>Action</th>
        </tr>
                      </thead>
                      <tbody>
        <tr ng-repeat="x in mySubjects" ng-init="id=x.SubjectId">
            <td>{{x.SubjectCode}}</td> 
             <td>{{x.SubjectName}}</td> 
             <td>{{x.Department}} </td>
              <td>{{x.Semester}}</td>
             <td>{{x.Section}}</td>
            
             <td>
                 <a href="#" ng-click="removeSubjects(id)">Remove</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 <a href="add_class.jsp?id={{id}}&subcode={{x.SubjectCode}}" >Add Class</a>
             </td>
        </tr>
                      </tbody>
        
    </table>
    
    
             <h1 style="text-align: center; margin-top: 50px;">Add More Subject</h1>
             <br>

 <%
 
             query="select * from subjects order by name_ asc";
             ps=con.prepareStatement(query);
	   
	     rt=ps.executeQuery();
  %>
  
  <div class="form-group col-sm-4">
        <input type="text" class="form-control" id="myInput" onkeyup="myFunction()" placeholder="Search for Subject Name or Code.." title="Type in a name">
  </div>
  
  
<table id="myTable" class="table table-hover">
    <thead>
  <tr>
    <th>Sl.No</th>
    <th>Graduation</th>
    <th>Subject</th>
    <th>Sub.Code</th>
    <th>Action</th>
  </tr>
    </thead>
    
  <%
            int count=1;
  while(rt.next()){
      String subid=rt.getString("id");
  %>
  
  <tbody>
  <tr>
    <td><%=count%></td>
    <td><%=rt.getString("graduate_")%></td>
    <td><%=rt.getString("name_")%></td>
    <td><%=rt.getString("subject_code")%></td>
    <td><a href="#" ng-click="loadSubjects('<%=subid%>')">Add This</a></td>
  </tr>
  </tbody>
  
  <%
  }
  %>
<!--  <tr>
     <td>1</td>
    <td>graduation</td>
    <td>bsc</td>
    <td>noofsem</td>
   <td><a href="">Edit</a> &nbsp;&nbsp;&nbsp;<a href="">Delete</a></td>
  </tr>-->

  
</table>

  </div>
        </div>

<nav class="navbar footer col-md-12" style="margin-bottom: 0px;">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Science and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</nav>

    </body>
</html>
