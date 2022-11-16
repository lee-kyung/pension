<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.MemberDao"%>
<% 
MemberDao mdao=new MemberDao();
mdao.member_info(session, request);

// jsp에 출력할 내용은 request객체영역에 저장
// EL표현식으로 접근, JSTL을 사용
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
	#section table td:first-child{
	width:100px;
	height:50px;}
	#section table td:last-child{
	width:206px;}
	#section span{
	display:inline-block;
	width:96px;
	height:33px;
	background:#FFFFD2;
	border:1px solid #FFFF48;
	text-align:center;
	margin-top:20px;
	padding-top:15px;	/*상하정렬*/
	cursor:pointer;
	font-size:13px;}
</style>

	<div id="section">
	<h2>회원정보</h2>
	<hr>
	<table align="center">
	
		<tr>
			<td><b>아이디</b></td>
			<td>${mdto.userid}</td>
		</tr>
		<tr>
			<td><b>이름</b></td>
			<td>${mdto.name }</td>
		</tr>
		<tr>
			<td><b>이메일</b></td>
			<td>${mdto.email }</td>
		</tr>
		<tr>
			<td><b>전화번호</b></td>
			<td>${mdto.phone }</td>
		</tr>
		<tr>
			<td colspan="2">
				<span onclick="location='member_update.jsp'">회원정보 수정</span>
				<span onclick="location='pwd_change.jsp'">비밀번호 변경</span>
				<span onclick="location='member_out.jsp'">회원 탈퇴</span>
			</td>
		</tr>
	</table>
	</div>
<c:import url="../bottom.jsp"/>