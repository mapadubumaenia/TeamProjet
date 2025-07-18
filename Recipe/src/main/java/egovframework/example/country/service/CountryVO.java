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
	private Integer countryCategoryId; // 나라별
	private Integer ingredientCategoryId; // 재료별
	private Integer situationCategoryId; // 상황별
	private String standardRecipeImageUrl; // 이미지
	private String recipeCreatedAt; // 작성일자
	private int likeCount; // 좋아요
	private String recipeContent; // 글 내용
	private byte[] standardRecipeImage; // 이미지업로드
	private String nickname; // 닉네임
	private int commentCount;  // 댓글 수
	private int viewCount; //게시글 조회수
	private String ingredient; //재료 소개
	private String recipeIntro; //레시피 소개
	private int id;
	private String name;

	
	
	public CountryVO(String userId, String recipeTitle, Integer countryCategoryId, Integer ingredientCategoryId,
			Integer situationCategoryId, String recipeContent, byte[] standardRecipeImage, String nickname,
			String ingredient, String recipeIntro) {
		super();
		this.userId = userId;
		this.recipeTitle = recipeTitle;
		this.countryCategoryId = countryCategoryId;
		this.ingredientCategoryId = ingredientCategoryId;
		this.situationCategoryId = situationCategoryId;
		this.recipeContent = recipeContent;
		this.standardRecipeImage = standardRecipeImage;
		this.nickname = nickname;
		this.ingredient = ingredient;
		this.recipeIntro = recipeIntro;
	}


	public CountryVO(String uuid, String userId, String recipeTitle, Integer countryCategoryId,
			Integer ingredientCategoryId, Integer situationCategoryId, String recipeContent, byte[] standardRecipeImage,
			String nickname, String ingredient, String recipeIntro) {
		super();
		this.uuid = uuid;
		this.userId = userId;
		this.recipeTitle = recipeTitle;
		this.countryCategoryId = countryCategoryId;
		this.ingredientCategoryId = ingredientCategoryId;
		this.situationCategoryId = situationCategoryId;
		this.recipeContent = recipeContent;
		this.standardRecipeImage = standardRecipeImage;
		this.nickname = nickname;
		this.ingredient = ingredient;
		this.recipeIntro = recipeIntro;
	}
	
}
