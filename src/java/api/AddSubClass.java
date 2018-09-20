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
import java.sql.Statement;
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
public class AddSubClass extends HttpServlet {

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
            
            String qs[]=request.getQueryString().split(",");
            
            String id=qs[0];
            String dept=qs[1];
            String sem=qs[2];
            
            Connection con=db.Dbconnection.getCon();
            String query="SELECT `id`,`subject_code`,name_ FROM `subjects` WHERE id='"+id+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
            if(rt.next()){
                //String sdid=rt.getString("(SELECT id from staff_details where staff_id='"+staffid+"' LIMIT 1)");
                String subcode=rt.getString("subject_code");
                String subname=rt.getString("name_");
                
               Statement st=con.createStatement();
              int i= st.executeUpdate("INSERT INTO `allocated_subjects`(`department_`, `semester_`, `subject_code`, `staff_id`) VALUES ('"+dept+"','"+sem+"','"+subcode+"','')");
	      if(i!=0){
                result.put("Status", "Added !");
                result.put("Result", "1");  
              }else{
                  result.put("Status", "Failed !");
                result.put("Result", "0"); 
              }
            }else{
                result.put("Status", "Failed !");
                result.put("Result", "0"); 
            }
           	
		rt.close();
            ps.close();
            con.close();
           
        }catch(Exception  e){
             result.put("Status", "Error");
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
