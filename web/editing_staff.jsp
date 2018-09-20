<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Array"%>
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
          <li class="active"><a href="home.jsp"> Home </a></li>
                <li><a href="#"> Add </a></li>
		<li><a href="#"> Edit </a></li>
		<li><a href="#"> Allocate </a></li>
		<li><a href="#"> Result </a></li>
                <li><a href="#"> Get List </a></li>
                <li><a href="#"> Profile </a></li>
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
            ArrayList depts=new ArrayList();
            while(rt.next()){
                depts.add(rt.getString("name_"));
            }
            rt.close();
            ps.close();
 %> 
   
<div class="container">
    <div style="height: 50px;"></div>
    <div class="col-sm-4"></div>
	<div class="col-sm-4">
            <%
            query="select * from staff_details where id='"+id+"'";
            ps=con.prepareStatement(query);
            rt=ps.executeQuery();
            if(rt.next()){
            %>
            <form action="UpdateStaff?<%=id%>" method="post">
                <div class="panel panel-default" >
				<div class="panel-heading">
					<h3>Add New Staff  </h3>
				</div>
				<div class="panel-body">
                                        
                                        <div class="form-group">
                                            <select required="required" name="department" class="form-control">
                                                <option value="<%=rt.getString("department_")%>"><%=rt.getString("department_").toUpperCase()%></option>
                                                <%
                                               Iterator it=depts.iterator();
                                                while(it.hasNext()){
                                                    String name=it.next().toString();
                                                    %>
                                                    <option value="<%=name%>"><%=name.toUpperCase()%></option>
                                                
                                                <%
                                                }
                                                %>
                                               
                                            </select>
                                          
					</div>
                                        <div class="form-group">
                                            <input type="text"  name="staffid" required="required" value="<%=rt.getString("staff_id")%>"  class="form-control" placeholder="Enter Staff ID" />
					</div>
					<div class="form-group">
                                            <input type="text"  name="staffname" required="required" value="<%=rt.getString("name_")%>" class="form-control" placeholder="Enter Staff Name" />
					</div>
                                                <center>
                                                <button type="submit" class="btn btn-success">Change</button>&nbsp;&nbsp;&nbsp;&nbsp;
                                    
                                                </center>
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