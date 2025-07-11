package egovframework.example.mypage.service.impl;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.mypage.service.MyInfoVO;

@Mapper
public interface MyPageMapper {
	// 1. 내 정보 조회
    public MyInfoVO selectMyInfo(String userId);
}
