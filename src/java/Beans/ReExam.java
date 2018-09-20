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
public class ReExam {
    public static Double getMark(String tblname,String regno,String subcode){
        Double mark=0.0;
        try{
            Connection con=db.Dbconnection.getCon();
            String query="select mark_ from "+tblname+" where reg_no='"+regno+"' and type_='reexam' and subject_code='"+subcode+"'";
            System.out.println("Reexam :"+query);
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
             if(rt.next()){
                mark=rt.getDouble("mark_");
             }
		
		rt.close();
            ps.close();
            con.close();
        }catch(Exception e){
            System.out.println("Mark Staus isEntered():"+e);
        }
        
        return mark;
    }
}
