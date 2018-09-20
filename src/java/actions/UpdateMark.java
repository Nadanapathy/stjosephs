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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author unbox
 */
public class UpdateMark extends HttpServlet {

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
             Connection con=db.Dbconnection.getCon();
             String query="select * from `student_details` where reg_no='"+request.getParameter("regno").trim()+"'";
            System.out.println("Query :"+query);
            PreparedStatement ps=con.prepareStatement(query);
	    String tblname="";
	    ResultSet rt=ps.executeQuery();
            if(rt.next()){
                String dept=rt.getString("department_");
                String cursem=rt.getString("current_sem");
                tblname=dept+"_sem"+cursem;
            }
            
           // =request.getParameter("dept")+"_sem"+request.getParameter("cursem");
        
        String mark=request.getParameter("mark");
        String subcode=request.getParameter("subcode");
        String regno=request.getParameter("regno");
        String type=request.getParameter("type");
        
           
            query="update "+tblname+" set mark_='"+mark+"' where reg_no='"+regno+"' and type_='"+type+"' and subject_code='"+subcode+"'";
           //  String[] types=new String[]{"cia1","cia2","assign1","assign2","attendance"};
             
            ps=con.prepareStatement(query);
            ps.execute();
	    
             
            ps.close();
            
            con.close();
           response.sendRedirect("home.jsp?updated='yes'");
        }catch(Exception e){
             response.sendRedirect("home.jsp?failed='yes'");
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
