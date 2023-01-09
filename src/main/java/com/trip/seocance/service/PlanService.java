package com.trip.seocance.service;

import com.trip.seocance.domain.Plan;
import com.trip.seocance.dto.PlanDTO;
import com.trip.seocance.dto.PlannerDTO;

import java.util.List;

/*
 * 플랜 Service
 *
 * @Author 문수빈
 * @Date 2023/01/09
 */
public interface PlanService {
    List<PlanDTO> selectPlans(PlannerDTO planner);
    List<PlanDTO> joinPlans(List<PlannerDTO> planners);
    List<PlanDTO> selectPlan(Long plannerNo);
    void deletePlans(Long plannerNo);

    default PlanDTO entityToDto(Plan plan) {
        PlanDTO dto = PlanDTO.builder()
                .planNo(plan.getPlanNo())
                .planner(plan.getPlanner())
                .name(plan.getName())
                .intro(plan.getIntro())
                .day(plan.getDay())
                .x(plan.getX())
                .y(plan.getY())
                .build();
        return dto;
    }

    default Plan dtoToEntity(PlanDTO dto) {
        Plan plan = Plan.builder()
                .planNo(dto.getPlanNo())
                .planner(dto.getPlanner())
                .name(dto.getName())
                .intro(dto.getIntro())
                .day(dto.getDay())
                .x(dto.getX())
                .y(dto.getY())
                .build();

        return plan;
    }
}
