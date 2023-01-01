package com.trip.seocance.repository;

import com.trip.seocance.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

/*
 * 멤버 관련 Repository
 *
 * @Author 문수빈
 * @Date 2023/01/01
 */

@Repository
public interface MemberRepository extends JpaRepository<Member, String> {
    Optional<Member> findByNickName(String nickname);
    Optional<Member> findById(String id);
    @Transactional
    void deleteById(String id);

    Member findOneById(String id);
}
