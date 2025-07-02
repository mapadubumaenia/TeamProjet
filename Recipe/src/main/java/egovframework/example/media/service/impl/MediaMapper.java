/**
 * 
 */
package egovframework.example.media.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.common.Criteria;

/**
 * @author user
 *
 */
@Mapper
public interface MediaMapper {
	public List<?> MediaList(Criteria criteria);   // 전체 조회
}
