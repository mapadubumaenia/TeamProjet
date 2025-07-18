package egovframework.example.mypage.service.impl;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.auth.service.MemberVO;
import egovframework.example.common.Criteria;
import egovframework.example.mypage.service.MyPageService;
import egovframework.example.mypage.service.MyPostVO;

@Service
public class MyPageServiceImpl extends EgovAbstractServiceImpl implements MyPageService {
    @Autowired
    MyPageMapper myPageMapper;
    
    
    //내가 작성한 레시피
    @Override
	public List<MyPostVO> selectMyRecipes(Criteria criteria) {
		// TODO Auto-generated method stub
		return myPageMapper.selectMyRecipes(criteria);
	}

	@Override
	public MyPostVO selectOneByUuid(String uuid) {
		// TODO Auto-generated method stub
		return myPageMapper.selectOneByUuid(uuid);
	}

	
    @Override
	public int selectMyRecipesCount(Criteria criteria) {
		// TODO Auto-generated method stub
		return myPageMapper.selectMyRecipesCount(criteria);
	}
    //좋아요한 게시물
	@Override
	public List<MyPostVO> selectLikedRecipes(Criteria criteria) {
		// TODO Auto-generated method stub
		return myPageMapper.selectLikedRecipes(criteria);
	}
    
   
    
	@Override
	public int selectLikedRecipesCount(Criteria criteria) {
		// TODO Auto-generated method stub
		return myPageMapper.selectLikedRecipesCount(criteria);
	}

	//  내 정보 조회
	@Override
	public boolean checkPassword(String userId, String inputPassword) {
		// TODO Auto-generated method stub
		String dbPassword = myPageMapper.getPasswordByUserId(userId);
        return dbPassword != null && BCrypt.checkpw(inputPassword, dbPassword);
	}

	@Override
	public String getPasswordByUserId(String userId) {
		// TODO Auto-generated method stub
		return myPageMapper.getPasswordByUserId(userId);
	}

	@Override
	public MemberVO getMemberById(String userId) {
		// TODO Auto-generated method stub
		return myPageMapper.getMemberById(userId);
	}

	@Override
	public void updateMember(MemberVO vo) {
		// TODO Auto-generated method stub
	       myPageMapper.updateMember(vo);
	}

	@Override
	public byte[] getProfileImage(String userId) {
		// TODO Auto-generated method stub
		MemberVO member = myPageMapper.getMemberById(userId);
	    return (member != null) ? member.getProfileImage() : null;
	}

	@Override
	public void deleteMember(String userId){
		// TODO Auto-generated method stub
		myPageMapper.nullStand(userId);
		myPageMapper.nullMedia(userId);
		myPageMapper.nullCommunity(userId);
		myPageMapper.nullColumn(userId);
		myPageMapper.nullQna(userId);
		myPageMapper.nullMethod(userId);
		myPageMapper.nullLike(userId);
		myPageMapper.nullComment(userId);
		
	    myPageMapper.deleteMember(userId);
	}



	
	
}
