package com.trip.seocance.service;

import com.trip.seocance.dto.AreaDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/*
 * 지역게시판 Service
 *
 * @Author 문수빈
 * @Date 2023/01/02
 */

public interface AreaService {

    AreaDTO getArea(String name);

    Page<AreaDTO> getAreaPage(AreaDTO dto, Pageable pageable);
}
