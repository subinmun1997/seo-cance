package com.trip.seocance.repository;

import com.trip.seocance.domain.Area;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/*
 * 지역게시판 Repository
 *
 * @Author 문수빈
 * @Date 2023/01/01
 */

@Repository
public interface AreaRepository extends JpaRepository<Area, String> {

    //지역명으로 지역정보 상세 조회
    Area findFirstByName(String name);

    //시군구코드 + 컨텐츠타입으로 지역정보 조회
    Page<Area> findBySigunguAndContentType(Integer sigungu, Integer contentType, Pageable pageable);

    //시군구코드로 지역정보 조회
    Page<Area> findBySigungu(Integer sigungu, Pageable pageable);

    //시군구코드 + 이름 검색으로 지역정보 조회
    Page<Area> findBySigunguAndNameContaining(Integer sigungu, String name, Pageable pageable);

    Page<Area> findBySigunguOrContentTypeOrNameContaining(Integer sigungu, Integer contentType, String name, Pageable pageable);
}