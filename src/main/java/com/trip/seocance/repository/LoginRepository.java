package com.trip.seocance.repository;

import com.trip.seocance.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/*
 * 로그인, 로그아웃 관련 Repository
 *
 * @Author 문수빈
 * @Date 2023/01/01
 */

@Repository
public interface LoginRepository extends JpaRepository<Member, String> {
    Optional<Member> findByIdAndPassword(String id, String password);
}
