<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.ReserveDao"%>
<% 
ReserveDao rdao=new ReserveDao();
rdao.getCalendar(request);
rdao.getRoom(request);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section table{
	width:900px;
	font-size:14px;
	table-layout: fixed;	/*너비 동일*/
	word-break:break-all;	/*너비가 고정된 상태에서 내용이 넘칠 경우 높이조절*/
	border-collapse:collapse;}
	#section #cal{
	font-weight:600;
	font-size:25px;}
	
	#section table{
	width:900px;}
	#section table tr:first-child, a{
	height:25px;
	text-align:center;
	text-decoration:none;
	color:black;
	border-top-color:white;}
	#section table tr:first-child{
	border-left-color:white;
	border-right-color:white;}
	#section table tr:nth-child(2){
	font-size:15px;
	font-weight:600;
	text-align:center;
	height:20px;}
	#section table #day{
	height:110px;}
	#section table #num{
	text-align:right;}
</style>
<script>

</script>
<%
rdao.getprev(request);
%> 

<div id="section">
<h2>예약</h2>
<hr>
<table align="center" border="1">
<tr>
 <!-- 관리자일 경우 이전달력 보여주기 -->
<td>
<c:if test="${userid=='admin' }">

	<c:if test="${m==1 }">
		<a href="reserve.jsp?y=${y-1 }&m=12"> <span id="cal"> << </span></a>
	</c:if>
	
	<c:if test="${m!=1 }">
		<a href="reserve.jsp?y=${y }&m=${m-1}"> <span id="cal"> << </span></a>
	</c:if>
	
</c:if>

<!-- 관리자가 아닐 경우 이전달력 숨기기 -->
<c:if test="${userid !='admin' }">
<c:if test="${prev==1 }">

	<c:if test="${m==1 }">
		<a href="reserve.jsp?y=${y-1 }&m=12"> <span id="cal"> << </span></a>
	</c:if>
	
	<c:if test="${m!=1 }">
		<a href="reserve.jsp?y=${y }&m=${m-1}"> <span id="cal"> << </span></a>
	</c:if>
</c:if>  
</c:if>
</td>

<td colspan="5">
	<c:if test="${m < 10}">
		<span id="cal">${y } 0${m }</span>
	</c:if>
	<c:if test="${m >= 10}">
		<span id="cal">${y } ${m }</span>
	</c:if>
</td>
<td>
	<c:if test="${m==12 }">
		<a href="reserve.jsp?y=${y+1 }&m=1"><span id="cal"> >> </span></a>
	</c:if>
	
	<c:if test="${m!=12 }">
		<a href="reserve.jsp?y=${y }&m=${m+1}"><span id="cal"> >> </span></a>
	</c:if>
</td>	
</tr>

	<tr>
		<td>SUN</td>
		<td>MON</td>
		<td>TUE</td>
		<td>WED</td>
		<td>THU</td>
		<td>FRI</td>
		<td>SAT</td>
	</tr>
	<c:set var="day" value="1"/>
	<c:forEach var="i" begin="1" end="${ju }">	<!-- 행 -->
	<tr id="day">
		<c:forEach var="j" begin="0" end="6">	<!-- 열 -->
		<c:if test="${(j<yoil && i==1) || (chong<day)}">
			<td>&nbsp; </td>
		</c:if>
		<c:if test="${ ( (j>=yoil && i==1) || i>1) && (chong >= day)}">
			<td  valign="top"><div id="num">${day }</div>
			<!-- 방의 이름을 출력 -->
			<!-- td에 출력되는 날짜가 오늘 이전인지 이후인지를 체크 -->
			<%
			// 년, 월은 request영역, 일은 pageContext => 스크립트변수
			String y=request.getAttribute("y").toString();
			String m=request.getAttribute("m").toString();
			String d=pageContext.getAttribute("day").toString();
			String dday=y+"-"+m+"-"+d;	//	YYYY-MM-DD
			
			rdao.getcheck(y, m, d, request);
			%>
			<c:if test="${tt==1 }">
			
			
				<c:forEach items="${rlist }" var="rdto"	>
					<!-- 방의 예약여부를 확인 : dao메소드(년, 월, 일, 방id) -->
					<c:set var="bang_id" value="${rdto.id }"/>
				<%
				String bang_id=pageContext.getAttribute("bang_id").toString();
				rdao.getEmpty(dday, bang_id, request);
				%>
				
				
					<!-- request영역의 cnt변수의 값이 1이면 예약불가, 0이면 예약가능 -->
					<c:if test="${cnt==0 }">
						<a href="reserve_next.jsp?y=${y }&m=${m }&d=${day }&id=${rdto.id }">${rdto.bang }</a>
						<br>
					</c:if>
					<c:if test="${cnt==1 }">
						<span style="color:red; text-decoration:line-through;">${rdto.bang }</span>
						<br>
					</c:if>
				</c:forEach>
			
			
			</c:if>
			</td>
		<c:set var="day" value="${day+1 }"/>	<!-- 날짜값을 1씩 증가 -->
		</c:if>
		</c:forEach>
	</tr>
	</c:forEach>
</table>
</div>
<c:import url="../bottom.jsp"/>