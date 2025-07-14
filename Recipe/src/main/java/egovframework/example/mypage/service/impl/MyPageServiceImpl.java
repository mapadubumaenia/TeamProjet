package egovframework.example.mypage.service.impl;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.mypage.service.MyInfoVO;
import egovframework.example.mypage.service.MyPageService;
import egovframework.example.mypage.service.MyPostVO;

@Service
public class MyPageServiceImpl extends EgovAbstractServiceImpl implements MyPageService {
    @Autowired
    MyPageMapper myPageMapper;
    
	
    
    
    @Override
	public List<MyPostVO> selectMyRecipes(String userID) {
		// TODO Auto-generated method stub
		return myPageMapper.selectMyRecipes(userID);
	}




	@Override
	public MyPostVO selectOneByUuid(String uuid) {
		// TODO Auto-generated method stub
		return null;
	}





	@Override
	public MyInfoVO selectMyInfo(String userId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
