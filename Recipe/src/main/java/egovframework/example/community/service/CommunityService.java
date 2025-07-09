package egovframework.example.community.service;

import java.util.List;

import egovframework.example.common.Criteria;

public interface CommunityService {

	List<?> selectCommuList(Criteria criteria);
	int selectCommuListToCnt(Criteria criteria);
	int insert(CommunityVO communityVO);
	CommunityVO selectCommunity(String uuid);
	int update(CommunityVO communityVO);
	int delete (String uuid);
	int increaseViewCount(String uuid);
	int increaseLikeCount(String uuid);

}