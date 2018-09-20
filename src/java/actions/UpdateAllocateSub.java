/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package actions;

import Beans.GetSubjects;
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
public class UpdateAllocateSub extends HttpServlet {

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
            
            String subcode=request.getParameter("subcode");
            String subname=GetSubjects.getSubjecName(subcode);
            String dept=request.getParameter("department");
            String sem=request.getParameter("semester");
            String section=request.getParameter("section");
            String shift=request.getParameter("shift");
            String isincharge=request.getParameter("incharge");
            
          Connection con=db.Dbconnection.getCon();
            String query="update `handling_subjects` set `subject_code`=?, `subject_name`=?, `department_`=?, `semester_`=?, `section_`=?, `shift_`=?, `is_incharge`=? where id='"+id+"'";
            PreparedStatement ps=con.prepareStatement(query);
            ps.setString(1, subcode);
            ps.setString(2, subname);
            ps.setString(3, dept);
            ps.setString(4, sem);
            ps.setString(5, section);
            ps.setString(6, shift);
            ps.setString(7, isincharge);
            ps.execute();
            
            response.sendRedirect("edit_allocate_sub.jsp?id="+id);
        }catch(Exception  e){
             System.out.println("update allocate sub :"+e);
             response.sendRedirect("edit_allocate_sub.jsp?id="+request.getQueryString());
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
