package com.trip.seocance.service.impl;

import com.trip.seocance.domain.Plan;
import com.trip.seocance.domain.Planner;
import com.trip.seocance.dto.PlanDTO;
import com.trip.seocance.dto.PlannerDTO;
import com.trip.seocance.repository.PlanRepository;
import com.trip.seocance.service.PlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/*
 * 플랜 Service 구현 클래스
 *
 * @Author 문수빈
 * @Date 2023/01/09
 */
@Service
public class PlanServiceImpl implements PlanService {

    @Autowired
    private PlanRepository repository;

    //사용자가 작성한 플랜들을 DB에 저장하는 메소드
    public List<Plan> insertPlan(List<PlanDTO> planDTOS, Planner planner) {
        List<Plan> plans = new ArrayList<>();

        for(PlanDTO dto : planDTOS) {
            dto.setPlanner(planner);
            Plan plan = repository.save(dtoToEntity(dto));
            if (plan == null) {
                return null;
            }
            plans.add(plan);
        }
        return plans;
    }

    //플래너의 첫번째 날짜 일정들을 반환하는 메소드 (planList.jsp로 이동시 사용)
    @Override
    public List<PlanDTO> selectPlans(PlannerDTO planner) {
        Date now = planner.getFDate();
        Date start = planner.getFDate();
        Date last = new Date(now.getYear(), now.getMonth(), now.getDate(), 23, 59, 59);

        List<Plan> result = repository.findAllByPlannerPlannerNoAndDayBetweenOrderByPlanNo(planner.getPlannerNo(), start, last);
        List<PlanDTO> dto = new ArrayList<PlanDTO>();
        for(Plan plan : result) {
            dto.add(entityToDto(plan));
        }
        return dto;
    }

    //사용자가 작성한 각 플래너마다 플랜들을 구한 후 join하여 1개의 List 타입으로 반환하는 메소드
    @Override
    public List<PlanDTO> joinPlans(List<PlannerDTO> planners) {
        List<PlanDTO> allPlans = new ArrayList<PlanDTO>();
        for(int i=0;i<planners.size();i++) {
            List<PlanDTO> plans = selectPlans(planners.get(i));
            allPlans.addAll(plans);
        }
        return allPlans;
    }

    //플래너 번호에 따른 플랜들을 List 타입으로 반환하는 메소드
    @Override
    public List<PlanDTO> selectPlan(Long plannerNo) {
        List<Plan> plans = repository.findAllByPlannerPlannerNoOrderByPlanNo(plannerNo);
        List<PlanDTO> planDTOS = new ArrayList<PlanDTO>();
        for(Plan plan : plans) {
            planDTOS.add(entityToDto(plan));
        }
        return planDTOS;
    }

    @Override
    public void deletePlans(Long plannerNo) {
        repository.deleteAllByPlannerPlannerNo(plannerNo);
    }

    //사용자가 수정한 플랜들을 DB에 반영 (저장, 수정, 삭제)
    public List<Plan> updatePlans(List<PlanDTO> updatePlans, Planner planner) {
        List<PlanDTO> origin_plans = selectPlan(planner.getPlannerNo());

        //사용자가 삭제한 플랜들 DB에서 삭제
        for(PlanDTO oldPlan : origin_plans) {
            boolean isContained = false;

            for(PlanDTO newPlan : updatePlans) {
                if(oldPlan.getPlanNo() == newPlan.getPlanNo()) {
                    isContained = true;
                    break;
                }
            }

            if(isContained == false) {
                repository.deleteByPlanNo(oldPlan.getPlanNo());
            }
        }

        //수정된 플랜들 DB 반영
        List<Plan> plans = insertPlan(updatePlans, planner);
        return plans;
    }

    public int getDiffDayCount(Date fromDate, Date toDate) {
        return (int)((toDate.getTime() - fromDate.getTime()) / 1000 / 60 / 60 / 24);
    }

    public List<Date> getDiffDays(Date fromDate, Date toDate) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(fromDate);
        int count = getDiffDayCount(fromDate, toDate);
        //시작일 부터
        cal.add(Calendar.DATE, -1);
        //데이터 저장
        List result = new ArrayList();
        for(int i=0;i<=count;i++) {
            cal.add(Calendar.DATE, 1);
            result.add(cal.getTime());
        }
        return result;
    }
}
