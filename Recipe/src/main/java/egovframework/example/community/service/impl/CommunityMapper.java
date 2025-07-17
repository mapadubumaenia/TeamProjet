package egovframework.example.community.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.common.Criteria;
import egovframework.example.community.service.CommunityVO;

/**
 * @author user
 *
 */
@Mapper
public interface CommunityMapper {
  public List<?> selectCommunityList(Criteria criteria);
  public int selectCommunityListTotCnt(Criteria criteria);
  public int insert(CommunityVO communityVO);
  public CommunityVO selectCommunity(String uuid);
  public int update(CommunityVO communityVO);
  public int delete (String uuid);
  public int increaseViewCount(String uuid);
  public int increaseLikeCount(String uuid);
  public int getLikeCount(String uuid);
}