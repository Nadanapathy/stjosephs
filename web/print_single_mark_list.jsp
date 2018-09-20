<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@page import="org.apache.poi.ss.usermodel.Font"%>
<%@page import="org.apache.poi.ss.usermodel.CreationHelper"%>
<%@page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="org.apache.poi.ss.usermodel.Workbook"%>
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


 <%
//String id=request.getQueryString();
 Connection con=db.Dbconnection.getCon();
            String query="select name_ from department";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		

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
               
                Workbook workbook = new XSSFWorkbook(); 
                 CreationHelper createHelper = workbook.getCreationHelper();

        // Create a Sheet
        Sheet sheet = workbook.createSheet("Marklist");
          // Create a Font for styling header cells
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerFont.setFontHeightInPoints((short) 14);
        headerFont.setColor(IndexedColors.RED.getIndex());

        // Create a CellStyle with the font
        CellStyle headerCellStyle = workbook.createCellStyle();
        headerCellStyle.setFont(headerFont);
        String[] columns = {"Reg.No", "Cumulative"};
        // Create a Row
        Row headerRow = sheet.createRow(0);

        // Create cells
        for(int i = 0; i < columns.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(columns[i]);
            cell.setCellStyle(headerCellStyle);
        }
               
           
                   int count=1;int rowNum = 1;
                    while(rt.next()){
                        int fmark=0;
                   
                    
                         String isre=rt.getString(q1);
                         if(!isre.equalsIgnoreCase("re")){
                              int ii=Integer.parseInt(rt.getString(q1));
                        
                                      String grad=Get.graduate(dept);
                                      double convert= Conversion.getValue(grad, "cia");
                                      double max_mark=Get.maxMark(dept, "cia");
                                      
                                   System.out.println("Convert  :"+convert+"\t max:"+max_mark);
                                   
                               double cia1=(ii*convert)/max_mark;
                               
                               ii=Integer.parseInt(rt.getString(q2));
                               double cia2=(ii*convert)/max_mark;
                               
                               double as1=rt.getDouble(q3);
                               double as2=rt.getDouble(q4);
                               double att=rt.getDouble(q5);
                               
                               double total=cia1+cia2+as1+as2+att;
                               
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
                         
                        fmark=in;
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
                        
                        fmark=in;
                         }
                           
                    
                       
                         Row row = sheet.createRow(rowNum++);
                          row.createCell(0).setCellValue(rt.getString("reg_no"));
                          row.createCell(1).setCellValue(fmark);

                    count++;
                  //  rowNum++;
                    }
                    
              response.setContentType("application/vnd.ms-excel");
              response.setHeader("Content-Disposition","attachment;filename=\""+subjectcode+".xlsx\""); 
               workbook.write(response.getOutputStream());
        //fileOut.close();
        response.getOutputStream().close();
        // Closing the workbook
        workbook.close();
        
              
           }else{
              
           }
           
           
                      
           
                                                }catch(Exception e){
                                                    System.out.println("print single :"+e);
                
                                                }
           %>
          
	
		
		
		

