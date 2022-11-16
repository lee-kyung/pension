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
	width:600px;
	margin-top:50px;
	border:none;}
	#section table td:first-child{
	text-align:right;
	font-size:15px;
	font-weight:700;}
	#section table input[type=text]{
	margin-left:10px;
	width:96%;
	outline:none;
	height:30px;}
	#section table textarea{
	margin-left:10px;
	width:96%;
	outline:none;
	height:200px;
	resize:none;}
	#section table input[type=file]{
	display:none;}
	#section table label div{
	margin-left:10px;
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;
	cursor: pointer;
	display: flex;				/*flex가 있어야 상하좌우정렬이 가능??*/
	align-items: center;		/*상하정렬*/
	justify-content: center;	/*좌우정렬*/
	font-size:13px;}
	#section table input[type=button], [type=submit]{
	margin-top:20px;
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
</style>

<div id="section">
<h2>여행후기</h2>
<hr>
<form method="post" action="write_ok.jsp" enctype="multipart/form-data">
<table align="center">
	<tr>
		<td>제목</td>
		<td><input type="text" name="title"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea name="content"></textarea></td>
	</tr>
	<tr>
		<td>파일</td>
		<td><label for="file"><div>첨부파일</div></label><input type="file" name="fname" id="file"></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="목록" onclick="location='list.jsp'">
			<input type="submit" value="작성">
		</td>
	</tr>
</table>
</form>
</div>
<c:import url="../bottom.jsp"/>