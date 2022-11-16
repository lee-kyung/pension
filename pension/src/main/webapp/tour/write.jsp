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
	height:300px;
	resize:none;}
	
/*	#section table input[type=file]{
	display:none;}
	
	#section table label span{
	margin-left:10px;
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;
	cursor: pointer;
	display: flex;			*/	/*flex가 있어야 상하좌우정렬이 가능??*/
/*	align-items: center;		/*상하정렬*/
/*	justify-content: center;	/*좌우정렬*/
/*	font-size:13px;}*/
	
	#section table #outer{
	padding-left:10px;}
	#section table .btn{
	width:30px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
	#section table .btn2{
	margin-top:20px;
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
	
</style>
<script>
	var size=1;	// id="outer"안에 있는 type='file'의 개수, name을 서로 다르게 하기위해 사용
	function add_file()
	{
		size++;
		var outer=document.getElementById("outer");
		var inner="<p class='fname'><input type='file' name='fname"+size+"'></p>";
		outer.innerHTML=outer.innerHTML+inner;
	}
	function del_file()
	{
		if(size>1)	// size>1는 파일첨부의 마지막 하나는 삭제하지 못하게 if문 사용
		{
			document.getElementsByClassName("fname")[size-1].remove();
			size--;
		}	
	}
</script>
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
		<td id="outer">
			<span class="fname"><input type="file" name="fname1" id="file"></span>
			
			<input type="button" onclick="add_file()" value="+" class="btn">
			<input type="button" onclick="del_file()" value="-" class="btn">
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="목록" onclick="location='list.jsp'" class="btn2">
			<input type="submit" value="작성" class="btn2">
		</td>
	</tr>
</table>
</form>
</div>
<c:import url="../bottom.jsp"/>