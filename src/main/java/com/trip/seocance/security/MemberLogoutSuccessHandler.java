package com.trip.seocance.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/*
 * 로그아웃 성공시 실행되는 Handler
 *
 * @Author 문수빈
 * @Date 2023/01/09
 */
public class MemberLogoutSuccessHandler implements LogoutSuccessHandler {

    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
        if(authentication != null) {
            try {
                request.getSession().invalidate();
                request.setAttribute("result", "true");

                request.getRequestDispatcher("/main").forward(request, response);
            } catch (Exception e) {
                System.out.println("MemberLogoutSuccessHandler err : " + e.getMessage());
            }
        }
    }
}
