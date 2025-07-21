package egovframework.example.main.service;

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
public class MainVO {
    private String uuid;        // 고유 식별자
    private String title;       // 레시피 제목
    private String imageUrl;    // 이미지 URL 또는 페이지 링크
    private byte[] image;       // 이미지 BLOB
    private String type;        // 구분: media, standard, column
    private int likeCount;
}
