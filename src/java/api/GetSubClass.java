/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package api;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author unbox
 */
public class GetSubClass extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
          response.setContentType("application/json");   
          
		  JSONArray array = new JSONArray();
       
	   JSONObject result=new JSONObject();
         
		 PrintWriter out = response.getWriter();
          
        try{
            
            System.out.println("Get Subject Class Called");
            String qs[]=request.getQueryString().split(",");
            
           // String id=qs[0];
            String dept=qs[0];
            String sem=qs[1];
           Connection con=db.Dbconnection.getCon();
           
            String query="select id,subject_code,(select name_ from subjects where subject_code=s.subject_code) from allocated_subjects  s where department_='"+dept+"' and semester_='"+sem+"'";
            System.out.println("Query :"+query);
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
            
            int count=1;
            while(rt.next()){
                JSONObject data=new JSONObject();
                data.put("Slno",count+"");
                data.put("SubjectCode", rt.getString("subject_code"));
                data.put("SubjectName", rt.getString("(select name_ from subjects where subject_code=s.subject_code)"));
                data.put("SubjectId",rt.getString("id"));
                array.add(data);
                count++;
            }
            
            result.put("Data", array);
            
	    rt.close();
            ps.close();
            con.close();
	 
           
        }catch(Exception  e){
             result.put("Status", "Error"+e);
            result.put("Result", "-1"); 
        }
		
	 out.println(result.toJSONString());	
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
