<%@page import="Beans.ReExam"%>
<%@page import="Beans.Get"%>
<%@page import="Beans.Conversion"%>
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
var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
    
   $scope.getSubjectName=function (){
         //   alert('getsubject name callled ....');
           $http.get("GetSubject?"+$scope.department+","+$scope.semester).then(function (response) {
            $scope.mySub = response.data.Data;
           }); 
        };
         
});
</script>
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
String id=request.getQueryString();
 Connection con=db.Dbconnection.getCon();
            String query="select name_ from department";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		
 %> 
   
 <div class="container" style="min-height: 468px;" ng-app="myApp" ng-controller="myCtrl">
    <div class="col-sm-4"></div>
	
                                                
                                                <!--  LINE-1 Content  -->
		
		<div class="col-sm-4">
			
		</div>
           
		
           <%
                                                try{
           if(request.getParameter("department")!=null && request.getParameter("cursem")!=null  && request.getParameter("shift")!=null ){
              
               String dept=request.getParameter("department");
               String sem=request.getParameter("cursem");
               String section=request.getParameter("section");
               String shift=request.getParameter("shift");
               //String type=request.getParameter("type");
            String subjectcode=request.getParameter("subcode");
               
//               String query1="select subject_code from allocated_subjects where department_='"+dept+"' and semester_='"+sem+"'";
//             PreparedStatement ps1=con.prepareStatement(query1);
//	   System.out.println("Subject Query :"+query1);
//	    ResultSet rt1=ps1.executeQuery();
//            ArrayList subjects=new ArrayList();
//            ArrayList subcodes=new ArrayList();
//            String addquery="";int querycount=1;
//              while(rt1.next()){
//                  String scode=rt1.getString("subject_code");
//                  subcodes.add(scode);
//              //    subjects.add(scode);
//                 
//                     String q="(select mark_ from "+dept+"_"+"sem"+sem+" where type_='"+type+"' and subject_code='"+scode+"' and reg_no=sd.reg_no )";
//                         
//                  
//                
//                  addquery+=","+q;
//                  subjects.add(q);
//                  querycount++;
//              } 
//               rt1.close();
//               ps1.close();
               
              // String qs=request.getQueryString();
               String q1="(select mark_ from "+dept+"_"+"sem"+sem+" where type_='cia1' and subject_code='"+subjectcode+"' and reg_no=sd.reg_no )";
               String q2="(select mark_ from "+dept+"_"+"sem"+sem+" where type_='cia2' and subject_code='"+subjectcode+"' and reg_no=sd.reg_no )";
               String q3="(select mark_ from "+dept+"_"+"sem"+sem+" where type_='assign1' and subject_code='"+subjectcode+"' and reg_no=sd.reg_no )";
               String q4="(select mark_ from "+dept+"_"+"sem"+sem+" where type_='assign2' and subject_code='"+subjectcode+"' and reg_no=sd.reg_no )";
               String q5="(select mark_ from "+dept+"_"+"sem"+sem+" where type_='attendance' and subject_code='"+subjectcode+"' and reg_no=sd.reg_no )";
                
                query="SELECT reg_no,section_,name_,"+q1+","+q2+","+q3+","+q4+","+q5+" FROM `student_details` sd where department_='"+dept+"' and current_sem='"+sem+"'  and shift='"+shift+"' and section_ ='"+section+"'  ORDER BY reg_no ASC ";
               System.out.println("Finale query :"+query);
               ps=con.prepareStatement(query);
               rt=ps.executeQuery();
           %>
           <form action="print_cumulative.jsp" method="post">
          
        
         
          
                   
               <table class="table table-hover" style="width: 100%">
                       <caption style="font-weight: bold;font-size: 25px;">
                            <label>Dept : <%=dept.toUpperCase()%></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           <label>Semester : <%=sem%></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           <label>Shift : <%=shift.toUpperCase()%></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                         
                             <label>Section : <%=section.toUpperCase()%></label>
                             <%
                            String subname= GetSubjects.getSubjecName(subjectcode);
                             %>
                             <label>Subject : <%=subjectcode.toUpperCase()%>&nbsp;&nbsp;&nbsp;<%=subname.toUpperCase()%></label>
                            <br><br>
                        </caption>   
                  
                    <thead>
                    <tr>
                        <th>Sl.No</th>
                        <th>Reg.No</th>
                        <th>Name</th>
                        <th>Section</th>
                        <th>CIA-1</th>
                        <th>CIA-2</th>
                        <th>COMP-1</th>
                        <th>COMP-2</th>
                        <th>ATT</th>
                        <th>TOTAL</th>
                        
                    </tr>
                    </thead>
                      <tbody>
                    <%
                   int count=1;
                    while(rt.next()){
                    %>
                  
                    <tr>
                        <td><%=count%></td>
                        <td><%=rt.getString("reg_no")%></td>
                        <td><%=rt.getString("name_")%></td>
                        <td><%=rt.getString("section_")%></td>
                        <%
                         String isre=rt.getString(q1);
                         if(!isre.equalsIgnoreCase("re")){
                             
                              String grad=Get.graduate(dept);
                                      double convert= Conversion.getValue(grad, "cia");
                                      if(Get.isSpecial(rt.getString("reg_no"))){
                                          
                                          convert= Conversion.getValue(grad, "special cia");
                                      }
                                      double max_mark=Get.maxMark(dept, "cia");
                                   System.out.println("Convert  :"+convert+"\t max:"+max_mark);
                            
                                   
                                  int ii=0;
                                   String cia1="",cia2="";
                                   double dcia1=0,dcia2=0;
                                   
                               String v=rt.getString(q1);     
                             if(v.equalsIgnoreCase("a")){
                                 cia1="a";
                             }else{
                                  ii=Integer.parseInt(v);
                                  dcia1=(ii*convert)/max_mark;
                                  cia1=dcia1+"";
                             }
                             
                             
                             v=rt.getString(q2);
                                if(v.equalsIgnoreCase("a")){
                                 cia2="a";
                             }else{
                                  ii=Integer.parseInt(v);
                                dcia2=(ii*convert)/max_mark;
                                  cia2=dcia2+"";
                             }
                              
                               
                               double as1=rt.getDouble(q3);
                               double as2=rt.getDouble(q4);
                               double att=rt.getDouble(q5);
                               
                               double total=dcia1+dcia2+as1+as2+att;
                               
                                  String tt=total+"";
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
                          %>
                         <td style="text-align: center;"><%=cia1%></td>
                        <td style="text-align: center;"><%=cia2%></td>
                        <td style="text-align: center;"><%=rt.getString(q3)%></td>
                        <td style="text-align: center;"><%=rt.getString(q4)%></td>
                        <td style="text-align: center;"><%=rt.getString(q5)%></td>
                        <td style="text-align: center;"><%=in%></td>
                        
                        <%
                         }else{
                            double cum_mark=ReExam.getMark(dept+"_"+"sem"+sem, rt.getString("reg_no"), subjectcode); 
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
                              %>
                         <td style="text-align: center;color: red">Re*</td>
                        <td style="text-align: center;color: red">Re*</td>
                        <td style="text-align: center;color: red">Re*</td>
                        <td style="text-align: center;color: red">Re*</td>
                        <td style="text-align: center;color: red">Re*</td>
                        <td style="text-align: center;color: red"><%=in%>*</td>
                        
                        <%
                         }
                           
                        %>
                       
                       
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
<!--                                                        <h1>Data Not Found !</h1>-->
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