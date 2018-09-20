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
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>

<script>
var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
           $scope.getSubjectName=function (){
           // alert('getsubject name callled ....');
           $http.get("GetSubject?"+$scope.department+","+$scope.semester).then(function (response) {
            $scope.mySub = response.data.Data;
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
    <%
//String usertype=session.getAttribute("Type").toString();
//String home_page="";
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
                  <li><a href="edit_student.jsp">Edit Student</a></li>
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
                   <li ><a href="single_sub_mark_list.jsp"> Sub.wise List(xlsx) </a></li>
                   <li ><a href="cumulative_list.jsp"> Cumulative List </a></li>
                   <li ><a href="cum_single_failures.jsp"> Cum.Single Fail List </a></li>
                   <li ><a href="incharge_staff_list.jsp"> Incharge Staffs List </a></li>
              </ul>
          </li>
           <li class="dropdown">
              <a href="#" data-toggle="dropdown"> Others<span class="caret"></span> </a>
              <ul class="dropdown-menu">
                  <li><a href="announce.jsp">Announce</a></li>
                  <li><a href="conversions.jsp">Convertions</a></li>
                   <li><a href="Backup">BackUp</a></li>
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
            String query="select name_ from department";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
 %> 
   
 <div class="container" style="min-height: 468px;" ng-app="myApp" ng-controller="myCtrl">
    <div class="col-sm-4"></div>
    <div class="col-sm-4" style="margin-top: 10px;">
            <form action="" method="post" >
                <div class="panel panel-default" >
				<div class="panel-heading">
					<h3>Re Exam Entry  </h3>
				</div>
                   
				<div class="panel-body">
                                       
                                        <div class="form-group">
                                            Select Department:
                                            <select required="required" name="department" ng-model="department" class="form-control">
                                                <option value="">--Select Department--</option>
                                                <%
                                                while(rt.next()){
                                                    %>
                                                    <option value="<%=rt.getString("name_")%>"><%=rt.getString("name_").toUpperCase()%></option>
                                                
                                                <%
                                                }
                                                rt.close();
                                                ps.close();
                                                %>
                                               
                                            </select>
                                          
					</div>
                                        <div class="form-group">
                                            Select Semester:
                                            <select name="cursem" ng-model="semester" required="required" ng-change="getSubjectName()" class="form-control">
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
                                         <div class="form-group">
                                             Select Section:
                                             <select name="section" required="required" class="form-control">
                                                <option value="">--Select Section--</option>
                                                <option value="a">A</option>
                                                <option value="b">B</option>
                                                <option value="c">C</option>
                                                <option value="d">D</option>
                                                <option value="e">E</option>
                                                <option value="f">F</option>
                                                <option value="g">G</option>
                                                <option value="h">H</option>
                                            </select>
                                           
					</div>
<!--                                           <div class="form-group">
                                             <select name="year" required="required" class="form-control">
                                                <option value="">--Select Current Year--</option>
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                
                                            </select>
                                           
					</div>-->
                                         <div class="form-group">
                                             Select Shift:
                                             <select name="shift" required="required" class="form-control">
                                                <option value="">--Select Shift--</option>
                                                <option value="d">D</option>
                                                <option value="e">E</option>
                                              
                                                
                                            </select>
                                           
					</div>
                                         <div class="form-group">
                                             Select Subject:
                                             <select name="subject" required="required" class="form-control" >
                                                <option ng-repeat="x in mySub" value="{{x.SubjectCode}}">{{x.SubjectName}}</option>
                                               
                                             
                                            </select>
                                           
					</div>
                                         <div class="form-group">
                                             Type:
                                             <select name="type" required="required" class="form-control">
                                                <option value="reexam">Re Exam</option>
<!--                                                <option value="cia1">CIA 1</option>
                                                <option value="cia2">CIA 2</option>
                                                <option value="re-cia1">Re-Exam CIA 1</option>
                                                <option value="re-cia2">Re-Exam CIA 2</option>
                                                <option value="assign1">ASSIGNMENT 1</option>
                                                <option value="assign2">ASSIGNMENT 2</option>
                                                <option value="attendance">ATTENDANCE</option>-->
                                             
                                            </select>
                                           
					</div>
<!--					<div class="form-group">
                                            <input type="file"  name="file" required="required" class="form-control" placeholder="selct file" />
					</div>-->
                                                <center>
                                                <button type="submit" class="btn btn-success">Submit</button>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <button type="reset" class="btn btn-info">CLEAR</button>
                                                </center>
				</div>
			</div>
            </form>
		</div>
           
                                                <!--  LINE-1 Content  -->
		
		<div class="col-sm-4">
			
		</div>
		
           <%
           if(request.getParameter("department")!=null && request.getParameter("cursem")!=null && request.getParameter("section")!=null && request.getParameter("shift")!=null){
              
               String dept=request.getParameter("department");
               String cursem=request.getParameter("cursem");
               String section=request.getParameter("section");
               String shift=request.getParameter("shift");
               String type=request.getParameter("type");
               String  subjectcode=request.getParameter("subject");
               String subjectname=GetSubjects.getSubjecName(subjectcode);
              
               query="SELECT * FROM `student_details` where department_='"+dept+"' and current_sem='"+cursem+"' and section_='"+section+"' and shift='"+shift+"' ORDER BY reg_no ASC ";
               ps=con.prepareStatement(query);
                rt=ps.executeQuery();
           %>
             <form action="ReExamEntry" method="post"> 
           <div class="col-md-12" style="margin-top: 30px;margin-bottom: 50px;">
                
               <div class="col-sm-2">
                   <label>Dept :</label>
                    <input type="text" class="form-control" name="department" readonly="" value="<%=dept.toUpperCase()%>">
               </div>  
               <div class="col-sm-2">
                   <label>Semester :</label>
                      <input type="text" class="form-control" name="cursem" readonly="" value="<%=cursem%>">
               </div>
               <div class="col-sm-2">
                   <label>Section :</label>
                     <input type="text" class="form-control" name="section" readonly="" value="<%=section.toUpperCase()%>">
               </div>
               <div class="col-sm-2">
                   <label>Shift :</label>
                   <input type="text" class="form-control" readonly="" name="shift" value="<%=shift.toUpperCase()%>">
               </div>
               <div class="col-sm-2">
                   <label>Subject :</label>
                    <input type="text" class="form-control" readonly="" name="subname" value="<%=subjectname.toUpperCase()%>">
               </div>
               <div class="col-sm-2">
                   <label>Type :</label>
                    <input type="text" class="form-control" readonly="" name="type" value="<%=type.toUpperCase()%>">
               </div>
                
                    <input type="hidden" class="form-control" readonly="" name="subcode" value="<%=subjectname.toUpperCase()%>">
              
           </div>
             
                   
                    <table class="table table-hover">
                        <thead>
                    <tr>
                        <th>Sl.No</th>
                        <th>Reg.No</th>
                        <th>Name</th>
                        <th>Mark</th>
                    </tr>
                        </thead>
                    
                    <%
                   int count=1;
                    while(rt.next()){
                    %>
                    
                    <tbody>
                    <tr>
                        <td><%=count%></td>
                        <td><%=rt.getString("reg_no")%></td>
                        <td><%=rt.getString("name_")%></td>
                        <td><input type="number" class="form-control" name="<%=rt.getString("reg_no")%>" min="0" placeholder="Enter Mark " ></td>
                    </tr>
                    <%
                    count++;
                    }
                    %>
                    <tr>
                        
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
                     <div class="col-md-12" style="text-align: center;">
                <button type="submit" class="btn btn-info">Save Mark</button>
            </div>
                </form>
                    
           
           
           <% 
           }else{
                %>
            
           
           <% 
           }
           %>
          
	
		
		
		
		
			
</div>

	<nav class="navbar footer col-md-12" style="margin-top: 30px;margin-bottom: 0px;">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Science and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</nav>
	
	

</body>
</html>