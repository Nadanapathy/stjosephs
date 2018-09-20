/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package actions;

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
public class UpdateStudentDetail extends HttpServlet {

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
            
            
            String id=request.getQueryString();
            
           String dept=request.getParameter("department");
           String cursem=request.getParameter("cursem");
           String section=request.getParameter("section");
           String year=request.getParameter("year");
           String shift=request.getParameter("shift");
           String regno=request.getParameter("regno");
           String name=request.getParameter("name");
           String isspec=request.getParameter("isspecial");
          
           Connection con=db.Dbconnection.getCon();
            String query="update `student_details` set `reg_no`=?, `name_`=?, `current_sem`=?, `section_`=?, `year_`=?, `shift`=?, `department_`=?,is_special=? where id='"+id+"'";
            PreparedStatement ps=con.prepareStatement(query);
	    ps.setString(1, regno);
            ps.setString(2, name);
            ps.setString(3, cursem);
            ps.setString(4, section);
            ps.setString(5, year);
            ps.setString(6, shift);
            ps.setString(7, dept);
            ps.setString(8, isspec);
            ps.execute();
           
            response.sendRedirect("editing_student.jsp?id="+id);
        }catch(Exception e){
            System.out.println("update sudent :"+e);
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
