/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package api;

import Beans.CheckNull;
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
public class GetSubject extends HttpServlet {

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
            
           // System.out.println("Get Subject Called");
            String[] qs=request.getQueryString().split(",");
            
           Connection con=db.Dbconnection.getCon();
           
            String query="select * from allocated_subjects where department_='"+qs[0]+"' and semester_='"+qs[1]+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
            Beans.GetSubjects get=new Beans.GetSubjects();
            while(rt.next()){
              JSONObject data=new JSONObject();
                data.put("SubjectCode", rt.getString("subject_code"));
                data.put("SubjectName",Beans.GetSubjects.getSubjecName(rt.getString("subject_code")).toUpperCase());
                data.put("SubjectId",rt.getString("id"));
                
               array.add(data);
            }
            
            result.put("Data", array);
            
	    rt.close();
            ps.close();
            con.close();
	 
           
        }catch(Exception  e){
             result.put("Status", "Error :"+e);
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
