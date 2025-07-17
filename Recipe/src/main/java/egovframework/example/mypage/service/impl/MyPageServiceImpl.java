package egovframework.example.mypage.service.impl;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.auth.service.MemberVO;
import egovframework.example.mypage.service.MyInfoVO;
import egovframework.example.mypage.service.MyPageService;
import egovframework.example.mypage.service.MyPostVO;

@Service
public class MyPageServiceImpl extends EgovAbstractServiceImpl implements MyPageService {
    @Autowired
    MyPageMapper myPageMapper;
    
    @Override
	public List<MyPostVO> selectMyRecipes(String userId) {
		// TODO Auto-generated method stub
		return myPageMapper.selectMyRecipes(userId);
	}

	@Override
	public MyPostVO selectOneByUuid(String uuid) {
		// TODO Auto-generated method stub
		return myPageMapper.selectOneByUuid(uuid);
	}

//  내 정보 조회
	@Override
	public MyInfoVO selectMyInfo(String userId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

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
