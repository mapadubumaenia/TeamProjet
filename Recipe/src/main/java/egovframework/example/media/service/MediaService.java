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
	List<?> MediaList(Criteria criteria);   // 전체 조회
}
