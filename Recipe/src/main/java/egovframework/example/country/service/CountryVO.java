/**
 * 
 */
package egovframework.example.country.service;

import egovframework.example.common.Criteria;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @author user
 *
 */
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@EqualsAndHashCode(callSuper = false)
public class CountryVO extends Criteria{

	private String uuid; // 기본키
	private String userId; // 사용자 아이디
	private String recipeTitle; // 글 제목
	private int countryCategoryId; // 나라별
	private int ingredientCategoryId; // 재료별
	private int situationCategoryId; // 상황별
	private String standardRecipeImageUrl; // 이미지
	private String recipeCreatedAt; // 작성일자
	private int likeCount; // 좋아요
	private String recipeContent; // 글 내용
	private byte[] standardRecipeImage; // 이미지업로드
	private String nickname; // 닉네임
	private int commentCount;  // 댓글 수
	private int viewCount; //게시글 조회수
}
