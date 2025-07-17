/**
 * 
 */
package egovframework.example.media.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.common.Criteria;
import egovframework.example.media.service.MediaVO;

/**
 * @author user
 *
 */
@Mapper
public interface MediaMapper {
	public List<?> allMedia(Criteria criteria);
	public int allMediaTotCnt(Criteria criteria);
	public List<?> MediaList(Criteria criteria);   
	public int MediaListTotCnt(Criteria criteria); 
	public MediaVO selectMedia(String uuid);       // 상세조회
	public int insert(MediaVO mediaVO);            // insert
	public int update(MediaVO mediaVO);           // 수정
	public int delete(MediaVO mediaVO);           //삭제
}
