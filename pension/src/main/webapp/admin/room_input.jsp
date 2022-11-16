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
	width:500px;
	margin-top:50px;}
	#section table td:first-child{
	width:100px;
	font-size:15px;
	font-weight:600;
	text-align:right;}
	#section table td{
	padding-top:10px;}
	#section table input[type=text]{
	width:98%;
	height:25px;
	outline:none;}
	#section table textarea{
	width:98%;
	height:100px;
	outline:none;
	resize:none;}
	#section table td:last-child{
	padding-left:20px;}
	#section table tr:last-child{	
	text-align:right;}
	#section table input[type=submit]{
	margin-top:10px;
	width:150px;
	height:50px;
	background:#FFFFD2;
	border:1px solid #FFFF48;
	cursor:pointer;}
	#section table #text{
	font-size:12px;}
</style>
<script>	

	var bangchk=0;	// 0이면 확인x, 1이면 확인o
	
	function bang_check(bang)
	{
		if(bang.trim()=="")
		{
			bangchk=0;
			document.getElementById("text").innerText="";
		}
		
		else
		{
			var chk=new XMLHttpRequest();  
			chk.open("get", "bang_check.jsp?bang="+bang);
			chk.send();
			
			chk.onreadystatechange=function()
			{
				if(chk.readyState==4)
				{
					if(chk.responseText.trim()=="0")	//사용가능0, 불가능1
					{
						document.getElementById("text").innerText="사용 가능한 방 이름입니다.";
						document.getElementById("text").style.color="blue";
						bangchk=1;
					}
					else
					{
						document.getElementById("text").innerText="동일한 방 이름이 존재합니다.";
						document.getElementById("text").style.color="red";
						bangchk=0;
					}
				}
			}
		}
	}
	
	function check(my)
	{
		if(bangchk==0)
			{
				alert("동일한 방 이름이 존재합니다.");
				return false;
			}
		else if(my.bang.value.trim()=="")
			{
				alert("방 이름을 작성해주세요");
				return false;
			}
		else if(my.min.value.trim()=="")
			{
				alert("최소인원을 작성해주세요");
				return false;
			}
		else if(my.max.value.trim()=="")
			{
				alert("최대인원을 작성해주세요");
				return false;
			}
		else if(my.price.value.trim()=="")
			{
				alert("가격을 작성해주세요");
				return false;
			}
		else if(my.type.value.trim()=="")
		{
			alert("방 구조를 작성해주세요");
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
	
</script>
<div id="section">
<h2>방 추가</h2>
<hr>
<form name="pkc" method="post" action="room_input_ok.jsp" onsubmit="return check(this)">
<table align="center">
	<tr>	
		<td>방 이름</td>
		<td>
			<input type="text" name="bang" onblur="bang_check(this.value)">
			<span id="text"></span>
		</td>
	</tr>
	<tr>	
		<td>최소인원</td>
		<td><input type="text" name="min"></td>
	</tr>
	<tr>	
		<td>최대인원</td>
		<td><input type="text" name="max"></td>
	</tr>
	<tr>	
		<td>1박 가격</td>
		<td><input type="text" name="price"></td>
	</tr>
	<tr>	
		<td>방 구조</td>
		<td><input type="text" name="type"></td>
	</tr>
	<tr>	
		<td>내용</td>
		<td><textarea name="content"></textarea></td>
	</tr>
	<tr>	
		<td colspan="2">
			<input type="submit" value="저장">
		</td>
	</tr>
</table>
</form>

</div>
<c:import url="../bottom.jsp"/>