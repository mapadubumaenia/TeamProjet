package egovframework.example.method.service;

import java.util.List;

import egovframework.example.common.Criteria;

public interface MethodService {

	
	
	 List<?> selectMethodList(Criteria criteria);  //전체 조회
	
    int  selectMethodListTotCnt(Criteria criteria);  //총 갯수 구하기
    
	int insert(MethodVO methodVO);     // insert
	 
	 MethodVO selectMethod(String uuid);     //상세조회
	 
	 int delete(String uuid);      //삭제
	
	 int update(MethodVO methodVO);   // ← 추가
	
	
	
	
	
	
	
	
	
}
