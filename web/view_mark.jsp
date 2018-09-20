<%@page import="Beans.GetSubjects"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar navbar-inverse">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">St.Joseph's College of Arts and Scinence</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      
      <ul class="nav navbar-nav navbar-right">
        <li class="active"><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="container" style="margin-top: 130px;height: 395px;">
	<div class="col-sm-4"></div>
	<div class="col-sm-4">
            <%
            String regno=request.getParameter("regno");
            String type=request.getParameter("type");
            
            Connection con=db.Dbconnection.getCon();
            
            String query="SELECT * FROM `student_details` WHERE `reg_no`='"+regno+"'";
            
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
            if(rt.next()){
                
              String dept=rt.getString("department_");
              String cursem=rt.getString("current_sem");
              
              
              
            %>
            <table style="width: 400px;" class="table">
                <caption>
                    <center>
                    Reg.No:<label><%=rt.getString("reg_no")%></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    Name:<label><%=rt.getString("name_")%></label>&nbsp;&nbsp;&nbsp;&nbsp;
                    Semester:<label><%=rt.getString("current_sem")%></label>&nbsp;&nbsp;&nbsp;&nbsp;
                    Type:<label><%=type.toUpperCase()%></label>
                    </center>
                </caption>
                <tr>
                    <th>Sl.No</th>
                    <th>Subject Code</th>
                    <th>Subject Name</th>
                    <th>Mark</th>
                </tr>
                <%
            int count=0;
            String tblname=dept+"_sem"+cursem;
            
            String query1="SELECT * FROM `"+tblname+"` WHERE `reg_no`='"+rt.getString("reg_no")+"' and type_='cia1'";
            System.out.println("Query 1 :"+query1);
            
            PreparedStatement ps1=con.prepareStatement(query1);
	   
	    ResultSet rt1=ps1.executeQuery();
                while(rt1.next()){
                count++;
                
                String subcode=rt1.getString("subject_code");
                String subname=GetSubjects.getSubjecName(subcode);
                    %>
                    <tr>
                        <td><%=count%></td>
                        <td><%=subcode%></td>
                         <td><%=subname%></td>
                        <td><%=rt1.getString("mark_")%></td>
                    </tr>
                <%
                }
                if(count<1){
                     %>
                <h1 style="color: #FF0000">Details Not Found !</h1>
            <%
                }
                %>
            </table>
            
            <%
            }else{
                %>
                <h1 style="color: #FF0000">Register Number Not Found !</h1>
            <%
            }
            
            con.close();
            %>
		</div>
		<div class="col-sm-4"></div>
</div>

	<div class="footer col-md-12">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Scinence and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</div>

</body>

</html>