package com.trip.seocance.repository;

import com.trip.seocance.domain.Plan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/*
 * 플랜 관련 Repository
 *
 * @Author 문수빈
 * @Date 2023/01/01
 */

public interface PlanRepository extends JpaRepository<Plan, Long> {

    List<Plan> findAllByPlannerPlannerNoAndDayBetweenOrderByPlanNo(Long plannerNo, Date start, Date end);
    List<Plan> findAllByPlannerPlannerNoOrderByPlanNo(Long plannerNo);
    @Transactional
    void deleteAllByPlannerPlannerNo(Long plannerNo);
    @Transactional
    void deleteByPlanNo(Long planNo);

}
