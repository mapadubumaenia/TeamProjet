package egovframework.example.country.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.common.Criteria;
import egovframework.example.country.service.CountryService;
import egovframework.example.country.service.CountryVO;

@Service
public class CountryServiceImpl implements CountryService{

	@Autowired
	private CountryMapper countryMapper;
//	전체조회
	@Override
	public List<?> selectCountryList(Criteria criteria) {
		// TODO Auto-generated method stub
		return countryMapper.selectCountryList(criteria);
	}
//	총갯수
	@Override
	public int selectCountryListTotCnt(Criteria criteria) {
		// TODO Auto-generated method stub
		return countryMapper.selectCountryListTotCnt(criteria);
	}
	
	
//	입력
	@Override
	public int insert(CountryVO countryVO) {
		// TODO Auto-generated method stub
		return countryMapper.insert(countryVO);
	}

	@Override
	public CountryVO selectCountry(String uuid) {
		// TODO Auto-generated method stub
		return countryMapper.selectCountry(uuid);
	}
//	삭제
	@Override
	public int delete(CountryVO countryVO) {
		// TODO Auto-generated method stub
		return countryMapper.delete(countryVO);
	}
//	수정
	@Override
	public int update(CountryVO countryVO) {
		// TODO Auto-generated method stub
		return countryMapper.update(countryVO);
	}
	
	
	
}
