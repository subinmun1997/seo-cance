package com.trip.seocance.service.impl;


import com.trip.seocance.domain.Area;
import com.trip.seocance.dto.AreaDTO;
import com.trip.seocance.repository.AreaRepository;
import com.trip.seocance.service.AreaService;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

/*
 * 지역게시판 Service
 *
 * @Author 문수빈
 * @Date 2023/01/09
 */

@Service
public class AreaServiceImpl implements AreaService {

    @Autowired
    private AreaRepository repository;
    @Autowired
    private ModelMapper modelMapper;

    @Override
    public AreaDTO getArea(String name) {
        Area area = repository.findFirstByName(name);
        return entityToDto(area);
    }

    @Override
    public Page<AreaDTO> getAreaPage(AreaDTO dto, Pageable pageable) {
        Page<AreaDTO> areaPage;

        if (dto.getSearchKeyword() == null) {
            areaPage = getAreaPageBySigunguOrContentType(dto, pageable);
        } else {
            areaPage = getAreaPageBySearch(dto, pageable);
        }
        return areaPage;
    }

    public Page<AreaDTO> getAreaPageBySigunguOrContentType(AreaDTO dto, Pageable pageable) {
        Page<Area> areaPage;

        if (dto.getContentType() == null) {
            areaPage = repository.findBySigungu(dto.getSigungu(), pageable);
        } else {
            areaPage = repository.findBySigunguAndContentType(dto.getSigungu(), dto.getContentType(), pageable);
        }
        return entityPageToDtoPage(areaPage);
    }

    public Page<AreaDTO> getAreaPageBySearch(AreaDTO dto, Pageable pageable) {
        Page<Area> areaPage = repository.findBySigunguAndNameContaining(dto.getSigungu(), dto.getSearchKeyword(), pageable);
        return entityPageToDtoPage(areaPage);
    }

    public Area dtoToEntity(AreaDTO dto) {
        return modelMapper.map(dto, Area.class);
    }

    public AreaDTO entityToDto(Area area) {
        return modelMapper.map(area, AreaDTO.class);
    }

    public Page<AreaDTO> entityPageToDtoPage(Page<Area> areaPage) {
        return modelMapper.map(areaPage, new TypeToken<Page<AreaDTO>>(){}.getType());
    }
}
