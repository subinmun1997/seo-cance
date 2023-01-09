package com.trip.seocance.security;

import com.trip.seocance.dto.MemberDTO;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;

/*
 * 사용자 정보를 담아두는 클래스
 *
 * @Author 문수빈
 * @Date 2023/01/09
 */
@Data
public class SecurityDetails implements UserDetails {

    private MemberDTO memberDTO;

    public SecurityDetails(MemberDTO memberDTO) {
        super();
        this.memberDTO = memberDTO;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> authList = new ArrayList<>();
        authList.add(new SimpleGrantedAuthority(memberDTO.getCrleader().toString()));
        return authList;
    }

    @Override
    public String getPassword() {
        return memberDTO.getPassword();
    }

    @Override
    public String getUsername() {
        return memberDTO.getId();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    public MemberDTO getMemberDTO() {
        return memberDTO;
    }
}
