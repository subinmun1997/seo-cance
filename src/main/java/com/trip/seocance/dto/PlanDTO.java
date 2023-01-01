package com.trip.seocance.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.trip.seocance.domain.Planner;
import lombok.*;

import java.util.Date;
import java.util.List;

/*
 * 플랜 DTO
 *
 * @Author 문수빈
 * @Date 2023/01/01
 */

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PlanDTO {

    private Long planNo;
    private Planner planner;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm")
    private Date day;
    private String name;
    private String intro;
    private Float x;
    private Float y;

    private List<PlanDTO> planList;
}
