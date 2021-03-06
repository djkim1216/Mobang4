<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/agent/css/reset.css">
<link rel="stylesheet" type="text/css" href="resources/agent/css/agent_header.css">
<script type="text/javascript" src="resources/agent/js/agent_header.js"></script>
</head>
<body>
	
	<div class="agenthead">
		<div class="headleft">
			<a style=""href="agent_home.all"><h1>모방 | 공인중개사</h1></a>
			<a href="home.all"><div class="h2">모방 사이트></div></a>
		</div>
		<div class="headright" style="padding-right: 10px;">
			<ul>
				<li class="first"><a href="#">광고상품 소개</a>
					<article class="adsubmenu">
						<a href="agent_sales.all"><div class="submenu">일반 상품</div></a>
						<a href="agent_premium_sales.all"><div class="submenu">역/동 상품</div></a>
						<a href="agent_premium_sales.all"><div class="submenu">대학교 상품</div></a>
						<a href="agent_sales.all"><div class="submenu">플러스 상품</div></a>
					</article>
				</li>
				<li class="first"><a href="#">고객센터</a>
					<article class="scsubmenu">
						<a href="noticelist.all"><div class="submenu">공지사항</div></a>
						<a href="fnq.all"><div class="submenu">문의사항</div></a>
					</article>
				</li>
				<li style="margin-right: 15px;">
					<a href="agent_roominsert.agent"><div class="button">방 올리기</div></a>
				</li>
				<li class="second">
					<a href="agent_mypage.agent" style="color:black;">마이페이지</a>
					<a href="<c:url value='/logout.all'/>">로그아웃</a>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>