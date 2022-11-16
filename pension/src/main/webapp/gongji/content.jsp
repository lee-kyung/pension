<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.GongjiDao"%>
<% 
GongjiDao gdao=new GongjiDao();
gdao.content(request);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section table{
	width:900px;
	margin-top:50px;
	border-left:none;
	border-right:none;
	border-top-color:white;
	border-collapse:collapse;}
	#section table td{
	border-left:none;
	border-right:none;}
	#section table #title{
	width:800px;
	font-size:20px;
	font-weight:700;}
	#section table #content{
	height:400px;}
	#section table tr:last-child{
	border-bottom-color:white;}
	#section table input[type=button]{
	margin-top:20px;
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
	#section table #btn{
	text-align:right}
</style>

<div id="section">
<h2>공지사항</h2>	
<hr>
<table align="center" border="1">
	<tr>
		<td id="title">${gdto.title }</td>
		<td>${gdto.writeday }</td>
	</tr>
	<tr>
		<td colspan="2" id="content">
			${gdto.content }
		</td>
	</tr>
	<tr>
		<td colspan="2" id="btn">
			<input type="button" value="목록" onclick="location='list.jsp'">
			<c:if test="${userid=='admin' }">
				<input type="button" value="수정" onclick="location='update.jsp?id=${gdto.id}'">
				<input type="button" value="삭제" onclick="location='delete.jsp?id=${gdto.id}'">
			</c:if>
		</td>
	</tr>
</table>
</div>

<c:import url="../bottom.jsp"/>