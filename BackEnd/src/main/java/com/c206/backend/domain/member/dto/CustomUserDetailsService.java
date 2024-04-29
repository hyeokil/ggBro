package com.c206.backend.domain.member.dto;

import com.c206.backend.domain.member.entity.Member;
import com.c206.backend.domain.member.repository.MemberRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

public class CustomUserDetailsService implements UserDetailsService {

    private final MemberRepository memberRepository;

    public CustomUserDetailsService(MemberRepository memberRepository){
        this.memberRepository = memberRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

        Member member = memberRepository.findByEmail(email);



        System.out.println("여기는 CustomUserDetailsService");

        if(member.getMemberId() != null){
            //UserDetails에 담아서 return하면 AuthenticationManager가 검증 함
            return new CustomUserDetails(member);
        }

        return null;
    }
}
