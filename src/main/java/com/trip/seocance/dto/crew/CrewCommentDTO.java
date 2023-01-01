package com.trip.seocance.dto.crew;

import com.trip.seocance.domain.Member;
import com.trip.seocance.domain.crew.CrewPost;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
public class CrewCommentDTO {

    private Long commentNo;
    private CrewPost crewPost;
    private Member member;
    private String content;
    private LocalDateTime wDate;
}
