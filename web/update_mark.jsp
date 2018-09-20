<%-- 
    Document   : update_mark
    Created on : Aug 20, 2018, 7:36:29 PM
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
        
        String tblname=request.getParameter("dept")+"_sem"+request.getParameter("cursem");
        
        String mark=request.getParameter("mark");
        String subcode=request.getParameter("subcode");
        String regno=request.getParameter("regno");
        String type=request.getParameter("type");
        
            Connection con=db.Dbconnection.getCon();
            String query="update "+tblname+" set mark_='re' where reg_no='"+regno+"' and type_=? and subject_code='"+subcode+"'";
             String[] types=new String[]{"cia1","cia2","assign1","assign2","attendance"};
             
            PreparedStatement ps=con.prepareStatement(query);
            for(String t:types){
                ps.setString(1, t);
                 ps.executeUpdate();
            }
	    
             
            ps.close();
            
            query="insert into "+tblname+" (`reg_no`, `type_`, `mark_`, `subject_code`) VALUES (?,?,?,?)";
            ps=con.prepareStatement(query);
            ps.setString(1, regno);
            ps.setString(2, "reexam");
            ps.setString(3, mark);
            ps.setString(4, subcode);
            ps.execute();
            
            
             ps.close();
            con.close();
           
        %>
    <center>
        <h1>Mark Updated Successfully !</h1>
        <a href="home.jsp">Click to Back</a>
    </center>
    </body>
</html>
