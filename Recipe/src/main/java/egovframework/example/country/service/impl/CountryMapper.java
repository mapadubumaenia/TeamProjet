/**
 * 
 */
package egovframework.example.country.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.common.Criteria;
import egovframework.example.country.service.CountryVO;

/**
 * @author user
 *
 */
@Mapper
public interface CountryMapper {
	public List<?> selectCountryList(Criteria criteria); // 전체조회
	public int selectCountryListTotCnt(Criteria criteria); // 총 개수 구하기
	public int insert(CountryVO countryVO); // insert
	public CountryVO selectCountry (String uuid); //상세조회
	public int delete(CountryVO countryVO); // delete 메소드
	public int update(CountryVO countryVO); // update 메소드
}
