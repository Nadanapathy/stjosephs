<%@page import="Beans.GetSubjects"%>
<%@page import="Beans.CheckNull"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
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
          <li ><a href="<%=home_page%>"> Home </a></li>
          <li class="active"><a href="defaulters_list.jsp"> Defaulters List</a></li>
          <li ><a href="failure_list.jsp"> Failures List </a></li>
          <li ><a href="mark_list.jsp"> Mark List </a></li>
          
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

  Connection con=db.Dbconnection.getCon();
            String query="select name_ from department";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
 %> 
   
 <div class="container" style="min-height: 468px;">
    <div class="col-sm-4"></div>
	<div class="col-sm-4" style="margin-top: 50px;">
            <form action="" method="post" >
                <div class="panel panel-default" >
				<div class="panel-heading">
					<h3>Get Defaulters List </h3>
				</div>
                    
				<div class="panel-body">
                                       
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
<!--                                        <div class="form-group">
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
                                           
					</div>-->
<!--                                         <div class="form-group">
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
                                           
					</div>-->
<!--                                           <div class="form-group">
                                             <select name="year" required="required" class="form-control">
                                                <option value="">--Select Current Year--</option>
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                
                                            </select>
                                           
					</div>-->
<!--                                         <div class="form-group">
                                             <select name="shift" required="required" class="form-control">
                                                <option value="">--Select Shift--</option>
                                                <option value="d">D</option>
                                                <option value="e">E</option>
                                              
                                                
                                            </select>
                                           
					</div>-->
                                         <div class="form-group">
                                             <select name="type" required="required" class="form-control">
                                                <option value="">--Select Type--</option>
                                                <option value="cia1">CIA 1</option>
                                                <option value="cia2">CIA 2</option>
                                                <option value="assign1">ASSIGNMENT 1</option>
                                                <option value="assign2">ASSIGNMENT 2</option>
                                                <option value="attendance">ATTENDANCE</option>
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
                                                try{
           if(request.getParameter("type")!=null && request.getParameter("department")!=null){
              
              String dept=request.getParameter("department");
//               String sem=request.getParameter("cursem");
//              // String section=request.getParameter("section");
//               String shift=request.getParameter("shift");
               String type=request.getParameter("type");
           //    String subjectcode=request.getParameter("subcode");
           
               
               query="SELECT `id`, `staff_details_id`, `staff_id`, `subject_id`, `subject_code`, `subject_name`, `department_`, `semester_`, `section_`, `shift_`, `status_`,(SELECT `name_` FROM `staff_details` WHERE `staff_id`=hs.staff_id),(SELECT id from marklist_details where handling_subjects_id=hs.id) FROM `handling_subjects` hs where department_='"+dept+"' ORDER by semester_ ASC;";
               System.out.println("Finale query Defaulters list:"+query);
               ps=con.prepareStatement(query);
               rt=ps.executeQuery();
           %>
           <form action="defaulters_print.jsp" method="post">
           <input type="hidden" name="query" value="<%=query%>">
        <div class="col-md-12" style="margin-top: 30px;margin-bottom: 50px;">
            <div class="col-sm-3">
                
            </div>
           <div class="col-sm-3">
               <label>Dept :</label>
               <input type="text" class="form-control" name="department" readonly="" value="<%=dept.toUpperCase()%>">
           </div>

           <div class="col-sm-3">
                <label>Type :</label>
                <input type="text" class="form-control" readonly="" name="type" value="<%=type.toUpperCase()%>">
           </div> 
           
        </div>   
           
           <div class="col-md-12" style="text-align: center;">
                    <button type="submit" class="btn btn-info">Print This</button>   
                    </div> <br>
          
                   
                    <table class="table table-hover">
                    
                  
                    <thead>
                    <tr>
                        <th>Sl.No</th>
                        <th>Staff Id</th>
                        <th>Staff Name</th>
                        <th>Sub.Code</th>
                        <th>Sub.Name</th>
                        <th>Dept</th>
                        <th>Sem</th>
                        <th>Shift</th>
                        <th>Section</th>
                     
                        
                    </tr>
                    </thead>
                      <tbody>
                    <%
                   int count=1;
                    while(rt.next()){
                        String s=rt.getString("(SELECT id from marklist_details where handling_subjects_id=hs.id)");
                        
                        if(CheckNull.isNull(s)){
                            String staffname=rt.getString("(SELECT `name_` FROM `staff_details` WHERE `staff_id`=hs.staff_id)");
                           %>
                     <tr>
                        <td><%=count%></td>
                        <td><%=rt.getString("staff_id")%></td>
                         <td><%=staffname%></td>
                          <td><%=rt.getString("subject_code")%></td>
                           <td><%=rt.getString("subject_name")%></td>
                            <td><%=rt.getString("department_")%></td>
                             <td><%=rt.getString("semester_")%></td>
                             <td><%=rt.getString("shift_")%></td>
                              <td><%=rt.getString("section_")%></td>
                       
                    </tr>
                    
                    <%  
                     count++;
                        }
                 
                    }
                    %>
                   
                    </tbody>
                    
                    
                    
                </table>
                
                    
                   
           </form>
           <% 
           }
                                                }catch(Exception e){
                                                    System.out.println(e);
                                                    %>
                                                    <center>
                                                        <h1>Data Not Found !<%=e%></h1>
                                                    </center>
           <%
                                                }
           %>
          
	
		
		
		
		
			
</div>

	<nav class="navbar footer col-md-12" style="margin-top: 30px;margin-bottom: 0px;">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Science and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</nav>
	
	

</body>
</html>