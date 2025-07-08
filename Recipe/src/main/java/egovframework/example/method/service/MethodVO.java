package egovframework.example.method.service;

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

public class MethodVO extends Criteria{

	
	private String uuid;                  //기본키
	private String userId;               // 아이디
	private String methodType;           //보관/손질 타입
	private String methodTitle;                 //제목
	private String methodContent;                //내용
	private MultipartFile image;        //내부 목적 사용
	private byte[] methodData;         //첨부파일
	private String methodUrl;             //이미지 다운로드를 위한 URL
	private String category;            // 카테고리
	private String methodCreatedAt;        //날짜
	
	
//	카테고리 위한 메소드
	 public String getCategory() { return category; }
	 public void setCategory(String category) { this.category = category; }
	 
	 
	 
	public MethodVO(String methodTitle, String methodContent, String methodUrl, String category) {
		super();
		this.methodTitle = methodTitle;
		this.methodContent = methodContent;
		this.methodUrl = methodUrl;
		this.category = category;
	}
	
	
	public MethodVO(String methodTitle, String methodContent,  String category,byte[] methodData) {
		super();
		this.methodTitle = methodTitle;
		this.methodContent = methodContent;
		this.category = category;
		this.methodData = methodData;
	}
	
	 
	
	
	
	

	
	 
	

	
	
	
	
	
	
	
	
	
}
