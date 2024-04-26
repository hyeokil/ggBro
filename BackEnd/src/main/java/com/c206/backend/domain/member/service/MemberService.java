package com.c206.backend.domain.member.service;

import com.c206.backend.domain.member.dto.request.SignUpRequestDto;
import org.springframework.stereotype.Service;

@Service
public interface MemberService {

    public Boolean signUpProcess(SignUpRequestDto signupDto);




}
