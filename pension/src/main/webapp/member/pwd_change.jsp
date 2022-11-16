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
	#section form{
	margin-top:100px;
	text-align:center;}
	
	#section [type=password]{
	width:300px;
	height:50px;
	outline:none;
	border:1px solid #D5D5D5;}
	#section input[type=submit]{
	width:300px;
	height:50px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
	#perr{
	font-size:12px;}
	#section input[type=password]:focus{
	border:1px solid #FFBB00;}
</style>
<script>
var pchk=0;
function pwd_check(pwd2)
{
	var pwd=document.pkc.pwd.value;
	if(pwd==pwd2)
		{
		document.getElementById("perr").innerText="비밀번호가 일치합니다.";
		document.getElementById("perr").style.color="blue";
		pchk=1;
		}
	else
		{
		document.getElementById("perr").innerText="비밀번호를 확인해주세요.";
		document.getElementById("perr").style.color="red";
		pchk=0;
		}
	}
</script>
 
	<div id="section">
	<h2>비밀번호 변경</h2>	
	<hr>
	<form name="pkc" method="post" action="pwd_change_ok.jsp">

		<input type="password" name="old_pwd" placeholder="기존 비밀번호"><p>
		<input type="password" name="pwd" placeholder="새로운 비밀번호"><p>
		<input type="password" name="pwd2" placeholder="비밀번호 확인" onkeyup="pwd_check(this.value)"><p>
		<span id="perr"></span>
		<p><input type="submit" value="비밀번호 변경">
		<%
		if(request.getParameter("chk")!=null)
		{
		%>
		<div style="font-size:12px; color:red;">기존 비밀번호가 틀렸습니다.</div>
		<%
		}
		%>
	</form>
	</div>
<c:import url="../bottom.jsp"/>