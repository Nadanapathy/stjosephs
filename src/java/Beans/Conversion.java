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
public class Conversion {
    public  static double getValue(String graduate,String type){
        double value=0.0;
         try{
            Connection con=db.Dbconnection.getCon();
            String query="SELECT * FROM `mark_details` where graduate_='"+graduate+"' and type_='"+type+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		if(rt.next()){
                   // list
                    value=rt.getDouble("convert_to");
                }
		
            rt.close();
            ps.close();
            con.close();
       }catch(Exception e){
           System.out.println("Get subjeccts :"+e);
       }
        
        return value;
    }
        public  static double getSpecialValue(String graduate,String type){
        double value=0.0;
         try{
            Connection con=db.Dbconnection.getCon();
            String query="SELECT * FROM `mark_details` where graduate_='"+graduate+"' and type_='"+type+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		if(rt.next()){
                   // list
                    value=rt.getDouble("convert_to");
                }
		
            rt.close();
            ps.close();
            con.close();
       }catch(Exception e){
           System.out.println("Get subjeccts :"+e);
       }
        
        return value;
    }
}
