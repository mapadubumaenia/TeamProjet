package egovframework.example.search.service;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

import egovframework.example.common.Criteria;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SearchVO extends Criteria {
    private String uuid;
    private String title;
    private String type;       
    private Date createdAt;
    private String nickname;
    private int likeCount;

    // 이미지 데이터
    private byte[] image;
}
