<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.AdminDao" %>
<%
AdminDao adao=new AdminDao();
adao.member_check(request);
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
	border-collapse:collapse;
	border-left:none;
	border-right:none;
	border-top-color:white;
	font-size:14px;
	text-align:center;}
	#section table td{
	height:25px;
	border-left:none;
	border-right:none;}
	#section table tr:first-child{
	font-size:15px;
	font-weight:600;}
</style>

<div id="section">
<h2>회원정보</h2>
<hr>
<table border="1" align="center">
	<tr>
		<td>아이디</td>
		<td>이 름</td>
		<td>전화번호</td>
		<td>상 태</td>
	</tr>
	<c:forEach items="${mlist }" var="mdto">
	<tr>
		<td>${mdto.userid }</td>
		<td>${mdto.name }</td>
		<td>${mdto.phone }</td>
	
	<c:if test="${mdto.state == 0 }">
		<td>회 원</td>
	</c:if>
	<c:if test="${mdto.state == 1 }">
		<td><a href="out_ok.jsp?id=${mdto.id }">탈퇴신청</a></td>
	</c:if>
	<c:if test="${mdto.state == 2 }">
		<td>탈퇴회원</td>
	</c:if>
	
	</tr>
	</c:forEach>
</table>

</div>
<c:import url="../bottom.jsp"/>