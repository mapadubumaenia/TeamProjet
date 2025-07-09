/**
 * 
 */
package egovframework.example.community.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.common.Criteria;
import egovframework.example.community.service.CommunityService;
import egovframework.example.community.service.CommunityVO;

/**
 * @author user
 *
 */
@Service
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private CommunityMapper communityMapper;

	@Override
	public List<?> selectCommuList(Criteria criteria) {
		return communityMapper.selectCommunityList(criteria);
	}

	@Override
	public int selectCommuListToCnt(Criteria criteria) {
		return communityMapper.selectCommunityListTotCnt(criteria);
	}

	@Override
	public int insert(CommunityVO communityVO) {
		return communityMapper.insert(communityVO);
	}

	@Override
	public CommunityVO selectCommunity(String uuid){
		return communityMapper.selectCommunity(uuid);
	}

	@Override
	public int update(CommunityVO communityVO) {
		return communityMapper.update(communityVO);
	}

	@Override
	public int delete(String uuid) {
		return communityMapper.delete(uuid);
	}

	@Override
	public int increaseViewCount(String uuid) {
		// TODO Auto-generated method stub
		return communityMapper.increaseViewCount(uuid);
	}

	@Override
	public int increaseLikeCount(String uuid) {
		// TODO Auto-generated method stub
		return communityMapper.increaseLikeCount(uuid);
	}
	
	
	
}