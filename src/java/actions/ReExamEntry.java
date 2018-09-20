/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package actions;

import Beans.CheckNull;
import Beans.Get;
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
public class ReExamEntry extends HttpServlet {

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
            System.out.println("re exam entry called....");
           String dept=request.getParameter("department").toLowerCase();
           System.out.println("re exam entry called....1");
           String cursem=request.getParameter("cursem");
           System.out.println("re exam entry called....2");
           String section=request.getParameter("section").toLowerCase();
           String type=request.getParameter("type").toLowerCase();
           String shift=request.getParameter("shift").toLowerCase();
          String subcode=request.getParameter("subcode").toLowerCase();
            
           Connection con=db.Dbconnection.getCon();
            String query="SELECT reg_no FROM `student_details` where department_='"+dept+"' and current_sem='"+cursem+"' and section_='"+section+"' and shift='"+shift+"' ORDER BY reg_no ASC ";
            System.out.println("Query :"+query);
            PreparedStatement ps=con.prepareStatement(query);
            
            String tblname=dept+"_sem"+cursem;
            String query1="insert into "+tblname+" (reg_no,type_,mark_,subject_code,year_)values(?,?,?,?,?)";
              System.out.println("Query 1 :"+query1);
	    PreparedStatement ps1=con.prepareStatement(query1);
            
            ResultSet rt=ps.executeQuery();
            int count=0;
            while(rt.next()){
                String regno=rt.getString("reg_no");
                String mark=request.getParameter(regno);
                if(!CheckNull.isNull(mark)){
                ps1.setString(1, regno);
                ps1.setString(2, type);
                ps1.setString(3, mark);
                ps1.setString(4, "reexam");
                String[] ac=Get.getAcademicYear();
                ps1.setString(5, ac[0]+"-"+ac[1]);
                count+=ps1.executeUpdate();
                }
               
               // count
            }
            out.println("Rows Updated :"+count);
            ps.close();
            con.close();
          
        //    response.sendRedirect("add_subject.jsp?stored='yes'");
            
        }catch(Exception e){
                System.out.println("Exception :"+e);
            //     response.sendRedirect("add_subject.jsp?failed='yes'");
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
