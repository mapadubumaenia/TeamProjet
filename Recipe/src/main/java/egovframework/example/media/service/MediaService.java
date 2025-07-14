/**
 * 
 */
package egovframework.example.media.service;

import java.util.List;


import egovframework.example.common.Criteria;

/**
 * @author user
 *
 */
public interface MediaService {
	List<?> allMedia(Criteria criteria);
	Integer allMediaTotCnt(Criteria criteria);
	List<?> MediaList(Criteria criteria);   // 전체 조회
	int MediaListTotCnt(Criteria criteria); //총 개수 구하기
	MediaVO selectMedia(String uuid);       // 상세조회
	int insert(MediaVO mediaVO);                 // insert
	int update(MediaVO mediaVO);           //수정
	int delete(MediaVO mediaVO);           //삭제

}
