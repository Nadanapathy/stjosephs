<%-- 
    Document   : log_action
    Created on : Aug 6, 2018, 6:28:19 AM
    Author     : unbox
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            
        String uname=request.getParameter("username");
        String pass=request.getParameter("password");
        Connection con=db.Dbconnection.getCon();
            String query="select name_ from staff_details where staff_id='"+uname+"' and password_='"+pass+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
            
            if(rt.next()){
                session.setAttribute("StaffId", uname);
                session.setAttribute("StaffName", rt.getString("name_"));
                
                response.sendRedirect("staff_home.jsp");
                
                
            }else{
               %>
    <center>
        <h1>Invalid Credentials</h1>
        <a href="login.html">Try Again</a>
    </center>
        <% 
            }
            
            rt.close();
            ps.close();
            con.close();
        %>
    </body>
</html>
