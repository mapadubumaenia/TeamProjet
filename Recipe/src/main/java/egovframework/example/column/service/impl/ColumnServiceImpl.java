// ColumnServiceImpl.java
package egovframework.example.column.service.impl;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.column.service.ColumnService;
import egovframework.example.column.service.BannerAdVO;
import egovframework.example.drink.service.DrinkVO;
import egovframework.example.like.service.LikeService;
import egovframework.example.method.service.MethodVO;

@Service
public class ColumnServiceImpl implements ColumnService {

    @Autowired private ColumnMapper mapper;
    @Autowired private LikeService   likeService;

    @Override
    public List<BannerAdVO> selectBannerAds() {
        return mapper.selectBannerAds();
    }

    @Override
    public List<DrinkVO> selectTopLikedDrinks(int limit) {
        List<DrinkVO> all = mapper.selectAllDrinks();
        // 좋아요 세팅
        all.forEach(d -> d.setLikeCount(likeService.countLikesByUuid(d.getUuid())));
        // 정렬·Top N
        return all.stream()
                  .sorted(Comparator.comparingInt(DrinkVO::getLikeCount).reversed())
                  .limit(limit)
                  .collect(Collectors.toList());
    }

    @Override
    public List<MethodVO> selectTopLikedByCategory(String methodType, int limit) {
        List<MethodVO> all = mapper.selectAllMethodsByType(methodType);
        all.forEach(m -> m.setLikeCount(likeService.countLikesByUuid(m.getUuid())));
        return all.stream()
                  .sorted(Comparator.comparingInt(MethodVO::getLikeCount).reversed())
                  .limit(limit)
                  .collect(Collectors.toList());
    }
}