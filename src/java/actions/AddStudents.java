/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package actions;

import Beans.Get;
import com.oreilly.servlet.MultipartRequest;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
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
public class AddStudents extends HttpServlet {

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
       String tmpdir=System.getProperty("java.io.tmpdir");

if(tmpdir==null){
    throw new IOException("System property 'java.io.tmpdir' does not specify a temp dir");
}

File tmp=new File(tmpdir);

if(!tmp.exists()){
    boolean created=tmp.mkdirs();
    
    if(!created){
        throw new IOException("unable to create tmp dir "+tmp);
    }
}
    


 MultipartRequest m=new MultipartRequest(request, tmp.getAbsolutePath(), 10014633);
      
           String dept=m.getParameter("department");
           String cursem=m.getParameter("cursem");
           String section=m.getParameter("section");
           String[] d=Get.getAcademicYear();
           String year=d[0]+"-"+d[1];
           String shift=m.getParameter("shift");
           
          File file=m.getFile("file");
            BufferedReader br=new BufferedReader(new InputStreamReader(new FileInputStream(file)));
            
            Connection con=db.Dbconnection.getCon();
            String query="INSERT INTO `student_details`(`reg_no`, `name_`, `current_sem`, `section_`, `year_`, `shift`, `department_`) VALUES(?,?,?,?,?,?,?)";
            PreparedStatement ps=con.prepareStatement(query);
	    
            String data="";int datacount=0;
            while((data=br.readLine())!=null){
                String[] datas=data.split(",");
                String regno=datas[0];
                String name=datas[1];
                
                ps.setString(1, regno);
                ps.setString(2, name);
                ps.setString(3, cursem);
                ps.setString(4, section);
                ps.setString(5, year);
                ps.setString(6, shift);
                ps.setString(7, dept);
                
                ps.execute();
                
                datacount++;
                
            }
            
           
            
            ps.close();
            con.close();
            out.println("<center> <h1>"+datacount+" Student details Added Now!</h1><br><a href='add_stud_details.jsp'>Click to Add More</a></center>");
            //response.sendRedirect("add_staff.jsp?stored='yes'");
           
        }catch(Exception e){
                System.out.println("Exception :"+e);
                 response.sendRedirect("add_staff.jsp?failed='yes'");
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
