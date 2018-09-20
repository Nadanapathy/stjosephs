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
import java.util.Date;

/**
 *
 * @author unbox
 */
public class MarkStatus {
    public static boolean isEntered(String handling_id,String type){
        boolean status=false;
        try{
            Connection con=db.Dbconnection.getCon();
            String query="select id from `marklist_details` where handling_subjects_id='"+handling_id+"' and type_='"+type+"'";
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
    
    public static boolean  makeUpdated(String handling_id,String type){
           boolean status=false;
        try{
            Connection con=db.Dbconnection.getCon();
            String query="INSERT INTO `marklist_details`(`handling_subjects_id`, `type_`, `date_time`) VALUES(?,?,?)";
            PreparedStatement ps=con.prepareStatement(query);
	   
            ps.setString(1, handling_id);
            ps.setString(2, type);
            
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            ps.setString(3, sdf.format(new Date()));
            ps.execute();
            ps.close();
            con.close();
            
            status=true;
            
        }catch(Exception e){
             System.out.println("Mark Staus makeUpdated():"+e);
        }
        return status;
    }
    
     public static boolean  canEnterMark(String type){
           boolean status=false;
        try{
            Connection con=db.Dbconnection.getCon();
            String query="SELECT * FROM `announce` WHERE `type_`='"+type+"'";
          //  System.out.println("Query :"+query);
            PreparedStatement ps=con.prepareStatement(query);
	    ResultSet rt=ps.executeQuery();
            if(rt.next()){
                 if(rt.getString("mark_entry_status").equalsIgnoreCase("yes")) {
                     status=true;
                 }   else{
                     status=false;
                 }            
            }
		
		rt.close();
            ps.execute();
            ps.close();
            con.close();
            
           // status=true;
            
        }catch(Exception e){
             System.out.println("Mark Staus makeUpdated():"+e);
        }
        return status;
    }
    
}
