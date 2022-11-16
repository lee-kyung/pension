<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.BoardDao"%>
<% 
BoardDao bdao=new BoardDao();
bdao.update(request);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section table{
	width:900px;
	margin-top:50px;}
	#section table tr{
	height:40px;}	
	#section table td:first-child, #writeday{
	font-size:15px;
	font-weight:700;}
	#section table #writeday{
	width:100px;}
	#section table td:last-child, #readnum-size{
	font-size:14px;}
	#section table #content{
	width:100px;
	height:150px;}
	#section table #readnum-size{
	width:350px;}
	#section table #btn{
	text-align:right;
	padding-top:20px;
	border-bottom-color:white;}
	#section table input[type=button]{
	margin-top:10px;
	width:150px;
	height:40px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
	#section table #del{
	display:none;
	text-align:right;}
	#section table input[type=password]{
	width:120px;
	height:20px;
	outline:none;}
	#section table input[type=submit]{
	margin-top:20px;
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
	#del{
	display:none;}
	#section table input[type=text]{
	width:98%;
	height:30px;
	outline:none;}
	#section table textarea{
	width:98%;
	height:300px;
	outline:none;
	resize:none;}
</style>
<script>
function del_form()
	{
		document.getElementById("del").style.display="table-row";
	}
</script>
<div id="section">
<h2>글 수정</h2>
<hr>
<form method="post" action="update_ok.jsp">
<input type="hidden" name="id" value="${bdto.id }">
	<table align="center">	
		<tr>
			<td>제목</td>
			<td colspan="3" >
				<input type="text" name="title" value="${bdto.title }">
			</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td colspan="3" >${bdto.userid }</td>
		</tr>
		<tr>
			<td id="content">내용</td>
			<td colspan="3">
				<textarea name="content">${bdto.content }</textarea>
			</td>
		</tr>
		<tr>
			<td>조회수</td>
			<td id="readnum-size">${bdto.readnum }</td>
			<td id="writeday">작성일</td>
			<td>${bdto.writeday }</td>
		</tr>
		<tr>
			<td colspan="4" id="btn">
			<c:if test="${userid==null || bdto.userid != userid }">
				<input type="button" value="수정" onclick="javascript:del_form()">
				<!-- 비회원이 수정할 경우 비밀번호를 입력할 폼 -->
				<tr id="del">
					<td colspan="4" >
						<input type="password" name="pwd">
						<input type="submit" value="수정">	
					</td>
				</tr>
			</c:if>	
			
			<c:if test="${!( userid==null || bdto.userid != userid )}">
				<input type="submit" value="글수정"> 
			</c:if>	
			
			</td>
		</tr>	
		
	</table>
	</form>
</div>
<c:import url="../bottom.jsp"/>