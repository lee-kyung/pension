<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.AdminDao"%>
<%
AdminDao adao=new AdminDao();
String content=adao.content_view(out,request);
String type=adao.type_view(out,request);
%>
<style>
	div #content_view{
	background:white;
	width:400px;
	height:200px;
	border:1px solid #FFBB00;
	font-size:14px;
	font-weight:600;}
</style>

<div id="content_view">
<br>
	<%=type%>
<hr>
<br>
	<%=content.replace("\r\n", "<br>")%>
</div>