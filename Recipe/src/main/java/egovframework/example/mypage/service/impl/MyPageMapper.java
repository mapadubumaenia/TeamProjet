package egovframework.example.mypage.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.auth.service.MemberVO;
import egovframework.example.common.Criteria;
import egovframework.example.mypage.service.MyPostVO;

@Mapper
public interface MyPageMapper {
	// 1. 내가 작성한 레시피
    public List<MyPostVO> selectMyRecipes(Criteria criteria);
    public MyPostVO selectOneByUuid(String uuid);
    public int selectMyRecipesCount(Criteria criteria);
    
    // 2. 좋아요레시피
    public List<MyPostVO> selectLikedRecipes(Criteria criteria);
    public int selectLikedRecipesCount(Criteria criteria);

    // 5. 내 정보 조회
    public String getPasswordByUserId(String userId);
    public MemberVO getMemberById(String userId);
    public void updateMember(MemberVO vo);
    public byte[] getProfileImage(String userId);
    public void deleteMember(String userId); 
    public String selectUserIdByNickname(String nickname);
    
    //삭제전 게시물에서 계정id정보 삭제
    public void nullStand(String userId);
    public void nullMedia(String userId);
    public void nullComment(String userId);
    public void nullCommunity(String userId);
    public void nullQna(String userId);
    public void nullLike(String userId);
    public void nullMethod (String userId);
    public void nullColumn (String userId);
}
