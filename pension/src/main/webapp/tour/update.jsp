<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ page import="dao.TourDao"%>
<% 
TourDao tdao=new TourDao();
tdao.update(request);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section table{
	width:900px;
	border-left:none;
	border-right:none;
	border-top-color:white;
	border-collapse:collapse;
	font-size:14px;}
 	#section table td{
	border-left:none;
	border-right:none;
	height:40px;} 
	#section table td:first-child, #readnum, #content{
	text-align:center;
	font-size:15px;
	font-weight:700;
	width:70px;}
	#section table #writeday-size{
	width:400px;}
	#section table #content{
	height:250px;}
/* 	#section table #btn{
	text-align:right;} */
	#section table #userid-size{
	width:500px;}
	#section table tr:last-child{
	border-bottom-color:white;}
/* 	#section table input[type=button]{
	margin-top:20px;
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;} */
	#section table img{
	padding-top:10px;
	padding-bottom:10px;}
     
</style>
<script>
	function del_add(n,my)
	{	
	// 체크된 사진에 투명도 주기
		if(my.checked==true)	// true생략도 가능, checked자체가 체크가 되었다면 true이기 때문에
			document.getElementsByClassName("cimg")[n].style.opacity="0.3";	
	// 체크해제된 사진 투명도 되돌리기
		else
			document.getElementsByClassName("cimg")[n].style.opacity="1";	
	}
	
	function check(upform)
	{
	// checkbox가 체크된 그림파일명과 체크가 안된 그림파일명을 각각 저장
		
		// 요소의 이름을 변수에 전달
		var chk=document.getElementsByName("chk");
		// 체크박스의 길이
		var len=chk.length;
		// 삭제할 파일을 저장
		var del="";
		//삭제하지 않을 파일을 저장
		var str="";
		
		for(i=0; i<len; i++)
		{
			// 체크가 되었다면 참이고 참은 삭제할 파일을 의미
			if(chk[i].checked)
				del=del+chk[i].value+",";
			
			// 삭제하지 않을 파일
			else
				str=str+chk[i].value+",";
		}	
		
		// 삭제파일 목록
		upform.del.value=del;
		
		// 보존파일 목록
		upform.str.value=str;
		return true;
	}
	
	// id="outer"안에 있는 type="file"의 개수, name을 서로 다르게 하기위해 사용
	var size=1;
	
	function add_file()
	{
		size++;
		var outer=document.getElementById("outer");
		var inner="<p class='fname'> <input type='file' name='fname"+size+"'> </p>";
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
<h2>여행후기</h2>
<hr>
<form method="post" onsubmit="return check(this)" action="update_ok.jsp" enctype="multipart/form-data">
<input type="hidden" name="id" value="${tdto.id }">
<input type="hidden" name="del" >
<input type="hidden" name="str" >

<table align="center" border="1">
	<tr>
		<td>제목</td>
		<td colspan="3"><input type="text" name="title" value="${tdto.title }"></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td id="userid-size" colspan="3">${tdto.userid }</td>
	</tr>
	<tr>
		<td>작성일</td>
		<td id="writeday-size">${tdto.writeday }</td>
		<td id="readnum">조회수</td>
		<td>${tdto.readnum }</td>
	</tr>
	
	<tr>
		<td id="content">내용</td>
		<td colspan="3"><textarea name="content">${tdto.content }</textarea></td>		
	</tr>
	<tr>
		<td>사진</td> 
		<td>
		<c:set var="t" value="0"/><!-- 사진에 index를 주기위해서, 초기값을 0으로 설정한다는 의미 -->
		<c:forEach items="${tdto.file}" var="img" >
			<img src="img/${img}" width="50" class="cimg">
			<input type="checkbox" onclick="del_add(${t},this)" name="chk" value="${img }">
		<c:set var="t" value="${t+1 }"/><!-- 사진의 인덱스값이 1씩 증가한다는 의미 -->	 
		</c:forEach><p>
		<span style="color:red;font-size:12px">삭제하려면 체크하세요</span>
		</td>
	</tr>
	<tr>
		<td>추가</td>
		<td id="outer">
			<span class="fname"><input type="file" name="fname1" id="file"></span>
			
			<input type="button" onclick="add_file()" value="추가" class="btn">
			<input type="button" onclick="del_file()" value="삭제" class="btn">
		</td>
	</tr>
	<tr>
		<td colspan="4" id="btn">
			<input type="button" value="목록" onclick="location='list.jsp'">
			<input type="submit" value="수정">
		</td>
	</tr>
</table>
</form>
</div>
<c:import url="../bottom.jsp"/>