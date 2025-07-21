package egovframework.example.mypage.service;

import java.util.List;

import egovframework.example.auth.service.MemberVO;
import egovframework.example.common.Criteria;

public interface MyPageService {
	//내가 작성한 레시피
	List<MyPostVO> selectMyRecipes(Criteria criteria);
	MyPostVO selectOneByUuid(String uuid); // for image
	int selectMyRecipesCount(Criteria criteria);
	
	//좋아요한 레시피
	List<MyPostVO> selectLikedRecipes(Criteria criteria);
	int selectLikedRecipesCount(Criteria criteria);
	
	//내 정보조회
	boolean checkPassword(String userid, String inputPassword);
	String getPasswordByUserId(String userId);
	MemberVO getMemberById(String userid);
	void updateMember(MemberVO vo);
	byte[] getProfileImage(String userId);
	void deleteMember(String userId);
	boolean isNicknameDuplicate(String nickname, String userId); 


}


