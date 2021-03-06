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
  Connection con=db.Dbconnection.getCon();
            String query="select name_ from department";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
 %> 
   
<script>
var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
    
  //  alert($scope.dept);
        $http.get("GetSubClass?"+$scope.dept+","+$scope.sem).then(function (response) {
            $scope.mySubjects = response.data.Data;
         });
         
    
      $scope.loadSubjects = function(id,dept,sem) {
      //   alert("id :"+id);
        //  $scope.staffid;
         
         
         $http.get("AddSubClass?"+id+","+dept+","+sem).then(function (response) {
            //$scope.mySubjects = response.data.Status;
         //   alert(response.data.Status);
            
             $http.get("GetSubClass?"+dept+","+sem).then(function (response) {
          //        alert(response.data.Data.SubjectId);
              $scope.mySubjects = response.data.Data;
             });
         });
        
        
          
    };
    
      $scope.removeSubjects = function(id) {
       //   alert("id :"+id);
         // $scope.staffid;
         
         
         $http.get("RemoveSubClass?"+id).then(function (response) {
            //$scope.mySubjects = response.data.Status;
       //     alert(response.data.Status);
            
              $http.get("GetSubClass?"+$scope.dept+","+$scope.sem).then(function (response) {
            $scope.mySubjects = response.data.Data;
         });
            
         });
           
    };
    
     
           
            
    
    
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
          <li ><a href="hod_home.jsp"> Home </a></li>
          <li ><a href="hod_subject_staff.jsp">Subject to Staff</a></li>
          <li class="active"><a href="hod_sub_class.jsp"> Subject to Sem </a></li>
      </ul>
    </div>
  </div>
</nav>
        
        
        <div ng-app="myApp" ng-controller="myCtrl">
    
  
   
   
    
    
        <div class="container">
            <div class="col-sm-4"></div>
            <form action="allocate_sub_class1.jsp" method="post" >
            <div class="col-sm-4" style="margin-top: 100px;">
           
                <div class="panel panel-default" >
                     <center>
				<div class="panel-heading">
					<h4>Allocate Subjects to Semester </h4>
				</div>
                    
				<div class="panel-body">
                                        
                                        <div class="form-group">
                                            
                                            <select required="required" name="department" class="form-control">
                                                <%
            String udept=session.getAttribute("Department").toString();
                                                
                                                    %>
                                                    
                                                    
                                                    <option value="<%=udept%>"><%=udept.toUpperCase()%></option>
                                                
                                                <%
                                               
                                                rt.close();
                                                ps.close();
                                                %>
                                               
                                            </select>
                                          
					</div><br>
                                        <div class="form-group">
                                            
                                            <select name="semester" required="required" class="form-control">
                                                <option value="">--Select Semester--</option>
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>
                                            </select>
                                           
					</div>
                                  
                                                <br>
                                       
<!--					<div class="form-group">
                                            <input type="file"  name="file" required="required" class="form-control" placeholder="selct file" />
					</div>-->
                                               
                                                <button type="submit" class="btn btn-success">Submit</button>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <button type="reset" class="btn btn-info">CLEAR</button>
                                                </center>
				</div>
			</div>
            </form>
                                                
                                                <div class="col-sm-4"></div>
		</div>
                     
     
   <%
   
       if(request.getParameter("department")!=null && request.getParameter("semester")!=null){
         String dept=request.getParameter("department");
         String sem=request.getParameter("semester");
      
   %> 
    
   

 <%
 
             query="select * from subjects order by name_ asc";
             ps=con.prepareStatement(query);
	   
	     rt=ps.executeQuery();
  %>
 
 
  
  <div class="col-md-6">
  <h2>Dept :<%=dept.toUpperCase()%></h2>
  </div>
  <div class="col-md-6">
  <h2>Semester :&nbsp;<%=sem%></h2>
  </div>
  
 <table class="table table-hover" ng-init="dept='<%=dept%>';sem='<%=sem%>'" >
     
         
         <thead>
         <tr>
         <th>Subject Code</th>
         <th>Subject Name</th>
         <th>Action</th>
     </tr>
         </thead>
     
     <%
//     String query1="select name_ from department";
//            PreparedStatement ps1=con.prepareStatement(query);
//	   
//	    ResultSet rt=ps.executeQuery();
     %>
       
     <tbody>
     <tr ng-repeat="x in mySubjects" ng-init="id=x.SubjectId">
            <td>{{x.SubjectCode}}</td> 
             <td>{{x.SubjectName}}</td> 
             <td><a href="#" ng-click="removeSubjects(id)">Remove</a></td>
        </tr>
     </tbody>
        
 </table>
     
      <h1 style="text-align: center;">Add More Subject</h1>
      <div class="form-group col-sm-4">
        <input type="text" class="form-control" id="myInput" onkeyup="myFunction()" placeholder="Search for Subject Name or Code.." title="Type in a name">
      </div>
     
<table class="table table-hover" id="myTable">
    <thead>    
  <tr class="header">
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
    <td><a href="#" ng-click="loadSubjects('<%=subid%>','<%=dept%>','<%=sem%>')">Add This</a></td>
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
<%
 }
           
%>
  </div>
  
  
  <nav class="navbar navbar-fixed-bottom footer col-md-12">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Science and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</nav>
  
    </body>
</html>
