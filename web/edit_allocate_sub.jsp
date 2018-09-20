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
          <li class="active"><a href="staff_home.jsp"> Home </a></li>
          <li><a href="add_stud_details.jsp"> Student </a></li>
		
<!--          <li><a href="allocate_sub.jsp"> Subject to Staff </a></li>
          <li><a href="allocate_sub_class.jsp"> Subject to Class </a></li>-->
<!--                <li><a href="#"> Get List </a></li>-->
                <li><a href="index.html"> Logout </a></li>
      </ul>
    </div>
  </div>
</nav>
 <%
String id=request.getParameter("id");
  Connection con=db.Dbconnection.getCon();
            String query="select name_ from department";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
            
            
            query="SELECT * FROM `handling_subjects` where id='"+id+"'";
            PreparedStatement ps1=con.prepareStatement(query);
	   
	    ResultSet rt1=ps1.executeQuery();
 %> 
   
 <div class="container" style="min-height: 468px;">
    <div class="col-sm-4"></div>
    <div class="col-sm-4" style="margin-top: 10px;">
            <form action="UpdateAllocateSub?<%=id%>" method="post" >
                <div class="panel panel-default" >
				<div class="panel-heading">
					<h3>Edit Allocated Class </h3>
				</div>
                    <%
                   if(rt1.next()){
                    %>
				<div class="panel-body">
                                        <div class="form-group">
                                            Subject Code:
                                            <input type="text"  value="<%=rt1.getString("subject_code")%>" name="subcode" required="required" class="form-control" placeholder="selct file" />
					</div>
                                        <div class="form-group">
                                            Department:
                                            <select required="required" name="department" class="form-control">
                                                <option value="<%=rt1.getString("department_")%>"><%=rt1.getString("department_")%></option>
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
                                            Semester:
                                            <select name="semester" required="required" class="form-control">
                                                <option value="<%=rt1.getString("semester_")%>"><%=rt1.getString("semester_")%></option>
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
                                             Section:
                                             <select name="section" required="required" class="form-control">
                                                <option value="<%=rt1.getString("section_")%>"><%=rt1.getString("section_")%></option>
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
                                             Shift:
                                             <select name="shift" required="required" class="form-control">
                                                <option value="<%=rt1.getString("shift_")%>"><%=rt1.getString("shift_")%></option>
                                                <option value="d">D</option>
                                                <option value="e">E</option>
                                              
                                                
                                            </select>
                                           
					</div>
                                         <div class="form-group" >
                                                     Is Incharge:
                                            <select name="incharge" ng-model="incharge" class="form-control" ng-init="incharge='yes'">
                                               <option value="<%=rt1.getString("is_incharge")%>"><%=rt1.getString("is_incharge")%></option>
                                               <option value="yes">YES</option>
                                                <option value="no">NO</option>
                                         </select>
                                         </div>
<!--                                         <div class="form-group">
                                             <select name="type" required="required" class="form-control">
                                                <option value="">--Select Type--</option>
                                                <option value="cia1">CIA 1</option>
                                                <option value="cia2">CIA 2</option>
                                                <option value="re-cia1">Re-Exam CIA 1</option>
                                                <option value="re-cia2">Re-Exam CIA 2</option>
                                                <option value="assign1">ASSIGNMENT 1</option>
                                                <option value="assign2">ASSIGNMENT 2</option>
                                                <option value="attendance">ATTENDANCE</option>
                                             
                                            </select>
                                           
					</div>-->
<!--					<div class="form-group">
                                            <input type="file"  name="file" required="required" class="form-control" placeholder="selct file" />
					</div>-->
                                                <center>
                                                <button type="submit" class="btn btn-success">Update</button>&nbsp;&nbsp;&nbsp;&nbsp;
                                   
                                                </center>
				</div>
                                                <%
                   }
                                                %>
			</div>
            </form>
		</div>
           
                                                <!--  LINE-1 Content  -->
		
		<div class="col-sm-4">
			
		</div>
		
           
	<nav class="navbar footer col-md-12" style="margin-top: 30px;margin-bottom: 0px;">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Science and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</nav>
	
	

</body>
</html>