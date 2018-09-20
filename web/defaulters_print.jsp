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
           if(request.getParameter("type")!=null && request.getParameter("department")!=null){
              
              String dept=request.getParameter("department");
//               String sem=request.getParameter("cursem");
//              // String section=request.getParameter("section");
//               String shift=request.getParameter("shift");
               String type=request.getParameter("type");
           //    String subjectcode=request.getParameter("subcode");
           
               
               query="SELECT `id`, `staff_details_id`, `staff_id`, `subject_id`, `subject_code`, `subject_name`, `department_`, `semester_`, `section_`, `shift_`, `status_`,(SELECT `name_` FROM `staff_details` WHERE `staff_id`=hs.staff_id),(SELECT id from marklist_details where handling_subjects_id=hs.id) FROM `handling_subjects` hs ORDER by semester_ ASC;";
               System.out.println("Finale query Defaulters list:"+query);
               ps=con.prepareStatement(query);
               rt=ps.executeQuery();
           %>
           <form action="defaulters_print.jsp" method="post">
           
<!--        <div class="col-md-12" style="margin-top: 30px;margin-bottom: 50px;">
           <div class="col-sm-3">
               <label>Dept :</label>
               <input type="text" class="form-control" name="department" readonly="" value="<%=dept.toUpperCase()%>">
           </div>

           <div class="col-sm-3">
                <label>Type :</label>
                <input type="text" class="form-control" readonly="" name="type" value="<%=type.toUpperCase()%>">
           </div> 
           
        </div>   -->
           
<!--           <div class="col-md-12" style="text-align: center;">
                    <button type="submit" class="btn btn-info">Print This</button>   
                    </div> <br>-->
          
                   
<table style="width: 80%">
                        <caption>
                            <h1>Defaulters List of <b> <%=type.toUpperCase()%></b>  <b><%=dept.toUpperCase()%></b> Department </h1><br>
                            
                        </caption>
                  
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
                        <td style="text-align: center"><%=count%></td>
                        <td style="text-align: center"><%=rt.getString("staff_id")%></td>
                         <td style="text-align: center"><%=staffname%></td>
                          <td style="text-align: center"><%=rt.getString("subject_code").toUpperCase()%></td>
                           <td style="text-align: center"><%=rt.getString("subject_name").toUpperCase()%></td>
                            <td style="text-align: center"><%=rt.getString("department_").toUpperCase()%></td>
                             <td style="text-align: center"><%=rt.getString("semester_")%></td>
                             <td style="text-align: center"><%=rt.getString("shift_").toUpperCase()%></td>
                              <td style="text-align: center"><%=rt.getString("section_").toUpperCase()%></td>
                       
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