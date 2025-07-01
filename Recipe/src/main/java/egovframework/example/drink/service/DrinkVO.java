package egovframework.example.drink.service;

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
public class DrinkVO extends Criteria{

	
	private int COLUMN_ID;
	private String USER_ID;
	private String COLUMN_TITLE;
	private String COLUMN_CONTENT;
	private String COLUMN_CATEGORY;
	private String COLUMN_CREATED_AT;
	
	
	
	
//	COLUMN_ID	NUMBER
//	USER_ID	VARCHAR2(50 BYTE)
//	COLUMN_TITLE	VARCHAR2(150 BYTE)
//	COLUMN_CONTENT	CLOB
//	COLUMN_CATEGORY	VARCHAR2(20 BYTE)
//	COLUMN_CREATED_AT	DATE
	
	
	
	
	
}
