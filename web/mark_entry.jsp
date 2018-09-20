<%@page import="Beans.Get"%>
<%@page import="Beans.MarkStatus"%>
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
            function check(v){
             //   alert('called');
                //var v=this.value;
               // alert(isNaN(v.value));
               var proceed=true;
               if(v.value==='a'){
                   proceed=false;
               }
               
               if(proceed){
                  if(!isNaN(v.value)){
                  // alert('is no');
                  <%
                  String max_value="10";
                  if(request.getParameter("department")!=null && request.getParameter("type")!=null){
                      if(request.getParameter("type").equalsIgnoreCase("cia1") || request.getParameter("type").equalsIgnoreCase("cia2")){
                         max_value=Get.maxMark(request.getParameter("department"), "cia")+"";
                         System.out.println("Cia :"+max_value);
                      }
                      
                       if(request.getParameter("type").equalsIgnoreCase("ASSIGN1") || request.getParameter("type").equalsIgnoreCase("ASSIGN2")){
                         max_value=Get.maxMark(request.getParameter("department"), "assignment")+"";
                          System.out.println("assignment :"+max_value);
                      }
                        if(request.getParameter("type").equalsIgnoreCase("ATTENDANCE") ){
                         max_value=Get.maxMark(request.getParameter("department"), "ATTENDANCE")+"";
                          System.out.println("attendance :"+max_value);
                      }
                  }
                  
                  %>
                    if(v.value><%=max_value%>){
                        alert("Invalid Mark");
                        v.value="";
                        v.focus();
                    }
                }  
                
                 if(isNaN(v.value)){
                   // alert('not no');
                    alert("Invalid Mark");
                        v.value="";
                        v.focus();
                } 
               }
                 
            }
        </script>
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
<!--          <li><a href="add_stud_details.jsp"> Student </a></li>-->
		
<!--          <li><a href="allocate_sub.jsp"> Subject to Staff </a></li>
          <li><a href="allocate_sub_class.jsp"> Subject to Class </a></li>-->
<!--                <li><a href="#"> Get List </a></li>-->
                <li><a href="index.html"> Logout </a></li>
      </ul>
    </div>
  </div>
</nav>
 <%
 String id=request.getQueryString();
  Connection con=db.Dbconnection.getCon();
            String query="select * from handling_subjects where id='"+id+"'";
            
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
 %> 
   
 <div class="container" style="min-height: 468px;">
    <div class="col-sm-4"></div>
    <div class="col-sm-4" style="margin-top: 10px;">
            <form action="" method="post" >
                <div class="panel panel-default" >
				<div class="panel-heading">
					<h3>Mark Entry  </h3>
				</div>
                    <%
                   
                    if(rt.next()){
                    %>
				<div class="panel-body">
                                        <div class="form-group">
                                            Subject Code:
                                            <input type="text" readonly=""  value="<%=rt.getString("subject_code")%>" name="subcode" required="required" class="form-control" placeholder="selct file" />
					</div>
                                        <div class="form-group">
                                            Department:
                                            <select required="required" name="department" class="form-control">
                                                <option value="<%=rt.getString("department_")%>"><%=rt.getString("department_")%></option>
                                              
                                               
                                            </select>
                                          
					</div>
                                        <div class="form-group">
                                            Semester:
                                            <select name="cursem" required="required" class="form-control">
                                                <option value="<%=rt.getString("semester_")%>"><%=rt.getString("semester_")%></option>
<!--                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>-->
                                            </select>
                                           
					</div>
                                         <div class="form-group">
                                             Section:
                                             <select name="section" required="required" class="form-control">
                                                <option value="<%=rt.getString("section_")%>"><%=rt.getString("section_")%></option>
<!--                                                <option value="a">A</option>
                                                <option value="b">B</option>
                                                <option value="c">C</option>
                                                <option value="d">D</option>
                                                <option value="e">E</option>
                                                <option value="f">F</option>
                                                <option value="g">G</option>
                                                <option value="h">H</option>-->
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
                                                <option value="<%=rt.getString("shift_")%>"><%=rt.getString("shift_")%></option>
<!--                                                <option value="d">D</option>
                                                <option value="e">E</option>-->
                                              
                                                
                                            </select>
                                           
					</div>
                                         <div class="form-group">
                                             Select Type:
                                             <select name="type" required="required" class="form-control">
                                                <option value="">--Select Type--</option>
                                                <option value="cia1">CIA 1</option>
                                                <option value="cia2">CIA 2</option>
                                                <option value="re-cia1">Re-Exam</option>
<!--                                                <option value="re-cia2">Re-Exam CIA 2</option>-->
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
                                                <%
                                                
                    }
                                                %>
			</div>
            </form>
		</div>
           
                                                <!--  LINE-1 Content  -->
		
		<div class="col-sm-4">
			
		</div>
		
           <%
           if(request.getParameter("department")!=null && request.getParameter("cursem")!=null && request.getParameter("section")!=null && request.getParameter("shift")!=null){
              
               String dept=request.getParameter("department");
               String cursem=request.getParameter("cursem");
               String section=request.getParameter("section");
               String shift=request.getParameter("shift");
               String type=request.getParameter("type");
               String subjectcode=request.getParameter("subcode");
              
               query="SELECT * FROM `student_details` where department_='"+dept+"' and current_sem='"+cursem+"' and section_='"+section+"' and shift='"+shift+"' ORDER BY reg_no ASC ";
               
                boolean ms=MarkStatus.isEntered(id, type);
          if(!ms){
              
              
              
              if(MarkStatus.canEnterMark(type)){
                  
              
               ps=con.prepareStatement(query);
                rt=ps.executeQuery();
           %>
            <form action="MarkEntry" method="post">
                <input type="hidden" name="handling" value="<%=id%>">
           <div class="col-md-12" style="margin-top: 30px;margin-bottom: 50px;">
               <div class="col-sm-2">
                   <label>Subject Code :</label>
                    <input type="text" class="form-control" name="subjectcode" readonly="" value="<%=subjectcode.toUpperCase()%>">
               </div>  
               <div class="col-sm-2">
                   <label>Dept :</label>
                    <input type="text" class="form-control" name="department" readonly="" value="<%=dept.toUpperCase()%>">
               </div>  
               <div class="col-sm-2">
                   <label>Semester :</label>
                      <input type="text" class="form-control" name="cursem" readonly="" value="<%=cursem%>">
               </div>
               <div class="col-sm-2">
                   <label>Section :</label>
                     <input type="text" class="form-control" name="section" readonly="" value="<%=section.toUpperCase()%>">
               </div>
               <div class="col-sm-2">
                   <label>Shift :</label>
                   <input type="text" class="form-control" readonly="" name="shift" value="<%=shift.toUpperCase()%>">
               </div>   
               <div class="col-sm-2">
                   <label>Type :</label>
                    <input type="text" class="form-control" readonly="" name="type" value="<%=type.toUpperCase()%>">
               </div>
           </div>
               
                   
                    <table class="table table-hover">
                        <thead>
                    <tr>
                        <th>Sl.No</th>
                        <th>Reg.No</th>
                        <th>Name</th>
                        <th>Mark</th>
                    </tr>
                        </thead>
                    
                    <%
                   
                   int count=1;
                    while(rt.next()){
                    %>
                    
                    <tbody>
                    <tr>
                        <td><%=count%></td>
                        <td><%=rt.getString("reg_no")%></td>
                        <td><%=rt.getString("name_")%></td>
                        <td><input type="text" class="form-control" name="<%=rt.getString("reg_no")%>"  placeholder="Enter Mark " onchange="check(this)" required="required"></td>
                    </tr>
                    <%
                    count++;
                    }
                    
                    %>
                    <tr>
                        
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
                    
                      <div class="col-md-12" style="text-align: center;">
                <button type="submit" class="btn btn-info">Save Mark</button>
            </div>
                </form>
              
          
                   
           
           
           <% 
              }else{
                  %>
                        <center>
                            <h3>You cant Enter Mark Now . Please Contact Admin <br> <a href="staff_home.jsp">Click to back</a></h3>
                        </center>
                                                <%  
              }
                    
                    }else{
                        %>
                        <center>
                            <h3>You have Entered mark list <br> <a href="staff_home.jsp">Click to back</a></h3>
                        </center>
                                                <%
                    }
           }
           %>
          
	
		
		
		
		
			
</div>

	<nav class="navbar footer col-md-12" style="margin-top: 30px;margin-bottom: 0px;">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Science and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</nav>
	
	

</body>
</html>