/**
 * 
 */
package egovframework.example.community.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.example.comment.service.impl.CommentMapper;
import egovframework.example.common.Criteria;
import egovframework.example.community.service.CommunityService;
import egovframework.example.community.service.CommunityVO;

/**
 * @author user
 *
 */
@Service
@Transactional
public class CommunityServiceImpl implements CommunityService {
	
	@Autowired
	private CommentMapper commentMapper;

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
		
		 commentMapper.deleteCommentsByUuid(uuid);  // 댓글 먼저 삭제
		 return communityMapper.delete(uuid);       // 게시글 삭제
	}

	@Override
	public int increaseViewCount(String uuid) {
		// TODO Auto-generated method stub
		return communityMapper.increaseViewCount(uuid);
	}

	public int increaseLikeCount(String uuid) {
	    communityMapper.increaseLikeCount(uuid);              // 좋아요 +1
	    return communityMapper.getLikeCount(uuid);            // 현재 좋아요 수 반환
	}
	
	
	
}