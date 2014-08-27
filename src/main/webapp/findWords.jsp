<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dictionary.*,java.util.Vector" %>
<%
String prefix = request.getParameter("prefix");

Dictionary dictionary = new Dictionary();
Vector<String> wordList = dictionary.retrieveWordList(prefix);
String result ="";
for(String word : wordList)
{
    result += (word + " ");
}
%>
<%=result%>