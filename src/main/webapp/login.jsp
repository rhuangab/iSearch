<!DOCTYPE HTML>
<html lang="en-US">

<%
if(session.isNew()){
session.setMaxInactiveInterval(1800);
}

if(request.getParameter("username")!=null && request.getParameter("username")!=null)
{
	session.setAttribute("username",request.getParameter("username"));	
	session.setAttribute("password",request.getParameter("password"));	
}	

%>

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="refresh" content="1;url=index.jsp">
        <title>Redirect Index</title>
    </head>
    <body>

   </body>
</html>