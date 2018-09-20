<%@page import="Beans.CheckDuplicate"%>
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
if(request.getParameter("updated")!=null){
    out.println("<script>alert('Updated Successfully !')</script>");
}
if(request.getParameter("failed")!=null){
    out.println("<script>alert('Failed !')</script>");
}

String id=request.getParameter("id");
//System.out.println("id :"+id);
Connection con=db.Dbconnection.getCon();
            String query="select * from subjects where id='"+id+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();

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
          <li><a href="add_subject.jsp"> Add Subject</a></li>
          <li class="active"><a href="edit_subject.jsp"> Edit Subject</a></li>
<!--		<li><a href="#"> Allocate </a></li>
		<li><a href="#"> Result </a></li>
                <li><a href="#"> Get List </a></li>
                <li><a href="#"> Profile </a></li>-->
      </ul>
    </div>
  </div>
</nav>
  
   
<div class="container">
    <div style="height: 50px;"></div>
    <div class="col-sm-4"></div>
	<div class="col-sm-4">
             <%
            if(rt.next()){
            %>
            <form action="UpdateSubject?<%=id%>" method="post">
                <div class="panel panel-default" >
				<div class="panel-heading">
					<h3>Edit Subject Details  </h3>
				</div>
				<div class="panel-body">
                                        <div class="form-group">
                                           
                                            <select name="department" required="required" class="form-control">
                                                  <%
                                                String grad=rt.getString("department_");
                                                 %>
                                                <option value="<%=grad%>"><%=grad%></option>
                                               
                                            </select>
                                            
					</div>
                                        <div class="form-group">
                                           
                                            <input type="text"  name="subcode" required="required" value="<%=rt.getString("subject_code")%>" readonly="" class="form-control" placeholder="Enter Subject Code" />
					</div>
					<div class="form-group">
                                            <input type="text"  name="subname" required="required" value="<%=rt.getString("name_")%>" class="form-control" placeholder="Enter Subject Name" />
					</div>
                                        <div class="form-group">
                                            <input type="number" min="0"  name="semester" required="required" value="<%=rt.getString("semester_")%>" class="form-control" placeholder="Enter Subject Name" />
					</div>
					
                                    <button type="submit" class="btn btn-success">Change</button>
				</div>
			</div>
            </form>
                                             <%
            }
            %>
		</div>
	   <div style="height: 100px;"></div>
	
	
		
		<!--  LINE-1 Content  -->
		
		<div class="col-md-4">
			
		</div>
		
		
			
</div>

	<div class="footer col-md-12">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Scinence and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</div>
	
	

</body>
</html>