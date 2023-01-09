package com.trip.seocance.service;

/*
 * 플래너 service
 *
 * @Author 문수빈
 * @Date 2023/01/09
 */

import com.trip.seocance.domain.Planner;
import com.trip.seocance.dto.PlannerDTO;

import java.text.ParseException;
import java.util.List;

public interface PlannerService {

    PlannerDTO insertPlanner(PlannerDTO dto) throws ParseException;
    List<PlannerDTO> selectPlanners(String id);
    PlannerDTO selectPlanner(Long plannerNo);
    void deletePlanner(Long plannerNo);

    default Planner dtoToEntity(PlannerDTO dto) throws ParseException {
        Planner entity = Planner.builder()
                .plannerNo(dto.getPlannerNo())
                .member(dto.getMember())
                .title(dto.getTitle())
                .fDate(dto.getFDate())
                .lDate(dto.getLDate())
                .intro(dto.getIntro())
                .wDate(dto.getWDate())
                .build();

        return entity;
    }

    default PlannerDTO entityToDto(Planner planner) {
        PlannerDTO dto = PlannerDTO.builder()
                .plannerNo(planner.getPlannerNo())
                .member(planner.getMember())
                .title(planner.getTitle())
                .intro(planner.getIntro())
                .fDate(planner.getFDate())
                .lDate(planner.getLDate())
                .wDate(planner.getWDate())
                .build();
        return dto;
    }
}
