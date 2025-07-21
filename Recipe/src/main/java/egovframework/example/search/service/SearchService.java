
package egovframework.example.search.service;

import java.util.List;

import egovframework.example.common.Criteria;

public interface SearchService {

	List<SearchVO> searchAllByTitle(Criteria criteria);
	
    int searchAllByTitleTotCnt(Criteria criteria);

	SearchVO getSearchResultByUuid(String uuid);
}