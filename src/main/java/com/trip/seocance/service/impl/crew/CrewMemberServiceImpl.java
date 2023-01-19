package com.trip.seocance.service.impl.crew;

import com.trip.seocance.domain.crew.CrewMember;
import com.trip.seocance.dto.crew.CrewMemberDTO;
import com.trip.seocance.repository.crew.CrewMemberRepository;
import com.trip.seocance.repository.crew.CrewRepository;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CrewMemberServiceImpl {

    @Autowired
    CrewMemberRepository crewMemberRepository;

    @Autowired
    CrewRepository crewRepository;

    @Autowired
    ModelMapper modelMapper;

    //크루원 조회
    public CrewMemberDTO getCrewMember(Long regNo) {
        CrewMember crewMember = crewMemberRepository.findByRegNo(regNo);
        CrewMemberDTO dto = modelMapper.map(crewMember, CrewMemberDTO.class);

        return dto;
    }

    //크루원 등록
    public void insertCrewMember(CrewMemberDTO dto) {
        CrewMember crewMember = modelMapper.map(dto, CrewMember.class);
        crewMemberRepository.save(crewMember);
    }

    //크루 번호로 크루 가입자 명단 조회
    public List<CrewMemberDTO> getCrewMembers(Long crewNo) {
        List<CrewMember> crewMembersEntity = crewMemberRepository.findByCrewCrewNoAndState(crewNo, true);
        List<CrewMemberDTO> crewMember = modelMapper.map(crewMembersEntity, new TypeToken<List<CrewMemberDTO>>() {
        }.getType());

        return crewMember;
    }

    //크루 번호로 크루 가입 대기자 명단 조회
    public List<CrewMemberDTO> getWatingMember(Long crewNo) {
        List<CrewMember> crewMembersEntity = crewMemberRepository.findByCrewCrewNoAndState(crewNo, false);
        List<CrewMemberDTO> WatingMember = modelMapper.map(crewMembersEntity, new TypeToken<List<CrewMemberDTO>>() {
        }.getType());

        return WatingMember;
    }

    //크루 번호, 크루원 id로 크루 가입 여부 확인
    public Boolean hasThisCrewMember(Long crewNo, String id) {
        return crewMemberRepository.existByCrewCrewNoAndMemberId(crewNo, id);
    }

    //크루 가입 승인
    @Transactional
    public void updateCrew(Long regNo) {
        CrewMember member = crewMemberRepository.findByRegNo(regNo);
        member.setState(true);
    }

    //크루 가입 거절 및 회원 강퇴
    public void deleteCrew(Long regNo) {
        crewMemberRepository.deleteById(regNo);
    }

    //회원id로 가입된 크루 명단 조회
    public List<CrewMemberDTO> getMyCrewList(String id) {
        List<CrewMember> crewMembers = crewMemberRepository.findAllByMemberId(id);
        List<CrewMemberDTO> crewMemberDTO = modelMapper.map(crewMembers, new TypeToken<List<CrewMemberDTO>>() {
        }.getType());

        return crewMemberDTO;
    }

    public int countMember(String id) {
        return crewMemberRepository.countCrewMemberByMemberId(id);
    }

    public boolean isJoinedCrew(String id) {
        return crewMemberRepository.existsByMemberId(id);
    }

    //아이디, 크루번호로 해당 크루멤버 조회
    public CrewMemberDTO getCrewMember(String id, Long crewNo) {
        CrewMember crewMemberEntity = crewMemberRepository.findByMemberIdAndCrewCrewNo(id, crewNo);
        return modelMapper.map(crewMemberEntity, CrewMemberDTO.class);
    }
}
