package com.c206.backend.domain.member.controller;

import com.c206.backend.domain.member.dto.request.SignInRequestDto;
import com.c206.backend.domain.member.dto.request.SignUpRequestDto;
import com.c206.backend.domain.member.service.MemberService;
import com.c206.backend.global.jwt.CustomUserDetails;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping(value = "/api/v1/member", produces = "application/json")
@Tag(name = "Member", description = "Member API")
public class MemberController {

    private final MemberService memberService;

    public MemberController(MemberService memberService){
        this.memberService = memberService;
    }


    @PostMapping(value = "/signin", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @Operation(summary = "로그인을 진행합니다.")
    public ResponseEntity<?> loginP(@RequestBody @Valid @Parameter SignInRequestDto signInRequestDto // HashMap<String, Object> map
    ){

//        try{
//            System.out.println("여기는 Login API");
//            System.out.println(signInRequestDto.getUsername()+" "+signInRequestDto.getPassword());
//            System.out.println(memberService.signInProcess(signInRequestDto));
//
//            return new ResponseEntity<>(HttpStatus.OK);
//        }catch (Exception e){
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
//        }
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/signup")
    @Operation(summary = "회원가입을 진행합니다." )
    public ResponseEntity<?> memberSignUp(@RequestBody @Valid @Parameter SignUpRequestDto signUpRequestDto, Errors error){
        if (error.hasErrors()) {
            // 바인딩 결과에 에러가 있으면 에러 메시지를 반환
            return ResponseEntity.badRequest().body(error.getAllErrors());
        }
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
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();  // HTTP 500 응답
        }
    }

    @PostMapping()
    @Operation(summary = "이메일 중복체크를 진행합니다.")
    public ResponseEntity<?> memberEmailDupCheck(@RequestBody @Parameter String email){

        try{
//            CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();

//            System.out.println(customUserDetails.getId());
//            System.out.println(customUserDetails.getEmail());
//            System.out.println(customUserDetails.getNickname());
            memberService.emailDupCheck(email);
            return new ResponseEntity<>(HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

    }
}
