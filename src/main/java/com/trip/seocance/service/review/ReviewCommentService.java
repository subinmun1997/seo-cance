package com.trip.seocance.service.review;

import com.trip.seocance.dto.review.ReviewCommentDTO;

import java.util.List;

public interface ReviewCommentService {
    List<ReviewCommentDTO> getCommentList(Long reviewNo);
    void insertComment(ReviewCommentDTO dto);
    void updateComment(ReviewCommentDTO dto);
    void deleteComment(Long commentNo);

}
