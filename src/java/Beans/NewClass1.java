/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;

/**
 *
 * @author unbox
 */
public class NewClass1 {
    public static void main(String[] args) throws Exception {
        Connection conn=db.Dbconnection.getCon();
    DatabaseMetaData md = conn.getMetaData();
    ResultSet rs = md.getTables(null, null, "%", null);
    while (rs.next()) {
      System.out.println(rs.getString(3));
    } 
    rs.close();
        System.out.println("------------------------------");
    DatabaseMetaData meta = conn.getMetaData();
     rs = meta.getColumns(null, null, "admin_log", "%");
     while (rs.next()) {
       
           System.out.println(rs.getString(4)); 
     }
    }
}
