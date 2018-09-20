<%@page import="Beans.Get"%>
<%@page import="Beans.GetSubjects"%>
<%@page import="Beans.CheckNull"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Beans.Conversion"%>
<%@page import="Beans.Get"%>
<%@page import="Beans.ReExam"%>
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
              // String section=request.getParameter("section");
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
               
               query="SELECT reg_no,section_,name_"+addquery+" FROM `student_details` sd where department_='"+dept+"' and current_sem='"+sem+"'  and shift='"+shift+"'  ORDER BY reg_no ASC ";
               System.out.println("Finale query :"+query);
               ps=con.prepareStatement(query);
               rt=ps.executeQuery();
           %>
           
           <input type="hidden" name="query" value="<%=query%>">
        
           
           
        <center>
                   
            <table style="width: 100%;">
                        <caption style="font-weight: bold;font-size: 25px;">
                            <label>Dept : <%=dept.toUpperCase()%></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           <label>Semester : <%=sem%></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           <label>Shift : <%=shift.toUpperCase()%></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label>Type : <%=type.toUpperCase()%></label>
                            <br><br>
                        </caption>
                  
                    <thead>
                        <tr style="font-size: 20px;font-weight: bold;">
                        <td style="width: 25px;text-align: center;">S.No</td>
                        <td style="width: 100px;">Reg.No</td>
                        <td style="width: 150px">Name</td>
                        <td style="text-align: center;">Section</td>
                     
                        <%
                        Iterator code=subcodes.iterator();
                        while(code.hasNext()){
                            String t=GetSubjects.getSubjecName(code.next().toString());
                            %>
                            <td style="text-align: center;"><%=t%></td>
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
                        <td><%=count%></td>
                        <td><%=rt.getString("reg_no")%></td>
                        <td><%=rt.getString("name_")%></td>
                        <td><%=rt.getString("section_")%></td>
                       <%
                       Iterator it=subjects.iterator();
                       int subcount=0;
                       while(it.hasNext()){
                           String v=rt.getString(it.next().toString());
                           if(CheckNull.isNull(v)){
                               %>
                               <td style="text-align: center;">NA</td>
                        <%
                           }else{
                               
                                if(!v.equalsIgnoreCase("re") && !v.equalsIgnoreCase("a")){
                                     // int ii=Integer.parseInt(v);
                                    
                             String grad=Get.graduate(dept);
                                      double convert= Conversion.getValue(grad, "cia");
                                      
                                      if(Get.isSpecial(rt.getString("reg_no"))){
                                          
                                          convert= Conversion.getValue(grad, "special cia");
                                      }
                                      double max_mark=Get.maxMark(dept, "cia");
                                      
                               int ii=Integer.parseInt(v);
                               double cum=(ii*convert)/max_mark;
                              %>
                              <td style="text-align: center;"><%=cum%>&nbsp;(<%=v%>)</td>
                        <%  
                                }else{
                                    
                                    if(v.equalsIgnoreCase("a")){
                                                 %>
                              <td style="text-align: center;color: red;">a</td>
                        <%  
                                    }else{
                                                
                                      double cum_mark=ReExam.getMark(dept+"_"+"sem"+sem, rt.getString("reg_no"), subcodes.get(subcount).toString()); 
                                       %>
                              <td style="text-align: center;color: red;"><%=cum_mark%>&nbsp;(<%=v%>)</td>
                        <%  
                                    }
                            
                                }
                               
                             
                           }
                         subcount++; 
                       }
                       %>
                    </tr>
                    
                    <%
                    count++;
                    }
                    %>
                 
                    </tbody>
                    
                    
                    
                </table>
                
        </center>
                   
         
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