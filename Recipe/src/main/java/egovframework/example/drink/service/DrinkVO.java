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

	
	
	private int uuid;
	private String userId;
	private String columnTitle;
	private String columnContent;
	private String columnCategory;
	private String columnCreatedAt;
	private MultipartFile image;        //내부 목적 사용
	private String columnUrl;
	
	
	
	public DrinkVO(int uuid, String userId, String columnTitle, String columnContent, String columnCategory,
			String columnCreatedAt) {
		super();
		this.uuid = uuid;
		this.userId = userId;
		this.columnTitle = columnTitle;
		this.columnContent = columnContent;
		this.columnCategory = columnCategory;
		this.columnCreatedAt = columnCreatedAt;
	}
	
	
	

	
	
	
	
	
	
	
	
	}
	
	
	
	
	
	
	
	
	
	
//	COLUMN_ID	NUMBER
//	USER_ID	VARCHAR2(50 BYTE)
//	COLUMN_TITLE	VARCHAR2(150 BYTE)
//	COLUMN_CONTENT	CLOB
//	COLUMN_CATEGORY	VARCHAR2(20 BYTE)
//	COLUMN_CREATED_AT	DATE
	
	
	
	
	
	
	
	
	
	
	

