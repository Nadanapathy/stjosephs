<%@page import="Beans.ReExam"%>
<%@page import="Beans.Conversion"%>
<%@page import="Beans.Get"%>
<%@page import="java.sql.Statement"%>
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
    
                                                
                                                <!--  LINE-1 Content  -->
		
           
		
           <%
                                                try{
           if(request.getParameter("department")!=null && request.getParameter("cursem")!=null  && request.getParameter("shift")!=null ){
              
               String dept=request.getParameter("department");
               String sem=request.getParameter("cursem");
               String section=request.getParameter("section");
               String shift=request.getParameter("shift");
             //  String type=request.getParameter("type");
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
                 
                    // String q="(select mark_ from "+dept+"_"+"sem"+sem+" where  subject_code='"+scode+"' and reg_no=sd.reg_no )";
                         
                 
                
                //  addquery+=","+q;
                //  subjects.add(q);
                  querycount++;
              } 
              
               rt1.close();
               ps1.close();
               
               query="SELECT reg_no,section_,name_"+addquery+" FROM `student_details` sd where department_='"+dept+"' and current_sem='"+sem+"'  and shift='"+shift+"' and  section_='"+section+"' ORDER BY reg_no ASC ";
               System.out.println("Finale query :"+query);
               ps=con.prepareStatement(query);
               rt=ps.executeQuery();
           %>
           <form action="#" method="post">
          
      
          
          
                   
           <table class="table table-hover" style="width: 100%">
                     <caption style="font-weight: bold;font-size: 25px;">
                            <label>Dept : <%=dept.toUpperCase()%></label> &nbsp;&nbsp;&nbsp;
                           <label>Semester : <%=sem%></label>&nbsp;&nbsp;&nbsp;&nbsp;
                            <label>Section : <%=section.toUpperCase()%></label>&nbsp;&nbsp;&nbsp;
                           <label>Shift : <%=shift.toUpperCase()%></label>&nbsp;&nbsp;&nbsp;
                            
                        </caption>
                  
                    <thead>
                    <tr>
                        <th>Sl.No</th>
                        <th>Reg.No</th>
                        <th>Name</th>
                      
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
               <tbody>
                    <%
                   int count=1;
                    while(rt.next()){
                    %>
                   
                    <tr>
                       
                       <%
                        int failcount=0;
                        code=subcodes.iterator();
                        String tblname=dept+"_sem"+sem;
                        String[] types=new String[]{"cia1","cia2","assign1","assign2","attendance"};
                        PreparedStatement ps3=con.prepareStatement("select * from "+tblname+" where reg_no=? and type_=? and subject_code=?");
                        while(code.hasNext()){
                          String t=code.next().toString();
                          double cum_mark=0;
                         
                          for(String type:types){
                              
                              ps3.setString(1, rt.getString("reg_no"));
                              ps3.setString(2, type);
                              ps3.setString(3, t);
                              
                              ResultSet rt3=ps3.executeQuery();
                             if(rt3.next()){
                                  String v=rt3.getString("mark_");
                                    if(CheckNull.isNull(v)){
                                     %>
                                        <td style="text-align: center;">NA</td>
                                     <%
                                    }else{
                                        
                                          if(!v.equalsIgnoreCase("re") && !v.equalsIgnoreCase("a")){
                                                      double mark=rt3.getDouble("mark_");
                                  
                                  if(type.equalsIgnoreCase("cia1")){
                                      String grad=Get.graduate(dept);
                                      double convert= Conversion.getValue(grad, "cia");
                                      double max_mark=Get.maxMark(dept, "cia");
                                        
                                      if(Get.isSpecial(rt.getString("reg_no"))){
                                          
                                          convert= Conversion.getValue(grad, "special cia");
                                      }
                                       double cum=(mark*convert)/max_mark;
                                       cum_mark+=cum;
                                       
                                  }
                                   if(type.equalsIgnoreCase("cia2")){
                                       String grad=Get.graduate(dept);
                                      double convert= Conversion.getValue(grad, "cia");
                                      double max_mark=Get.maxMark(dept, "cia");
                                        
                                      if(Get.isSpecial(rt.getString("reg_no"))){
                                          
                                          convert= Conversion.getValue(grad, "special cia");
                                      }
                                       double cum=(mark*convert)/max_mark;
                                       cum_mark+=cum;
                                  }
                                   if(type.equalsIgnoreCase("assign1")){
                                        cum_mark+=mark;
                                  }
                                   if(type.equalsIgnoreCase("assign2")){
                                        cum_mark+=mark;
                                  }
                                   if(type.equalsIgnoreCase("attendance")){
                                     //  double cum=(mark*2.5)/50;
                                       cum_mark+=mark;
                                  }
                                   
                                          }else{
                                            
                                              if(v.equalsIgnoreCase("a")){
                                               //  cum_mark=0;
                                             }else{
                                                
                                                  cum_mark=ReExam.getMark(dept+"_"+"sem"+sem, rt.getString("reg_no"), t); 
                             
                                             }
                              
                                          }
                              
                                   
                                    }
                                  
                              }
                              rt3.close();
                          }
                          if(cum_mark<10){
                              failcount++;
                          }
                      
                        }
                        ps3.close();
                        
                        //getting single failures completed
                        if(failcount==1){
                        %>
                       
                        <td><%=count%></td>
                        <td><%=rt.getString("reg_no")%></td>
                        <td><%=rt.getString("name_")%></td>
                        <td><%=rt.getString("section_")%></td>                        
                        <%
                         code=subcodes.iterator();
                        ps3=con.prepareStatement("select * from "+tblname+" where reg_no=? and type_=? and subject_code=?");
                        while(code.hasNext()){
                          String t=code.next().toString();
                          double cum_mark=0;
                         
                          for(String type:types){
                              
                              ps3.setString(1, rt.getString("reg_no"));
                              ps3.setString(2, type);
                              ps3.setString(3, t);
                              
                              ResultSet rt3=ps3.executeQuery();
                              if(rt3.next()){
                                  String v=rt3.getString("mark_");
                                    if(CheckNull.isNull(v)){
                                     %>
                                        <td style="text-align: center;">NA</td>
                                     <%
                                    }else{
                                        
                                          if(!v.equalsIgnoreCase("re") && !v.equalsIgnoreCase("a")){
                                                      double mark=rt3.getDouble("mark_");
                                  
                                  if(type.equalsIgnoreCase("cia1")){
                                      String grad=Get.graduate(dept);
                                      double convert= Conversion.getValue(grad, "cia");
                                      double max_mark=Get.maxMark(dept, "cia");
                                        
                                      if(Get.isSpecial(rt.getString("reg_no"))){
                                          
                                          convert= Conversion.getValue(grad, "special cia");
                                      }
                                       double cum=(mark*convert)/max_mark;
                                       cum_mark+=cum;
                                       
                                  }
                                   if(type.equalsIgnoreCase("cia2")){
                                       String grad=Get.graduate(dept);
                                      double convert= Conversion.getValue(grad, "cia");
                                      double max_mark=Get.maxMark(dept, "cia");
                                        
                                      if(Get.isSpecial(rt.getString("reg_no"))){
                                          
                                          convert= Conversion.getValue(grad, "special cia");
                                      }
                                       double cum=(mark*convert)/max_mark;
                                       cum_mark+=cum;
                                  }
                                   if(type.equalsIgnoreCase("assign1")){
                                        cum_mark+=mark;
                                  }
                                   if(type.equalsIgnoreCase("assign2")){
                                        cum_mark+=mark;
                                  }
                                   if(type.equalsIgnoreCase("attendance")){
                                     //  double cum=(mark*2.5)/50;
                                       cum_mark+=mark;
                                  }
                                   
                                          }else{
                                            
                                              if(v.equalsIgnoreCase("a")){
                            
                                             }else{
                                                
                                                  cum_mark=ReExam.getMark(dept+"_"+"sem"+sem, rt.getString("reg_no"), t); 
                             
                                             }
                              
                                          }
                              
                                   
                                    }
                                  
                              }
                              rt3.close();
                          }
                          if(cum_mark<10){
                              failcount++;
                          }
                          String tt=cum_mark+"";
                          String[] fcm=tt.split("\\.");
                          int in=Integer.parseInt(fcm[0]),dec=0;
                         // String dec="";
                          if(fcm.length>0){
                               String[] dot=fcm[1].split("");
//                               int c=0;
                              
                               int cc=Integer.parseInt(dot[0]);
                               if(cc>5){
                                 // cc++;
                                   dec=0;
                                   in++;
                               }else{
                                   dec=cc;
                               }
                              //dec=dot[0];
                          }else{
                              dec=0;
                          }
                        if(cum_mark<10){
                          %>
                         <td style="text-align: center;color: #FF0000;"><%=in%>.<%=dec%></td>
                        <%  
                        }else{
                           %>
                         <td style="text-align: center;">-</td>
                        <% 
                        }
                         
                        }
                        ps3.close();
                         count++;
                        }
                        %>
                    </tr>
                    
                    <%
                   
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