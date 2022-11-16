<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../top.jsp"/> 

<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section table{
	margin-top:70px;
	font-size:14px;}
	#section input[type=text], [type=password]{
	outline:none;
	width:97%;
	height:40px;
	border:1px solid #D5D5D5;}
	#section input[type=text]:focus, [type=password]:focus{
	border:1px solid #FFBB00;}
	input[type=submit]{
	width:400px;
	height:50px;
	background:#FFFFD2;
	border:1px solid #FFFF48;
	margin-top:15px;}
	#err, #perr{
	font-size:12px;}
</style>
<!-- 
1. 회원아이디 조회
2. 비밀번호 일치여부
3. 필수입력(아이디, 이름, 전화번호 유효성체크)
-->
<script>

//member_input.jsp

var uchk=0; // 아이디의 중복체크 여부를 확인하는 변수 (0이면 확인x, 1이면 확인o)

function userid_check(userid)
{
	
	if(userid.trim()=="")	// 아이디값이 없는 경우 
	{		
		// 사용가능한 아이디 체크를 하고 다시 아이디를 지웠을 경우 중복체크를 다시 번복하기위해서 필요 
		uchk=0; 
		document.getElementById("err").innerText="";
	}
	else
	{
		var chk=new XMLHttpRequest();  
		chk.open("get", "userid_check.jsp?userid="+userid);
		chk.send();
	
		chk.onreadystatechange=function()
		{
			if(chk.readyState==4)
			{
				if(chk.responseText.trim()=="0") // 사용가능하면 0, 불가능 1
				{
					document.getElementById("err").innerText="사용 가능한 아이디";
					document.getElementById("err").style.color="blue";
					uchk=1;	// 중복체크 확인 o
				}
				else
				{
					document.getElementById("err").innerText="사용 불가능한 아이디";
					document.getElementById("err").style.color="red";
					uchk=0;	// 중복체크 x
				}
			}	
		}		
	}
}
var pchk=0;	// 비밀번호의 동일 여부를 확인하는 변수
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
function check(my)
{
	// 아이디, 비밀번호, 이름, 전화번호의 유효성체크(다중if를 작성할 경우 아닌걸로 작성)
	if(uchk==0)
	{
		alert("아이디를 확인하세요");
		return false;
	}
	else if(my.name.value.trim()=="")
	{
		alert("이름을 작성해주세요");
		return false;
	}
	else if(pchk==0)
	{
		alert("비밀번호를 확인하세요");
		return false;
	}
	else if(my.phone.value.trim()=="")
	{
		alert("전화번호를 작성해주세요");
		return false;
	}
	else
		return true;
}
</script>

<div id="section">
<h2>회원가입</h2>
<hr>
<form name="pkc" method="post" action="member_input_ok.jsp" onsubmit="return check(this)">
<table align="center">
	<tr>
		<td>아이디</td>
		<td>
			<input type="text" name="userid" onblur="userid_check(this.value)"><br>
			<span id="err"></span>
		</td>	<!-- blur : 나갈때 -->
	</tr>
	<tr>
		<td>이름</td>
		<td><input type="text" name="name"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="pwd"></td>
	</tr>
	<tr>
		<td>비밀번호확인</td>
		<td>
			<input type="password" name="pwd2" onkeyup="pwd_check(this.value)">
			<!-- keyup은 작성할때마다 값이 전달돼서 작성할때마다 확인이 가능. (keydown, keypress 는 작성할때마다 값이 전달x) -->
			<br><span id="perr"></span>
		</td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input type="text" name="email"></td>
	</tr>
	<tr>
		<td>전화번호</td>
		<td><input type="text" name="phone" ></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="회원가입">
		</td>
	</tr>
</table>
</form>
</div>

<c:import url="../bottom.jsp"/>