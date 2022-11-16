<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="dao.ReserveDao"%>
<% 
ReserveDao rdao=new ReserveDao();
rdao.reserve_next(request);
%>
<%
// 몇박을 알려주는 getSuk()메소드를 호출
rdao.getSuk(request);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section table{
	width:900px;
	border-collapse:collapse;
	border-left:none;
	border-right:none;
	border-top-color:white;
	margin-top:50px;
	font-size:14px;}
	#section table td{
 	border-left:none;
	border-right:none; 
	height:50px;}
	#section table td:first-child{
	font-size:15px;
	font-weight:600;
	width:150px;}
	#section table td:nth-child(3){
	font-size:15px;
	font-weight:600;
	width:150px;}
	#section table .border{
	padding-bottom:50px;
	border-bottom:2px dashed orange;}
	#section table .border2{
	padding-top:50px;}
	#section table tr:last-child{
	text-align:right;
	border-bottom-color:white;}
	#section table select{
	outline:none;}
	#section table input[type=submit]{
	margin-top:10px;
	width:200px;
	height:50px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
</style>
<script>
	// 총 가격을 구하는 함수
	function total_price()
	{
		// 숙박, 인원, 숯, bbq의 선택값을 가져와서 각각의 금액을 구한다.
		
		// 1. 숙박
		var ss=document.reser.suk.value;
		var ssprice=ss*${rdto.price};
		document.getElementById("suk").innerText=new Intl.NumberFormat().format(ssprice);
		
		// 2. 인원
		var ii=document.reser.inwon.value;
		ii=ii-${rdto.min};
		var iiprice=ii*20000;
		document.getElementById("inwon").innerText=new Intl.NumberFormat().format(iiprice);
		
		// 3. 숯
		var cc=document.reser.charcoal.value;
		var ccprice=cc*10000;
		document.getElementById("charcoal").innerText=new Intl.NumberFormat().format(ccprice);
		
		// 4. bbq
		var bb=document.reser.bbq.value;
		var bbprice=bb*20000;
		document.getElementById("bbq").innerText=new Intl.NumberFormat().format(bbprice);
		
		// 5. total
		var tt=ssprice+iiprice+ccprice+bbprice;
		document.getElementById("total").innerText=new Intl.NumberFormat().format(tt);
		
		// form태그내에 총 금액을 전달
		document.reser.total.value=tt;
	}
</script>
<div id="section">
<form name="reser" method="post" action="reserve_ok.jsp">
	<input type="hidden" name="inday" value="${ymd }">
	<input type="hidden" name="bang_id" value="${rdto.id }">
	<input type="hidden" name="total" value="${rdto.price }">
<h2>${rdto.bang } 예약정보</h2>
<hr>
<table border="1" align="center">
	<tr>
		<td>입실일</td>
		<td>${ymd }</td>
		<td>숙박일수</td>
		<td>
			<select name="suk" onchange="total_price()">
			<c:forEach begin="1" end="${chk}" var="i"> 
				<option value="${i}"> ${i}박 </option>
			</c:forEach>
			</select> 
		</td>
	</tr>
	<tr>
		<td>기준인원</td>
		<td>( ${rdto.min } / ${rdto.max } )</td>
		<td>입실인원</td>
		<td>
			<select name="inwon" onchange="total_price()">
			<c:forEach begin="${rdto.min }" end="${rdto.max }" var="i">
				<option value="${i }">${i }명</option>
			</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<td>애견</td>
		<td>
			<select name="charcoal" onchange="total_price()">
				<option value="0">선택안함</option>
				<option value="1">1마리</option>
				<option value="2">2마리</option>
				<option value="3">3마리</option>
				<option value="4">4마리</option>
				<option value="5">5마리</option>
			</select>
		</td>
		<td>BBQ(삼겹살 및 재료)</td>
		<td>
			<select name="bbq" onchange="total_price()">
				<option value="0">선택안함</option>
				<option value="1">1개</option>
				<option value="2">2개</option>
				<option value="3">3개</option>
				<option value="4">4개</option>
				<option value="5">5개</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="border">숙박 가격</td>
		<td colspan="3"  class="border">
			<span id="suk">
				<fmt:formatNumber value="${rdto.price }" type="number"/>
			</span>원
		</td>
	</tr>
	<tr>
		<td  class="border2">인원 추가</td>
		<td colspan="3"  class="border2">
			<span id="inwon">0</span>원
		</td>
	</tr>
	<tr>
		<td>애견</td>
		<td colspan="3">
			<span id="charcoal">0</span>원
		</td>
	</tr>
	<tr>
		<td>BBQ</td>
		<td colspan="3">
			<span id="bbq">0</span>원
		</td>
	</tr>
	<tr>
		<td>총 가격</td>
		<td colspan="3">
			<span id="total">
				<fmt:formatNumber value="${rdto.price }" type="number"/>
			</span>원
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<input type="submit" value="예약하기">
		</td>
	</tr>
</table>
</form>
</div>
<c:import url="../bottom.jsp"/>