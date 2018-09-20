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
          <li ><a href="staff_home.jsp"> Home </a></li>
          <li class="active"><a href="get_failures.jsp"> Failures List </a></li>
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
					<h3>Get Mark List </h3>
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
           if(request.getParameter("department")!=null && request.getParameter("cursem")!=null  && request.getParameter("shift")!=null && request.getParameter("type")!=null){
              
               String dept=request.getParameter("department");
               String sem=request.getParameter("cursem");
               String section=request.getParameter("section");
               String shift=request.getParameter("shift");
               String type=request.getParameter("type");
           //    String subjectcode=request.getParameter("subcode");
               
               String query1="select subject_code from allocated_subjects where department_='"+dept+"' and semester_='"+sem+"'";
             PreparedStatement ps1=con.prepareStatement(query1);
	   System.out.println("Subject Query :"+query1);
	    ResultSet rt1=ps1.executeQuery();
            ArrayList subjects=new ArrayList();
            ArrayList subcodes=new ArrayList();
            String addquery="";int querycount=1;
              while(rt1.next()){
                  String scode=rt1.getString("subject_code");
                  subcodes.add(scode);
              //    subjects.add(scode);
                 
                     String q="(select mark_ from "+dept+"_"+"sem"+sem+" where type_='"+type+"' and subject_code='"+scode+"' and reg_no=sd.reg_no )";
                         
                  
                
                  addquery+=","+q;
                  subjects.add(q);
                  querycount++;
              } 
               rt1.close();
               ps1.close();
               
               String qs=request.getQueryString();
               
               query="SELECT reg_no,section_,name_,(select mark_ from "+dept+"_"+"sem"+sem+" where type_='"+type+"' and subject_code='"+qs+"' and reg_no=sd.reg_no ) FROM `student_details` sd where department_='"+dept+"' and current_sem='"+sem+"'  and shift='"+shift+"' and section_ ='"+section+"'  ORDER BY reg_no ASC ";
               System.out.println("Finale query :"+query);
               ps=con.prepareStatement(query);
               rt=ps.executeQuery();
           %>
           <form action="print.jsp" method="post">
           <input type="hidden" name="subcode" value="<%=qs%>">
        <div class="col-md-12" style="margin-top: 30px;margin-bottom: 50px;">
           <div class="col-sm-2">
               <label>Dept :</label>
               <input type="text" class="form-control" name="department" readonly="" value="<%=dept.toUpperCase()%>">
           </div>
           <div class="col-sm-2">
                <label>Semester :</label>
                <input type="text" class="form-control" name="cursem" readonly="" value="<%=sem%>">
           </div>      
           <div class="col-sm-2">       
                <label>Shift :</label>
                <input type="text" class="form-control" readonly="" name="shift" value="<%=shift.toUpperCase()%>">
           </div>
           <div class="col-sm-2">
                <label>Type :</label>
                <input type="text" class="form-control" readonly="" name="type" value="<%=type.toUpperCase()%>">
           </div> 
           <div class="col-sm-2">
                <label>Section :</label>
                <input type="text" class="form-control" readonly="" name="type" value="<%=section.toUpperCase()%>">
           </div> 
           
        </div>   
           
           <div class="col-md-12" style="text-align: center;">
                    <button type="submit" class="btn btn-info">Print This</button>   
                    </div> <br>
          
                   
                    <table class="table table-hover">
                    
                  
                    <thead>
                    <tr>
                        <th>Sl.No</th>
                        <th>Reg.No</th>
                        <th>Name</th>
                        <th>Section</th>
                       <%
                       
                            String t=GetSubjects.getSubjecName(qs);
                            %>
                            <th style="text-align: center;"><%=t.toUpperCase()%></th>
                       
                        
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
                        <td><%=rt.getString("section_")%></td>
                       <%
                      
                           
                           String v=rt.getString("(select mark_ from "+dept+"_"+"sem"+sem+" where type_='"+type+"' and subject_code='"+qs+"' and reg_no=sd.reg_no )");
                           if(CheckNull.isNull(v)){
                               %>
                               <td style="text-align: center;">NA</td>
                        <%
                           }else{
                               int ii=Integer.parseInt(v);
                               if(ii<20){
                                     %>
                           <td style="text-align: center;font-weight: bolder;color: #FF0000;"><%=v%></td>
                        <%   
                               }else{
                                    %>
                           <td style="text-align: center;"><%=v%></td>
                        <%    
                               }
                           
                           }
                          
                     
                       %>
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
                    </tbody>
                    
                    
                    
                </table>
                
                    
                   
           </form>
           <% 
           }else{
                %>
            
           
           <% 
           }
                                                }catch(Exception e){
                                                    %>
                                                    <center>
                                                        <h1>Data Not Found !</h1>
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