package com.c206.backend.domain.quest.service;

import com.c206.backend.domain.quest.dto.response.MemberQuestListResponseDto;
import com.c206.backend.domain.quest.entity.MemberQuest;
import com.c206.backend.domain.quest.entity.Quest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface QuestService {

    List<MemberQuestListResponseDto> getQuestList(Long memberId);

    void getQuestReward(Long memberId, Long memberQuestId);

    void addQuestList(Long memberId);

}