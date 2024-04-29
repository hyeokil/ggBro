package com.c206.backend.global.jwt;

import com.c206.backend.domain.member.dto.CustomUserDetails;
import com.c206.backend.domain.member.dto.MemberDto;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class JwtTokenFilter extends OncePerRequestFilter {

    // 예를 들어, 토큰 검증을 담당하는 JwtTokenUtil 컴포넌트를 주입받을 수 있습니다.
     private final JwtTokenUtil jwtTokenUtil;

    // 생성자 주입을 통한 JwtTokenUtil 컴포넌트의 주입
     public JwtTokenFilter(JwtTokenUtil jwtTokenUtil) {
         this.jwtTokenUtil = jwtTokenUtil;
     }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
         //request 에서 Authorization 헤더 찾기
        String header = request.getHeader("Authorization");

        logger.info("filter  " + header);

        //Authorization 헤더 검증
//        if (header != null && header.startsWith("Bearer ")) {
//            String token = header.substring(7);
//            // if (jwtTokenUtil.validateToken(token)) { // 토큰 유효성 검증
//            String username = "exampleUser"; // 예시, 실제로는 토큰에서 추출
//
//            UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
//                    username, null, Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER")));
//            authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
//
//            SecurityContextHolder.getContext().setAuthentication(authentication);
//            // }
//        }

        if(header == null || !header.startsWith("Bearer ")){
            System.out.println("token null");
            filterChain.doFilter(request, response);

            return;
        }

        System.out.println("authorization now");
        //Bearer 부분 제거

        String token = header.split(" ")[1];

        if(jwtTokenUtil.isExpired(token)){
            System.out.println("token expired");
            filterChain.doFilter(request, response);

            return;
        }

        String email = jwtTokenUtil.getEmail(token);
        String nickname = jwtTokenUtil.getNickname(token);

        //...
        //userEntity를 생성하여 값 set

        MemberDto memberDto = new MemberDto();
        memberDto.setEmail(email);
        memberDto.setNickname(nickname);

        //UserDetails에 회원 정보 객체 담기
        CustomUserDetails customUserDetails = new CustomUserDetails(memberDto);

        //스프링 시큐리티 인증 토큰 생성
        Authentication authToken = new UsernamePasswordAuthenticationToken(customUserDetails, null, customUserDetails.getAuthorities());
        //세션에 사용자 등록
        SecurityContextHolder.getContext().setAuthentication(authToken);

        // JWT 검증 로직 구현
        filterChain.doFilter(request, response);
    }
}
