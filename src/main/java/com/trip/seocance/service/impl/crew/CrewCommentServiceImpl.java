package com.trip.seocance.service.impl.crew;

import com.trip.seocance.domain.crew.CrewComment;
import com.trip.seocance.dto.crew.CrewCommentDTO;
import com.trip.seocance.repository.crew.CrewCommentRepository;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CrewCommentServiceImpl {

    @Autowired
    CrewCommentRepository repository;

    @Autowired
    ModelMapper modelMapper;

    public List<CrewCommentDTO> getComments(Long postNo) {
        List<CrewComment> commentEntity = repository.findAllByCrewPost_PostNo(postNo);
        List<CrewCommentDTO> comments = modelMapper.map(commentEntity, new TypeToken<List<CrewCommentDTO>>() {
        }.getType());

        return comments;
    }

    @Transactional
    public CrewComment insertComment(CrewCommentDTO dto) {
        dto.setWDate(LocalDateTime.now());
        CrewComment comment = modelMapper.map(dto, CrewComment.class);
        //크루 포인트 5증가
        return repository.save(comment);
    }

    @Transactional
    public void updateComment(Long commentNo, CrewCommentDTO dto) {
        CrewComment comment = repository.findByCommentNo(commentNo);
        comment.setWDate(LocalDateTime.now());
        comment.setContent(dto.getContent());
    }

    public void deleteComment(Long commentNo) {
        repository.deleteById(commentNo);
    }
}
