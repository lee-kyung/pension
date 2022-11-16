<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
</style>
<script>
	var size=1;
	function add_file()
	{
		size++;
		var outer=document.getElementById("outer");
		var inner="<p class='fname'><input type='file' name='fname"+size+"'></p>";
		outer.innerHTML=outer.innerHTML+inner;
	}
	
	function del_file()
	{
		if(size>1)
		{
			document.getElementsByClassName("fname")[size-1].remove();
			size--;
		}
	}
</script>
<div id="section">
<h2>사진첩</h2>
<hr>

<form method="post" action="write_ok.jsp" enctype="multipart/form-data">
<table border="1">
	<tr>
		<td>사 진</td>
	</tr>
	<tr>
		<td id="outer">
			<span class="fname"><input type="file" name="fname"></span>
			<input type="button" onclick="add_file()" value="+">	
			<input type="button" onclick="del_file()" value="-">	
		</td>
	</tr>
	<tr>
		<td><input type="password" name="pwd" placeholder="비밀번호를 입력하세요"></td>
	</tr>
	<tr>
		<td>
			<input type="button" value="목록" onclick="location='list.jsp'">
			<input type="submit" value="작성">
		</td>
	</tr>
</table>
</form>

</div>
<c:import url="../bottom.jsp"/>