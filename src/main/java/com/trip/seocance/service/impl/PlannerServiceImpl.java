package com.trip.seocance.service.impl;

import com.trip.seocance.domain.Planner;
import com.trip.seocance.dto.PlannerDTO;
import com.trip.seocance.repository.PlannerRepository;
import com.trip.seocance.service.PlannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

/*
 * 플래너 Service 구현 클래스
 *
 * @Author 문수빈
 * @Date 2023/01/10
 */
@Service
public class PlannerServiceImpl implements PlannerService {

    @Autowired
    private PlannerRepository repository;

    //추가된 코드
    public Planner insertPlanner(Planner planner) {
        Planner savedPlanner = repository.save(planner);
        return savedPlanner;
    }

    @Override
    public PlannerDTO insertPlanner(PlannerDTO dto) throws ParseException {
        Planner entity = dtoToEntity(dto);
        Planner planner = repository.save(entity);
        PlannerDTO plannerDTO = entityToDto(planner);
        return plannerDTO;
    }

    @Override
    public List<PlannerDTO> selectPlanners(String id) {
        List<Planner> planners = repository.findAllByMemberIdOrderByPlannerNoDesc(id);
        List<PlannerDTO> dto = new ArrayList<PlannerDTO>();
        for(Planner planner : planners) {
            dto.add(entityToDto(planner));
        }
        return dto;
    }

    @Override
    public PlannerDTO selectPlanner(Long plannerNo) {
        Planner planner = repository.findByPlannerNo(plannerNo);
        PlannerDTO dto = entityToDto(planner);
        return dto;
    }

    @Override
    public void deletePlanner(Long plannerNo) {
        repository.deleteByPlannerNo(plannerNo);
    }
}
