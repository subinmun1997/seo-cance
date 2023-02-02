package com.trip.seocance.service.impl.review;

import com.trip.seocance.domain.Member;
import com.trip.seocance.domain.review.Review;
import com.trip.seocance.domain.review.ReviewComment;
import com.trip.seocance.dto.review.ReviewCommentDTO;
import com.trip.seocance.repository.MemberRepository;
import com.trip.seocance.repository.review.ReviewCommentRepository;
import com.trip.seocance.repository.review.ReviewRepository;
import com.trip.seocance.service.review.ReviewCommentService;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ReviewCommentServiceImpl implements ReviewCommentService {

    @Autowired
    ReviewCommentRepository reviewCommentRepository;
    @Autowired
    ReviewRepository reviewRepository;
    @Autowired
    MemberRepository memberRepository;
    @Autowired
    ModelMapper modelMapper;

    @Override
    public List<ReviewCommentDTO> getCommentList(Long reviewNo) {
        List<ReviewComment> commentEntity = reviewCommentRepository.findAllByReview_ReviewNo(reviewNo);
        return entityListToDtoList(commentEntity);
    }

    @Override
    public void insertComment(ReviewCommentDTO dto) {
        setWDate(dto);
        setReview(dto);
        setMember(dto);
        ReviewComment comment = dtoToEntity(dto);
        reviewCommentRepository.save(comment);
    }

    public void setWDate(ReviewCommentDTO dto) {
        dto.setWDate(LocalDateTime.now());
    }

    public void setReview(ReviewCommentDTO dto) {
        Review review = reviewRepository.findByReviewNo(dto.getReview().getReviewNo());
        dto.setReview(review);
    }

    public void setMember(ReviewCommentDTO dto) {
        Member member = memberRepository.findOneById(dto.getMember().getId());
        dto.setMember(member);
    }

    @Override
    @Transactional
    public void updateComment(ReviewCommentDTO dto) {
        ReviewComment comment = reviewCommentRepository.findByCommentNo(dto.getCommentNo());
        comment.setWDate(LocalDateTime.now());
        comment.setContent(dto.getContent());
    }

    @Override
    public void deleteComment(Long commentNo) {
        reviewCommentRepository.deleteById(commentNo);
    }

    public ReviewComment dtoToEntity(ReviewCommentDTO dto) {
        return modelMapper.map(dto, ReviewComment.class);
    }

    public ReviewCommentDTO entityToDto(ReviewComment comment) {
        return modelMapper.map(comment, ReviewCommentDTO.class);
    }

    public List<ReviewCommentDTO> entityListToDtoList(List<ReviewComment> commentList) {
        return modelMapper.map(commentList, new TypeToken<List<ReviewCommentDTO>>() {
        }.getType());
    }
}
