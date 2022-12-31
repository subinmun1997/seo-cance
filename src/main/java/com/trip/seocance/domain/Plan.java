package com.trip.seocance.domain;

/*
 * 플랜 Entity
 *
 * @Author 문수빈
 * @Date 2022/12/31
 */

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "PLAN_TBL")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@ToString
@Builder
@SequenceGenerator(name = "PLAN_SEQ_GENERATOR", sequenceName = "PLAN_SEQ", initialValue = 1, allocationSize = 1)
public class Plan {

    @Id
    @Column(name = "plan_no", nullable = false)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PLAN_SEQ_GENERATOR")
    private Long planNo;

    @ManyToOne
    @JoinColumn(name = "planner_no")
    private Planner planner;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @Column(nullable = false)
    private Date day;

    @Column(nullable = false)
    private String name;

    private String intro;

    @Column(nullable = false)
    private Float x;

    @Column(nullable = false)
    private Float y;
}
