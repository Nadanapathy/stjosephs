/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author SAM
 */
public class Dbconnection {
    public static String Dbname="college",Dbuser="Root",Dbpass="B2lsolutions@guna";
    
    public static Connection getCon(){
        Connection con=null;
        try{
           Class.forName("com.mysql.jdbc.Driver");
           con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+Dbname,Dbuser,Dbpass);
      
        }catch(Exception e){
            System.out.println("Exception in DB.java :"+e);
        }
        return con;
    }
}
