package com.trip.seocance.repository;

import com.trip.seocance.domain.Planner;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/*
 * 플래너 관련 Repository
 *
 * @Author 문수빈
 * @Date 2023/01/01
 */

@Repository
public interface PlannerRepository extends JpaRepository<Planner, Long> {
    List<Planner> findAllByMemberIdOrderByPlannerNoDesc(String id);
    Planner findByPlannerNo(Long plannerNo);
    @Transactional
    void deleteByPlannerNo(Long plannerNo);
}
