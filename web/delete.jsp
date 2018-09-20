<%-- 
    Document   : delete
    Created on : Aug 6, 2018, 10:56:19 AM
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
        String reqpage=request.getHeader("Referer");
        String type=request.getParameter("type");
        System.out.println("type :"+type);
        Connection con=db.Dbconnection.getCon();
        String tblname="";
        switch(type){
            case "subject": tblname="subjects";break;
            case "department": tblname="department";break;
            case "staff": tblname="staff_details";break;
        }
            String id=request.getParameter("id");
            String query="delete from "+tblname+" where id='"+id+"'";
            PreparedStatement ps=con.prepareStatement(query);
	    int i=ps.executeUpdate();
            
             ps.close();
            con.close();
            
	    if(i!=0){
                %>
    <center>
        <h1>Deleted Successfully !</h1>
        <a href="<%=reqpage%>">Click here to Back</a>
    </center>
        <%
            }else{
                 %>
    <center>
        <h1>Operation Failed !</h1>
        <a href="<%=reqpage%>">Click here to Back</a>
    </center>
        <%   
            }
           
        
        %>
       
    </body>
</html>
