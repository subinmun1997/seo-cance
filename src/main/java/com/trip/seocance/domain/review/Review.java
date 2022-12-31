package com.trip.seocance.domain.review;


/*
 * 후기게시판 Entity
 *
 * @Author 문수빈
 * @Date 2022/12/31
 */

import com.trip.seocance.domain.Member;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;


@Entity
@Table(name = "REVIEW_BOARD_TBL")
@Getter
@NoArgsConstructor
@SequenceGenerator(name = "REVIEW_BOARD_SEQ_GEN", sequenceName = "REVIEW_BOARD_SEQ", allocationSize = 1)
@Setter
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "REVIEW_BOARD_SEQ_GEN")
    @Column(name = "REVIEW_NO")
    private Long reviewNo;

    @ManyToOne
    @JoinColumn(name = "ID")
    private Member member;

    private String title;
    private String content;

    @Column(name = "COURSE_IMG")
    private String courseImgName;

    @Column(name = "UPLOAD_IMG")
    private String uploadImgNames;

    @Column(name = "W_DATE")
    private LocalDateTime wDate;

    private int hit;

    @Column(name = "AREA_NO")
    private int areaNo;
}
