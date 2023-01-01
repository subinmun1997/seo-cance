package com.trip.seocance.dto.crew;

import com.trip.seocance.domain.Member;
import com.trip.seocance.domain.crew.Crew;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

/*
 * 크루활동 게시판 DTO
 *
 * @Author 문수빈
 * @Date 2023/01/01
 */

@Getter
@Setter
@ToString
public class CrewPostDTO {

    private Long postNo;
    private Crew crew;
    private Member member;
    private String category;
    private String title;
    private String content;
    private String memberList;
    private String uploadImg;
    private LocalDateTime wDate;
    private Integer hit;
}
