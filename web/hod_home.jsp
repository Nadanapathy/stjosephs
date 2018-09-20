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

<link rel="stylesheet" href="css/style.css">
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
      <a class="navbar-brand" href="#">St.Joseph's College of Arts and Scinence</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      
      <ul class="nav navbar-nav navbar-right">
          <li class="active"><a href="<%=home_page%>"> Home </a></li>
     
       
          <li class="dropdown">
              <a href="#" data-toggle="dropdown"> Allocate<span class="caret"></span> </a>
              <ul class="dropdown-menu">
                  <li><a href="allocate_class_sub.jsp">Subject and Staff</a></li>
                  <li><a href="hod_subject_staff.jsp">Subject to Staff</a></li>
                  <li><a href="allocate_sub_class.jsp">Subject to Sem</a></li>
              </ul>
          </li>
<!--          <li><a href="re_exam_entry.jsp"> Re-Exam Entry </a></li>-->
        
          <li class="dropdown">
              <a href="failure_list.jsp" data-toggle="dropdown"> Get List<span class="caret"></span> </a>
              <ul class="dropdown-menu">
                   <li ><a href="defaulters_list.jsp"> Defaulters List</a></li>
                   <li ><a href="single_failures.jsp"> Single Failures List</a></li>
                   <li ><a href="failure_list.jsp"> Failures List </a></li>
                   <li ><a href="mark_list.jsp"> Mark List </a></li>
                   <li ><a href="cum_single_failures.jsp"> Cum.Sinlge Fail List </a></li>
              </ul>
          </li>
          
           <li class="dropdown">
              <a href="failure_list.jsp" data-toggle="dropdown"> Profile<span class="caret"></span> </a>
              <ul class="dropdown-menu" style="left: -70px;">
                  <li><a href="hod_changepass.jsp"> Change Password </a></li>
                    <li><a href="index.html"> Logout </a></li>
              </ul>
          </li>
          
      </ul>
    </div>
  </div>
</nav>
  
   
<div class="container">
    <div class="col-sm-2"></div>
	<div class="col-sm-8" style="margin-top: 100px;">
            <%
            String deptt=session.getAttribute("Department").toString();
            %>
            <h1>Welcome  to HOD of <%=deptt.toUpperCase()%> Department</h1>
<!--            <form action="" method="post">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>Instant Mark Entry  </h3>
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
                                            <input type="text" name="subcode" required="required" class="form-control" placeholder="Enter Subject code" />
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
            </form>-->
		</div>
	<%
        if(request.getParameter("regno")!=null && request.getParameter("type")!=null && request.getParameter("subcode")!=null ){
           
            Connection con=db.Dbconnection.getCon();
            String query="select * from `student_details` where reg_no='"+request.getParameter("regno").trim()+"'";
            System.out.println("Query :"+query);
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
            if(rt.next()){
                String dept=rt.getString("department_");
                String cursem=rt.getString("current_sem");
                String name=rt.getString("name_");
                String tblname=dept+"-sem"+cursem;
                String type=request.getParameter("type");
                String subname=GetSubjects.getSubjecName(request.getParameter("subcode").trim());
                
                %>
                <form action="update_mark.jsp" method="post">
                     <input type="hidden" name="dept" value="<%=dept%>">
                     <input type="hidden" name="cursem" value="<%=cursem%>">
                <table>
                    <tr>
                        <th>Reg.No</th><th>Name</th><th>Sub.Code</th><th>Sub.Name</th><th>Type</th><th>Mark</th>
                    </tr>
                   
                    <tr>
                        <td><input type="text" name="regno" value="<%=request.getParameter("regno").trim()%>" readonly=""required=""></td>
                        <td><input type="text" name="name" value="<%=name%>" readonly=""></td>
                        <td><input type="text" name="subcode" value="<%=request.getParameter("subcode").trim()%>" readonly="" required=""></td>
                        <td><input type="text" name="subname" value="<%=subname%>" readonly="" required=""></td>
                        <td><input type="text" name="type" value="<%=type%>" readonly="" required=""></td>
                        <td><input type="text" name="mark" name="mark" required=""> </td>
                        <td><button type="submit">Update</button></td>
                    </tr>
                  
                </table> 
                          </form>
    <%
                
            }else{
              %>
                <center>
                    <h1>Invalid Register No</h1>
                </center>
           
           <%   
            }
		
		rt.close();
            ps.close();
            con.close();
        }else{
          
        }
        %>
	
		
		<!--  LINE-1 Content  -->
		
		<div class="col-md-4">
			
		</div>
		
		
			
</div>

	<nav class="navbar navbar-fixed-bottom footer col-md-12">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Science and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</nav>
	
	

</body>
</html>