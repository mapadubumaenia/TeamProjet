// ColumnService.java
package egovframework.example.column.service;

import java.util.List;

import egovframework.example.drink.service.DrinkVO;
import egovframework.example.method.service.MethodVO;

public interface ColumnService {
    List<BannerAdVO> selectBannerAds();
    List<DrinkVO>    selectTopLikedDrinks(int limit);
    List<MethodVO>   selectTopLikedByCategory(String methodType, int limit);
}