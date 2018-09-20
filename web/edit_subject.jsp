<%-- 
    Document   : edit_dept
    Created on : Aug 5, 2018, 8:24:12 PM
    Author     : unbox
--%>

<%@page import="Beans.GetSubjects"%>
<%@page import="java.beans.Beans"%>
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
           location.href = "delete.jsp?id="+id+"&type=subject";
        }
    }
</script>
<script>
function myFunction() {
  var input, filter, table, tr, td,td1, i;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
     // td0 = tr[i].getElementsByTagName("td")[1];
    td = tr[i].getElementsByTagName("td")[1];
    td1 = tr[i].getElementsByTagName("td")[4];
    if (td) {
       
      if ((td.innerHTML.toUpperCase().indexOf(filter) > -1) || (td1.innerHTML.toUpperCase().indexOf(filter)>-1)) {
         
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }   
    
     
    
  }
}
</script>
</head>
<body>
    
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
    
     <div class="container" style="min-height: 498px;">
        
        <center>
             <h1>Edit Subject Details</h1>
        </center>
   
<h2>All Departments</h2>
 <%
   Connection con=db.Dbconnection.getCon();
            String query="select * from subjects order by name_ asc";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
  %>

  <div class="form-group col-md-4">
        <input type="text" class="form-control" id="myInput" onkeyup="myFunction()" placeholder="Search for Dept Name or Sub.Code" title="Type in a name">
  </div>
  
<table class="table table-hover" id="myTable">
    <thead>
  <tr class="header">
    <th style="width:3%;">Sl.No</th>
    <th style="width:10%;">Department</th>
    <th style="width:3%;">Sem</th>
    <th style="width:40%;">Subject</th>
    <th style="width:30%;">Sub.Code</th>
    <th style="width:40%;">Action</th>
  </tr>
    </thead>
  <%
            int count=1;
  while(rt.next()){
      String id=rt.getString("id");
      String subname=GetSubjects.getSubjecName(rt.getString("subject_code"));
  %>
  <tbody>
  <tr>
    <td><%=count%></td>
    <td><%=rt.getString("department_").toUpperCase()%></td>
    <td><%=rt.getString("semester_").toUpperCase()%></td>
    <td><%=subname.toUpperCase()%></td>
    <td><%=rt.getString("subject_code").toUpperCase()%></td>
    <td><a href="editing_subject.jsp?id=<%=id%>">Edit</a> &nbsp;&nbsp;&nbsp; <a href="#" onclick="deletethis('<%=id%>')">Delete</a> </td>
  </tr>
  </tbody>
  <%
  count++;
  }
  %>
<!--  <tr>
     <td>1</td>
    <td>graduation</td>
    <td>bsc</td>
    <td>noofsem</td>
   <td><a href="">Edit</a> &nbsp;&nbsp;&nbsp;<a href="">Delete</a></td>
  </tr>-->

  
</table>

  </div>

<nav class="navbar footer col-md-12" style="margin-bottom: 0px;">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Science and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</nav>

</body>
</html>
