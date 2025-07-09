package egovframework.example.method.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.common.Criteria;
import egovframework.example.method.service.MethodVO;

@Mapper
public interface MethodMapper {

	 public List<?> selectMethodList(Criteria criteria);  //전체 조회
     public int  selectMethodListTotCnt(Criteria criteria);  //총 갯수 구하기
	 public int insert(MethodVO methodVO);     // insert
	 public MethodVO selectMethod(String uuid);     //상세조회
	 public int delete(String uuid);      //삭제
	
	
	
	
	
	
	
	
}
