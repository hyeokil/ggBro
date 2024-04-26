package com.c206.backend.domain.member.service;

import com.c206.backend.domain.member.dto.request.SignUpRequestDto;
import com.c206.backend.domain.member.entity.Member;
import com.c206.backend.domain.member.repository.MemberRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService{

    private final MemberRepository memberRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public MemberServiceImpl(MemberRepository memberRepository, BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.memberRepository = memberRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    @Override
    public Boolean signUpProcess(SignUpRequestDto signupDto) {

        String email = signupDto.getEmail();;
        String password = signupDto.getPassword();

        boolean isExist = memberRepository.existsByEmail(email);

        if(isExist){
            return false;
        }else{

            signupDto.setPassword(bCryptPasswordEncoder.encode(password));
            memberRepository.save(signupDto.toEntity());
            return true;
        }
    }
}
