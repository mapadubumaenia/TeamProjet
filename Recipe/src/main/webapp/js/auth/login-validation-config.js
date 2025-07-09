/**
 *
 */ 
$("#addForm").validate({
  rules: {
    // 유효성 검사 규칙
    userid: {          // id별명
      required: true, // 필수 입력
      minlength: 4,    //  최소 입력 길이

    },
    password: {       // id별명
      required: true, // 필수 입력
      minlength: 6,   // 최소 입력 길이
    }
  },
  messages: {
    // 오류값 발생시 출력할 메시지 수동 지정
    userid: {   // id별명
      required: "＊필수 입력 항목입니다.",
      minlength: "＊최소 {0}글자 이상 입력하세요.",
      
    },
    password: {
      required: "＊필수 입력 항목입니다.",
      minlength: "＊최소 {0}글자 이상 입력하세요.",
    }
  }
});
