package com.c206.backend.domain.member.controller;

import com.c206.backend.domain.member.dto.request.SignUpRequestDto;
import com.c206.backend.domain.member.service.MemberService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequestMapping(value = "/api/v1/member", produces = "application/json")
@Tag(name = "Member", description = "Member API")
public class MemberController {

    private final MemberService memberService;

    public MemberController(MemberService memberService){
        this.memberService = memberService;
    }

    @PostMapping("/signup")
    @Operation(summary = "회원가입을 진행합니다." )
    public ResponseEntity<?> memberSignUp(@RequestBody @Parameter SignUpRequestDto signUpRequestDto){
        try {
            System.out.println(signUpRequestDto.getEmail());
            System.out.println(signUpRequestDto.getNickname());
            memberService.signUpProcess(signUpRequestDto);

            return new ResponseEntity<>(HttpStatus.OK);
        }catch (Exception e)
        {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
}
