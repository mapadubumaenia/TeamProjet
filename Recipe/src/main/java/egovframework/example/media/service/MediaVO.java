/**
 * 
 */
package egovframework.example.media.service;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import egovframework.example.common.Criteria;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @author user UUID VARCHAR2(255 BYTE) USER_ID VARCHAR2(50 BYTE) TITLE
 *         VARCHAR2(100 BYTE) MEDIA_CATEGORY NUMBER RECIPE_IMAGE_URL
 *         VARCHAR2(255 BYTE) RECIPE_CREATED_AT DATE LIKE_COUNT NUMBER CONTENT
 *         VARCHAR2(4000 BYTE) RECIPE_IMAGE BLOB INGREDIENT VARCHAR2(500 BYTE)
 */
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MediaVO extends Criteria {
	private String uuid;
	private String userId;
	private String title;
	private int mediaCategory;
	private String recipeImageUrl;
	private Date recipeCreatedAt;
	private int likeCount;
	private String content;
	private byte[] recipeImage; // BLOB 타입은 byte[] 또는 다른 적절 타입
	private String ingredient;
	private MultipartFile image; // 내부 사용(이미지파일)

// 필드 6개
	public MediaVO(String title, String content, String ingredient, int mediaCategory, byte[] recipeImage) {
			super();
			this.title = title;
			this.content = content;
			this.ingredient = ingredient;
			this.mediaCategory = mediaCategory;
			this.recipeImage = recipeImage;
		}

// 필드 
	public MediaVO(String uuid, String title, String content, byte[] recipeImage) {
			super();
			this.uuid = uuid;
			this.title = title;
			this.content = content;
			this.recipeImage = recipeImage;
		}

	public MediaVO(String userId, String title, int mediaCategory, String content, byte[] recipeImage,
			String ingredient) {
		super();
		this.userId = userId;
		this.title = title;
		this.mediaCategory = mediaCategory;
		this.content = content;
		this.recipeImage = recipeImage;
		this.ingredient = ingredient;
	}
	
	

}
