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
<script>
    function validate(){
        if(document.getElementById("newpass").value!==document.getElementById("newpass1").value){
            alert('Password Does not matched');
            document.getElementById("newpass").value="";
             document.getElementById("newpass1").value="";
              document.getElementById("newpass").focus();
              return false;
        }
    }
</script>
</head>
<body>
<%
if(request.getParameter("changed")!=null){
    out.println("<script>alert('Password Changed !')</script>");
}
if(request.getParameter("incorrect")!=null){
    out.println("<script>alert('Old Password is Incorrect !')</script>");
}
if(request.getParameter("failed")!=null){
    out.println("<script>alert('Process Failed !')</script>");
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
              <a href="#" data-toggle="dropdown"> Allocate<span class="caret"></span> </a>
              <ul class="dropdown-menu">
                  <li><a href="subject_staff.jsp">Subject to Staff</a></li>
                  <li><a href="allocate_sub_class.jsp">Subject to Sem</a></li>
              </ul>
          </li>
          <li><a href="re_exam_entry.jsp"> Re-Exam Entry </a></li>
          <li><a href="announce.jsp"> Announce  </a></li>
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
                    <li><a href="index.html"> Change Password </a></li>
                    <li><a href="index.html"> Logout </a></li>
              </ul>
          </li>
          
      </ul>
    </div>
  </div>
</nav>
  
   
<div class="container">
    <div class="col-sm-2"></div>
    <div class="col-sm-8" >
          
		
	
             
        <form action="UpdateFlash" method="post" >
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>Edit Flash News  </h3>
				</div>
				<div class="panel-body">
                              <%
                               Connection con=db.Dbconnection.getCon();
            String query="SELECT * FROM `others` where type_='flash news'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
            if(rt.next()){
                              %>          
                                       
                                    
                                        <div class="form-group">
                                            Title:
                                            <input type="text" readonly="" value="<%=rt.getString("type_")%>" name="title" id='oldpass' required="required" class="form-control"  />
                                       </div>
                                    
					<div class="form-group">
                                            Content:
                                            <input type="text" name="content" value="<%=rt.getString("content_")%>" id='newpass' required="required" class="form-control"  />
					</div>
                                        <div class="form-group">
                                            Status:
                                            <select class="form-control" name="status">
                                                <option value="yes">yes</option>
                                                 <option value="no">No</option>
                                            </select>
                                           </div>
<!--                                        <div class="form-group">
                                            <input type="text" name="regno" required="required" class="form-control" placeholder="Enter Reg.No" />
					</div>-->
					
                                    <button type="submit" class="btn btn-success">Change</button>
                                    <%
            }
                                    %>
				</div>
			</div>
            </form>
        </div>
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