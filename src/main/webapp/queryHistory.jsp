<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="favorite.*,result.*,comp4321.*,java.util.Vector" %>
<html>

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

<script src="js/changeFavoriteStatusAndIcon.js"></script>
<script src="js/showLinkList.js"></script>
<style type="text/css">

</style>
  <link rel="icon" href="logo.jpg"/>
</head>
<body>

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
</form>
<ul class="nav navbar-nav navbar-right">

<li><a><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;
<%
String username = "";
if(session.isNew()){
    session.setMaxInactiveInterval(1800);
}
if(session.getAttribute("username")!=null)
{
    username = (String) session.getAttribute("username");
    out.print(session.getAttribute("username"));
}
%>
</a></li>
<li><a href="logout.jsp">Logout</a></li>
</ul>
</div>
</nav>

<%
Result result = new Result(null);

%>

<div style="position:relative;top:15">
<table class="table table-striped" width=90%>
<tr>
<th style="text-align:center">&nbsp;\#</th>
<th>Query</th>
<th>Time Comsumed</th>
<th># of results</th>
</tr>
<%

QueryHistory queryHistory = new QueryHistory();
Vector<ResultInfo> queryList = queryHistory.getQueryList(username);
int num = 0;
for (ResultInfo info: queryList) {
    %>
    <tr>
    <td style="text-align:center">&nbsp;<%=++num%></td>
    <td>
    <div>
    <h4><a href=<%= "\"query.jsp?txtname=" + info.query.replaceAll("\"", "'") + "\""%> >
    <%
    out.println(info.query);

    %>
    </a>
    </h4>
    </div>
    </td>
    <td>
    <%=info.time%>
    </td>
    <td>
    <%=info.numberOfResult%>
    </td>
    </tr>
    <%
}
%>
</table>
</div>
</body>
</html>
