package egovframework.example.column.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.column.service.BannerAdVO;
import egovframework.example.drink.service.DrinkVO;
import egovframework.example.method.service.MethodVO;

@Mapper
public interface ColumnMapper {

	 // 1) 광고판 배너
    List<BannerAdVO> selectBannerAds();

    // 2) 드링크 기본 정보 전체 조회
    List<DrinkVO> selectAllDrinks();

    // 3) 메서드(보관법/손질법) 기본 정보 조회
    List<MethodVO> selectAllMethodsByType(@Param("methodType") String methodType);
}