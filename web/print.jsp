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

<style>
    table,tr,td{
        border-style: solid;
        border-collapse: collapse;
    }
</style>

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
               
               query="SELECT reg_no,section_,name_"+addquery+" FROM `student_details` sd where department_='"+dept+"' and current_sem='"+sem+"'  and shift='"+shift+"' and section_='"+section+"'  ORDER BY reg_no ASC ";
               System.out.println("Finale query :"+query);
               ps=con.prepareStatement(query);
               rt=ps.executeQuery();
           %>
           <form action="print.jsp" method="post">
<!--           <input type="hidden" name="query" value="<%=query%>">
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
                <label>Section :</label>
                <input type="text" class="form-control" readonly="" name="section" value="<%=section.toUpperCase()%>">
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
           
           <div class="col-md-12" style="text-align: center;">
                    <button type="submit" class="btn btn-info">Print This</button>   
                    </div> <br>-->
          
                   
               <table class="table table-hover"  style="width: 100%;">
                       <caption style="font-weight: bold;font-size: 25px;">
                            <label>Dept : <%=dept.toUpperCase()%></label> &nbsp;&nbsp;&nbsp;
                           <label>Semester : <%=sem%></label>&nbsp;&nbsp;&nbsp;&nbsp;
                            <label>Section : <%=section.toUpperCase()%></label>&nbsp;&nbsp;&nbsp;
                           <label>Shift : <%=shift.toUpperCase()%></label>&nbsp;&nbsp;&nbsp;
                            <label>Type : <%=type.toUpperCase()%></label>
                            <br><br>
                        </caption>
                  
                    <thead>
                    <tr>
                        <th>Sl.No</th>
                        <th>Reg.No</th>
                        <th>Name</th>
<!--                         <th>hhh</th> <th>hhh</th> <th>hhh</th> <th>hhh</th> <th>hhh</th>-->
                       <%
                        Iterator code=subcodes.iterator();
                        while(code.hasNext()){
                            String t=GetSubjects.getSubjecName(code.next().toString());
                            %>
                            <th style="text-align: center;"><%=t.toUpperCase()%></th>
                        <%
                        }
                        %>
                           
                    </tr>
                    </thead>
                    <%
                   int count=1;
                    while(rt.next()){
                    %>
                   <tbody>
                    <tr>
                      
                       <%
                       Iterator it=subjects.iterator();
                       int failcount=0,failed_index=0;int subindex=0;
                       while(it.hasNext()){
                            
                           String v=rt.getString(it.next().toString());
                           if(CheckNull.isNull(v)){
                          
                           }else{
                                if(v.equalsIgnoreCase("re") || v.equalsIgnoreCase("a")){
                                     failcount++;
                                   failed_index=subindex;
                                }else{
                                      int ii=Integer.parseInt(v);
                               if(ii<20){
                                   failcount++;
                                   failed_index=subindex;
                             
                               }else{
                              
                               }
                                }
                             
                           
                           }
                           
                           subindex++;
                       }
                       
                       if(failcount>0){
                           %>
                               <td><%=count%></td>
                               <td><%=rt.getString("reg_no")%></td>
                               <td><%=rt.getString("name_")%></td>
                               <td><%=rt.getString("section_")%></td> 
                           
                          <%
                           Iterator it1=subjects.iterator();
                           while(it1.hasNext()){
                               String v=rt.getString(it1.next().toString());
                               
                               if(CheckNull.isNull(v)){
                               %>
                               <td style="text-align: center;">NA</td>
                        <%
                               }else{
                                 if(v.equalsIgnoreCase("re") || v.equalsIgnoreCase("a")){
                                     
                              %>
                           <td style="text-align: center;font-weight: bolder;color: #FF0000;"><%=v%></td>
                        <%    
                          
                           }else{
                                     
                                          
                               int ii=Integer.parseInt(v);
                               if(ii<20){
                                                %>
                           <td style="text-align: center;font-weight: bolder;color: #FF0000;"><%=v%></td>
                        <%
                               }else{
                                                      %>
                           <td style="text-align: center;font-weight: bolder;color: #FF0000;">-</td>
                        <%  
                               }
                                                  
                                 }
                                 
                               }     
                                  }
                           count++;
                       }
                       
                       %>
                    </tr>
                    
                    <%
                   
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