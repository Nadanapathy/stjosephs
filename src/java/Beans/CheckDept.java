/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author unbox
 */
public class CheckDept {
    public static boolean isThere(String dept){
           boolean status=false;
        try{
            Connection con=db.Dbconnection.getCon();
            String query="SELECT * FROM `department` WHERE `name_`='"+dept+"' ";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
             if(rt.next()){
                 status=true;
             }else{
                status=false; 
             }
		
		rt.close();
            ps.close();
            con.close();
        }catch(Exception e){
            System.out.println("Mark Staus isEntered():"+e);
        }
        return status;
    }
       public static boolean isSubCodeThere(String subcode){
           boolean status=false;
        try{
            Connection con=db.Dbconnection.getCon();
            String query="SELECT * FROM `subjects` WHERE `subject_code`='"+subcode+"' ";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
             if(rt.next()){
                 status=true;
             }else{
                status=false; 
             }
		
		rt.close();
            ps.close();
            con.close();
        }catch(Exception e){
            System.out.println("Mark Staus isEntered():"+e);
        }
        return status;
    }
       
           public static boolean isStaffIdThere(String staffid){
           boolean status=false;
        try{
            Connection con=db.Dbconnection.getCon();
            String query="SELECT * FROM `staff_details` WHERE `staff_id`='"+staffid+"' ";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
             if(rt.next()){
                 status=true;
             }else{
                status=false; 
             }
		
		rt.close();
            ps.close();
            con.close();
        }catch(Exception e){
            System.out.println("Mark Staus isEntered():"+e);
        }
        return status;
    }
}
