<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.TourDao_old"%>
<% 
TourDao_old tdao=new TourDao_old();
tdao.content(request);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section table{
	width:1000px;
	border-left:none;
	border-right:none;
	border-top-color:white;
	border-collapse:collapse;
	font-size:14px;}
	#section table td{
	border-left:none;
	border-right:none;
	height:40px;}
	#section table td:first-child, #readnum, #content{
	text-align:center;
	font-size:15px;
	font-weight:700;
	width:70px;}
	#section table #btn{
	text-align:right;}
	#section table #userid-size{
	width:500px;}
	#section table tr:last-child{
	border-bottom-color:white;}
	#section table input[type=button]{
	margin-top:20px;
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
	#section table img{
	padding-top:10px;
	padding-bottom:10px;}
</style>

<div id="section">
<h2>여행후기</h2>
<hr>
<table align="center" border="1">
	<tr>
		<td>제목</td>
		<td colspan="3">${tdto.title }</td>
	</tr>
	<tr>
		<td>작성자</td>
		<td id="userid-size">${tdto.userid }</td>
		<td id="readnum">조회수</td>
		<td>${tdto.readnum }</td>
	</tr>
	<tr>
		<td>사진</td>
		<td><img src="img/${tdto.fname }" width="500"></td>
		<td id="content">내용</td>
		<td>${tdto.content }</td>
	</tr>
	<tr>
		<td colspan="4" id="btn">
			<input type="button" value="목록" onclick="location='list.jsp'">
		<!-- 회원본인의 글일 경우 -->
		<c:if test="${userid==tdto.userid || userid=='admin'}">
			<input type="button" value="수정" onclick="location='update.jsp?id=${tdto.id}&fname=${tdto.fname }'">
			<input type="button" value="삭제" onclick="location='delete.jsp?id=${tdto.id}&fname=${tdto.fname}'">
		</c:if>
		</td>
	</tr>
</table>
</div>
<c:import url="../bottom.jsp"/>