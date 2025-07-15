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
<link rel="stylesheet" href="/css/openmedia.css">
</head>
<body>
	<!-- 머리말 -->
	<jsp:include page="/common/header.jsp" />

	<div class="update">
	<form action="/media/edit.do" id="addForm" name="addForm" method="post"
		enctype="multipart/form-data">

<input type="hidden" name="uuid" value="<c:out value='${mediaVO.uuid}' />">

		<div class="mb3">
			<label for="mediaCategory" class="form-label">카테고리</label> 
			
			<select
				class="form-select" id="mediaCategory" name="mediaCategory">
				<option value="1"<c:if test="${mediaVO.mediaCategory == 1}">selected</c:if>>영화</option>
				<option value="2"<c:if test="${mediaVO.mediaCategory == 2}">selected</c:if>>드라마</option>
				<option value="3"<c:if test="${mediaVO.mediaCategory == 3}">selected</c:if>>게임</option>

			</select> 
			<label for="title" class="form-label">요리이름</label> 
			<input class="form-control" id="title" name="title" placeholder="title" value="${mediaVO.title}"/>
		</div>
		<div class="mb3">
			<label for="ingredient" class="form-label">준비물</label> 
			<textarea class="form-control" id="ingredient" name="ingredient"
				placeholder="ingredient">${mediaVO.ingredient}</textarea>
		</div>
		<div class="mb3">
			<label for="content" class="form-label">만드는 방법</label> 
			<textarea class="form-control" id="content" name="content"
				placeholder="content">${mediaVO.content}</textarea>
		</div>
		
		<c:if test="${mediaVO.recipeImageUrl != null}">
                <div class="mb-3">
                    <p>기존 이미지:</p>
                    <img src="${mediaVO.recipeImageUrl}" class="img-fluid mb-2" alt="기존 이미지">
                </div>
            </c:if>

            <div class="mb-3">
                <label for="recipeImage" class="form-label">이미지 수정</label>
                <input type="file" class="form-control" id="recipeImage" name="recipeImage" />
            </div>

		<div class="ubuttons">
   <button class="btn btn-outline-dark" type="button" onclick="fn_update()">수정</button>
   <button class="btn btn-outline-dark" type="button" onclick="fn_delete()">삭제</button>
   </div>
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
	function fn_update() {

		$("#addForm").attr("action",'<c:out value="/media/edit.do" />')
		.submit();		
	}
	function fn_delete() {
		if (confirm("삭제하시겠습니까?")) {
			$("#addForm").attr("action",'<c:out value="/media/delete.do" />')
			.submit();	
		}	
	}
	
</script>

	<!-- 꼬리말 -->
	<jsp:include page="/common/footer.jsp" />
</body>
</html>