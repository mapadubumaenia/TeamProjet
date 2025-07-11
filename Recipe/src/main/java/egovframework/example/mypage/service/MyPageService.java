package egovframework.example.mypage.service;

public interface MyPageService {
	//내 정보조히
	MyInfoVO selectMyInfo(String userId)throws Exception;
}
