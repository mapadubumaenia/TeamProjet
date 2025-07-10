<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RecipeCode</title>
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


	<!-- 업로드 시 추가(첨부파일이라는 요청): enctype="multipart/form-data" -->
	<!-- 스프링 업로드 파일 제한(기본): 1M -> 10M -->
	<div class="upload">
	<form action="/media/add.do" id="addForm" name="addForm" method="post"
		enctype="multipart/form-data">

		<div class="mb3">
			<label for="mediaCategory" class="form-label">카테고리</label> 
			
			<select
				class="form-select" id="mediaCategory" name="mediaCategory">
				<option value="1">영화</option>
				<option value="2">드라마</option>
				<option value="3">게임</option>

			</select> 
			<label for="title" class="form-label">요리이름</label> 
			<input class="form-control" id="title" name="title" placeholder="title" />
		</div>
		<div class="mb3">
			<label for="ingredient" class="form-label">준비물</label> 
			<textarea class="form-control" id="ingredient" name="ingredient"
				placeholder="ingredient" /></textarea>
		</div>
		<div class="mb3">
			<label for="content" class="form-label">만드는 방법</label> 
			<textarea class="form-control" id="content" name="content"
				placeholder="content" /></textarea>
		</div>
		<div class="input-group">
			<input type="file" class="form-control" id="recipeImage"
				name="recipeImage">

		</div>

		<button class="btn btn-dark" type="button" onclick="fn_save()">올리기</button>
	</form>
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
	

	<script type="text/javascript">
		function fn_save() {
			$("#addForm").attr("action", '<c:out value="/media/add.do" />')
					.submit();
		}
	</script>

	<!-- 꼬리말 -->
	<jsp:include page="/common/footer.jsp" />
</body>
</html>