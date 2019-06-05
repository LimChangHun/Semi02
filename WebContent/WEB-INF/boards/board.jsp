<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>후원 게시판</title>
<link href="https://fonts.googleapis.com/css?family=Cute+Font|Noto+Serif+KR:700|Do+Hyeon|Sunflower:300|Jua|Nanum+Gothic|Nanum+Gothic+Coding&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>

<link rel="stylesheet" href="nav_footer.css">
<style>
	.progress {
		width: 200px;
	}
	.progress-bar {
		background-color: orange;
	}
	.wrapper {
		display: inline-block;
	}
	.boardName {
		text-align: center;
		margin-bottom: 50px;
		font-family: "Do Hyeon";
		font-size: 50px;
		color: darkslategray;
	}
	
	/*검색*/
	#dropdownforSearch {
		float: left;
        height: 30px;
        margin-top: 3px;
	}
	
	.searchWord {
/*		float: left;*/
		width: 250px;
        height: 30px;
	}
	
	#searchBox {
		margin-right: 10px;
		margin-bottom: 10px;
	}
	
	.searchBtn {
		/*                margin-left: 1px;*/
		background-color: #1ebdd8;
		border-color: #1ebdd8;
		color: #FFF;
	}
	
	.searchBtn:hover {
		border-color: #28a39f;
		background-color: #28a39f;
		color: #FFF;
	}
	
	.listBox {
		margin-bottom: 50px;
	}
	
	.list {
		width: 250px;
		height: 350px;
		margin: 10px auto;
	}
	
	.list img {
		width: 250px;
		height: 200px;
		margin: auto;
	}
	
	.progress {
		width: 70%;
		float: left;
		position: static;
	}
	
	.amount {
		position: relative;
		left: 10px;
		bottom: 3px;
	}
	
	.numBox li a {
		color: lightslategray;
	}
	
	.bottonBtns {
		margin-bottom: 100px;
	}
	
	#goMainBtn {
		background-color: #1ebdd8;
		border-color: #1ebdd8;
		color: #FFF;
		margin: 0 5px;
	}
	
	#goMainBtn:hover {
		border-color: #28a39f;
		background-color: #28a39f;
		color: #FFF;
	}
	
	#writeBtn {
		background-color: #1ebdd8;
		border-color: #1ebdd8;
		color: #FFF;
	}
	
	#writeBtn:hover {
		border-color: #28a39f;
		background-color: #28a39f;
		color: #FFF;
	}
	.article{
		cursor: pointer;
	}
</style>
<script>
	$(function(){
		$.ajax({
			url : "Fund",
			type : "post",
		}).done(function(resp) {
			$("#card1").css("width", resp + "%");
			$("#card1_span").text(resp + "%");
		})
		
		$("#goMainBtn").on("click",function(){
			location.href="Main.members";
		})
		
		$(".searchBtn").on("click",function(){
	       if($(".searchWord").val()==""){
	    	   alert("검색할 내용을 입력해주세요.");
	       }
		})
		

// 		$(".page-link").on("click",function(){
// 			var paging = $(this).attr("paging");
// 			$.ajax({
// 					url:"List.board",		
// 					type:"post",
// 					data:{
// 						currentPage:paging,
// 						searchOption:$("#dropdownforSearch option").val(),
// 						searchWord:$(".searchWord").val()
// 						}
// 			}).done(function(resp){
// 				console.log(resp); 			    	
// 			});
// 		})

	})
</script>
</head>
<body>
	<!--상단 메뉴바-->
	<nav class="navbar navbar-expand-md navbar-light">
		<div class="logo">
			<a class="navbar-brand anker" href="Main.members" style="font-family: 'Cute Font', cursive;"><h1>도움닿기</h1></a>
		</div>
		<div id="toggle">
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav nav-ul">
				<li class="nav-item nav-li"><a class="nav-link anker" href="Introduce.members">소개</a></li>
				<li class="nav-item nav-li mr-3"><a id="logos" class="nav-link anker" href="TalentDonations.board">재능기부 게시판</a></li>
				<li class="nav-item nav-li ml-3"><a id="logos" class="nav-link anker" href="List.board?currentPage=1&&searchOption==null&&searchWord==null">후원 게시판</a></li>
	
				<c:choose>
					<c:when test="${sessionScope.loginEmail != null || navercontents.name != null || realcontents.email != null}">
						<li class="nav-item nav-li ml-3"><a id="logos" class="nav-link anker" href="myPage.members?currentPage=1&currentPage2=1">마이 페이지</a></li>
						<li class="nav-item nav-li ml-4"><a class="nav-link anker" href="Logout.members">로그아웃</a></li>

					</c:when>
					<c:otherwise>
						<li class="nav-item nav-li"><a class="nav-link anker ml-1 pr-0" href="LoginForm.members">로그인</a></li>
						<li class="nav-item nav-li"><a class="nav-link anker pl-0" href="JoinForm.members">회원가입</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</nav>

	<div class="boardName">
		<p>게시판</p>
	</div>

	<div id="wrapper" class="container listBox">

		<!--검색창-->
		<div class="row d-flex justify-content-end">
			<form action="List.board?currentPage=1" method=post id=searchBox>
				<select name="searchOption" id="dropdownforSearch">
					<option>검색방법</option>
					<option name="searchOption" value="title">제목</option>
					<option name="searchOption" value="contents">내용</option>
					<option name="searchOption" value="all">제목+내용</option>
				</select> 
				<input type="text" name="searchWord" class="searchWord" placeholder="검색할 내용 입력">
				<button type="submit" class="btn searchBtn">검색</button>
			</form>
		</div>

	</div>

		<!--글목록-->
		<div class="row listRow">
			<c:forEach var="list" items="${board }">
				<div class="col-lg-3 col-md-6 col-sm-12 article" boardNo="${list.boardNo}">
					<div class="card list">
						<img src=${list.filePath}> 
						<div class="card-body">
							<h5 class="card-title">${list.title }</h5>
							<p class="card-text">${list.writer }</p>
							<div class="progress">
								<div id="card1" class="progress-bar" role="progressbar"
									aria-valuenow="${percentage }" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
							<div class="amount">
								<small class="text-muted amount">${list.amount }</small>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	

	<!--페이지네비게이터 -->
		<div class="row  p-0 m-0" id="num_box">
			<div class="col-12 d-flex justify-content-center">
				<nav aria-label="Page navigation example">
					<ul class="pagination pagination-sm">
								${getNavi }
					</ul>
				</nav>		
			</div>
		</div>
	<!--하단 버튼들 -->
	<div class="row p-0 m-0" id="bottom">
		<div class="col-12 bottonBtns d-flex justify-content-center">
			<button type="button" class="btn" id="goMainBtn">메인으로</button>
			<button type="button" class="btn" id="writeBtn">글쓰기</button>
		</div>
	</div>
	
	<div id="footer">
		<div id="f_logo_wrap">
			<a id="f_logo" href="Main.members" style="font-family: 'Cute Font', cursive;"><h1>도움닿기</h1></a>
		</div>
		<div id="f_info_wrap">
			<div id="f_info">행동하는 당신과 당신의 도움으로<br>다시 희망을 찾는 사람들을 응원힙니다.</div>
		</div>
		<div id="f_sns">
			<img id="kakao" class="sns" src="photo_image/ka.png">
			<img class="sns" src="photo_image/fa.png">
			<img id="insta" class="sns" src="photo_image/kk.png">
			<a href="/"><div id="suggest">후원 신청</div></a>
		</div>
		<div id="copyright">COPYRIGHT ⓒ 2019 BY RUNUP ALL RIGHT RESERVED</div>
	</div>
	
	<script>
		$("#goMainBtn").on("click", function(){
			location.href="Main.members";
		})
	
		$("#writeBtn").on("click", function(){
			location.href="write.board";
		})
		
		$(".article").on("click", function(){
			var boardNo = $(this).attr("boardNo");
			location.href="Read.board?boardNo="+boardNo+"&commentPage=1";
		})
	</script>
</body>
</html>