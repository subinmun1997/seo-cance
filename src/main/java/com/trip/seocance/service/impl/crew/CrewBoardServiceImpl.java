package com.trip.seocance.service.impl.crew;

import com.trip.seocance.domain.Member;
import com.trip.seocance.domain.crew.Crew;
import com.trip.seocance.domain.crew.CrewPost;
import com.trip.seocance.dto.crew.CrewPostDTO;
import com.trip.seocance.repository.crew.CrewBoardRepository;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CrewBoardServiceImpl {

    @Autowired
    CrewBoardRepository repository;

    @Autowired
    ModelMapper modelMapper;

    //크루 활동 게시글 전체
    public Page<CrewPostDTO> getCrewPosts(Pageable pageable) {
        Page<CrewPost> crewPostsEntity = repository.findAll(pageable);
        Page<CrewPostDTO> crewPosts = modelMapper.map(crewPostsEntity, new TypeToken<Page<CrewPostDTO>>() {}.getType());

        return crewPosts;
    }

    //크루 활동 게시글 카테고리 조회
    public Page<CrewPostDTO> getCrewPostsByCat(String category, Pageable pageable) {
        Page<CrewPost> crewPostsEntity = repository.findAllByCategory(category, pageable);
        Page<CrewPostDTO> crewPosts = modelMapper.map(crewPostsEntity, new TypeToken<Page<CrewPostDTO>>() {}.getType());

        return crewPosts;
    }

    //크루 게시글 조회
    @Transactional
    public CrewPostDTO getCrewPost(Long postNo) {
        CrewPost crewPostEntity = repository.findByPostNo(postNo);
        increaseHit(crewPostEntity);
        //크루 포인트 1증가

        CrewPostDTO dto = modelMapper.map(crewPostEntity, CrewPostDTO.class);
        return dto;
    }

    public void increaseHit(CrewPost post) {
        post.setHit(post.getHit() + 1);
    }

    //크루 게시글 등록
    @Transactional
    public CrewPostDTO insertPost(CrewPostDTO dto, Crew crew, Member member, String memberList) {
        dto.setHit(1);
        dto.setWDate(LocalDateTime.now());
        dto.setCrew(crew);
        dto.setMember(member);
        dto.setMemberList(memberList);

        CrewPost crewPostEntity = modelMapper.map(dto, CrewPost.class);
        //크루 포인트 10 증가

        CrewPost post = repository.save(crewPostEntity);
        return modelMapper.map(post, CrewPostDTO.class);
    }

    //인기 크루 게시글 조회
    public List<CrewPostDTO> getPopularPosts() {
        List<CrewPost> posts = repository.findTop5ByOrderByHitDesc();
        List<CrewPostDTO> postDTOS = modelMapper.map(posts, new TypeToken<List<CrewPostDTO>>(){}.getType());

        return postDTOS;
    }

    public void deletePost(Long postNo) {
        repository.deleteById(postNo);
        System.out.println(postNo + "번 게시글 삭제");
    }

    @Transactional
    public void updatePost(Long postNo, CrewPostDTO dto) {
        CrewPost post = repository.findByPostNo(postNo);
        post.setTitle(dto.getTitle());
        post.setContent(dto.getContent());
        post.setUploadImg(dto.getUploadImg());
        post.setCategory(dto.getCategory());
        //멤버 변경사항
    }
}