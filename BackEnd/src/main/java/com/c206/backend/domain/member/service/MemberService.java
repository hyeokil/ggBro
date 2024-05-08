package com.c206.backend.domain.member.service;

import com.c206.backend.domain.member.dto.request.SignInRequestDto;
import com.c206.backend.domain.member.dto.request.SignUpRequestDto;
import com.c206.backend.domain.member.dto.response.MemberInfoResponseDto;
import com.c206.backend.domain.member.dto.response.MemberTrashCountResDto;
import org.springframework.stereotype.Service;

import javax.swing.text.StyledEditorKit;

@Service
public interface MemberService {

    public Boolean signUpProcess(SignUpRequestDto signupDto);

    public Boolean signInProcess(SignInRequestDto signInDto);

    public Boolean emailDupCheck(String email);

    public MemberTrashCountResDto getMemberInfo(Long memberId);

    public boolean updateMemberInfoPicture(Long memberId, Long profilePetId);

}
