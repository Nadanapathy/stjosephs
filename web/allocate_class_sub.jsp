<%@page import="Beans.Get"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Beans.GetSubjects"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
     <script>
function myFunction() {
   // alert('1');
  var input, filter, select,option, i;
 input = document.getElementById("sstaffid");
  filter = input.value.toUpperCase();
 
  select = document.getElementById("myselect");
  option=select.getElementsByTagName("option");
  // alert(select.length);
   for( i=0;i < select.length; i++){
       option=select.getElementsByTagName("option")[i];
     //  alert(option.value);
       if(option.innerHTML.toUpperCase().indexOf(filter) > -1){
           option.style.display = "";
        
           
       }else{
           option.style.display = "none";
       }
   }
}

function myFunction1() {
   // alert('1');
  var input, filter, select,option, i;
 input = document.getElementById("ssubid");
  filter = input.value.toUpperCase();
 
  select = document.getElementById("myselect1");
  option=select.getElementsByTagName("option");
  // alert(select.length);
   for( i=0;i < select.length; i++){
       option=select.getElementsByTagName("option")[i];
     //  alert(option.value);
       if(option.innerHTML.toUpperCase().indexOf(filter) > -1){
           option.style.display = "";
        
           
       }else{
           option.style.display = "none";
       }
   }
}
</script>
<script>
    function deletethis(id){
        if(confirm('Are Your Sure, Delete this ?')){
           location.href = "delete.jsp?id="+id+"&type=subject";
        }
    }
</script>
<script>
var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
  
       // $scope.staffid;
        
        $scope.getStaffName=function (){
          //  alert('getstaff name callled ....'+$scope.staffname);
           $http.get("GetStaffDetails?"+$scope.staffname).then(function (response) {
          //     alert(response.data.StaffId);
            // $scope.myStaffName = response.data.Name;
             $scope.myStaffId = response.data.StaffId;
          //   alert($scope.myStaffid);
           }); 
        };
        
        $scope.getSubjectName=function (){
          //  alert('getsubject name callled ....');
           $http.get("GetSubjectDetails?"+$scope.subjectid).then(function (response) {
            $scope.mySubName = response.data.Name;
           }); 
        };
        var dept=document.getElementById("dept").value;
            var sem=document.getElementById("semester").value;
            var section=document.getElementById("section").value;
            var shift=document.getElementById("shift").value;
            var year=document.getElementById("year").value;
            
         $http.get("GetHandlingSubject?"+sem+","+section+","+shift+","+dept+","+year).then(function (response) {
                 $scope.mySubjects = response.data.Data;
               //  alert($scope.mySubjects);
                 }); 
        
        $scope.addThis=function(){
//            dept=document.getElementById("dept").value;
//            sem=document.getElementById("semester").value;
//             section=document.getElementById("section").value;
//             shift=document.getElementById("shift").value;
//             year=document.getElementById("year").value;
            
        
//alert("dept :"+dept);
    //        alert('staff id '+$scope.staffid);
            
//            alert('sub id '+$scope.subjectid);
//            alert('incharge '+$scope.incharge);
//            alert($scope.mySubName);
            if($scope.myStaffId && $scope.subjectid && $scope.incharge){
               // alert('true');
                 $http.get("AddHandlingSubject?"+$scope.myStaffId+","+$scope.subjectid+","+$scope.incharge+","+sem+","+section+","+shift+","+dept+","+year).then(function (response) {
                // $scope.my = response.data.Name;
                // alert(my);
                 $http.get("GetHandlingSubject?"+sem+","+section+","+shift+","+dept+","+year).then(function (response) {
                 $scope.mySubjects = response.data.Data;
                // alert($scope.mySubjects);
                 }); 
                 }); 
                 
                
                 
            }else{
                alert('Please Select All Fields !');
            }
            
        };
        
        
         $scope.removeSubjects = function(id) {
       //   alert("id :"+id);
         // $scope.staffid;
         
           if(confirm('Are Your Sure, Delete this ?')){
                 $http.get("RemoveSubjects?"+id).then(function (response) {
            //$scope.mySubjects = response.data.Status;
          //  alert(response.data.Status);
            $http.get("GetHandlingSubject?"+sem+","+section+","+shift+","+dept+","+year).then(function (response) {
                 $scope.mySubjects = response.data.Data;
              //   alert($scope.mySubjects);
                 }); 
           
         });
           }
       
           
    };
  
});
</script>

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
      <a class="navbar-brand" href="#">St.Joseph's College of Arts and Science</a>
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
  
   
          <div class="container" ng-app="myApp" ng-controller="myCtrl">
    <div class="col-sm-12">
        <form action="" method="post">
             <div class="col-sm-2">
                  <label>Dept:</label>
                  <%
                  if(usertype.equalsIgnoreCase("admin")){
                      Connection con=db.Dbconnection.getCon();
            String query="select name_ from department";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
                     %>
                   <select name="department" class="form-control" required="">
                    <option value="">--select section--</option>
                      <%
                        while(rt.next()){
                        %>
                      <option value="<%=rt.getString("name_")%>"><%=rt.getString("name_").toUpperCase()%></option>
                                                
                       <%
                       }
                        rt.close();
                        ps.close();
                        con.close();
                        %>
                </select> 
                  
                  <% 
                  }else{
                      String dept=session.getAttribute("Department").toString();
                      %>
                   <select name="department" class="form-control" required="">
                    <option value="<%=dept%>"><%=dept%></option>
                   
                </select> 
                  <%
                  }
                  %>
               
             </div>
           
             <div class="col-sm-2">
                  <label>Section :</label>
                <select name="section" class="form-control" required="">
                    <option value="">--select section--</option>
                    <option value="a">A</option>
                    <option value="b">B</option>
                    <option value="c">C</option>
                    <option value="d">D</option>
                    <option value="e">E</option>
                    <option value="f">F</option>
                </select> 
             </div>
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <div class="col-sm-2">
                <label>Semester:</label>  
                  <select name="semester" class="form-control" required="">
                 <option value="">--select semester--</option>
                <option value="1">1</option>
                 <option value="2">2</option>
                  <option value="3">3</option>
                   <option value="4">4</option>
                    <option value="5">5</option>
                     <option value="6">6</option>
            </select>
             </div>
             <div class="col-sm-2">
                <label>Shift:</label> 
                 <select name="shift" class="form-control" required="">
                 <option value="">--select shift--</option>
                <option value="d">D</option>
                <option value="e">E</option>
            </select>
             </div>
               <%
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy");
            String y=sdf.format(new Date());
            String[] ac=Get.getAcademicYear();
            %>
             <div class="col-sm-2">
                <label> Select Year:</label>  
                <select name="year" class="form-control"   >
                <option value="<%=ac[0]%> <%=ac[1]%>"><%=ac[0]%> <%=ac[1]%></option>
<!--                <option value="nov">Nov <%=y%></option>-->
                </select> 
               
                <input type="hidden" readonly="" class="form-control" value="<%=y%>" style="width: 40px;">
             </div>
            
             <div class="col-md-2" style="margin-top: 23px;">
                   <input type="submit" value="Submit" class="btn-success">
             </div>
                 
     
         
        </form>
    </div>
	<div >
          <%
          if(request.getParameter("department")!=null && request.getParameter("section")!=null && request.getParameter("semester")!=null && request.getParameter("shift")!=null && request.getParameter("year")!=null){
          String dept=request.getParameter("department");
          %>
           <form action="" method="post" name="add">
               <table style="width: 80%" >
                   <caption >
                       <center>
                            &nbsp;&nbsp;&nbsp;
                       <h3 style="float: left;">Dept :<input type="text" id="dept"  style="width: 155px;border-style: none;" value="<%=dept.toUpperCase()%>" readonly="" required=""></h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                       <h3 style="float: left;">Section :<input type="text" id="section"  style="width: 35px;border-style: none;" value="<%=request.getParameter("section").toUpperCase()%>" readonly="" required=""></h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                       <h3 style="float: left;">Semester :<input type="text" id="semester"   style="width: 35px;border-style: none;" value="<%=request.getParameter("semester").toUpperCase()%>" readonly="" required=""></h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                       <h3 style="float: left;">Shift :<input type="text" id="shift"   style="width: 35px;border-style: none;" value="<%=request.getParameter("shift").toUpperCase()%>" readonly="" required=""></h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                       <h3 style="float: left;" >Year :<input type="text" id="year"  style="width: 150px;border-style: none;" value="<%=request.getParameter("year").toUpperCase()%>" readonly="" required=""></h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                       </center> 
                      
                   </caption>
                            
                       <tr >
                       
                       <th style="text-align: center;">Staff Name</th>
                       <th style="text-align: center;">Staff Id</th>
                       <th style="text-align: center;">Sub.Code</th>
                       <th style="text-align: center;">Sub.Name</th>
                       <th style="text-align: center;">Is Incharge</th>
                   </tr>
                   <tr>
                       
                       <td>
                            <div class="col-sm-2">
                              <input type="text" class="form-control" style="width: 200px;" id="sstaffid" onkeyup="myFunction()" placeholder="search staff name" >
                              <select name="myStaffName" class="form-control" ng-model="staffname" id="myselect" style="width: 200px;" ng-change="getStaffName()">
                               <%
                               Connection con=db.Dbconnection.getCon();
            String query="select * from staff_details order by name_ asc";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		while(rt.next()){
                    %>
                    <option value="<%=rt.getString("name_")%>"><%=rt.getString("name_")%></option>
                               <%
                }
		
		rt.close();
            ps.close();
         
                               %>
                               
                           </select>  
                           </div>
                          
                       </td>
                       
                       <td>
                           <div class="col-sm-2">
                               <input type="text" name="myStaffId" class="form-control" style="width: 250px;" ng-model="myStaffId"  value="{{myStaffId}}" required="">
                           </div>
                          
                       </td>
                       <td>
                            <div class="col-sm-2">
                            <input type="text" class="form-control" style="width: 100px;" id="ssubid" onkeyup="myFunction1()" placeholder="search Sub.Code" >
                            <select name="subjectid" class="form-control" style="width: 100px;" ng-model="subjectid" id="myselect1" ng-change="getSubjectName()">
                               <%
                              
             query="SELECT * FROM `subjects` order by subject_code asc";
             ps=con.prepareStatement(query);
	   
	     rt=ps.executeQuery();
		while(rt.next()){
                    %>
                    <option value="<%=rt.getString("subject_code")%>"><%=rt.getString("subject_code")%></option>
                               <%
                }
		
		rt.close();
            ps.close();
            con.close();
                               %>
                               
                           </select>
                            </div>
                       </td>
                       <td>
                           <div  class="col-md-12">
                               <input type="text" name="mySubName" class="form-control" style="width: 200px;" ng-model="mySubName"   value="{{mySubName}}" required="">  
                           </div>
                          
                       </td>
                       <td>
                           <div class="col-md-12" style="width: 110px;">
                               <select name="incharge" ng-model="incharge" class="form-control" ng-init="incharge='yes'">
                               <option value="yes">YES</option>
                               <option value="no">NO</option>
                           </select>
                           </div>
                           
                       </td>
                       <td>
                           <div class="col-md-12" style="width: 120px;">
                               <button type="button" class="btn-success" ng-click="addThis()">Add This</button>
                           </div>
                          
                       </td>
                   </tr>
                   
               </table>
           </form>
           
                               
                               <table class="table">
                                   <caption>
                                       <center>
                                           <h3>Subject and Staff Details</h3>
                                       </center>
                                   </caption>
                                  <tr>
                                      <th>Sub.Code</th><th>Sub.Name</th><th>Staff Id</th><th>Staff Name</th><th>Is Incharge</th><th>Action</th>
                   </tr> 
                   <tr  ng-repeat="x in mySubjects" ng-init="id=x.SubjectId">
                       
                         <td>{{x.SubjectCode}}</td> 
                          <td>{{x.SubjectName}}</td> 
                          <td>{{x.StaffId}}</td> 
                        <td>{{x.StaffName}}</td> 
                           <td>{{x.Isincharge}}</td> 
                           <td><a href="edit_allocation.jsp?{{id}}">Edit</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" ng-click="removeSubjects(id)">Delete</a></td>
                   </tr>
                               </table>
            
            <%   
          }
          %>
	</div>
        <div style="height: 150px;">
        </div>
		
		<!--  LINE-1 Content  -->
		
		
		
			
</div>

	<nav class="navbar navbar-fixed-bottom footer col-md-12">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Science and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</nav>
	
	

</body>
</html>