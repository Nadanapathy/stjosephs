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
</head>
<body>
<%

if(request.getParameter("stored")!=null){
    out.println("<script>alert('Announced')</script>");
}
if(request.getParameter("change")!=null){
    out.println("<script>alert('Changed !')</script>");
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
          <li ><a href="home.jsp"> Home </a></li>
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
          <li class="active"><a href="announce.jsp"> Announce  </a></li>
          <li class="dropdown">
              <a href="failure_list.jsp" data-toggle="dropdown"> Get List<span class="caret"></span> </a>
              <ul class="dropdown-menu">
                   <li ><a href="defaulters_list.jsp"> Defaulters List</a></li>
                   <li ><a href="failure_list.jsp"> Failures List </a></li>
                   <li ><a href="single_failures.jsp"> Single Failures List</a></li>
                   <li ><a href="mark_list.jsp"> Mark List </a></li>
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
  
   
<div class="container">
   <div class="col-md-2">
			
		</div>
		
<!--	<div class="col-sm-4" style="margin-top: 100px;">
            <form action="Announce" method="post">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>Announce  </h3>
				</div>
				<div class="panel-body">
                                        
                                        <div class="form-group">
                                            
                                            <select name="type" required="required" class="form-control">
                                                <option value="">--Select Type--</option>
                                                <option value="cia1">CIA 1</option>
                                                <option value="cia2">CIA 2</option>
                                                <option value="assign1">ASSIGNMENT 1</option>
                                                <option value="assign2">ASSIGNMENT 2</option>
                                                <option value="attendance">ATTENDANCE</option>
                                                <option value="reexam">Re-Exam</option>
                                                
                                            </select>
                                            
					</div>
                                    
                                       <div class="form-group">
                                           <input type="date" name="date" required="required" class="form-control" placeholder="Enter Date Time" />
                                       </div>
                                    
					<div class="form-group">
                                            <input type="text" name="regno" required="required" class="form-control" placeholder="Enter Reg.No" />
					</div>
                                        <div class="form-group">
                                            <input type="text" name="regno" required="required" class="form-control" placeholder="Enter Reg.No" />
					</div>
					
                                    <button type="submit" class="btn btn-success">SUBMIT</button>
				</div>
			</div>
            </form>
		</div>-->
<div class="col-md-8">
		<%
                 Connection con=db.Dbconnection.getCon();
            String query="SELECT * FROM `mark_details` ";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		%>
                <table class="table table-hover" id="myTable">
                    <caption>
                        <center>
                            <h1>Cumulative Mark Conversion Details</h1>
                        </center>
                    </caption>
                    <tr style="background-color: #cccccc">
                         <th>Graduate</th>
                        <th>Type</th>
                          <th>Max Mark</th>
                        <th style="text-align: center;">Convert to</th>
                        <th style="text-align: center;">Action</th>
                    </tr>
                    <%
                    while(rt.next()){
                       
                       
                    %>
                    <tr>
                         <td><%=rt.getString("graduate_").toUpperCase()%></td>
                        <td><%=rt.getString("type_").toUpperCase()%></td>
                        <td style="text-align: center;">
                          <%=rt.getString("max_mark").toUpperCase()%> 
                          
                        </td>
                        <td style="text-align: center;">
                          <%=rt.getString("convert_to").toUpperCase()%> 
                          
                        </td>
                         <td style="text-align: center;">
                             <a href="edit_mark_details.jsp?<%=rt.getString("id")%>">Edit</a>
                            
                         </td>
                      
                    </tr>
                       
    <%
                    }
		%>
       </table>  
                    <%
		rt.close();
            ps.close();
            con.close();
                %>
		<!--  LINE-1 Content  -->
</div>		
		<div class="col-md-4">
			
		</div>
		
		
			
</div>

	<nav class="navbar navbar-fixed-bottom footer col-md-12">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Science and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</nav>
	
	

</body>
</html>