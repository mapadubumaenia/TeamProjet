/**
 * 
 */
package egovframework.example.like.service;

/**
 * @author user
 *
 */

public interface LikeService {

    // 좋아요 등록
    void insertLike(LikeVO likeVO);

    // 좋아요 여부 확인
    int countLikeByUser(LikeVO likeVO);

    // 좋아요 삭제
    void deleteLike(LikeVO likeVO);
    
    // 게시물의 총 좋아요 수
    int countLikesByUuid(String uuid);
}
