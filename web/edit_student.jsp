<%-- 
    Document   : edit_dept
    Created on : Aug 5, 2018, 8:24:12 PM
    Author     : unbox
--%>

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
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>

<link rel="stylesheet" href="css/style.css">

<script>
    function deletethis(id){
        if(confirm('Are Your Sure, Delete this ?')){
           location.href = "delete.jsp?id="+id+"&type=staff";
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
    td = tr[i].getElementsByTagName("td")[2];
    td1 = tr[i].getElementsByTagName("td")[1];
    if (td) {
      if (td.innerHTML.toUpperCase().indexOf(filter) > -1 || td1.innerHTML.toUpperCase().indexOf(filter) > -1) {
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
          <li ><a href="add_stud_details.jsp"> Add Student</a></li>
          <li class="active"><a href="edit_student.jsp"> Edit Student</a></li>
<!--           <li><a href="allocate_sub_class.jsp"> Subject to Sem </a></li>-->
<!--		<li><a href="#"> Allocate </a></li>
		<li><a href="#"> Result </a></li>
                <li><a href="#"> Get List </a></li>
                <li><a href="#"> Profile </a></li>-->
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
     <div class="container" style="min-height: 498px;">
         <div class="col-md-4">
             
         </div>
         <div class="col-md-4">
               
                <div  >
				<div class="panel-heading">
					<h3>Edit Students Detail  </h3>
				</div>
                    <div >
                                           <form action="" method="post" >
                                        <div class="form-group">
                                            <select required="required" name="department" class="form-control">
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
                                            <select name="cursem" required="required" class="form-control">
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
                                             <select name="shift" required="required" class="form-control">
                                                <option value="">--Select Shift--</option>
                                                <option value="d">D</option>
                                                <option value="e">E</option>
                                                
                                            </select>
                                           
					</div>

                                                <center>
                                                <button type="submit" class="btn btn-success">Submit</button>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <button type="reset" class="btn btn-info">CLEAR</button>
                                                </center>
 </form>
                                                
				</div>
			</div>
           
         </div>
      <div class="col-md-6">
             
         </div>
     <div class="col-md-12">   
         <div style="height: 100px;">
             
         </div>
           
   <%
   if(request.getParameter("department")!=null && request.getParameter("section")!=null && request.getParameter("cursem")!=null && request.getParameter("shift")!=null){
  
       String dept=request.getParameter("department");
   String section=request.getParameter("section");
   String semester=request.getParameter("cursem");
   String shift=request.getParameter("shift");
   %>
 <h1 style="text-align: center;">Edit Student Details</h1>
   <h2>All Studnets</h2>
 <%

             query="select * from student_details where department_='"+dept+"' and current_sem='"+semester+"' and section_='"+section+"' and shift='"+shift+"' order by name_ asc";
           System.out.println("Edit student Query :"+query);
             ps=con.prepareStatement(query);
	   
	     rt=ps.executeQuery();
  %>

  <div class="form-group col-md-4">
      <input type="text" class="form-control" id="myInput" onkeyup="myFunction()" placeholder="Search for Student Name or Student id.." title="Type in a name">
  </div>
  
<table class="table table-hover" id="myTable">
    <caption>
        <h3>
        Dept :&nbsp;<%=dept.toUpperCase()%>&nbsp;&nbsp;&nbsp;&nbsp;
        Current Sem:&nbsp;<%=semester.toUpperCase()%>&nbsp;&nbsp;&nbsp;&nbsp;
        Section :&nbsp;<%=section.toUpperCase()%>&nbsp;&nbsp;&nbsp;&nbsp;
        Shift :&nbsp;<%=shift.toUpperCase()%>
        </h3>
    </caption>
    <thead>
  <tr class="header">
    <th style="width:3%;">Sl.No</th>
    <th style="width:10%;">Reg.No</th>
    <th style="width:40%;">Student Name</th>
   
    <th style="width:40%;">Action</th>
  </tr>
    </thead>
   <tbody>
  <%
            int count=1;
  while(rt.next()){
      String id=rt.getString("id");
  %>
 
  
  <tr>
    <td><%=count%></td>
    <td><%=rt.getString("reg_no")%></td>
    <td><%=rt.getString("name_")%></td>
   
    <td>
        <a href="editing_student.jsp?id=<%=id%>">Edit</a> 
        &nbsp;&nbsp;&nbsp;
        <a href="#" onclick="deletethis('<%=id%>')">Delete</a> 
        &nbsp;&nbsp;&nbsp;
     
    </td>
  </tr>
  
  
  <%
  count++;
  }
  %>
  </tbody>
<!--  <tr>
     <td>1</td>
    <td>graduation</td>
    <td>bsc</td>
    <td>noofsem</td>
   <td><a href="">Edit</a> &nbsp;&nbsp;&nbsp;<a href="">Delete</a></td>
  </tr>-->

  
</table>
<%
   }else{
       %>
     
<%
   }
%>
                                                </div>
  </div>

<nav class="navbar footer col-md-12" style="margin-bottom: 0px;">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Science and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</nav>

</body>
</html>
