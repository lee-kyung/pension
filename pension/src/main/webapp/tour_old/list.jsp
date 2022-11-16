<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.TourDao_old"%>
<% 
TourDao_old tdao=new TourDao_old();
tdao.list(request);
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
	width:700px;
	margin-top:50px;
	border-left:none;
	border-right:none;
	border-top-color:white;
	border-collapse:collapse;}
	#section table td{
	border-left:none;
	border-right:none;}
	#section table tr:first-child{
	font-size:15px;
	font-weight:700;}
	#section table #userid, #readnum, #writeday{
	text-align:center;}
	#section table #userid{
	width:70px;}
	#section table #readnum{
	width:60px;}
	#section table #writeday{
	width:100px;}
	#section table .userid, .readnum, .writeday{
	text-align:center;
	font-size:14px;}
	#section table #img{
	width:50px;}
	#section table input[type=button]{
	margin-top:20px;
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
	#section table #btn{
	text-align:right;
	border-bottom-color:white;}
</style>
<div id="section">
<h2>여행후기</h2>
<hr>
<table align="center" border="1">
	<tr>
		<td id="userid">작성자</td>
		<td colspan="2">제목</td>
		<td id="readnum">조회수</td>
		<td id="writeday">작성일</td>
	</tr>
	<c:forEach items="${list }" var="tdto">
	<tr>
		<td class="userid">${tdto.userid }</td>
		<td><a id="a1" href="readnum.jsp?id=${tdto.id}">${tdto.title }</a></td>
		<td id="img"><img src="img/${tdto.fname }" width="50"></td>
		<td class="readnum">${tdto.readnum }</td>
		<td class="writeday">${tdto.writeday }</td>
	</tr>
	</c:forEach>
	<c:if test="${userid != null }">
	<tr>
		<td colspan="5" id="btn">
			<input type="button" value="작성" onclick="location='write.jsp'">
		</td>
	</tr>
	</c:if>
</table>
</div>
<c:import url="../bottom.jsp"/>