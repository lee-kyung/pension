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
	width:900px;
	margin-top:50px;
	border-collapse:collapse;
	border:none;}
	#section table td{
	padding:5px;}
	#section table td:first-child{
	width:100px;
	text-align:center;
	font-size:14px;}
	#section table input[type=text], [type=password]{
	width:98%;
	height:30px;
	outline:none;}
	#section table textarea{
	width:98%;
	height:300px;
	outline:none;
	resize:none;}
	#section table #btn{
	text-align:right;}
	#section table input[type=submit]{
	margin-top:10px;
	width:200px;
	height:50px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
</style>
<script>
function check(my)
{
	if(${userid==null})
	{
		if(my.title.value.trim()=="")
		{
			alert("제목을 작성해주세요");
			return false;
		}
		else if(my.pwd.value.trim()=="")
		{
			alert("비밀번호를 작성해주세요");
			return false;
		}
		else if(my.content.value.trim()=="")
		{
			alert("내용을 작성해주세요");
			return false;
		}
		else
			return true;
	}
	else
	{
		if(my.title.value.trim()=="")
		{
			alert("제목을 작성해주세요");
			return false;
		}
		else if(my.content.value.trim()=="")
		{
			alert("내용을 작성해주세요");
			return false;
		}
		else
			return true;
	}
}
</script>
	<div id="section">
	<h2>작성하기</h2>
	<hr>
	<form method="post" action="write_ok.jsp" onsubmit="return check(this)">
	<table align="center">	
		<tr>
			<td id="title">제목</td>
			<td><input type="text" name="title"></td>
		</tr>
		
		<c:if test="${userid==null }">
		<tr>
			<td id="pwd">비밀번호</td>
			<td><input type="password" name="pwd" placeholder="비밀번호를 입력하세요"></td>
		</tr>
		</c:if>
		
		<tr>
			<td id="content">내용</td>
			<td><textarea name="content"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" id="btn">
				<input type="submit" value="작성">
			</td>
		</tr>
	</table>
	</form>
	</div>
<c:import url="../bottom.jsp"/>