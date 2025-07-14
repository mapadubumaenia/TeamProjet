/**
 * 
 */
package egovframework.example.like.service.impl;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.like.service.LikeVO;

/**
 * @author user
 *
 */
@Mapper
public interface LikeMapper {

	    // 좋아요 등록
	    public void insertLike(LikeVO likeVO);

	    // 좋아요 여부 확인
	    public int countLikeByUser(LikeVO likeVO);

	    // 좋아요 삭제
	    public void deleteLike(LikeVO likeVO);
	    
	    // 게시물의 총 좋아요 수
	    public int countLikesByUuid(String uuid);
	    
	    
	    
	}


