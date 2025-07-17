package egovframework.example.mypage.service;

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
public class MyInfoVO {
	private String userId;
	private String password;
	private String userName;
	private String email;
	private String phoneNum;
	private String nickname;
	private byte[] profileImage;
	private MultipartFile image;
}
