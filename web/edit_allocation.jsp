<%-- 
    Document   : edit_dept
    Created on : Aug 5, 2018, 8:24:12 PM
    Author     : unbox
--%>

<%@page import="Beans.CheckDuplicate"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- jQuery library -->
<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

 Latest compiled JavaScript 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>-->

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="css/style.css">
<script>
    function deletethis(id){
        if(confirm('Are Your Sure, Delete this ?')){
           location.href = "delete.jsp?id="+id+"&type=department";
        }
    }
</script>

<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.2/angular.min.js"></script>
<script>
var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http,$window) {
  
       // $scope.staffid;
        
        $scope.getStaffName=function (){
            alert('getstaff name callled ....');
           $http.get("GetStaffDetails?"+$scope.staffid).then(function (response) {
            $scope.myStaffName = response.data.Name;
           }); 
        };
        
        $scope.getSubjectName=function (){
            alert('getsubject name callled ....');
           $http.get("GetSubjectDetails?"+$scope.subjectid).then(function (response) {
            $scope.mySubName = response.data.Name;
           }); 
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
          <li ><a href="<%=home_page%>"> Home </a></li>
          <li><a href="allocate_class_sub.jsp">Back</a></li>
<!--		<li><a href="#"> Allocate </a></li>
		<li><a href="#"> Result </a></li>
                <li><a href="#"> Get List </a></li>
                <li><a href="#"> Profile </a></li>-->
      </ul>
    </div>
  </div>
</nav>
    
     <div class="container" style="min-height: 498px;" ng-app="myApp" ng-controller="myCtrl"> 
        
             <h1 style="text-align: center;">Edit Details</h1>
             <%
             String id=request.getQueryString();
	   
            Connection con=db.Dbconnection.getCon();
            String query="SELECT * FROM `handling_subjects` WHERE `id`='"+id+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
            if(rt.next()){
             %>
             <form action="UpdateHandlingSubject?<%=id%>" method="post"> 
                 SubjectCode:
                 <select name="subjectid" ng-model="subjectid" ng-init="subjectid='<%=rt.getString("subject_code")%>'" data-ng-init="getSubjectName()" ng-change="getSubjectName()" >
                     <option value="<%=rt.getString("subject_code")%>"><%=rt.getString("subject_code")%></option>
                      <%
                              
             query="SELECT * FROM `subjects` order by subject_code asc";
              PreparedStatement ps1=con.prepareStatement(query);
	   
	      ResultSet rt1=ps1.executeQuery();
		while(rt1.next()){
                    %>
                    <option value="<%=rt1.getString("subject_code")%>"><%=rt1.getString("subject_code")%></option>
                               <%
                }
		
		rt1.close();
            ps1.close();
            
                               %>
                 </select><br><br>
                 Subject Name:
                 <input type="text" name="mySubName" ng-init="mySubName='<%=rt.getString("subject_name")%>'" ng-model="mySubName"   value="{{mySubName}}" required="">
<!--                  <select name="subjectname">
                     <option value="<%=rt.getString("subject_name")%>"><%=rt.getString("subject_name")%></option>
                 </select>-->
                 <br><br>
                 Staff Id:
                 <select name="staffid" ng-model="staffid" ng-init="staffid='<%=rt.getString("staff_id")%>'" ng-change="getStaffName()" >
                     <option value="<%=rt.getString("staff_id")%>"><%=rt.getString("staff_id").toUpperCase()%></option>
                       <%
                              
             query="select * from staff_details order by name_ asc";
               ps1=con.prepareStatement(query);
	   
	      rt1=ps1.executeQuery();
              String staffname="";
		while(rt1.next()){
                    staffname=Beans.GetStaffDetails.getName(rt1.getString("staff_id"));
                    %>
                     <option value="<%=rt1.getString("staff_id")%>"><%=rt1.getString("staff_id")%></option>
                               <%
                }
		
		rt1.close();
            ps1.close();
            
                               %>
                 </select><br><br>
                 Staff Name:<input type="text" name="myStaffName" ng-init="myStaffName='<%=staffname%>'"  ng-model="myStaffName"  value="{{myStaffName}}" required="">
                 <br><br>
                 Semester:
                  <select name="semester">
                       <%
                        String[] s=new String[]{"1","2","3","4","5","6","7","8"};
        
                        String[] c=CheckDuplicate.removeAndSetFirst(s, rt.getString("semester_").toLowerCase());
                        for(String ss:c){
                            %>
                            <option value="<%=ss%>"><%=ss.toUpperCase()%></option>
                       <%
                        }
                      %>

                 </select><br><br>
                 Section:
                  <select name="section">
                      <%
                         s=new String[]{"a","b","c","d","e","f"};
        
                        c=CheckDuplicate.removeAndSetFirst(s, rt.getString("section_").toLowerCase());
                        for(String ss:c){
                            %>
                            <option value="<%=ss%>"><%=ss.toUpperCase()%></option>
                       <%
                        }
                      %>

                 </select><br><br>
                 Shift:
                  <select name="shift">
                        <%
                         s=new String[]{"d","e"};
        
                         c=CheckDuplicate.removeAndSetFirst(s, rt.getString("shift_").toLowerCase());
                        for(String ss:c){
                            %>
                            <option value="<%=ss%>"><%=ss.toUpperCase()%></option>
                       <%
                        }
                      %>

                 </select><br><br>
                 Is Incharge:
                  <select name="incharge">
                        <%
                         s=new String[]{"yes","no"};
        
                         c=CheckDuplicate.removeAndSetFirst(s, rt.getString("is_incharge").toLowerCase());
                        for(String ss:c){
                            %>
                            <option value="<%=ss%>"><%=ss.toUpperCase()%></option>
                       <%
                        }
                      %>

                 </select><br><br>
                 Department:
                  <select name="department">
                     <option value="<%=rt.getString("department_")%>"><%=rt.getString("department_").toUpperCase()%></option>
                        <%
                              
            query="select * from department order by name_ asc";
               ps1=con.prepareStatement(query);
	   
	      rt1=ps1.executeQuery();
		while(rt1.next()){
                    %>
                     <option value="<%=rt1.getString("name_")%>"><%=rt1.getString("name_").toUpperCase()%></option>
                               <%
                }
		
		rt1.close();
            ps1.close();
            
                               %>
                 </select><br><br>
                 Year:
                 <select>
                       <%
                         s=new String[]{"yes","no"};
        
                         c=CheckDuplicate.removeAndSetFirst(s, rt.getString("is_incharge").toLowerCase());
                        for(String ss:c){
                            %>
                            <option value="<%=ss%>"><%=ss.toUpperCase()%></option>
                       <%
                        }
                      %>
                 </select>
                 <button type="submit">Update</button>
                 
             </form>
             
             <%
    
            }
		
		rt.close();
            ps.close();
            con.close();
	 
             %>


  
  


  </div>

<nav class="navbar footer col-md-12" style="margin-bottom: 0px;">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Science and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</nav>

</body>
</html>
