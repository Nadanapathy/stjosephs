/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import org.apache.tomcat.jni.Local;

/**
 *
 * @author unbox
 */
public class Get {
    public static String graduate(String dept){
        String grad="";
              try{
            Connection con=db.Dbconnection.getCon();
            String query="SELECT * FROM `department` where name_='"+dept+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		if(rt.next()){
                   // list
                    grad=rt.getString("graduate_");
                }
		
            rt.close();
            ps.close();
            con.close();
       }catch(Exception e){
           System.out.println("Get subjeccts :"+e);
       }
              return grad;
    }
    public static double maxMark(String dept,String type){
         double mark=0.0;
              try{
                  String graduate=Get.graduate(dept);
            Connection con=db.Dbconnection.getCon();
            String query="SELECT * FROM `mark_details` where graduate_='"+graduate+"' and type_='"+type+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		if(rt.next()){
                   // list
                    mark=rt.getDouble("max_mark");
                }
		
            rt.close();
            ps.close();
            con.close();
       }catch(Exception e){
           System.out.println("Get subjeccts :"+e);
       }
              return mark;
    }
    
    public static String[] getAcademicYear(){
        String[] d=new String[2];
         
        SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
        String[] dates=sdf.format(new Date()).split("-");
        int mon=Integer.parseInt(dates[1]);
        int year=Integer.parseInt(dates[2]);
        System.out.println("mon :"+mon+"\n year :"+year);
//        if(mon>11 && mon<5){
//            d[0]="april";
//            if(mon==12){
//                year++;
//                d[1]=year+"";
//            }else{
//                 d[1]=year+"";
//            }
//        }
//        if(mon >=5 && mon<12){
//             d[0]="nov";
//             d[1]=year+"";
//        }
        
        switch(mon){
            case 1: d[0]="april";d[1]=year+"";break;
            case 2: d[0]="april";d[1]=year+"";break;
            case 3: d[0]="april";d[1]=year+"";break;
            case 4: d[0]="april";d[1]=year+"";break;
            case 5: d[0]="nov";d[1]=year+"";break;
            case 6: d[0]="nov";d[1]=year+"";break;
            case 7: d[0]="nov";d[1]=year+"";break;
            case 8: d[0]="nov";d[1]=year+"";break;
            case 9: d[0]="nov";d[1]=year+"";break;
            case 10: d[0]="nov";d[1]=year+"";break;
            case 11: d[0]="nov";d[1]=year+"";break;
            case 12: d[0]="april";d[1]=(year+1)+"";break;
                
        }
        
       
            return d;
    }
    
        public static boolean isSpecial(String regno){
        boolean status=false;
              try{
            Connection con=db.Dbconnection.getCon();
            String query="SELECT `is_special` FROM `student_details` WHERE `reg_no`='"+regno+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		if(rt.next()){
                   // list
                    if(!CheckNull.isNull(rt.getString("is_special"))){
                         if(rt.getString("is_special").equalsIgnoreCase("yes")){
                           status=true;
                          }
                    }else{
                        status=false;
                    }
                   
                    
                }
		
            rt.close();
            ps.close();
            con.close();
       }catch(Exception e){
           System.out.println("Get subjeccts :"+e);
       }
              return status;
    }
          public static boolean isSubThere(String subcode){
        boolean status=false;
              try{
            Connection con=db.Dbconnection.getCon();
            String query="SELECT `id` FROM `subjects` WHERE `subject_code`='"+subcode+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		if(rt.next()){
                   // list
                status=true;  
                    
                }else{
                    status=false;  
                }
		
            rt.close();
            ps.close();
            con.close();
       }catch(Exception e){
           System.out.println("Get subjeccts :"+e);
       }
              return status;
    }
          
          
                public static boolean isStaffThere(String staffid){
        boolean status=false;
              try{
            Connection con=db.Dbconnection.getCon();
            String query="SELECT `id` FROM `staff_details` WHERE `staff_id`='"+staffid+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		if(rt.next()){
                   // list
                status=true;  
                    
                }else{
                    status=false;  
                }
		
            rt.close();
            ps.close();
            con.close();
       }catch(Exception e){
           System.out.println("Get subjeccts :"+e);
       }
              return status;
    }
          
//    public static void main(String[] args) {
//       String[] d=Get.getAcademinYear();
//        System.out.println(d[0]+"-"+d[1]);
//    }
}
