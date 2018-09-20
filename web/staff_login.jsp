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
      <a class="navbar-brand" href="#">St.Joseph's College of Arts and Science</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      
      <ul class="nav navbar-nav navbar-right">
            <li ><a href="index.html"><span class="glyphicon glyphicon-log-in"></span> Home</a></li>
        <li class="active"><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="container">
	<div class="col-sm-4"></div>
        <div class="col-sm-4" style="margin-top: 100px;">
            <form action="staff_log_action.jsp" method="post">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>Staff LogIn  </h3>
				</div>
				<div class="panel-body">
					<div class="form-group">
                                            <input type="text" name="username" required="required" class="form-control" placeholder="User Name" />
					</div>
					<div class="form-group">
						<input type="password" name="password" required="required" class="form-control" placeholder="Password" />
					</div>
                                    <button type="submit" class="btn btn-success">SUBMIT</button>
				</div>
			</div>
            </form>
		</div>
		<div class="col-sm-4"></div>
</div>

	<nav class="navbar navbar-fixed-bottom footer col-md-12">
		<p style="text-align: center;"> &copy; 2018 St.Joseph's College of Arts and Science and designed by <a href="www.b2lsolutions.in">B2L Solutions </a></p>
	</nav>

</body>

</html>