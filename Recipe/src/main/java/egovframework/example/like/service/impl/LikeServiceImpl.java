/**
 * 
 */
package egovframework.example.like.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.like.service.LikeService;
import egovframework.example.like.service.LikeVO;

/**
 * @author user
 *
 */
@Service
public class LikeServiceImpl implements LikeService{

    @Autowired
    private LikeMapper likeMapper;
    
//    좋아요 등록
	@Override
	public void insertLike(LikeVO likeVO) {
		// TODO Auto-generated method stub
		likeMapper.insertLike(likeVO);

		
	}
	

	
	//	좋아요 여부 확인

	@Override
	public int countLikeByUser(LikeVO likeVO) {
		// TODO Auto-generated method stub
		return likeMapper.countLikeByUser(likeVO);
	}
//	좋아요 삭제
	@Override
	public void deleteLike(LikeVO likeVO) {
		// TODO Auto-generated method stub
		likeMapper.deleteLike(likeVO);

	}
	
//  개시물의 총 좋아요 수
	@Override
	public int countLikesByUuid(String uuid) {
		// TODO Auto-generated method stub
		return likeMapper.countLikesByUuid(uuid);
	}

}
