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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author unbox
 */
public class UpdateHandlingSubject extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String staffid=request.getParameter("staffid");
            String subjectcode=request.getParameter("subjectid");
            String incharge=request.getParameter("incharge");
            String semester=request.getParameter("semester");
            String section=request.getParameter("section");
            String shift=request.getParameter("shift");
            String dept=request.getParameter("department");
           // String year=request.getParameter("");
            
           Connection con=db.Dbconnection.getCon();
            String query="update `handling_subjects` set `staff_details_id`=(SELECT `id` FROM `staff_details` WHERE `staff_id`='"+staffid+"' limit 1), `staff_id`='"+staffid+"', `subject_id`=(SELECT `id` FROM `subjects` WHERE `subject_code`='"+subjectcode+"' limit 1), `subject_code`='"+subjectcode+"', `subject_name`=(SELECT name_ FROM `subjects` WHERE `subject_code`='"+subjectcode+"' limit 1), `department_`='"+dept+"', `semester_`='"+semester+"', `section_`='"+section+"', `shift_`='"+shift+"', `is_incharge`='"+incharge+"' where id='"+request.getQueryString()+"'";
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
            
            response.sendRedirect("edit_allocation.jsp?"+request.getQueryString());
        }catch(Exception e){
            System.out.println("Update Hanling sub :"+e);
        }
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
