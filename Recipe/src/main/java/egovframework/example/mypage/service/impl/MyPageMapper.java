package egovframework.example.mypage.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.common.Criteria;
import egovframework.example.mypage.service.MyInfoVO;
import egovframework.example.mypage.service.MyPostVO;

@Mapper
public interface MyPageMapper {
	// 1. 내가 작성한 레시피
    public List<MyPostVO> selectMyRecipes(String userId);
    public MyPostVO selectOneByUuid(String uuid);
	// 5. 내 정보 조회
    public MyInfoVO selectMyInfo(String userId);
}
