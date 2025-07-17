<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="password-check">
    <p>비밀번호를 입력해주세요</p>
    <input type="password" id="checkPasswordInput" />
    <button id="confirmBtn">확인</button>
    <p id="pwError" style="color:red; display:none;">비밀번호가 틀렸습니다.</p>
</div>

<script>
  $("#confirmBtn").click(function() {
    const pw = $("#checkPasswordInput").val();

    $.ajax({
      type: "POST",
      url: "/mypage/checkPassword.do",
      data: { password: pw },
      success: function(response) {
        if (response === "success") {
          window.location.href = "/mypage/updateForm.do";
        }
      },
      error: function(xhr) {
        if (xhr.responseText === "wrongPassword") {
          $("#pwError").show();
        } else {
          alert("로그인 정보가 없습니다.");
        }
      }
    });
  });
</script>