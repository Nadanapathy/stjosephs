/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author unbox
 */
public class GetStaffDetails {
    public static Map get(String staffid){
        Map details=new HashMap();
        
        try{
            Connection con=db.Dbconnection.getCon();
            String query="select * from staff_details where staff_id='"+staffid+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		if(rt.next()){
                    details.put("Name", rt.getString("name_"));
                    details.put("Department", rt.getString("department_"));
                    details.put("Id", rt.getString("id"));
                    details.put("Status", rt.getString("status_"));
                }
		
		rt.close();
            ps.close();
            con.close();
        }catch(Exception e){
            System.out.println(e);
        }
        
        return details;
    }
        public static String getName(String staffid){
       String name="";
        
        try{
            Connection con=db.Dbconnection.getCon();
            String query="select * from staff_details where staff_id='"+staffid+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		if(rt.next()){
                    name= rt.getString("name_");
                   
                }
		
		rt.close();
            ps.close();
            con.close();
        }catch(Exception e){
            System.out.println(e);
        }
        
        return name;
    }
}
