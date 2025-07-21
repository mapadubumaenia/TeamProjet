package egovframework.example.search.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.common.Criteria;
import egovframework.example.search.service.SearchVO;


@Mapper
public interface SearchMapper {

    // 제목 기반 통합 검색 결과 목록 조회
    List<SearchVO> searchAllByTitle(Criteria criteria);

    // 제목 기반 통합 검색 총 개수 조회
    int searchAllByTitleTotCnt(Criteria criteria);
    
    SearchVO getSearchResultByUuid(String uuid);
}
