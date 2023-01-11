package com.trip.seocance.service.impl;

import com.trip.seocance.domain.Member;
import com.trip.seocance.domain.Plan;
import com.trip.seocance.domain.crew.Crew;
import com.trip.seocance.domain.crew.CrewComment;
import com.trip.seocance.domain.crew.CrewMember;
import com.trip.seocance.domain.crew.CrewPost;
import com.trip.seocance.domain.review.Review;
import com.trip.seocance.domain.review.ReviewComment;
import com.trip.seocance.dto.MemberDTO;
import com.trip.seocance.dto.PlanDTO;
import com.trip.seocance.dto.crew.CrewCommentDTO;
import com.trip.seocance.dto.crew.CrewDTO;
import com.trip.seocance.dto.crew.CrewMemberDTO;
import com.trip.seocance.dto.crew.CrewPostDTO;
import com.trip.seocance.dto.review.ReviewCommentDTO;
import com.trip.seocance.dto.review.ReviewDTO;
import com.trip.seocance.repository.MemberRepository;
import com.trip.seocance.repository.crew.CrewBoardRepository;
import com.trip.seocance.repository.crew.CrewCommentRepository;
import com.trip.seocance.repository.crew.CrewMemberRepository;
import com.trip.seocance.repository.crew.CrewRepository;
import com.trip.seocance.repository.review.ReviewCommentRepository;
import com.trip.seocance.repository.review.ReviewRepository;
import com.trip.seocance.security.SecurityDetails;
import com.trip.seocance.service.MemberService;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

/*
 * 멤버 Service 구현 클래스
 *
 * @Author 문수빈
 * @Date 2023/01/09
 */

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberRepository repository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private CrewRepository crewRepository;

    @Autowired
    private CrewMemberRepository crewMemberRepository;

    @Autowired
    private CrewBoardRepository crewBoardRepository;

    @Autowired
    private CrewCommentRepository crewCommentRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private ReviewCommentRepository commentRepository;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public MemberDTO save(MemberDTO memberDTO) throws IOException {
        String rawPassword = memberDTO.getPassword();
        String encPassword = bCryptPasswordEncoder.encode(rawPassword);
        memberDTO.setPassword(encPassword);

        Member member = dtoToEntity(memberDTO);
        Member validUser = repository.save(member);
        MemberDTO dto = entityToDto(validUser);
        return dto;
    }

    public MemberDTO updateMember(MemberDTO memberDTO) throws IOException {
        Member memberEntity = dtoToEntity(memberDTO);
        Member member = repository.save(memberEntity);
        MemberDTO dto = entityToDto(member);
        return dto;
    }

    @Override
    public MemberDTO selectMember(String id) {
        Optional<Member> member = repository.findById(id);
        return member.isPresent() ? entityToDto(member.get()) : null;
    }

    @Override
    public Page<ReviewDTO> getReviewListByUser(String id, Pageable pageable) {
        Page<Review> entityPage = reviewRepository.findAllByMemberId(id, pageable);
        Page<ReviewDTO> reviewList = modelMapper.map(entityPage, new TypeToken<Page<ReviewDTO>>() {}.getType());

        return reviewList;
    }

    @Override
    public int deleteMember(String id) {
        repository.deleteById(id);
        Optional<Member> result = repository.findById(id);
        return !(result.isPresent()) ? 0 : 1;
        //계정이 삭제되었다면 0, 그렇지 않다면 1
    }

    @Override
    public Page<ReviewCommentDTO> getReviewCommentListByUser(String id, Pageable pageable) {
        Page<ReviewComment> entityPage = commentRepository.findAllByMemberId(id, pageable);
        Page<ReviewCommentDTO> commentList = modelMapper.map(entityPage, new TypeToken<Page<ReviewCommentDTO>>(){}.getType());

        return commentList;
    }

    @Override
    public List<ReviewDTO> getReviewListByMember(String id) {
        List<Review> reviews = reviewRepository.findAllByMemberId(id);
        List<ReviewDTO> reviewList = modelMapper.map(reviews, new TypeToken<List<ReviewDTO>>() {}.getType());

        return reviewList;
    }

    @Override
    public void deleteCommentListByUser(String id) {
        commentRepository.deleteAllByMemberId(id);
    }

    @Override
    public void deleteCommentListByReviewNo(Long reviewNo) {
        commentRepository.deleteAllByReview_ReviewNo(reviewNo);
    }

    @Override
    public void updateMemberSecurity(MemberDTO dto, HttpSession session) {
        //세션 초기화
        SecurityContextHolder.clearContext();
        UserDetails updateUserDetails = new SecurityDetails(dto);
        Authentication newAuth = new UsernamePasswordAuthenticationToken(updateUserDetails, null, updateUserDetails.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(newAuth);
        session.setAttribute("SPRING_SECURITY_CONTEXT", newAuth);
    }

    //사용자 크루 조회 (크루장)
    @Override
    public CrewDTO getCrew(String id) {
        Crew crew = crewRepository.findByMemberId(id);
        CrewDTO dto = null;
        if (crew != null) {
            dto = modelMapper.map(crew, CrewDTO.class);
        }
        return dto;
    }

    //사용자 크루 조회 (크루원)
    @Override
    public List<CrewMemberDTO> getCrewList(String id) {
        Member member = repository.findById(id).get();
        List<CrewMember> crew = crewMemberRepository.findAllByMemberId(id);
        List<CrewMemberDTO> dto = null;
        if (crew != null) {
            dto = modelMapper.map(crew, new TypeToken<List<CrewMemberDTO>>() {}.getType());
        }
        return dto;
    }

    @Override
    public List<CrewPostDTO> getCrewPostListByMember(String id) {
        List<CrewPost> entityPage = crewBoardRepository.findAllByMemberId(id);
        List<CrewPostDTO> list = modelMapper.map(entityPage, new TypeToken<List<CrewPostDTO>>() {}.getType());
        return list;
    }

    @Override
    public Page<CrewPostDTO> getCrewPostListByUser(String id, Pageable pageable) {
        Page<CrewPost> entityPage = crewBoardRepository.findAllByMemberId(id, pageable);
        Page<CrewPostDTO> list = modelMapper.map(entityPage, new TypeToken<Page<CrewPostDTO>>() {}.getType());

        return list;
    }

    @Override
    public Page<CrewCommentDTO> getCrewCommentListByUser(String id, Pageable pageable) {
        Page<CrewComment> entityPage = crewCommentRepository.findAllByMemberId(id, pageable);
        Page<CrewCommentDTO> list = modelMapper.map(entityPage, new TypeToken<Page<CrewCommentDTO>>() {}.getType());
        return list;
    }

    @Override
    public void deleteCrewCommentListByUser(String id) {
        crewCommentRepository.deleteAllByMemberId(id);
    }

    @Override
    public void deleteCrewCommentListByPostNo(Long postNo) {
        crewCommentRepository.deleteAllByCrewPostPostNo(postNo);
    }

    @Override
    public void deleteCrewMember(String id) {
        crewMemberRepository.deleteAllByMemberId(id);
    }


    @Override
    public int checkId(String id) {
        Optional<Member> result = repository.findById(id);
        return result.isPresent() ? 0 : 1;
        //중복된 아이디가 있으면 0, 없다면 1
    }

    @Override
    public int checkNickname(String nickname) {
        Optional<Member> result = repository.findByNickName(nickname);
        return result.isPresent() ? 0 : 1;
        //중복된 닉네임이 있으면 0, 없다면 1
    }

    //MemberDTO 객체를 Member 객체로 변환해서 반환해주는 메소드
    public Member selectMemberEntity(Member entity) {
        Member member = repository.findById(entity.getId()).get();
        return member;
    }

    @Override
    public MemberDTO entityToDto(Member member) {
        return MemberService.super.entityToDto(member);
    }

    //메소드 추가
    public void setMemberToCrleader(String id, HttpSession session) {
        MemberDTO dto = selectMember(id);
        dto.setCrleader('y');
        Member member = dtoToEntity(dto);
        modelMapper.map(member, MemberDTO.class);
        updateMemberSecurity(modelMapper.map(member, MemberDTO.class), session);

        repository.save(member);
    }

}
