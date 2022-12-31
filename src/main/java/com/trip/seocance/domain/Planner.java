package com.trip.seocance.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;

import javax.persistence.*;
import java.util.Date;

/*
 * 플래너 Entity
 *
 * @Author 문수빈
 * @Date 2022/12/31
 */

@Entity
@Table(name = "PLANNER_TBL")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@ToString
@Builder
@SequenceGenerator(name = "PLANNER_SEQ_GENERATOR", sequenceName = "PLANNER_SEQ", initialValue = 1, allocationSize = 1)
public class Planner {

    @Id
    @Column(name = "planner_no", nullable = false)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PLANNER_SEQ_GENERATOR")
    private Long plannerNo;

    @ManyToOne
    @JoinColumn(name = "ID")
    private Member member;

    @Column(nullable = false)
    private String title;

    @Column(name = "f_date", nullable = false)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date fDate;

    @Column(name = "l_date", nullable = false)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date lDate;

    @Column(name = "intro", nullable = true)
    private String intro;

    @Column(name = "w_date")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date wDate;

    @PrePersist
    protected void prePersist() {
        wDate = new Date();
    }

    @PreUpdate
    protected void proUpdate() {
        wDate = new Date();
    }

}
