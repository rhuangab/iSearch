<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="favorite.*,java.util.Vector" %>
<%
String username = request.getParameter("username");
String pageID = request.getParameter("pageID");

ChangeFavorite changeFavorite = new ChangeFavorite();
changeFavorite.changeFavoriteStatus(username, pageID);
changeFavorite.finalize();
%>

