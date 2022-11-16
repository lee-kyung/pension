<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;
	text-align:center;}
	#section h2{
	text-align:left;}
	#section form{
	margin-top:70px;}
	#section input[type=text], [type=password]{
	width:300px;
	height:50px;
	border:1px solid #D5D5D5;
	outline:none;}
	#section input[type=submit]{
	width:300px;
	height:50px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
	#section input[type=text]:focus, [type=password]:focus{
	border:1px solid #FFBB00;}
	span{
	font-size:14px;
	cursor:pointer;}
	#userid_form, #pwd_form{
	display:none;
	margin-top:-40px;}
	#msg_print{
	font-size:14px;
	margin-top:20px;}
</style>
<script>
<!-- 아이디찾기 폼은 보이고 비밀번호찾기 폼은 숨기기 + 숨기는 폼의 값을 비우기 -->
	function userid_func()
	{
		document.getElementById("userid_form").style.display="block";
		document.getElementById("pwd_form").style.display="none";
		document.pf.userid.value="";
		document.pf.name.value="";
		document.pf.phone.value="";
	}
<!-- 비밀번호찾기 폼은 보이고 아이디찾기 폼은 숨기기 + 숨기는 폼의 값을 비우기 -->
	function pwd_func()
	{
		document.getElementById("pwd_form").style.display="block";
		document.getElementById("userid_form").style.display="none";
		document.uf.name.value="";
		document.uf.phone.value="";
	}
</script>

	<div id="section">	
	<h2>로그인</h2>
	<hr>
		<form method="post" action="login_ok.jsp">	
			<input type="text" name="userid" placeholder="아이디를 입력하세요"><p>
			<input type="password" name="pwd" placeholder="비밀번호를 입력하세요"><p>
			<input type="submit" value="로그인">
		</form>
		
		<div>
			<span onclick="userid_func()">아이디 찾기 | </span>	
			<span onclick="pwd_func()">비밀번호 찾기</span>
		</div>
		
		<c:if test="${chk==5 }">
			<div id="msg_print" style="color:red;">아이디, 비밀번호 정보가 일치하지 않습니다.</div>
		<% session.removeAttribute("chk"); %>
		</c:if>
		
		<c:if test="${chk==1 }">	
			<div id="msg_print">당신의 아이디는<b> ' ${imsiuser } '</b> 입니다.</div>
		<%
			session.removeAttribute("imsiuser");
			session.removeAttribute("chk");
		%>		
		</c:if>		
		<c:if test="${chk==2 }">
			<div id="msg_print" style="color:red;">이름, 전화번호 정보가 일치하지 않습니다.</div>
		<% session.removeAttribute("chk"); %>
		</c:if>
		<c:if test="${chk==3 }">
			<div id="msg_print">당신의 비밀번호는 <b>' ${pwd } '</b> 입니다.</div>
		<%
			session.removeAttribute("pwd");
			session.removeAttribute("chk");
		%>	
		</c:if>
		<c:if test="${chk==4 }">
			<div id="msg_print" style="color:red;">이름, 전화번호 정보가 일치하지 않습니다.</div>
		<% session.removeAttribute("chk"); %>
		</c:if>
		
		<div id="userid_form">
			<form name="uf" method="post" action="userid_search.jsp">
				<input type="text" placeholder="이름" name="name"><p>
				<input type="text" placeholder="전화번호" name="phone"><p>
				<input type="submit" value="아이디찾기">
			</form>
		</div>
		<div id="pwd_form">
			<form name="pf" method="post" action="pwd_search.jsp">
				<input type="text" placeholder="아이디" name="userid"><p>
				<input type="text" placeholder="이름" name="name"><p>
				<input type="text" placeholder="전화번호" name="phone"><p>
				<input type="submit" value="비밀번호찾기">
			</form>
		</div>
<%-- 	<%
		if(request.getParameter("chk") != null)	// chk값이 있다는 뜻(로그인 실패), 단순 링크를 통해 들어왔을 때는 null이다.
		{
	%>
		<div style="font-size:12px; color:red;"> 아이디 혹은 비밀번호를 잘못입력하였습니다.</div>
	<%
		}
	%> 
	--%>
	</div>

<c:import url="../bottom.jsp"/>

<!-- 
chk 로그인 링크
1	아이디찾기 성공
2	아이디찾기 실패
3	비밀번호찾기 성공
4	비밀번호찾기 실패
5	로그인 실패 -->