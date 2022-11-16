<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%@ page import="dao.ReserveDao"%>
<% 
ReserveDao rdao=new ReserveDao();
rdao.reserve_view(session, request);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section table{
	margin-top:50px;
	width:900px;
	text-align:center;
	font-size:14px;
	border-collapse:collapse;
	border-left:none;
	border-right:none;
	border-top-color:white;}
	#section table td{
	height:50px;
	border-left:none;
	border-right:none;}
	#section table tr:first-child{
	font-size:15px;
	font-weight:600;}
	#section table tr:last-child{
	border-bottom-color:white;}
	#section table td:nth-child(8){
	width:100px;}
	#section table input[type=button]{
	width:99%;
	height:99%;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
</style>

<div id="section">
<h2>${name }님의 예약내용</h2>
<hr>
<table border="1" align="center">
	<tr>
		<td>방</td>
		<td>입실일</td>
		<td>퇴실일</td>
		<td>애견</td>
		<td>BBQ</td>
		<td>총 결제금액</td>
		<td>예약일</td>
		<td>상 태</td>
		<td></td>
	</tr>
	<c:forEach items="${rlist }" var="rdto">
	<tr>
		<td>${rdto.bang }</td>
		<td>${rdto.inday }</td>
		<td>${rdto.outday }</td>
		<td>${rdto.charcoal }마리</td>
		<td>${rdto.bbq }개</td>
		<td><fmt:formatNumber value="${rdto.total }"/>원</td>
		<td>${rdto.writeday }</td>
		
		<c:if test="${rdto.state==0}">
			<c:set var="state" value="예약완료"/>
		</c:if>
		<c:if test="${rdto.state==1}">
			<c:set var="state" value="예약취소중"/>
		</c:if>
		<c:if test="${rdto.state==2}">
			<c:set var="state" value="취소완료"/>
		</c:if> 
		<c:if test="${rdto.state==3}">
			<c:set var="state" value="사용완료"/>
		</c:if>
		<td>${state }</td>
		<!-- 버튼(예약완료->예약취소, 예약취소->취소철회) -->
		<!-- 1. 현상태가 예약완료일 경우 예약취소 버튼이 보이도록 -->
		<c:if test="${rdto.state==0 }">
			<td><input type="button" value="예약취소" onclick="location='state_change.jsp?id=${rdto.id}&state=1&ck=${ck }'"></td>
		</c:if>
		<!-- 2. 현상태가 예약취소일 경우 취소철회 버튼이 보이도록 -->
		<c:if test="${rdto.state==1 }">
			<td><input type="button" value="취소철회" onclick="location='state_change.jsp?id=${rdto.id}&state=0&ck=${ck } '"></td>
		</c:if>
		<!-- 3. 그 외 -->
		<!--  test="${ rdto.state==2 || rdto.state==3 }" -->
		<c:if test="${ !( rdto.state==0 || rdto.state==1 ) }">
			<td> &nbsp;</td>
		</c:if>
		
<%-- 		
		<c:if test="${rdto.state==0}">
			<td>예약완료</td>
		</c:if>
		<c:if test="${rdto.state==1}">
			<td>취소신청중</td>
		</c:if>
		<c:if test="${rdto.state==2}">
			<td>취소완료</td>
		</c:if>
		<c:if test="${rdto.state==3}">
			<td>사용완료</td>
		</c:if> --%>
	</tr>
	</c:forEach>
</table>
</div>
<c:import url="../bottom.jsp"/>