package com.c206.backend.domain.member.controller;

import com.c206.backend.domain.member.dto.CustomUserDetails;
import com.c206.backend.domain.member.dto.CustomUserDetailsService;
import com.c206.backend.domain.member.dto.request.SignInRequestDto;
import com.c206.backend.domain.member.dto.request.SignUpRequestDto;
import com.c206.backend.domain.member.service.MemberService;
import com.c206.backend.global.jwt.JwtTokenUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@Slf4j
@RestController
@RequestMapping(value = "/api/v1/member", produces = "application/json")
@Tag(name = "Member", description = "Member API")
public class MemberController {

    private final MemberService memberService;
    @Value("${spring.jwt.access}")String access;
    @Value("${spring.jwt.refresh}")String refresh;

    public MemberController(MemberService memberService){
        this.memberService = memberService;
    }


    @PostMapping("/signin")
    @Operation(summary = "로그인을 진행합니다.")
    public ResponseEntity<?> loginP(@RequestBody @Parameter SignInRequestDto signInRequestDto // HashMap<String, Object> map
    ){

        try{
            System.out.println("여기는 MemberController");
//            SignInRequestDto signInRequestDto = new SignInRequestDto((String) map.get("username"), (String) map.get("password"));
            System.out.println(signInRequestDto.getUsername()+" "+signInRequestDto.getPassword());
            System.out.println(memberService.signInProcess(signInRequestDto));

//            JwtTokenUtil jwtTokenUtil = new JwtTokenUtil(access,refresh);
//
//            String jwtAccessToken = jwtTokenUtil.createAccessJwt(signInRequestDto.getEmail(), "", 60*60*10L);
//            System.out.println("이건 jwtAccessToken 약식");
//            System.out.println(jwtAccessToken);

            return new ResponseEntity<>(HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/signup")
    @Operation(summary = "회원가입을 진행합니다." )
    public ResponseEntity<?> memberSignUp(@RequestBody @Parameter SignUpRequestDto signUpRequestDto){
        try {
            System.out.println(signUpRequestDto.getEmail());
            System.out.println(signUpRequestDto.getNickname());
            memberService.signUpProcess(signUpRequestDto);

            //펫 자동생성
            //업적 자동생성
            //퀘스트 자동생성

            return new ResponseEntity<>(HttpStatus.OK);
        }catch (Exception e)
        {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping
    @Operation(summary = "이메일 중복체크를 진행합니다.")
    public ResponseEntity<?> memberEmailDupCheck(@RequestBody @Parameter String email, @Parameter(hidden = true) Authentication authentication){

        try{
            memberService.emailDupCheck(email);
            return new ResponseEntity<>(HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

    }
}
