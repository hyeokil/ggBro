package com.c206.backend.global.Filter;

import com.c206.backend.domain.member.dto.CustomUserDetails;
import com.c206.backend.global.jwt.JwtTokenUtil;
import jakarta.servlet.FilterChain;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import java.util.Collection;
import java.util.Iterator;

public class LoginFilter extends UsernamePasswordAuthenticationFilter {
    private final AuthenticationManager authenticationManager;

    private final JwtTokenUtil jwtTokenUtil;

    public LoginFilter(AuthenticationManager authenticationManager, JwtTokenUtil jwtTokenUtil) {

        this.authenticationManager = authenticationManager;
        this.jwtTokenUtil = jwtTokenUtil;
        setFilterProcessesUrl("/api/v1/member/signin");
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {

        System.out.println("여기는 attempAuthentication - LoginFilter");

        System.out.println(request.toString());

        //클라이언트 요청에서 username, password 추출
        String email = obtainUsername(request);
        String password = obtainPassword(request);
        System.out.println("여기의 이메일은 "+ email);
        System.out.println("여기의 패스워드는 "+ password);


        //스프링 시큐리티에서 username과 password를 검증하기 위해서는 token에 담아야 함
        UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(email, password, null);

        System.out.println(authToken);

        //token에 담은 검증을 위한 AuthenticationManager로 전달
        return authenticationManager.authenticate(authToken);
    }

    //로그인 성공시 실행하는 메소드 (여기서 JWT를 발급하면 됨)
    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication authentication) {

        System.out.println("로그인성공핸냐?");
        //UserDetailsS
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();

        String email = customUserDetails.getEmail();

        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        Iterator<? extends GrantedAuthority> iterator = authorities.iterator();
        GrantedAuthority auth = iterator.next();

//        String role = auth.getAuthority();
        String nickname = customUserDetails.getNickname();

        String accessToken = jwtTokenUtil.createAccessJwt(email, nickname, 60*60*10L);
        System.out.println("액세스 토큰은 이렇게 생겼다. "+ accessToken);
        String refreshToken = jwtTokenUtil.createRefreshJwt(email, nickname, 60*60*10L);
        System.out.println("리프레쉬 토큰은 이렇게 생겼다. "+ refreshToken);

        response.addHeader("Authorization", "Bearer " + accessToken);


        response.addCookie(createCookie("Authorization", accessToken));
        response.addCookie(createCookie("refresh", refreshToken));

    }

    //로그인 실패시 실행하는 메소드
    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed) {
        response.setStatus(401);
    }

    private Cookie createCookie(String key, String value) {

        Cookie cookie = new Cookie(key, value);
        cookie.setMaxAge(60*60*60*60);
        //cookie.setSecure(true);
        cookie.setPath("/");
        cookie.setHttpOnly(false);

        return cookie;
    }
}
