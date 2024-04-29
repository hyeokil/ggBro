package com.c206.backend.domain.achievement.controller;


import com.c206.backend.domain.achievement.dto.response.MemberAchievementListResponseDto;
import com.c206.backend.domain.achievement.dto.response.NewGoalResponseDto;
import com.c206.backend.domain.achievement.service.MemberAchievementService;
import com.c206.backend.global.common.dto.Message;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/achievement")
public class MemberAchievementController {

    private final MemberAchievementService memberAchievementService;

    // AuthenticationPrincipal 변경
    @GetMapping("/list")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Message<List<MemberAchievementListResponseDto>>> getMemberAchievementList(
            @AuthenticationPrincipal Long memberId) {
        List<MemberAchievementListResponseDto> memberAchievementListResponseDtoList = memberAchievementService.getMemberAchievementList(memberId);
        return ResponseEntity.ok().body(Message.success(memberAchievementListResponseDtoList));
    }


    // AuthenticationPrincipal 변경
    @PostMapping("/{memberAchievementId}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Message<NewGoalResponseDto>> receiveAchievementReward(
            @PathVariable("memberAchievementId") Long memberAchievementId,
            @AuthenticationPrincipal Long memberId) {
        NewGoalResponseDto newGoal = memberAchievementService.getReward(memberId, memberAchievementId);
        return ResponseEntity.ok().body(Message.success(newGoal));
    }
}
