package com.trip.seocance.security;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/*
 * 로그인 실패시 실행되는 Handler
 *
 * @Author 문수빈
 * @Date 2023/01/09
 */
public class LoginFailHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        try {
            request.setAttribute("result", "false");
            request.getRequestDispatcher("/seocance/member").forward(request, response);
        } catch (Exception e) {
            System.out.println("LoginFailHandler err : " + e.getMessage());
        }
    }
}
