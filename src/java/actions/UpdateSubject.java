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
public class UpdateSubject extends HttpServlet {

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
               
          String grad=request.getParameter("department");
          String subcode=request.getParameter("subcode");
          String subj=request.getParameter("subname");
           String sem=request.getParameter("semester");
          String id=request.getQueryString();
           Connection con=db.Dbconnection.getCon();
            String query="update subjects set `department_`=?,`name_`=?, `subject_code`=?,semester_=? where id='"+id+"'";
            PreparedStatement ps=con.prepareStatement(query);
	    ps.setString(1, grad.toLowerCase());
            ps.setString(2, subj.toLowerCase());
            ps.setString(3, subcode);
            ps.setString(4, sem);
            ps.execute();
            
            ps.close();
            con.close();
          
            response.sendRedirect("editing_subject.jsp?updated='yes'&id="+id);
            
        }catch(Exception e){
                System.out.println("Exception :"+e);
                 response.sendRedirect("edit_subject.jsp?failed='yes'");
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
