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
		if(session.isNew()){
		session.setMaxInactiveInterval(1800);
		}
		
		if(session.getAttribute("username")!=null)
		{
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
Vector<Score> pageIDList = new Vector<Score>();
String query = "";
ResultInfo info = new ResultInfo("",0,0);
if(request.getParameter("txtname")!=null)
{
	//out.println("You input "+request.getParameter("txtname"));
    query = request.getParameter("txtname");
	Query q = new Query();
	pageIDList = q.getScore( ((String) session.getAttribute("username")), query, info);
}
else
{
	//out.println("You input nothing");
}

%>

<form class="form-inline" role="form" method="post" action="query.jsp" style="position:relative;top:10;left:50">
<img height="46" width="140" src="iSearch.png"/>&nbsp;&nbsp;&nbsp;
<div class="form-group">
<input style="width:550;height:50;font-size:18px" type="text" class="form-control" name="txtname" placeholder="Enter query" value=<%="'"+query+"'" %> >
</div>
<input style="width:100;height:50;font-size:18px" type="submit" value="Search" class="btn btn-primary">
</form>

<div style="position:relative;top:15">
<div style="position:relative;left:50">
<p class="text-muted">
Total time: <%=info.time%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Number of Results: <%=info.numberOfResult%> (only top 50 results are showed)</p>

</div>
<table class="table table-striped" width=90%>
<%
for (Score i: pageIDList) {

    %>
    <tr><td>
        <div >
        <table border=0 bordercolor="#a1a1a1" width=90% frame=void>
        <tr>
        <td rowspan="5" width=10% align="middle">
        <% out.println(i.overall + "</br>");
            out. println("VS_B:" + i.vsScoreBody + "</br>");
			out. println("VS_T:" + i.vsScoreTitle + "</br>");
            out. println("PR:" + i.pageRank);%></td>
        
        <td width=60%>
        <div style="display: table-cell">
        <a href=<%=result.getUrl(i.page_id)%> target="_blank"><h4>
        <%=result.getTitle(i.page_id)%>
        </h4></a>
        </div>
        <div style="display:table-cell;whitespace:nospace;position:relative;left:10px">
        <image onclick="changeFavoriteStatusAndIcon()" src=
        <%
        ChangeFavorite changeFavorite = new ChangeFavorite();
        Vector<String> favoriteList = changeFavorite.getFavoriteList(""+ session.getAttribute("username"));
        changeFavorite.finalize();
        if(favoriteList!=null && favoriteList.contains(i.page_id))
          out.println("'favorite_on.png'");
        else
          out.println("'favorite.png'");
        %> width="25px" height="25px"
        pageID=<%=i.page_id%>
        username=<%= session.getAttribute("username")%> >
        </div>
        <div style="display:table-cell;whitespace:nospace;position:relative;left:20px">
        </div>
        </td>
        </tr>
        
        <!-- URL row -->
        <tr>
        <td width=70%>
        <a href=<%=result.getUrl(i.page_id)%> target="_blank">
        <h5>
        <%=result.getUrl(i.page_id)%>
        </h5></a></td>
        
        </tr>
        <tr>
        <td class="td_height">Last Modification Date:<%=result.getLastModification(i.page_id)%> ,Size of Page:<%=result.getPageSize(i.page_id)%> </td>
        </tr>
        <tr>
        <td class="td_height">
        <%
        Vector<WordAndFrequencyStruct> wordAndFrequencyList = result.getTopWordList(i.page_id);
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
        <td class="td_height">
        <button class="btn btn-default" onclick=<%="showLinkList('parent"+i.page_id+"')"%> >Parent Links</button>
        &nbsp;
        <button class="btn btn-default" onclick=<%="showLinkList('child"+i.page_id+"')"%> ><font color='blue'>Child Links</font></button>
        &nbsp;
        <form style="display:inline" action="query.jsp">
        <button type="submit" class="btn btn-default">Similar Pages</button>
        <input type="hidden" name="txtname" value = <%="'"+similarPageQuery+"'"%> >
        </form>

        
        <div style="position:relative;top:3px" class="hidden_menu" id=<%="parent"+i.page_id%> >
        <ul>
        <%
        Vector<String> parentLinkList = result.getParentLinks(i.page_id);
        for(String parentLink : parentLinkList)
        {
            out.println("<li>" + parentLink+"</li>");
        }
        %>
        </ul>
        </div>
        
        <div style="position:relative;top:3px" class="hidden_menu" id=<%="child"+i.page_id%> >
        <ul>
        <%
        Vector<String> childLinkList = result.getChildLinks(i.page_id);
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
