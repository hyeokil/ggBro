package com.c206.backend.domain.member.dto;

import com.c206.backend.domain.member.entity.Member;
import com.c206.backend.domain.member.repository.MemberRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final MemberRepository memberRepository;

    public CustomUserDetailsService(MemberRepository memberRepository){
        this.memberRepository = memberRepository;
    }

    @Override
    public CustomUserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

        // 혁일이형한테 물어보기
        Member member = memberRepository.findByEmail(email);
        System.out.println("여기는 CustomUserDetailsService");

        if(member.getId() != null){
            //UserDetails에 담아서 return하면 AuthenticationManager가 검증 함
            System.out.println(member.getEmail());
            System.out.println(member.getNickname());
            return new CustomUserDetails(member);
        }

        return null;
    }
}
