package com.c206.backend.global.jwt;

import com.c206.backend.domain.member.entity.Member;
import com.c206.backend.domain.member.repository.MemberRepository;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final MemberRepository memberRepository;

    public CustomUserDetailsService(MemberRepository memberRepository){
        this.memberRepository = memberRepository;
    }

    @Override
    public CustomUserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

        System.out.println("여기는 CustomUserDetailsService");

        // 혁일이형한테 값이 null일때의 처리 물어보기
        Optional<Member> member = memberRepository.findByEmail(email);
        if(member.isPresent()){
            if(member.get().getId() != null){
                //UserDetails에 담아서 return하면 AuthenticationManager가 검증 함
                System.out.println(member.get().getId());
                System.out.println(member.get().getEmail());
                System.out.println(member.get().getNickname());
                return new CustomUserDetails(member.get());
            }
        }
        else{
            System.out.println("없는 회원입니다.");
            //에러처리하기
            return null;
        }

        return null;
    }
}
