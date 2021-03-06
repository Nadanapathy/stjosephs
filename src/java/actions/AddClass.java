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
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author unbox
 */
public class AddClass extends HttpServlet {

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
          
            Connection con=db.Dbconnection.getCon();
            String query="UPDATE `handling_subjects` SET `department_` = ?, `semester_` = ?, `section_` = ?, `shift_` = ? WHERE `handling_subjects`.`id` = '"+id+"'";
            PreparedStatement ps=con.prepareStatement(query);
	    
            ps.setString(1, request.getParameter("department").toLowerCase());
            ps.setString(2, request.getParameter("semester").toLowerCase());
            ps.setString(3, request.getParameter("section").toLowerCase());
            ps.setString(4, request.getParameter("shift").toLowerCase());
	    
            boolean execute = ps.execute();
            ps.close();
            
            Statement st=con.createStatement();
            ResultSet rt=st.executeQuery("select staff_id,staff_details_id from `handling_subjects` where `id` = '"+id+"'");
            String staffid="";
            if(rt.next()){
                staffid=rt.getString("staff_details_id");
            }
            con.close();
            
            response.sendRedirect("allocate_sub.jsp?stored='yes'&id="+staffid);
            
        }catch(Exception e){
            
            System.out.println("AddClass :"+e);
            
             response.sendRedirect("allocate_sub.jsp?failed='yes'");
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
