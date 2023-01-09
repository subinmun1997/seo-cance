package com.trip.seocance.security;

import com.trip.seocance.dto.MemberDTO;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/*
 * 로그인 성공시 실행되는 Handler
 *
 * @Author 문수빈
 * @Date 2023/01/09
 */
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
        try {
            MemberDTO dto = ((SecurityDetails)authentication.getPrincipal()).getMemberDTO();
            HttpSession session = request.getSession();
            session.setAttribute("member", dto);
            response.sendRedirect("/seocance/main");
        } catch (Exception e) {
            System.out.println("LoginSuccessHandler err : " + e.getMessage());
        }
    }
}
