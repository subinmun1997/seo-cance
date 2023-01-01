package com.trip.seocance.dto.review;

import com.trip.seocance.domain.Member;
import com.trip.seocance.domain.review.Review;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
public class ReviewCommentDTO {

    private Long commentNo;
    private Review review;
    private Member member;
    private String content;
    private LocalDateTime wDate;
}
