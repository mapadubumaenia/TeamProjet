package egovframework.example.mypage.service;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

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
public class MyPostVO {
	private String uuid;
	private String userId;
	private String title;
	private int count;
	private int likeCount;
	
	private byte[] mainImage;
	private MultipartFile image;
	private Date createdAt;  
	private String imageUrl;
	
	public String contentType;


}
