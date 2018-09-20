/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package actions;

import Beans.CheckDept;
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
public class AddDept extends HttpServlet {

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
            
          String grad=request.getParameter("graduate");
          int semcount=Integer.parseInt(request.getParameter("semcount"));
          String dept=request.getParameter("department");
            if(!CheckDept.isThere(dept.toLowerCase())){
                  Connection con=db.Dbconnection.getCon();
            String query="insert into department ( `graduate_`,`name_`, `sem_count`, `status_`,table_name_format)values(?,?,?,?,?)";
            PreparedStatement ps=con.prepareStatement(query);
            //String tblname=
	    ps.setString(1, grad);
            ps.setString(2, dept.toLowerCase());
            ps.setString(3, semcount+"");
            ps.setString(4, "yes");
            ps.setString(5, dept+"_sem"+semcount);
            ps.execute();
            
            ps.close();
            
            //PreparedStatement ps1=con.prepareStatement(query);
            Statement st=null;
            for(int i=1;i<=semcount;i++){
                 st=con.createStatement();
                 query="CREATE TABLE "+dept+"_sem"+i+" ( `id` INT NOT NULL AUTO_INCREMENT ,  `reg_no` VARCHAR(15) NOT NULL ,`type_` VARCHAR(35) NOT NULL ,`subject_code` VARCHAR(35) NOT NULL ,  `mark_` FLOAT(10) NULL DEFAULT NULL ,`year_` VARCHAR(35) NULL DEFAULT NULL,    PRIMARY KEY  (`id`)) ";
                 st.executeUpdate(query);
                 st.close();
            }
           
          //  ps1.close();
            
             String q="INSERT INTO `hod_log`(`login_id`, `password_`, `department_`) VALUES ('"+dept.toLowerCase()+"','"+dept.toLowerCase()+"','"+dept.toLowerCase()+"')";
             ps=con.prepareStatement(q);
             ps.execute();
            
            con.close();
             response.sendRedirect("add_dept.jsp?stored='yes'");
            }else{
                 response.sendRedirect("add_dept.jsp?has='yes'");
            }
         
         
          
            
        }catch(Exception e){
                System.out.println("Exception :"+e);
                 response.sendRedirect("add_dept.jsp?failed='yes'");
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
