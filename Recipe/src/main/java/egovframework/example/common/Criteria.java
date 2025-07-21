package egovframework.example.common;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author : GGG
 * @fileName : Criteria
 * @since : 2024-04-02 description : 
 *      공통 클래스 
 *      페이징처리 목적
 *      전자정부 프레임워크에서 가져옴
 *      일부 수정
 */
@Getter
@Setter
@ToString
public class Criteria {
	/** 검색조건 종류 (ex: 제목, 작성자) */
	private String searchCondition = "";

	/** 검색 키워드 */
	private String searchKeyword = "";

	/** 검색 사용 여부 (현재 사용 안 함) */
	private String searchUseYn = "";
	
	private String category;    // ← 추가(카테고리용)

	
	/** 현재페이지 */
	private int pageIndex = 1;

	/** 페이지갯수: 화면에 보일 행 개수 */
	private int pageUnit = 12;
	
	/** 페이지갯수: 화면에 보일 행 개수 */
	private int pageUnit10 = 10;

	/** OFFSET 계산용 시작 인덱스 */
	private int firstIndex = 1;

	/** 등록 시간 (필요시) */
	private String insertTime;

	/** 수정 시간 (필요시) */
	private String updateTime;

	/** 정렬 옵션: recent, likes, reviewed */
	private String sortOption = "recent";
	
	// 필터링
	private Integer filterCountryCategoryId;  /** 나라별 필터링 */
	private Integer filterIngredientCategoryId; // 재료별 필터링
	private Integer filterSituationCategoryId; // 상황별 필터링
	
	
	private int mediaCategory;
	
	public int getMediaCategory() {
		return mediaCategory;
	}
	
	public void setMediaCategory(int mediaCategory) {
		this.mediaCategory=mediaCategory;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		// TODO Auto-generated method stub
		 this.pageUnit = recordCountPerPage;
	}

	private String userId;
	
	
	private int startRow;
	private int endRow;

	public int getStartRow() {
	    return (pageIndex-1)*pageUnit;
	}
	public int getEndRow() {
	    return pageIndex * pageUnit;
	}


public void setStartRow(int startRow) {
    this.startRow = startRow;
}


public void setEndRow(int endRow) {
    this.endRow = endRow;
}
}
