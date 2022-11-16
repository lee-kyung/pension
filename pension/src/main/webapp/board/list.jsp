<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.BoardDao" %>
<%
BoardDao bdao=new BoardDao();
bdao.list(request);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#a1{
	font-size:14px;
	font-weight:100;}
	#section table{
	width:900px;
	margin-top:50px;
	border-left:none;
	border-right:none;
	border-top-color:white;
	border-collapse:collapse;}
	#section table a{
	text-decoration:none;
	color:black;}
	#section table tr{
	height:40px;}
	#section table tr:last-child{
	border-bottom-color:white;}
	#section table td{
	border-left:none;
	border-right:none;}
	#section table #title{
	width:600px;}
	#section table #title, #name, #readnum, #writeday{
	font-size:15px;
	font-weight:700;}
	#section table #name, #readnum, #writeday{
	text-align:center;}
	#section table .name, .readnum, .writeday{
	text-align:center;
	font-size:14px;}
	#section table #btn{
	text-align:right;}
	#section table input[type=button]{
	margin-top:10px;
	width:200px;
	height:50px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
</style>

	<div id="section">
	<h2>자유게시판</h2>
	<hr>
	<table align="center" border="1">
		<tr>
			<td id="title">제목</td>
			<td id="name">작성자</td>
			<td id="readnum">조회수</td>
			<td id="writeday">작성일</td>
		</tr>
	<c:forEach items="${list }" var="bdto">
		<tr>
			<td><a id="a1" href="readnum.jsp?id=${bdto.id }">${bdto.title }</a></td>
			<td class="name">${bdto.userid}</td>
			<td class="readnum">${bdto.readnum }</td>
			<td class="writeday">${bdto.writeday }</td>
		</tr>
	</c:forEach>	
		<tr>
			<td colspan="4" id="btn">
				<input type="button" value="작성하기" onclick="location='write.jsp'">
				
			</td>
		</tr>
	</table>
	</div>
	
<c:import url="../bottom.jsp"/>