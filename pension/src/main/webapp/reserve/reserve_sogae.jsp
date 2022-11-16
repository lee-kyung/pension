<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%@ page import="dao.AdminDao"%>
<% 
AdminDao adao=new AdminDao();
adao.room_view(request);
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
	font-size:14px;
	text-align:center;}
	#section table tr:first-child{
	font-size:15px;
	font-weight:600;}
	#section table td{
	border-left:none;
	border-right:none;
	height:40px;}
	#section table .inwon{
	width:100px;}
	#section table #bang{
	width:500px;}
	#section #text{
	margin-top:100px;
	font-size:14px;
	margin-bottom:100px;}
</style>

<div id="section">
<h2>예약안내</h2>
<hr>
<table align="center" border="1">
	<tr>
		<td rowspan="2" id="bang">객실명</td>
		<td colspan="2">인원</td>
		<td rowspan="2">1박 가격</td>
	</tr>
	<tr>
		<td class="inwon"><b>최소</b></td>
		<td class="inwon"><b>최대</b></td>
	</tr>
	
	<c:forEach items="${rlist }" var="rdto">
	<tr>
		<td>${rdto.bang }</td>
		<td>${rdto.min }</td>
		<td>${rdto.max }</td>
		<td>
			<fmt:formatNumber value="${rdto.price }"/>
		</td>
	</tr>
	</c:forEach>
</table>
<div id="text">

※ 예약	<p>
- 당일 예약 불가합니다. <p>
<br>

※ 비용	<p>
- 추가인원 : 20,000원 <p>
- 애견 : 마리당 10,000원 (대형견도 똑같이 받습니다.) <p>
- BBQ : 25,000원 (1인분) <p>
<br>

※ 인원 <p>
- 최대 인원 초과시 입실이 불가합니다.  <p>
- 각 객실의 비용은 최소인원이 이용할 수 있는 요금이며 추가인원이 발생할 경우 비용이 추가됩니다.  <p>
<br>
※  시간 <p>
- 입실은 15시 이후 퇴실은 11시 이전으로 시간 엄수 바랍니다. <p>
- 정해진 시간보다 일찍 도착한 경우 미리 연락바랍니다. <p>
<br>
※ 애견 <p>
- 저희는 애견펜션으로 강아지와 동반 입실이 가능합니다. <p>
- 대형견 또한 입실이 가능합니다. <p>
- 밥그릇, 배변봉투, 배변패드는 준비되어있으나 그 외의 물건들은 지참바랍니다. <p>
- 입질이 심한 강아지는 독채를 이용해주세요. <p>
<br>
※ 바베큐<p>
- 개별 & 공용 바베큐장<p>
- 이용시간에 제한없습니다. <p>
- 이용하신 후 청소바랍니다. <p>
<br>
※ 야외 풀장<p>
- 강아지와 함께 입실 가능합니다. <p>
- 7월~ 8월만 운영합니다. <p>
<br>
※ 환불<p>
- 당일 취소시 50% 환불 가능합니다. <p>
- 입실 전날 취소시 전액 환불 가능합니다. <p>
</div>
</div>
<c:import url="../bottom.jsp"/>