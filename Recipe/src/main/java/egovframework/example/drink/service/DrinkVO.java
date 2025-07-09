package egovframework.example.drink.service;

import org.springframework.web.multipart.MultipartFile;

import egovframework.example.common.Criteria;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;



@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class DrinkVO extends Criteria{

	
	

	private String uuid;                 //기본키
	private String userId;               // 아이디
	private String columnTitle;            //제목
	private String columnContent;          //내용
	private byte[] columnData;         //첨부파일
	private String columnCreatedAt;        //날짜
	private MultipartFile image;        //내부 목적 사용
	private String columnUrl;             //이미지 다운로드를 위한 URL
	 private String category;            // 카테고리
	 private String columnIngredient;            // 재료 
	 private String userNickname;                //별명
	
	

	
	 public String getCategory() { return category; }
	 public void setCategory(String category) { this.category = category; }





	

	public DrinkVO(String columnTitle, String columnContent,  String category,
			String columnIngredient ,byte[] columnData) {
		super();
		this.columnTitle = columnTitle;
		this.columnContent = columnContent;
		this.category = category;
		this.columnIngredient = columnIngredient;
		this.columnData = columnData;
	}
	
	
	

	
	
	


	


	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	}
	
	
	
	
	
	
	
	
	
	
//	COLUMN_ID	NUMBER
//	USER_ID	VARCHAR2(50 BYTE)
//	COLUMN_TITLE	VARCHAR2(150 BYTE)
//	COLUMN_CONTENT	CLOB
//	COLUMN_CATEGORY	VARCHAR2(20 BYTE)
//	COLUMN_CREATED_AT	DATE
	
	
	
	
	
	
	
	
	
	
	

