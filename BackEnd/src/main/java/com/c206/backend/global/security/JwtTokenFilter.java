package com.c206.backend.global.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Collections;

@Component
public class JwtTokenFilter extends OncePerRequestFilter {

    // 예를 들어, 토큰 검증을 담당하는 JwtTokenUtil 컴포넌트를 주입받을 수 있습니다.
    // private final JwtTokenUtil jwtTokenUtil;

    // 생성자 주입을 통한 JwtTokenUtil 컴포넌트의 주입
    // public JwtTokenFilter(JwtTokenUtil jwtTokenUtil) {
    //     this.jwtTokenUtil = jwtTokenUtil;
    // }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException, ServletException, IOException {
        String header = request.getHeader("Authorization");

        if (header != null && header.startsWith("Bearer ")) {
            String token = header.substring(7);
            // if (jwtTokenUtil.validateToken(token)) { // 토큰 유효성 검증
            String username = "exampleUser"; // 예시, 실제로는 토큰에서 추출

            UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                    username, null, Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER")));
            authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

            SecurityContextHolder.getContext().setAuthentication(authentication);
            // }
        }


        // JWT 검증 로직 구현
        filterChain.doFilter(request, response);
    }
}
