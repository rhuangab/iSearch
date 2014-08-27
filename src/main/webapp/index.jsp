<!DOCTYPE html><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>
iSearch
</title>

<link rel="stylesheet" type="text/css" href="css/linkList.css" />
<!--<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />-->
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<!--<link rel="stylesheet" type="text/css" href="css/bootstrap-theme.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css" />-->
<script src="js/bootstrap.js"></script>
<script src="js/bootstrap.min.js"></script>

<style type="text/css">
#letterpress {
	margin-top:10%;
	text-align://center;
}
body
{ 
background-image:url('colortree.jpg');
background-repeat:no-repeat;
background-attachment:fixed;
background-position:right bottom; 
background-size:400px 400px;
}
</style>

<script src="js/findWords.js"></script>
  <link rel="icon" href="logo.jpg"/>
</head>
<body onload="test()">

<nav class="navbar navbar-default" role="navigation">
  <div class="navbar-header 
    <a class="navbar-brand"><img src="logo.jpg" height="42" width="42"/></a>
  </div>

  <div>
    <ul class="nav navbar-nav">
      <li class="active"><a>iSearch</a></li>
      <li><a href="index.jsp">Search</a></li>
      <li><a href="favorite.jsp">Favorite</a></li>
	  <li><a href="queryHistory.jsp">History</a></li>
    </ul>
    <form class="navbar-form navbar-left" role="search">
      <div class="form-group">
        <input type="text" class="form-control" placeholder="Search">
      </div>
      <button type="submit" class="btn btn-default">Submit</button>
    </form>

    <ul class="nav navbar-nav navbar-right">
	
      <li><a><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp; 
	  <%
		if(session.isNew()){
		session.setMaxInactiveInterval(1800);
		}else{
			if(session.getAttribute("username")!=null)
			{
				out.print(session.getAttribute("username"));		
			}
			
		}
		%>		
	  </a></li>
      <li><a href="logout.jsp">Logout</a></li>	  
    </ul>
  </div>
</nav>

<div align="center" id="letterpress"><img src="iSearch.png"/></div>
</br>
<div align="center">
<form class="form-inline" method="post" action="query.jsp">
     <div class="form-group" style="width:30%">
         <input onkeyup="findWords()" onblur="clearWords()"  id="textField" type="text" style="font-size:15px" name="txtname" class="form-control" placeholder="Enter query" autocomplete="off"></div>
	<input type="submit" value="Search" class="btn btn-default">
</form>
<div style="position:relative;left:13px;text-align:left">
<!--<ul >-->
<table>
<tr><td id="spacer" style="visibility:hidden;font-size:15px;"></td>
<td id="list8">

<div style="position:absolute;left:31%;top:2px">
<ul class="nav nav-pills" id="testLabel" >
</ul>
</div>
</td>

</tr>
</table>
</div>

</div>


</body>
</html>
 
