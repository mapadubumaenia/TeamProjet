<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세조회 - ${mediaVO.title}</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 파비콘 추가 -->
<link rel="icon" href="/images/01.png" type="image/png">
<!-- 	부트스트랩 css  -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<!-- 	개발자 css -->
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/exstyle.css">
<link rel="stylesheet" href="/css/media.css">
</head>
<body>
	<!-- 머리말 -->
	<jsp:include page="/common/header.jsp" />

	<!-- 본문 -->
	<div class="container">
    <h2>${mediaVO.title}</h2>
    <p><strong>작성자:</strong> ${mediaVO.userId}</p>
    <p><strong>등록일:</strong> ${mediaVO.recipeCreatedAt}</p>
    <img src="${mediaVO.recipeImageUrl}" alt="${mediaVO.title} 이미지" class="img-fluid mb-4" />
    <p><strong>준비물:</strong> ${mediaVO.ingredient}</p>
    <pre style="white-space: pre-wrap;">${mediaVO.content}</pre>
    <a href="/media/game.do" class="btn btn-outline-dark mt-4 ">게임페이지 가기</a>
	</div>

	
	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<!-- 부트스트랩 js -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
	<!-- 토글 애니메이션 js -->
	<script src="/js/nav.js"></script>
	<!-- 페이징 라이브러리 -->
	<script src="/js/jquery.twbsPagination.js" type="text/javascript"></script>

	<!-- 꼬리말 -->
	<jsp:include page="/common/footer.jsp" />
</body>
</html>