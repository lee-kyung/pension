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
	margin-top:50px;}
	#section table #title, #content{
	font-weight:700;
	width:60px;
	text-align:center;
	font-size:15px;}
	#section table #text{
	font-size:14px;
	text-align:right;}
	#section table tr:last-child{
	border-bottom-color:white;}
	#section table tr{
	height:40px;}
	#section table input[type=text]{
	width:98%;
	height:30px;
	outline:none;}
	#section table textarea{
	width:98%;
	height:300px;
	outline:none;
	resize:none;
	font-size:13px;}
	#section table input[type=submit], [type=button]{
	margin-top:20px;
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
	#section table #btn{
	text-align:right;}
</style>

<div id="section">
<h2>공지사항</h2>
<hr>
	<form method="post" action="write_ok.jsp">
		<table align="center">
			<tr>
				<td id="title">제목</td>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<td id="content">내용</td>
				<td><textarea name="content"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" id="text">
					<input type="checkbox" name="gubun" value="1">
					이 글을 항상 첫페이지에 출력하고자하면 체크하세요
				</td>
			</tr>
			<tr>	
				<td colspan="2" id="btn">
					<input type="button" value="목록" onclick="location='list.jsp'">
					<input type="submit" value="저장">
				</td>
			</tr>
		</table>
	</form>
</div>

<c:import url="../bottom.jsp"/>