package egovframework.example.mypage.service;

import java.util.List;

import egovframework.example.auth.service.MemberVO;

public interface MyPageService {
	//내가 작성한 레시피
	List<MyPostVO> selectMyRecipes(String userId);
	MyPostVO selectOneByUuid(String uuid); // for image

	//내 정보조회
	MyInfoVO selectMyInfo(String userId)throws Exception;
	boolean checkPassword(String userid, String inputPassword);
	String getPasswordByUserId(String userId);
	MemberVO getMemberById(String userid);
	void updateMember(MemberVO vo);
	byte[] getProfileImage(String userId);
	void deleteMember(String userId);



}


