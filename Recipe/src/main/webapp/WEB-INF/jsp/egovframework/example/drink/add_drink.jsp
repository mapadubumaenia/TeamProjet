<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <!--    부트스트랩 css  -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
   <!--    개발자 css -->
   <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/exstyle.css">
    <link rel="stylesheet" href="/css/Drinkstyle.css">
    <link rel="stylesheet" href="/css/Add_drink.css">
    


</head>
<body>
<jsp:include page="/common/header.jsp"/>
<div class="page mt3">
     <!--업로드 시 추가(첨부파일이라는 요청):enctype="multipart/form-data"  -->
     <!--스프링 업로드 파일 제한: 1MB(디폴트) => 10MB로 변경해야함  -->
   <form id="addForm"
         name="addForm"
         method="post"
         enctype="multipart/form-data"
         >
        <input type="hidden" name="csrf" value="${sessionScope.CSRF_TOKEN}">
        
        <div class="mb3">
            <label for="columnTitle" class="form-label">제목</label>
            <input  
                  class="form-control"
                  placeholder="제목" 
                   id="columnTitle"
                  name="columnTitle"
                  />
        </div>
        
      <div class="mb-3">
  <label for="columnIngredient" class="form-label">
    재료 <small class="text-muted">(한 줄에 하나씩 입력)</small>
  </label>
  <textarea
    id="columnIngredient"
    name="columnIngredient"
    class="form-control"
    rows="5"
    placeholder="예)&#10;우유&#10;바나나&#10;꿀"
    required
  ></textarea>
</div>
        
        
              <!-- ▶ 카테고리 선택 추가 -->
  <div class="mb3">
    <label for="category" class="form-label">카테고리</label>
    <select id="category"
            name="category"
            class="form-select"
            required>
      <option value="" disabled selected>-- 선택하세요 --</option>
      <option value="cocktail">칵테일</option>
      <option value="smoothie">스무디&amp;쥬스</option>
      <option value="coffee">커피&amp;티</option>
    </select>
  </div>
        
        
        
        
      <div class="input-group">
      <!-- type="file":파일 대화상자가 화면에 보입니다. -->
        <input type="file" 
               class="form-control" 
                id="image"
                  name="image"
               >
       
      </div>
        
        
        
        
        
        <!-- 내용 입력 멀티라인으로 -->
  <div class="mb3">
    <label for="columnContent" class="form-label">내용</label>
    <textarea
      id="columnContent"
      name="columnContent"
      class="form-control form-content"
      rows="6"
      placeholder="내용을 입력하세요"></textarea>
  </div>
  
  <div class="save">
  <button type="button" class="btn btn-secondary" id="previewBtn">미리보기</button>
       <!-- 변경: reset → 이전 페이지로 이동 -->
    <button type="button"
            class="btn btn-secondary btn-cancel"
            onclick="history.back()">
      취소
    </button>
  <button class="btn btn-mocha"
                type="button"
                onclick="fn_save()"
                >저장</button>
                
  
  </div>
  



  
    
    </form>
</div>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- 부트스트랩 js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

<script type="text/javascript">
    function fn_save() {
    	$("#addForm").attr("action",'<c:out value="/drink/add.do" />')
	    .submit();
	}
</script>




<!-- 미리보기 모달 (팝업) -->
<div class="modal fade" id="previewModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">미리보기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body" id="previewModalBody">
        <!-- AJAX로 previewFragment.jsp가 로드됩니다 -->
      </div>
      <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>


<script>
  // 미리보기 버튼 클릭 시
  $('#previewBtn').on('click', function(){
    var formData = new FormData($('#addForm')[0]);
    $.ajax({
      url: '<c:url value="/drink/preview.do"/>',
      type: 'POST',
      data: formData,
      processData: false,
      contentType: false,
      success: function(html){
        $('#previewModalBody').html(html);
        new bootstrap.Modal($('#previewModal')).show();
      }
    });
  });

</script>






<jsp:include page="/common/footer.jsp"/>







</body>
</html>
