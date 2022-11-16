<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ page import="dao.AdminDao"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body{
	margin:0px;}
	
	/*스크롤바없애기*/
	body{
	-ms-overflow-style: none;}
	::-webkit-scrollbar {
 	 display: none;}
 	 
	#first{
	width:100%;
	height:33px;
	margin:auto; /* 중앙정렬 */
	background:#005D00;
	text-align:center;
	color:white;
	padding-top :7px; /*기존 height:40 이 padding-top:7을 주면 height 47이 되서 7을 뺴주고(height33) 글은 중앙으로 온다.*/
	}
	#second a{
	text-decoration:none;
	color:black;
	font-size:14px;
	font-weight:700;}

	#second{
	width:1100px;
	height:60px;
	margin:auto; /* 중앙정렬 */
	border-bottom:1px solid black;
	}
	#second > #left{	/* 로고부분의 너비*/
	width:200px;
	height:60px;
	cursor:pointer;}
	#second > #right{	/* 메뉴 부분의 너비*/
	width:890px;
	height:60px;}	
	#second > #left, #second > #right{ /*second밑에 있는 아이디들*/
	display:inline-block;}	/* left, right를 한 줄로 */
	#second > #right > ul > li{	/*second 아래 right 아래 main 아래에 있는 li*/
	list-style-type:none;	/* li 앞 스타일 */
	display:inline-block;	/* 세로로 줄서있는 li를 가로로 줄세우기*/	
	width:136px; 	/* 메뉴들의 너비 */}
	
	#second > #right > ul > li:last-child{	/*마지막 li태그*/
	width:280px; 	/* 마지막 li태그의 길이 (???님 로그아웃 회원정보 부분)*/
	text-align:right;}
	
	#second  #right  #main{	/* 이름이 하나밖에 없어서 >은 생략가능 */
	position:relative;
	}	
	#second #right #main .sub{	
	position:absolute;	/*부메뉴의 기준점이 주메뉴가 된다. relative - absolute. 가지런히 정렬됨. */
	padding-left:80px;	/* .sub : 부메뉴의 ul태그 (ul태그는 왼쪽에 공간을 가진다. 만약 width를 정하지 않을때는 왼쪽에 공간이 생기기때문에 padding-left:0px을 줘야한다.)*/
	visibility:hidden;
	background:rgba(255, 255, 255, 0.7);	/* 배경색을 투명으로 */
	width:150px;
	margin-left:-80px;	/* sub메뉴와 하단메뉴의 위치 조정 */
	}
	#second #right #main .sub li{
	list-style-type:none;
	height:30px;	/* 높이를 줘서 글자사이 간격이 생김*/
	margin-top:10px;	/* 주메뉴와 부메뉴 사이의 간격 */
	}
	#third{
	width:1100px;
	height:400px;
	margin:auto; /* 중앙정렬 */
	/* background:#cccccc; */}
	
	#fourth{
	width:1100px;
	height:130px;
	margin:auto; /* 중앙정렬 */
	/* background:green; */}
	#fourth table{
	width:350px;
	margin:auto;
	/*  border:1px solid black;  */}
	#fourth a{
	text-decoration:none;
	color:black;
	font-size:14px;}
	#fourth a:hover{
	text-decoration:underline;}
	#fourth .writeday{
	font-size:14px;
	width:100px;
	text-align:right;}
	#fourth b{
	font-size:15px;
	cursor:pointer;}
	#fourth > div{
	width:360px;
	height:130px;
/* 	border:1px solid black; */
	display:inline-block;}
	
	#fifth{
	width:1100px;
	height:150px;
	margin:auto; /* 중앙정렬 */
	/* background:pink; */}
	#fifth > div{
	width:210px;
	height:150px;
	border:1px solid red;
	display:inline-block;
	}
	
	#sixth{
	width:1100px;
	height:100px;
	margin:auto; /* 중앙정렬 */
/*	background:#FFBB00;
*/	color:white;
	background:#005D00;
	font-size:13px;}

/* 하단 고정 */	
	body{
	display:flex;
	flex-direction:column;	/*아이템들의 배치방향*/
	min-height:100vh;/* 최소길이가 100 view height(view height:현재보이는 뷰의 height값의 퍼센트치)*/
	}
	footer{
	margin-top:auto;}	/*고정*/
	

	#second #admin {
	display:inline-block;
	position:relative;}
	#second #admin #sub {
	position:absolute;	/*부메뉴의 기준점이 주메뉴가 된다. relative - absolute. 가지런히 정렬됨. */
	visibility:hidden;
	background:rgba(255, 255, 255, 0.7);	/* 배경색을 투명으로 */
	width:130px;
	margin-left:-50px;	/* sub메뉴와 하단메뉴의 위치 조정 */
	}
	#second #admin #sub li {
	list-style-type:none;
	height:30px;	/* 높이를 줘서 글자사이 간격이 생김*/
	margin-top:10px;	/* 주메뉴와 부메뉴 사이의 간격 */
	text-align:left;
	margin-left:15px;}


</style>
<script src="../etc/pension.js"></script>
<script>
	function view(n)
	{
		document.getElementsByClassName("sub")[n].style.visibility="visible";
	}
	function hide(n)
	{
		document.getElementsByClassName("sub")[n].style.visibility="hidden";
	}
	function admin_view()
	{
		document.querySelector("#second #admin #sub").style.visibility="visible";
		// css의 선택자를 사용할 수 있다. querySelectorAll()
	}
	function admin_hide()
	{
		document.querySelector("#second #admin #sub").style.visibility="hidden";
	}
</script>
</head>
<body>
<nav class="navbar navbar-expand-sm bg-light navbar-light fixed-top">
	<div id="first"> 펜션 오픈 기념 1박에 100원 !!! &ensp;&ensp;&ensp;&ensp;&ensp;&ensp; <span id="aa" >X</span></div>
	
	<div id="second">
		<div id="left" onclick="location='../main/index.jsp'"><img src="../img/gs.jpg" width="50">애견펜션</div>
		<div id="right">
			<ul >
				<li id="main" onmouseover="view(0)" onmouseout="hide(0)">펜션소개
					<ul class="sub">
						<li><a href="../sogae/intro.jsp">인사말</a></li>	<!-- index가 메인페이지로 index에서 상위-> sogae로 하위-> intro.jsp -->
						<li><a href="../sogae/room.jsp?id=1">객실소개</a></li>
						<li><a href="../sogae/map.jsp">오시는 길</a></li>
					</ul>
				</li>
				<li id="main" onmouseover="view(1)" onmouseout="hide(1)">여행정보
					<ul class="sub">
						<li><a href="../travel/tour.jsp">주변 여행지</a></li>
					</ul>
				</li>
				<li id="main" onmouseover="view(2)" onmouseout="hide(2)">예약관련
					<ul class="sub">
						<li><a href="../reserve/reserve_sogae.jsp">예약안내</a></li>
						<li><a href="../reserve/reserve.jsp">예약하기</a></li>
					</ul>
				</li>
				<li id="main" onmouseover="view(3)" onmouseout="hide(3)">커뮤니티
					<ul class="sub">
						<li><a href="../gongji/list.jsp">공지사항</a></li>
						<li><a href="../tour/list.jsp">여행후기</a></li>
						<li><a href="../board/list.jsp">자유게시판</a></li>
						<!-- <li><a href="../photo/list.jsp">사진첩</a></li> -->
					</ul>
				</li>
				<li id="main">
				<!-- 로그인하지 않은 상태 -->
				<c:if test="${userid==null }">
					<a href="../member/login.jsp">로그인 | </a>
					<a href="../member/member_input.jsp">회원가입</a>
				</c:if>
				
				<!-- 로그인한 상태 -->
				<c:if test="${userid != null }">	
					<a>${name } 님 | </a>
					<!-- 로그인 : 관리자가 아닌 경우 -->
					<c:if test="${userid != 'admin' }">
						<a href="../member/member_info.jsp">회원정보 | </a>
						<a href="../reserve/reserve_view.jsp?ck=1">예약현황 | </a>
					</c:if>	
					<!-- 로그인 : 관리자인경우 -->
					<c:if test="${userid =='admin' }">
					<div id="admin" onmouseover="admin_view()" onmouseout="admin_hide()"> <a>관리자메뉴</a> |
						<ul id="sub">
							<li><a href="../member/member_info.jsp">관리자정보</a></li>
							<li><a href="../admin/room_view.jsp">객실관리</a></li>
							<li><a href="../admin/reserve_check.jsp">예약관리</a></li>
							<li><a href="../admin/member_check.jsp">회원관리</a></li>
						</ul>
					</div>
					</c:if>		
				<!-- 로그인 : 모든 회원(관리자포함) -->
					<a href="../member/logout.jsp">로그아웃</a>			
				</c:if>
				</li>
			</ul>
		</div>
	</div>	
</nav>
