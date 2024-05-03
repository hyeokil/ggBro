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
import org.springframework.web.bind.annotation.PathVariable;
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

//        for(MemberQuestListResponseDto questItem : questList){
//            System.out.println(questItem.getPetNickname()+" "+questItem.getMemberQuestId()+" "+questItem.getQuestId()+" " +
//                    ""+questItem.getGoal()+" "+questItem.getProgress()+" "+questItem.isDone());
//        }

        return ResponseEntity.ok().body(Message.success(questList));
    }

    @PostMapping(value = "/{memberQuestId}")
    @Operation(summary = "퀘스트 보상을 지급합니다.")
    public ResponseEntity<Message<?>> questReward(@Parameter(hidden = true)Authentication authentication,
                                                  @PathVariable(value = "memberQuestId") Long memberQuestId ){
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();



        return ResponseEntity.ok().body(Message.success());
    }

    @PostMapping(value = "addquest")
    @Operation(summary = " 테스트용 API.사용자에게 퀘스트를 생성해줍니다.")
    public ResponseEntity<Message<?>> addQuest(@Parameter(hidden = true)Authentication authentication){
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();

        questService.addQuestList(memberId);

        return ResponseEntity.ok().body(Message.success());
    }

}
