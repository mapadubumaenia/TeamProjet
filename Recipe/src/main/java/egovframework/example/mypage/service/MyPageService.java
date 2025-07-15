package egovframework.example.mypage.service;

import java.util.List;

import egovframework.example.common.Criteria;

public interface MyPageService {
	//내가 작성한 레시피
	List<MyPostVO> selectMyRecipes(String userId);
	MyPostVO selectOneByUuid(String uuid); // for image

	//내 정보조회
	MyInfoVO selectMyInfo(String userId)throws Exception;
	
}
