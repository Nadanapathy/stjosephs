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
          <li ><a href="home.jsp"> Home </a></li>
          <li ><a href="add_stud_details.jsp"> Add Students </a></li>
          <li class="active"><a href="edit_student.jsp"> Edit Student </a></li>
<!--		<li><a href="#"> Edit </a></li>
		<li><a href="#"> Allocate </a></li>
		<li><a href="#"> Result </a></li>
                <li><a href="#"> Get List </a></li>
                <li><a href="#"> Profile </a></li>-->
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
            
            String query1="SELECT * FROM `student_details` where id='"+id+"'";
            PreparedStatement ps1=con.prepareStatement(query1);
	   
	    ResultSet rt1=ps1.executeQuery();
 %> 
   
<div class="container">
    <div class="col-sm-4"></div>
	<div class="col-sm-4" style="margin-top: 20px;">
            <form action="UpdateStudentDetail?<%=id%>" method="post" >
                <div class="panel panel-default" >
				<div class="panel-heading">
					<h3>Edit Students Detail  </h3>
				</div>
                    <%
                    if(rt1.next()){
                    %>
				<div class="panel-body">
                                        
                                        <div class="form-group">
                                            Department:
                                            <select required="required" name="department" class="form-control">
                                                <option value="<%=rt1.getString("department_")%>"><%=rt1.getString("department_").toUpperCase()%></option>
                                                <%
                                                while(rt.next()){
                                                    %>
                                                    <option value="<%=rt.getString("name_")%>"><%=rt.getString("name_").toUpperCase()%></option>
                                                
                                                <%
                                                }
                                                %>
                                               
                                            </select>
                                          
					</div>
                                        <div class="form-group">
                                            Semester:
                                            <select name="cursem" required="required" class="form-control">
                                                <option value="<%=rt1.getString("current_sem")%>"><%=rt1.getString("current_sem")%></option>
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
                                                <option value="<%=rt1.getString("section_")%>"><%=rt1.getString("section_").toUpperCase()%></option>
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
                                           <div class="form-group">
                                               Year:
                                             <select name="year" required="required" class="form-control">
                                                <option value="<%=rt1.getString("year_")%>"><%=rt1.getString("year_")%></option>
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                
                                            </select>
                                           
					</div>
                                         <div class="form-group">
                                             Shift:
                                             <select name="shift" required="required" class="form-control">
                                                <option value="<%=rt1.getString("shift")%>"><%=rt1.getString("shift").toUpperCase()%></option>
                                                <option value="d">D</option>
                                                <option value="e">E</option>
                                              
                                                
                                            </select>
                                           
					</div>
					<div class="form-group">
                                            Reg.No:
                                            <input type="text"  name="regno" value="<%=rt1.getString("reg_no")%>" required="required" class="form-control"  />
					</div>
                                        <div class="form-group">
                                            Name:
                                            <input type="text"  name="name" value="<%=rt1.getString("name_").toUpperCase()%>" required="required" class="form-control"  />
					</div>
                                         <div class="form-group">
                                             Is Special Student:
                                             <select name="isspecial" required="required" class="form-control">
                                                <option value="<%=rt1.getString("is_special")%>"><%=rt1.getString("is_special")%></option>
                                                <option value="yes">yes</option>
                                                <option value="no">no</option>
                                               
                                            </select>
                                           
					</div>
                                                <center>
                                                <button type="submit" class="btn btn-success">UPDATE</button>&nbsp;&nbsp;&nbsp;&nbsp;
                                    
                                                </center>
				</div>
                                                <%
                    }
                                                %>
			</div>
                        <div style="height: 100px;">
                            
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