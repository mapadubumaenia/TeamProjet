package egovframework.example.mypage.service.impl;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.common.Criteria;
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


	@Override
	public MyInfoVO selectMyInfo(String userId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
