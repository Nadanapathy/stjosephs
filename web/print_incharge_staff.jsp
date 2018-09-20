<%@page import="Beans.GetStaffDetails"%>
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

  
  
<script>
   if(navigator.userAgent.toLowerCase().indexOf('chrome') > -1){   // Chrome Browser Detected?
    window.PPClose = false;                                     // Clear Close Flag
    window.onbeforeunload = function(){                         // Before Window Close Event
        if(window.PPClose === false){                           // Close not OK?
            return 'Leaving this page will block the parent window!\nPlease select "Stay on this Page option" and use the\nCancel button instead to close the Print Preview Window.\n';
        }
    };                   
    window.print();                                             // Print preview
    window.PPClose = true;                                      // Set Close Flag to OK.
}
</script>
<style>
    table,tr,td{
        border-style: solid;
        border-collapse: collapse;
    }
</style>
</head>
<body>



 <%

  Connection con=db.Dbconnection.getCon();
            String query="select name_ from department";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
 %> 
   
 <div class="container" style="min-height: 468px;">
    <div class="col-sm-4"></div>
	
                                                
                                                <!--  LINE-1 Content  -->
		
		<div class="col-sm-4">
			
		</div>
           
		
           <%
                                                try{
           if(request.getParameter("department")!=null && request.getParameter("cursem")!=null  && request.getParameter("section")!=null ){
              
               String dept=request.getParameter("department");
               String sem=request.getParameter("cursem");
               String section=request.getParameter("section");
               String shift=request.getParameter("shift");
             //  String type=request.getParameter("type");
           //    String subjectcode=request.getParameter("subcode");
               
              // String query1="select subject_code from allocated_subjects where department_='"+dept+"' and semester_='"+sem+"'";
             
               query="select * from handling_subjects where department_='"+dept+"' and  semester_='"+sem+"' and section_='"+section+"'   and shift_='"+shift+"' ";
               System.out.println("Finale query :"+query);
               ps=con.prepareStatement(query);
               rt=ps.executeQuery();
           %>
           <form action="" method="post">
         
    
      
          
                   
               <table class="table table-hover" style="width: 90%">
                        <caption>
                             <label>Dept : <%=dept.toUpperCase()%></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           <label>Semester : <%=sem%></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           <label>Shift : <%=shift.toUpperCase()%></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label>Section : <%=section.toUpperCase()%></label>
                        </caption>
                  
                    <thead>
                    <tr>
                        <th>Sl.No</th>
                        <th>Staff Id</th>
                        <th>Staff Name</th>
                        <th>Sub.code</th>
                        <th>Sub.Name</th>
                        <th>Is Incharge</th>
                    
                        
                    </tr>
                    </thead>
                    <%
                   int count=1;
                    while(rt.next()){
                    %>
                    <tbody>
                    <tr>
                        <td><%=count%></td>
                        <td><%=rt.getString("staff_id")%></td>
                        <%
                        String staffname=GetStaffDetails.getName(rt.getString("staff_id"));
                        %>
                        <td><%=staffname%></td>
                        <td><%=rt.getString("subject_code")%></td>
                         <td><%=rt.getString("subject_name")%></td>
                          <td><%=rt.getString("is_incharge")%></td>
                      
                    </tr>
                    
                    <%
                    count++;
                    }
                    %>
                 
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