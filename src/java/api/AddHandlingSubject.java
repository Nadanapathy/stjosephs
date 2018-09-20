/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package api;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
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
public class AddHandlingSubject extends HttpServlet {

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
            String[] qs=URLDecoder.decode(request.getQueryString()).split(",");
            for(String q:qs){
                System.out.println("values :"+q);
            }
            String staffid=qs[0];
            String subjectcode=qs[1];
            String incharge=qs[2];
            String semester=qs[3];
            String section=qs[4];
            String shift=qs[5];
            String dept=qs[6];
            String year=qs[7];
            
           Connection con=db.Dbconnection.getCon();
            String query="INSERT INTO `handling_subjects`(`staff_details_id`, `staff_id`, `subject_id`, `subject_code`, `subject_name`, `department_`, `semester_`, `section_`, `shift_`, `is_incharge`, `status_`,year_) VALUES((SELECT `id` FROM `staff_details` WHERE `staff_id`='"+staffid+"' limit 1),'"+staffid+"',(SELECT `id` FROM `subjects` WHERE `subject_code`='"+subjectcode+"' limit 1),'"+subjectcode+"',(SELECT name_ FROM `subjects` WHERE `subject_code`='"+subjectcode+"' limit 1),'"+dept+"','"+semester+"','"+section+"','"+shift+"','"+incharge+"','yes','"+year+"')";
            PreparedStatement ps=con.prepareStatement(query);
	   // ps.setString(1, "(SELECT `id` FROM `staff_details` WHERE `staff_id`='"+staffid+"' limit 1)");
//            ps.setString(1, staffid);
//            System.out.println("1");
//         //   ps.setString(3, "(SELECT `id` FROM `subjects` WHERE `subject_code`='"+subjectcode+"' limit 1)");
//            ps.setString(2, subjectcode);
//             System.out.println("2");
//        //    ps.setString(5, "(SELECT `name_ FROM `subjects` WHERE `subject_code`='"+subjectcode+"' limit 1)");
//            ps.setString(3, dept);
//             System.out.println("3");
//            ps.setString(4, semester);
//            ps.setString(5, section);
//            ps.setString(6, shift);
//            ps.setString(7, incharge);
//            ps.setString(8, "yes");
            
            ps.execute();
            
	     
            ps.close();
            con.close();
            result.put("status", "inserted !");
        }catch(Exception  e){
             result.put("Status", "Error"+e);
             System.out.println("Add Handlinge sub :"+e);
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
