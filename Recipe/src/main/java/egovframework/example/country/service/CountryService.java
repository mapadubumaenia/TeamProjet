/**
 * 
 */
package egovframework.example.country.service;

import java.util.List;

import egovframework.example.common.Criteria;

/**
 * @author user
 *
 */
public interface CountryService {
	
	List<?> selectCountryList(Criteria criteria); // 전체조회
	int selectCountryListTotCnt(Criteria criteria); // 총 개수 구하기
	int insert(CountryVO countryVO); // insert
	CountryVO selectCountry (String uuid); //상세조회
	int delete(CountryVO countryVO); // delete 메소드
	int update(CountryVO countryVO); // update 메소드
}

