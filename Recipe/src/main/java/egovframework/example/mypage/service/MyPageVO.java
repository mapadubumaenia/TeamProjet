package egovframework.example.mypage.service;

import java.util.List;

import egovframework.example.common.Criteria;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@EqualsAndHashCode(callSuper = false)
public class MyPageVO extends Criteria{
	   private MyInfoVO myInfo;
	   private List<MyPostVO> myPosts;
	   private List<MyCommentVO> myComments;
	   private List<MyScrapVO> myScraps;
	   private List<LikedPostVO> likedPosts;
	   private List<LikedCommentVO> likedComments;
}
