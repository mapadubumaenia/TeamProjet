/**
 *
 */ 
$("#addForm").validate({
  rules: {
    // 유효성 검사 규칙
    userName: {          // 사용자이름
      required: true, // 필수 입력
      minlength: 2,    //  최소 입력 길이
    },
    phoneNum: {       // 전화번호
      required: true,  // 필수 입력
      digits: true,    // 숫자 형태로만 입력 가능하도록 설정
    }
  },
  messages: {
    // 오류값 발생시 출력할 메시지 수동 지정
    userName: {   // id별명
      required: "＊필수 입력 항목입니다.",
      minlength: "＊최소 {0}글자 이상 입력하세요.",
      
    },
    phoneNum: {
      required: "＊필수 입력 항목입니다.",
      digits: "＊반드시 숫자만 입력하세요.",
    }
  }
});
