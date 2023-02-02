package com.trip.seocance.dto.review;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.trip.seocance.domain.Member;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;

/*
 * 후기게시판 DTO
 *
 * @Author 문수빈
 * @Date 2023/01/01
 */

@Getter
@Setter
@ToString
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ReviewDTO {

    private Long reviewNo;
    private Member member;
    private String title;
    private String content;
    private String courseImgName;
    private String uploadImgNames;
    private LocalDateTime wDate;
    private int hit;
    private int areaNo;

    //DTO Only
    private MultipartFile courseImgFile;
    private String[] uploadImgs;
}
