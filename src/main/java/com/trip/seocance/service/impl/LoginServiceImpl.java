package com.trip.seocance.service.impl;

import com.trip.seocance.domain.Member;
import com.trip.seocance.dto.MemberDTO;
import com.trip.seocance.repository.LoginRepository;
import com.trip.seocance.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

/*
 * 로그인 Service 구현 클래스
 *
 * @Author 문수빈
 * @Date 2023/01/09
 */

@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private LoginRepository repository;

    @Override
    public MemberDTO login(MemberDTO dto) {
        Optional<Member> result = repository.findByIdAndPassword(dto.getId(), dto.getPassword());
        return result.isPresent() ? entityToDto(result.get()) : null;
    }

}
