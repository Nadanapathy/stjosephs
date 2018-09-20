<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
          <li ><a href="index.html"><span class="glyphicon glyphicon-log-in"></span> Home</a></li>
        <li class="active"><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="container" style="margin-top: 130px;height: 395px;">
	<div class="col-sm-4"></div>
	<div class="col-sm-4">
            <%
             Connection con=db.Dbconnection.getCon();
             SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
             String date=sdf.format(new Date());
            String query="SELECT * FROM `announce` WHERE status_='yes' ";
            PreparedStatement ps=con.prepareStatement(query);
	   
	    ResultSet rt=ps.executeQuery();
		
		
		
            %>
            <form action="view_mark.jsp" method="post">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>Get Your Mark  </h3>
				</div>
				<div class="panel-body">
					<div class="form-group">
                                            <label >Enter Reg.No</label>
                                            <input type="text" name="regno" required="required" class="form-control" placeholder="Reg.No" />
					</div>
                                    
                                        <div class="form-group">
                                                <label >Select Type</label>
                                             <select name="type" required="required" class="form-control">
                                                <option value="">--Select Type--</option>
                                                <%
            int count=0;
                                                while(rt.next()){
                                                 %>
                                                <option value="<%=rt.getString("type_")%>"><%=rt.getString("type_").toUpperCase()%></option>
                                                <%
                                                    count++;
                                                }
                                                if(count==0){
                                                    %>
                                                 <option value="">NO Results Announced</option>
                                                <%
                                                }
                                                
                                                rt.close();
            ps.close();
            con.close();
                                                %>
<!--                                                <option value="cia1">CIA 1</option>
                                                <option value="cia2">CIA 2</option>
                                                <option value="assign1">ASSIGNMENT 1</option>
                                                <option value="assign2">ASSIGNMENT 2</option>
                                                <option value="attendance">ATTENDANCE</option>-->
                                            </select>
                                           
					</div>
<!--					<div class="form-group">
						<input type="password" name="password" required="required" class="form-control" placeholder="Password" />
					</div>-->
                                    <button type="submit" class="btn btn-success">SUBMIT</button>
				</div>
			</div>
            </form>
		</div>
		<div class="col-sm-4"></div>
</div>

	<div class="footer col-md-12">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Scinence and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</div>

</body>

</html>