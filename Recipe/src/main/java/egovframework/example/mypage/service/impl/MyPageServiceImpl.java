package egovframework.example.mypage.service.impl;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.mypage.service.MyInfoVO;
import egovframework.example.mypage.service.MyPageService;

@Service
public class MyPageServiceImpl extends EgovAbstractServiceImpl implements MyPageService {
    @Autowired
    MyPageMapper myPageMapper;
    
	@Override
	public MyInfoVO selectMyInfo(String userId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
