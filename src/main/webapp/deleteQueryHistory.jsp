<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="favorite.*,result.*,comp4321.*,java.util.Vector" %>
<%
QueryHistory queryHistory = new QueryHistory();
String username = (String) request.getParameter("username");
queryHistory.deleteQueryHistory(username);
queryHistory.finalize();

String redirectURL = "queryHistory.jsp";
response.sendRedirect(redirectURL);

%>
