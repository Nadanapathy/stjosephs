/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author unbox
 */
public class GetSubjects {
    public static List getSubjecCode(String dept,String sem){
       ArrayList list=null;
       
       try{
            Connection con=db.Dbconnection.getCon();
            String query="select subject_code from allocated_subjects where department_='"+dept+"' and semester_='"+sem+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		while(rt.next()){
                   // list
                }
		
		rt.close();
            ps.close();
            con.close();
       }catch(Exception e){
           System.out.println("Get subjeccts :"+e);
       }
       
       return list;
    }
    
     public static String  getSubjecName(String subcode){
       String name="";
       
       try{
            Connection con=db.Dbconnection.getCon();
            String query="SELECT `name_` FROM `subjects` WHERE `subject_code`='"+subcode.toLowerCase()+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		if(rt.next()){
                  name=rt.getString("name_");
                }
		
		rt.close();
            ps.close();
            con.close();
       }catch(Exception e){
           System.out.println("Get subjeccts :"+e);
       }
       
       return name;
    }
    
}
