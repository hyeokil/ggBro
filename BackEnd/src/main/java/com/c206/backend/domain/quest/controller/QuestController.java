package com.c206.backend.domain.quest.controller;

import com.c206.backend.domain.quest.dto.response.MemberQuestListResponseDto;
import com.c206.backend.domain.quest.entity.Quest;
import com.c206.backend.domain.quest.service.QuestService;
import com.c206.backend.global.common.dto.Message;
import com.c206.backend.global.jwt.CustomUserDetails;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/quest")
public class QuestController {

    private final QuestService questService;

    @PostMapping(value = "/list")
    @Operation(summary = "퀘스트 목록을 열람합니다.")
    public ResponseEntity<Message<?>> questList(@Parameter(hidden = true)Authentication authentication){
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();

        List<MemberQuestListResponseDto> questList = questService.getQuestList(memberId);
        System.out.println("존재합니까? "+questList.isEmpty());

        for(MemberQuestListResponseDto questItem : questList){
            System.out.println(questItem.getMember_id().getEmail()+" "+questItem.getMember_id().getNickname());
            System.out.println(questItem.getPet_id().getName());
            System.out.println(questItem.getQuest_id().getGoalMin()+" "+questItem.getQuest_id().getGoalMax());
            System.out.println(questItem.getGoal()+" "+questItem.getProgress()+" "+questItem.is_done());
        }

        return ResponseEntity.ok().body(Message.success("안녕"));
    }

    @PostMapping(value = "addquest")
    @Operation(summary = "테스트용 API. 사용자에게 퀘스트를 생성해줍니다.")
    public ResponseEntity<Message<?>> addQuest(@Parameter(hidden = true)Authentication authentication){
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();

        questService.addQuestList(memberId);

        return ResponseEntity.ok().body(Message.success());
    }

}
