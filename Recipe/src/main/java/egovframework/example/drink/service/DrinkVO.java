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

	
	
	private int column_id;
	private String user_id;
	private String column_title;
	private String column_content;
	private String column_category;
	private String column_created_at;
	private MultipartFile image;        //내부 목적 사용
	private String column_url;
	
	
	
	public DrinkVO(int column_id, String user_id, String column_title, String column_content, String column_category) {
		super();
		this.column_id = column_id;
		this.user_id = user_id;
		this.column_title = column_title;
		this.column_content = column_content;
		this.column_category = column_category;
	}
	
	
	
	
	
	
	
	
	
	}
	
	
	
	
	
	
	
	
	
	
//	COLUMN_ID	NUMBER
//	USER_ID	VARCHAR2(50 BYTE)
//	COLUMN_TITLE	VARCHAR2(150 BYTE)
//	COLUMN_CONTENT	CLOB
//	COLUMN_CATEGORY	VARCHAR2(20 BYTE)
//	COLUMN_CREATED_AT	DATE
	
	
	
	
	
	
	
	
	
	
	

