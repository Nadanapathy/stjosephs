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
            String query="select * from hod_log where login_id='"+uname+"' and password_='"+pass+"'";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
            
            if(rt.next()){
                session.setAttribute("Type","hod");
                session.setAttribute("HodId", uname);
              //  session.setAttribute("StaffName", rt.getString("name_"));
                session.setAttribute("Department", rt.getString("department_"));
                response.sendRedirect("hod_home.jsp");
                
                
            }else{
               %>
    <center>
        <h1>Invalid Credentials</h1>
        <a href="hod.jsp">Try Again</a>
    </center>
        <% 
            }
            
            rt.close();
            ps.close();
            con.close();
        %>
    </body>
</html>
