<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.MemberDao"%>
<% 
MemberDao mdao=new MemberDao();
mdao.member_update(session, request);

%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section table{
	margin-top:70px;
	font-size:14px;}
	#section table td{
	width:100px;
	height:50px;}
	#section input[type=text]{
	width:200px;
	height:40px;
	outline:none;
	border:1px solid #D5D5D5;}
	#section input[type=text]:focus{
	border:1px solid #FFBB00;}
	#section input[type=submit]{
	display:inline-block;
	width:100%;
	height:50px;
	margin-top:20px;
	background:#FFFFD2;
	border:1px solid #FFFF48;
	text-align:center;}
</style>
	<div id="section">
	<form method="post" action="member_update_ok.jsp">
	<h2>회원정보</h2>
	<hr>
	<table align="center">
		<tr>
			<td><b>아이디</b></td>
			<td>${userid}</td>
		</tr>
		<tr>
			<td><b>이름</b></td>
			<td>${name }</td>
		</tr>
		<tr>
			<td><b>이메일</b></td>
			<td><input type="text" name="email" value="${mdto.email }"></td>
		</tr>
		<tr>
			<td><b>전화번호</b></td>
			<td><input type="text" name="phone" value="${mdto.phone }"></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="수정">
			</td>
		</tr>
	</table>
	</form>
	</div>
<c:import url="../bottom.jsp"/>