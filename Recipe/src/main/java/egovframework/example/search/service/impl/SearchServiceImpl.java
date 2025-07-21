package egovframework.example.search.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.common.Criteria;
import egovframework.example.search.service.SearchService;
import egovframework.example.search.service.SearchVO;

@Service
public class SearchServiceImpl implements SearchService {

   @Autowired SearchMapper searchMapper;

@Override
public List<SearchVO> searchAllByTitle(Criteria criteria) {
	// TODO Auto-generated method stub
	return searchMapper.searchAllByTitle(criteria);
}

@Override
public int searchAllByTitleTotCnt(Criteria criteria) {
	// TODO Auto-generated method stub
	return searchMapper.searchAllByTitleTotCnt(criteria);
}

@Override
public SearchVO getSearchResultByUuid(String uuid) {
	// TODO Auto-generated method stub
	return searchMapper.getSearchResultByUuid(uuid);
}




}