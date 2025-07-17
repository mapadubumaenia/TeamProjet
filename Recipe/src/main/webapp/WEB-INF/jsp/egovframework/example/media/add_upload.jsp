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
			<textarea class="form-control" id="ingredient" name="ingredient" rows="3"
				placeholder="예) 소고기 200g, 우유 20ml ..." /></textarea>
		</div>
		<div class="mb3">
			<label for="content" class="form-label">만드는 방법</label> 
			<textarea class="form-control" id="content" name="content" rows="7"
				placeholder="content" /></textarea>
		</div>
		<div class="mb-3">
		<label for="recipeImage" class="form-label">대표 이미지 추가 (10MB 이하)</label>
			<input type="file" class="form-control" id="recipeImage"
				name="recipeImage">
		</div>
<div class="ubuttons">
		<button class="btn btn-outline-dark" type="button" onclick="fn_save()">올리기</button>
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
		function fn_save() {
			$("#addForm").attr("action", '<c:out value="/media/add.do" />')
					.submit();
		}
	</script>
	
	<script>
  const textarea = document.getElementById('content');
// 1~6번까지 적어둠
  textarea.value = '1. \n2. \n3. \n4. \n5. \n6. ';

  textarea.addEventListener('keydown', function(e) {
    if (e.key === 'Enter') {
      e.preventDefault();

      // 현재 커서 위치
      const start = this.selectionStart;
      const end = this.selectionEnd;

      // 현재 내용에서 커서 위치 기준으로 앞부분 텍스트 추출
      const textBeforeCursor = this.value.substring(0, start);

      // 마지막 줄 번호 찾기 (텍스트에서 줄바꿈 기준으로 나누기)
      const lines = textBeforeCursor.split('\n');
      const lastLine = lines[lines.length - 1];

      // 마지막 줄에서 번호 추출 (ex: "6. ")
      const match = lastLine.match(/^(\d+)\.\s*/);
      let nextNumber = 1;
      if (match) {
        nextNumber = parseInt(match[1], 10) + 1;
      }
      // 새 번호 붙인 줄 추가
      const insertText = '\n' + nextNumber + '. ';
      // 현재 내용에 새 줄 삽입
      this.value = this.value.substring(0, start) + insertText + this.value.substring(end);
      // 커서 위치 새 줄 뒤로 이동
      this.selectionStart = this.selectionEnd = start + insertText.length;
    }
  });
</script>

<script>
  document.getElementById("recipeImage").addEventListener("change", function () {
    const file = this.files[0]; // 사용자가 선택한 파일

    if (file && file.size > 10 * 1024 * 1024) { // 10MB 초과
      alert("⚠️ 10MB 이하의 이미지만 업로드할 수 있습니다.\n선택한 파일 크기: " + (file.size / (1024 * 1024)).toFixed(2) + "MB");
      this.value = ""; // 파일 입력 초기화
    }
  });
</script>

	<!-- 꼬리말 -->
	<jsp:include page="/common/footer.jsp" />
</body>
</html>