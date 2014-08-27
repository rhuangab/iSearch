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

ChangeFavorite cf = new ChangeFavorite();
Vector<String> pageIDList = cf.getFavoriteList(username);
%>
<p class="text-muted">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Number of Results: <%=pageIDList.size()%></p>

<div>
<table class="table table-striped" width=90%>
<%
for (String i: pageIDList) {
    %>
    <tr><td>
        <div>
        <table border=0 bordercolor="#a1a1a1" width=90% frame=void>
        <tr>
        <div style="display: table-cell">
        <a href=<%=result.getUrl(i)%> target="_blank"><h4>  &nbsp;&nbsp;&nbsp;
        <%=result.getTitle(i)%>
        </h4></a>
        </div>
        <div style="display:table-cell;whitespace:nospace;position:relative;left:10px">
        <image onclick="changeFavoriteStatusAndIcon()" src=
        <%
        ChangeFavorite changeFavorite = new ChangeFavorite();
        Vector<String> favoriteList = changeFavorite.getFavoriteList(""+ session.getAttribute("username"));
        changeFavorite.finalize();
        if(favoriteList!=null && favoriteList.contains(i))
          out.println("'favorite_on.png'");
        else
          out.println("'favorite.png'");
        %> width="25px" height="25px"
        pageID=<%=i%>
        username=<%= session.getAttribute("username")%> >
        </div>
        <div style="display:table-cell;whitespace:nospace;position:relative;left:20px">
        </div>
        </td>
        </tr>
        
        <!-- URL row -->
        <tr>
        <td width=70%>
        <a href=<%=result.getUrl(i)%> target="_blank">
        <h5>  &nbsp;&nbsp;&nbsp;
        <%=result.getUrl(i)%>
        </h5></a></td>
        
        </tr>
        <tr>
        <td class="td_height">  &nbsp;&nbsp;&nbsp; Last Modification Date:<%=result.getLastModification(i)%> ,Size of Page:<%=result.getPageSize(i)%> </td>
        </tr>
        <tr>
        <td class="td_height">  &nbsp;&nbsp;&nbsp;
        <%
        Vector<WordAndFrequencyStruct> wordAndFrequencyList = result.getTopWordList(i);
        String similarPageQuery = "";
        for(WordAndFrequencyStruct wf : wordAndFrequencyList)
        {
            similarPageQuery += (" " + wf.wordString);
        }
        if(similarPageQuery != null && similarPageQuery.length() >0)
        {similarPageQuery = similarPageQuery.substring(1);}
        %>
        <%
        for(WordAndFrequencyStruct wf : wordAndFrequencyList)
        {
            out.println(wf.wordString + ",");
            out.println(wf.frequency + " ");
        }
        %>
        </td>
        </tr>
        <tr>
        <td class="td_height">  &nbsp;&nbsp;&nbsp;
        <button class="btn btn-default" onclick=<%="showLinkList('parent"+i+"')"%> >Parent Links</button>
        &nbsp;
        <button class="btn btn-default" onclick=<%="showLinkList('child"+i+"')"%> ><font color='blue'>Child Links</font></button>
        
        <div style="position:relative;top:3px" class="hidden_menu" id=<%="parent"+i%> >
        <ul>
        <%
        Vector<String> parentLinkList = result.getParentLinks(i);
        for(String parentLink : parentLinkList)
        {
            out.println("<li>" + parentLink+"</li>");
        }
        %>
        </ul>
        </div>
        
        <div style="position:relative;top:3px" class="hidden_menu" id=<%="child"+i%> >
        <ul>
        <%
        Vector<String> childLinkList = result.getChildLinks(i);
        for(String childLink : childLinkList)
        {
            out.println("<li><font color='blue'>" + childLink+"</font></li>");
        }
        %>
        </ul>
        </div>
        
        </td>
        </tr>
        
        </table>
        </div>
        </td>
    </tr>
    <%
}
%>
</table>
</div>
</body>
</html>
